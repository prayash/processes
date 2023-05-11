// Processes - Day 70
// Prayash Thapa - March 10, 2016

int formRes       = 8;
int stepSize      = 1;
float initRadius  = 75;
float ease        = 0.1;

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

void setup() {
  size(1200, 800);

  centerX = width/2;
  centerY = height/2;
  float angle = radians(360 / float(formRes));

  // Initial setup / starting positions
  for (int i = 0; i < formRes; i++) {
    x[i] = cos(angle * i) * initRadius;
    y[i] = sin(angle * i) * initRadius;
  }

  stroke(255, 55);
  background(#1a232a);

  setupSenselMorph();
}

// ************************************************************************************

void draw() {
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

  strokeWeight(0.75);
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

void mousePressed() {
  centerX = mouseX;
  centerY = mouseY;
  float angle = radians(360 / float(formRes));
  float radius = initRadius * random(0.5,1.0);
  for (int i = 0; i < formRes; i++){
    x[i] = cos(angle * i) * radius;
    y[i] = sin(angle * i) * radius;
  }
}

void keyReleased() {
  if (key == 's') saveFrame("_##.png");
  if (key == DELETE || key == BACKSPACE) background(#1a232a);

  if (key == 'b') filter(BLUR, 1);
  if (key == 'e') filter(ERODE);
  if (key == 'd') filter(DILATE);

  if (key == 'f' || key == 'F') freeze = !freeze;
  if (freeze == true) noLoop();
  else loop();
}

void setupSenselMorph() {
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
  WINDOW_HEIGHT_PX =
    (int) (sensel.getSensorHeightMM() / sensel.getSensorWidthMM() * WINDOW_WIDTH_PX);

  // Enable contact sending
  sensel.setFrameContentControl(SenselDevice.SENSEL_FRAME_CONTACTS_FLAG);

  // Enable scanning
  sensel.startScanning();
}

void drawMorphPoints() {
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

    // println("Contact ID " + id + ", event=" + event + ", mm coord: (" + sensor_x_mm + ", " + sensor_y_mm + "),
    // shape: (" + orientation + ", " + major + ", " + minor + "), area=" + area +
    // ", force=" + force);

    // Set to false to just draw circles
    if (false) {
      float scale = (float)force / 10000.0f;
      if(scale > 1.0f) scale = 1.0f;

      color from = color(0, 102, 153);
      color to = color(204, 102, 0);
      color clr = lerpColor(from, to, scale);

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
