import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.serial.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class build extends PApplet {

// Processes - Day 70
// Prayash Thapa - March 10, 2016

int formRes       = 8;
int stepSize      = 1;
float initRadius  = 75;
float ease        = 0.1f;

float centerX, centerY;
float[] x         = new float[formRes];
float[] y         = new float[formRes];

boolean freeze    = false;

boolean sensel_sensor_opened = false;

int WINDOW_WIDTH_PX = 1150;
//We will scale the height such that we get the same aspect ratio as the sensor
int WINDOW_HEIGHT_PX;
SenselDevice sensel;

// ************************************************************************************

public void setup() {
  

  centerX = width/2;
  centerY = height/2;
  float angle = radians(360 / PApplet.parseFloat(formRes));

  // Initial setup / starting positions
  for (int i = 0; i < formRes; i++) {
    x[i] = cos(angle * i) * initRadius;
    y[i] = sin(angle * i) * initRadius;
  }

  stroke(255, 55);
  background(0xff1a232a);

  setupSenselMorph();
}

// ************************************************************************************

public void draw() {
  drawMorphPoints();

  // Float towards mouse position
  if (mouseX != 0 || mouseY != 0) {
    // centerX += (mouseX - centerX) * ease;
    // centerY += (mouseY - centerY) * ease;
  }

  // Calculate new points & add randomness
  for (int i = 0; i < formRes; i++) {
    x[i] += random(-stepSize, stepSize);
    y[i] += random(-stepSize, stepSize);
  }

  strokeWeight(0.75f);
  noFill();

  beginShape();
    // Start Point
    vertex(x[formRes - 1] + centerX, y[formRes - 1] + centerY);

    // only these points are drawn
    for (int i = 0; i < formRes; i++) {
      if (keyPressed == true) ellipse(x[i] + centerX, y[i] + centerY, 5, 5);
      else vertex(x[i] + centerX, y[i] + centerY);
    }

    vertex(x[0] + centerX, y[0] + centerY);

    // End Point
    vertex(x[1] + centerX, y[1] + centerY);
  endShape();
}

// ************************************************************************************

public void mousePressed() {
  centerX = mouseX;
  centerY = mouseY;
  float angle = radians(360 / PApplet.parseFloat(formRes));
  float radius = initRadius * random(0.5f,1.0f);
  for (int i = 0; i < formRes; i++){
    x[i] = cos(angle * i) * radius;
    y[i] = sin(angle * i) * radius;
  }
}

public void keyReleased() {
  if (key == 's') saveFrame("_##.png");
  if (key == DELETE || key == BACKSPACE) background(0xff1a232a);

  if (key == 'b') filter(BLUR, 1);
  if (key == 'e') filter(ERODE);
  if (key == 'd') filter(DILATE);

  if (key == 'f' || key == 'F') freeze = !freeze;
  if (freeze == true) noLoop();
  else loop();
}

public void setupSenselMorph() {
  DisposeHandler dh = new DisposeHandler(this);
  sensel = new SenselDevice(this);

  sensel_sensor_opened = sensel.openConnection();

  if (!sensel_sensor_opened) {
    println("Unable to open Sensel sensor!");
    exit();
    return;
  }

  // Init window height so that display window aspect ratio matches sensor.
  // NOTE: This must be done AFTER senselInit() is called, because senselInit() initializes
  // the sensor height/width fields. This dependency needs to be fixed in later revisions
  WINDOW_HEIGHT_PX = (int) (sensel.getSensorHeightMM() / sensel.getSensorWidthMM() * WINDOW_WIDTH_PX);

  // Enable contact sending
  sensel.setFrameContentControl(SenselDevice.SENSEL_FRAME_CONTACTS_FLAG);

  // Enable scanning
  sensel.startScanning();
}

public void drawMorphPoints() {
  SenselContact[] c = sensel.readContacts();

  if (c == null) {
    println("NULL CONTACTS");
    return;
  }

  for (int i = 0; i < c.length; i++) {
    float force = c[i].total_force;

    float area = c[i].area_mm_sq;

    float sensor_x_mm = c[i].x_pos_mm;
    float sensor_y_mm = c[i].y_pos_mm;

    int screen_x = (int) ((sensor_x_mm / sensel.getSensorWidthMM())  * WINDOW_WIDTH_PX);
    int screen_y = (int) ((sensor_y_mm / sensel.getSensorHeightMM()) * WINDOW_HEIGHT_PX);

    float orientation = c[i].orientation_degrees;
    float major = c[i].major_axis_mm;
    float minor = c[i].minor_axis_mm;

    // NOTE: This assumes window is scaled similar to sensor:
    int screen_major = (int) ((major / sensel.getSensorWidthMM())  * WINDOW_WIDTH_PX);
    int screen_minor = (int) ((minor / sensel.getSensorWidthMM())  * WINDOW_WIDTH_PX);

    int id = c[i].id;
    int event_type = c[i].type;

    String event;
    switch (event_type) {
      case SenselDevice.SENSEL_EVENT_CONTACT_INVALID:
        event = "invalid";
        break;
      case SenselDevice.SENSEL_EVENT_CONTACT_START:
        sensel.setLEDBrightness(id, (byte)100); //turn on LED
        event = "start";
        break;
      case SenselDevice.SENSEL_EVENT_CONTACT_MOVE:
        event = "move";
        break;
      case SenselDevice.SENSEL_EVENT_CONTACT_END:
        sensel.setLEDBrightness(id, (byte)0);
        event = "end";
        break;
      default:
        event = "error";
    }

    println("Contact ID " + id + ", event=" + event + ", mm coord: (" + sensor_x_mm + ", " + sensor_y_mm + "), shape: (" + orientation + ", " + major + ", " + minor + "), area=" + area + ", force=" + force);

    // Set to false to just draw circles
    if (false) {
      float scale = (float)force / 10000.0f;
      if(scale > 1.0f) scale = 1.0f;

      int from = color(0, 102, 153);
      int to = color(204, 102, 0);
      int clr = lerpColor(from, to, scale);

      pushMatrix();
      translate( screen_x, screen_y );
      rotate( radians(orientation) );

      stroke(255);
      fill(clr);
      ellipse( 0, 0, screen_minor, screen_major);
      popMatrix();
    } else {
      float size = force / 100.0f;
      if(size < 10) size = 10;

      // ellipse(screen_x, screen_y, size, size);
      centerX += (screen_x - centerX) * ease;
      centerY += (screen_y - centerY) * ease;
    }
  }

  if (c.length > 0) println("****");
}

public class DisposeHandler {
  DisposeHandler(PApplet pa) {
    pa.registerMethod("dispose", this);
  }

  public void dispose() {
    println("Closing sketch");
    if (sensel_sensor_opened) {
      sensel.stopScanning();
      sensel.closeConnection();
    }
  }
}
/**************************************************************************
 * Copyright 2017 Sensel, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 * http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 **************************************************************************/

/* 
  Sensel API for Processing.

  -> Outside of all functions:
  -> SenselDevice sensel;

  -> Inside setup():
  -> sensel = new SenselDevice(this);
  -> sensel.openConnection(); //returns true if successful, false if error
  -> sensel.setFrameContentControl(SenselDevice.SENSEL_FRAME_CONTACTS_FLAG); //enables contact sending
  -> sensel.startScanning(); //Start scanning
  
  -> Inside draw():
  -> SenselContact[] contacts = sensel.readContacts();

  -> Inside DisposeHandler:
  -> sensel.stopScanning();
  -> sensel.closeConnection();
*/



public class SenselContact
{                                                                                                                                            
  int id;
  int type;
  float x_pos_mm; // x position in mm                                                                                                                                         
  float y_pos_mm; // y position in mm    
  float total_force;
  float area_mm_sq; // area in square mm                                                                                                                                                                         
  float orientation_degrees; // angle from -90 to 90 degrees                                                                                                                          
  float major_axis_mm; // length of the major axis                                                                                                                                             
  float minor_axis_mm; // length of the minor axis 
}

public class SenselDevice
{
  final static byte SENSEL_REG_MAGIC                          = (byte)0x00;
  final static byte SENSEL_REG_MAGIC_LENGTH                   = (byte)0x06;
  final static byte SENSEL_REG_SENSOR_ACTIVE_AREA_WIDTH_UM    = (byte)0x14;
  final static byte SENSEL_REG_SENSOR_ACTIVE_AREA_HEIGHT_UM   = (byte)0x18;
  final static byte SENSEL_REG_SCAN_CONTENT_CONTROL = (byte)0x24;
  final static byte SENSEL_REG_SCAN_ENABLED         = (byte)0x25;
  final static byte SENSEL_REG_SCAN_READ_FRAME      = (byte)0x26;
  final static byte SENSEL_REG_CONTACTS_MAX_COUNT   = (byte)0x40;
  final static byte SENSEL_REG_ACCEL_X              = (byte)0x60;
  final static byte SENSEL_REG_ACCEL_Y              = (byte)0x62;
  final static byte SENSEL_REG_ACCEL_Z              = (byte)0x64;
  final static byte SENSEL_REG_LED_BRIGHTNESS       = (byte)0x80;

  final static byte SENSEL_FRAME_CONTACTS_FLAG      = (byte)0x04;

  final static byte SENSEL_PT_READ_ACK  = 1;
  final static byte SENSEL_PT_RVS_ACK   = 3;
  final static byte SENSEL_PT_WRITE_ACK = 5;

  final static int SENSEL_EVENT_CONTACT_INVALID = 0;
  final static int SENSEL_EVENT_CONTACT_START   = 1;
  final static int SENSEL_EVENT_CONTACT_MOVE    = 2;
  final static int SENSEL_EVENT_CONTACT_END     = 3;

  final static byte SENSEL_BOARD_ADDR   = (byte)0x01;
  final static byte SENSEL_READ_HEADER  = (byte)(SENSEL_BOARD_ADDR | (1 << 7));
  final static byte SENSEL_WRITE_HEADER = SENSEL_BOARD_ADDR;

  private Serial serial_port;
  private float sensor_width_mm;
  private float sensor_height_mm;
  private int sensor_max_contacts;
  private float sensor_mm_value_scale = 256.0f;
  private float sensor_gram_value_scale = 8.0f;
  private float sensor_degree_value_scale = 16.0f;
  private PApplet parent;

  public SenselDevice(PApplet p)
  {
    parent = p; 
  }

  private boolean _checkForMagic(Serial port)
  {
    port.write(SENSEL_READ_HEADER);
    port.write(SENSEL_REG_MAGIC);
    port.write(SENSEL_REG_MAGIC_LENGTH);
    
    delay(500);
    
    //1-byte packet type, 2-byte size of payload, Payload, 1-byte checksum
    int magic_response_size = 5 + SENSEL_REG_MAGIC_LENGTH;
    
    if(port.available() < magic_response_size)
    {
      println("Magic not found!");
    }
    else
    {
      //println("Bytes available: " + port.available());

      //Check ACK
      if(port.readChar() != SENSEL_PT_READ_ACK) //Packet ACK
      {
        println("READ ACK NOT FOUND IN MAGIC PACKET!");
        return false;
      }
      
      //Check Reg
      if(port.readChar() != SENSEL_REG_MAGIC) //Packet ACK
      {
        println("READ REG NOT FOUND IN MAGIC PACKET!");
        return false;
      }

      //Check 2-byte packet size
      int packet_size = _convertBytesTo16((byte)port.readChar(), (byte)port.readChar());
      if(packet_size != SENSEL_REG_MAGIC_LENGTH)
      {
        println("LENGTH MISMATCH IN MAGIC PACKET! (Expected " + SENSEL_REG_MAGIC_LENGTH + ", received " + packet_size + ")");
        return false;
      }
      
      String magic = "";
      int checksum_calculated = 0;
      for(int i = 0; i < SENSEL_REG_MAGIC_LENGTH; i++)
      {
        char c = port.readChar();
        magic += c;
        checksum_calculated += c; 
      }
      checksum_calculated &= (0xFF);
      
      //Verify checksum
      int checksum_received = (int)port.readChar();
      if(checksum_received != checksum_calculated)
      {
        println("CHECKSUM MISMATCH IN MAGIC PACKET! (calculated " + (int)checksum_calculated + ", received " + (int)checksum_received + ")");
        return false;
      }
      
      if(magic.equals("S3NS31"))
      {
        println("MAGIC FOUND!");
        return true;
      }
      else
      {
        println("Invalid magic: " + magic);
      }
    }  
    return false;
  }

  public boolean openConnection()
  {
    String[] serial_list = Serial.list();
    serial_port = null;
    
    for(int i = 0; i < serial_list.length; i++)
    {
      println("Opening " + serial_list[i]);
      Serial curr_port;
      
      try{
        curr_port = new Serial(parent, serial_list[i], 115200);
      }
      catch(Exception e)
      {
        continue;
      }
      
      //Flush port
      curr_port.clear();
      
      if(_checkForMagic(curr_port))
      {
        serial_port = curr_port;
        
        int [] sensor_width_arr  = _readReg(0x14, 4);
        int [] sensor_height_arr = _readReg(0x18, 4);
        
        //Convert from um to mm
        sensor_width_mm  = ((float)_convertBytesTo32((byte)sensor_width_arr[0],  (byte)sensor_width_arr[1],  (byte)sensor_width_arr[2],  (byte)sensor_width_arr[3]))  / 1000.0f;
        sensor_height_mm = ((float)_convertBytesTo32((byte)sensor_height_arr[0], (byte)sensor_height_arr[1], (byte)sensor_height_arr[2], (byte)sensor_height_arr[3])) / 1000.0f;
        
        println("Sensor Width = "  + sensor_width_mm  + " mm");
        println("Sensor Height = " + sensor_height_mm + " mm");
        
        sensor_max_contacts = _readReg(SENSEL_REG_CONTACTS_MAX_COUNT, 1)[0];
        println("Sensor Max Contacts = " + sensor_max_contacts);
        break;
      }
      else
      {
        curr_port.stop(); 
      }
    }
    return (serial_port != null);
  }
  
  public void closeConnection()
  {
    setLEDBrightnessAll((byte)0);
    serial_port.stop();
  }
  
  public void setFrameContentControl(byte content)
  {
    senselWriteReg(SENSEL_REG_SCAN_CONTENT_CONTROL, 1, content);
  }
  
  public void setLEDBrightness(int idx, byte brightness)
  {
    if(idx < 16)
      senselWriteReg(SENSEL_REG_LED_BRIGHTNESS + idx, 1, brightness); 
  }
  
  public void setLEDBrightnessAll(byte brightness)
  {
    for(int i = 0; i < 16; i++)
      senselWriteReg(SENSEL_REG_LED_BRIGHTNESS + i, 1, brightness); 
  }
  
  public float getSensorWidthMM()
  {
    return sensor_width_mm;
  }
  
  public float getSensorHeightMM()
  {
    return sensor_height_mm; 
  }
  
  public int getMaxNumContacts()
  {
    return sensor_max_contacts;
  }
  
  public void startScanning()
  {
    senselWriteReg(SENSEL_REG_SCAN_ENABLED, 1, 1);
  }
  
  public void stopScanning()
  {
    senselWriteReg(SENSEL_REG_SCAN_ENABLED, 1, 0);
  }
  
  private int[] _readReg(int addr, int size)
  {
    serial_port.write(SENSEL_READ_HEADER);
    serial_port.write((byte)addr);
    serial_port.write((byte)size);
    
    int[] rx_buf = new int[size]; // TODO (Ilya): I think the rx_buf should be a byte array, and this funciton should return bytes.
    
    int ack;
    while((ack = serial_port.read()) == -1);
    
    if(ack != SENSEL_PT_READ_ACK)
      println("FAILED TO RECEIVE ACK ON READ (regaddr=" + addr + ", ack=" + ack + ")");
    
    int reg;
    while((reg = serial_port.read()) == -1);
    
    if(reg != addr)
      println("FAILED TO RECEIVE REG ON READ (regaddr=" + addr + ", readreg=" + reg + ")");
    
    int size0;
    while((size0 = serial_port.read()) == -1);
  
    int size1;
    while((size1 = serial_port.read()) == -1);
    
    int resp_size = _convertBytesTo16((byte)size0, (byte)size1);
  
    //if(size != resp_size)
    //  println("RESP_SIZE != SIZE (" + resp_size + "!=" + size + ") ON READ");
    //else
    //  println("RESP_SIZE == SIZE (" + resp_size + "==" + size + ") ON READ");
    
    int checksum = 0;
    
    for(int i = 0; i < size; i++)
    {
       while((rx_buf[i] = serial_port.read()) == -1);
       checksum += rx_buf[i];
    }
    
    checksum = (checksum & 0xFF);
    
    int resp_checksum;
    while((resp_checksum = serial_port.read()) == -1);
    
    if(checksum != resp_checksum)
      println("CHECKSUM FAILED: " + checksum + "!=" + resp_checksum + " ON READ");
    
    return rx_buf;
  }
  
  private int _readContactFrameSize()
  {
    serial_port.write(SENSEL_READ_HEADER);
    serial_port.write((byte)SENSEL_REG_SCAN_READ_FRAME);
    serial_port.write((byte)0x00);
    
    int ack;
    while((ack = serial_port.read()) == -1);
    
    if(ack != SENSEL_PT_RVS_ACK)
      println("FAILED TO RECEIVE FRAME ACK ON FRAME READ");
    
    int reg;
    while((reg = serial_port.read()) == -1);
    
    if(reg != SENSEL_REG_SCAN_READ_FRAME)
      println("FAILED TO RECEIVE FRAME REG ON FRAME READ");
      
    int header;
    while((header = serial_port.read()) == -1);
    
    if(header != 0)
      println("FAILED TO RECEIVE FRAME HEADER ON FRAME READ");
      
    int size0;
    while((size0 = serial_port.read()) == -1);
  
    int size1;
    while((size1 = serial_port.read()) == -1);
    
    int content_bitmask;
    while((content_bitmask = serial_port.read()) == -1);
    //println("CBM: " + content_bitmask);
    
    int frame_counter;
    while((frame_counter = serial_port.read()) == -1);
    
    serial_port.read(); //Time
    serial_port.read();
    serial_port.read();
    serial_port.read();
    serial_port.read(); //Contacts content
    //println("FC: " + frame_counter);
    
    //println("Finished reading contact frame size: " + (size0 | (size1 <<8)));  
    
    return _convertBytesTo16((byte)size0, (byte)size1) - 7; //Packet size includes content bitmask and lost frame count which we've already read out
  }
  
  //We only support single-byte writes at this time TODO: Implement multi-byte write
  private void senselWriteReg(int addr, int size, int data)
  {
    if(size != 1)
      println("writeReg only supports writes of size 1");
      
    serial_port.write(SENSEL_WRITE_HEADER);
    serial_port.write((byte)addr);
    serial_port.write((byte)size);
    serial_port.write((byte)data);
    serial_port.write((byte)data); //Checksum
    
    int ack;
    while((ack = serial_port.read()) == -1);
    
    if(ack != SENSEL_PT_WRITE_ACK)
      println("FAILED TO RECEIVE ACK ON WRITE (regaddr=" + addr + ", ack=" + ack + ")");
      
    int reg;
    while((reg = serial_port.read()) == -1);
    
    if((byte)reg != (byte)addr)
      println("FAILED TO RECEIVE REG ON WRITE (regaddr=" + addr + ", readReg=" + reg + ")");
  }
  
  private int _convertBytesTo32(byte b0, byte b1, byte b2, byte b3)
  {
    return ((((int)b3) & 0xff) << 24) | ((((int)b2) & 0xff) << 16) | ((((int)b1) & 0xff) << 8) | (((int)b0) & 0xff); 
  }
  
  private int _convertBytesTo16(byte b0, byte b1)
  {
    return ((((int)b1) & 0xff) << 8) | (((int)b0) & 0xff); 
  }
  
  // Convert two bytes (which represent a two's complement signed 16 bit integer) into a signed int
  private int _convertBytesToS16(byte b0, byte b1)
  {
    return (((int)b1) << 8) | (((int)b0) & 0xff);
  }
  
  public SenselContact[] readContacts()
  {
    SenselContact[] retval = null;
    int contact_frame_size = _readContactFrameSize() + 1; //For checksum!
  
    //println("CFS: " + contact_frame_size);
  
    if(true)//contact_frame_size > 0)
    {  
      //println("Force frame: " + contact_frame_size);
      byte[] contact_frame = new byte[contact_frame_size];
      
      int aval;
      do
      {
        aval = serial_port.available();
        //println("Aval: " + aval);
        delay(1);
      }
      while(aval < contact_frame_size);
      
      int read_count = serial_port.readBytes(contact_frame);
      
      if(read_count < contact_frame_size)
      {
        println("SOMETHING BAD HAPPENED! (" + read_count + " < " + contact_frame_size + ")");
        exit(); 
      }
      
      int num_contacts = ((int)contact_frame[0]) & 0xff;  
    
      //print("Num Contacts: " + num_contacts + "....");
      
      int idx = 0;
      
      SenselContact[] c = new SenselContact[num_contacts];
      
      for(int i = 0; i < num_contacts; i++)
      {
        c[i] = new SenselContact();
        c[i].id = (((int)contact_frame[++idx]) & 0xff);
        c[i].type = (((int)contact_frame[++idx]) & 0xff);
        c[i].x_pos_mm = ((float)_convertBytesTo16(contact_frame[++idx], contact_frame[++idx])) / sensor_mm_value_scale;
        //Convert y_pos to y_pos_mm
        c[i].y_pos_mm = ((float)_convertBytesTo16(contact_frame[++idx], contact_frame[++idx])) / sensor_mm_value_scale;
        //Convert dx to dx_mm
        c[i].total_force = ((float)_convertBytesTo16(contact_frame[++idx], contact_frame[++idx])) / sensor_gram_value_scale;
        c[i].area_mm_sq = ((float)_convertBytesTo16(contact_frame[++idx], contact_frame[++idx]));
        //Convert x_pos to x_pos_mm
        c[i].orientation_degrees = ((float)_convertBytesToS16(contact_frame[++idx], contact_frame[++idx])) / sensor_degree_value_scale;
        //Convert major_axis to mm (assumes that x_to_mm and y_to_mm are the same)
        c[i].major_axis_mm = ((float)_convertBytesTo16(contact_frame[++idx], contact_frame[++idx])) / sensor_mm_value_scale;
        //Convert minor_axis to mm (assumes that x_to_mm and y_to_mm are the same)
        c[i].minor_axis_mm = ((float)_convertBytesTo16(contact_frame[++idx], contact_frame[++idx])) / sensor_mm_value_scale;
      }
      retval = c;
    }  
    //TODO: ACTUALLY USE CHECKSUM!!!
    //byte checksum;
    //while((checksum = (byte)serial_port.read()) == -1);
    //println("finish read");
  
    return retval;
  }
  
  
  // Returns (x,y,z) acceleration in G's using the following coordinate system:
  //
  //          ---------------------------
  //        /   Z /\  _                 /
  //       /       |  /| Y             /
  //      /        | /                /
  //     /         |/                /
  //    /           -----> X        /
  //   /                           /
  //   ----------------------------
  //
  // Assumes accelerometer is configured to the default +/- 2G range
  public float[] readAccelerometerData()
  {
    // Read accelerometer data bytes for X, Y and Z
    int[] acc_bytes = _readReg(SENSEL_REG_ACCEL_X,6);

    // Convert raw bytes to signed values
    int[] acc_values = new int[3];
    acc_values[0] = _convertBytesToS16((byte)acc_bytes[0], (byte)acc_bytes[1]);
    acc_values[1] = _convertBytesToS16((byte)acc_bytes[2], (byte)acc_bytes[3]);
    acc_values[2] = _convertBytesToS16((byte)acc_bytes[4], (byte)acc_bytes[5]);
    
    // Rescale to G's (at a range of +/- 2G, accelerometer returns 0x4000 for 1G acceleration)
    float[] acc_data = new float[3];
    acc_data[0] = ((float)acc_values[0] / 0x4000);
    acc_data[1] = ((float)acc_values[1] / 0x4000);    
    acc_data[2] = ((float)acc_values[2] / 0x4000);
    
    return acc_data;
  }
}
  public void settings() {  size(1200, 800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "build" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
