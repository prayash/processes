// Processes - Day 70
// Prayash Thapa - March 10, 2016

import processing.pdf.*;
boolean recordPDF = false;

int formResolution = 15;
int stepSize = 2;
float distortionFactor = 0.5;
float initRadius = 75;
float centerX, centerY;
float[] x = new float[formResolution];
float[] y = new float[formResolution];

boolean filled = false;
boolean freeze = false;

// ************************************************************************************

void setup(){
  size(500, 500);

  // init form
  centerX = width/2;
  centerY = height/2;
  float angle = radians(360/float(formResolution));
  for (int i=0; i<formResolution; i++){
    x[i] = cos(angle*i) * initRadius;
    y[i] = sin(angle*i) * initRadius;
  }

  stroke(255, 25);
  background(#1a232a);
}

// ************************************************************************************

void draw(){
  // floating towards mouse position
  if (mouseX != 0 || mouseY != 0) {
    centerX += (mouseX-centerX) * 0.01;
    centerY += (mouseY-centerY) * 0.01;
  }

  // calculate new points
  for (int i=0; i<formResolution; i++){
    x[i] += random(-stepSize,stepSize);
    y[i] += random(-stepSize,stepSize);
    // ellipse(x[i], y[i], 5, 5);
  }

  strokeWeight(0.75);
  if (filled) fill(random(255));
  else noFill();

  beginShape();
    // start controlpoint
    curveVertex(x[formResolution-1]+centerX, y[formResolution-1]+centerY);

    // only these points are drawn
    for (int i=0; i<formResolution; i++){
      curveVertex(x[i]+centerX, y[i]+centerY);
    }
    curveVertex(x[0]+centerX, y[0]+centerY);

    // end controlpoint
    curveVertex(x[1]+centerX, y[1]+centerY);
  endShape();
}

// ************************************************************************************

void mousePressed() {
  //init form on mouse position
  centerX = mouseX;
  centerY = mouseY;
  float angle = radians(360/float(formResolution));
  float radius = initRadius * random(0.5,1.0);
  for (int i=0; i<formResolution; i++){
    x[i] = cos(angle*i) * radius;
    y[i] = sin(angle*i) * radius;
  }
}

void keyReleased() {
  if (key == 's' || key == 'S') saveFrame("_##.png");
  if (key == DELETE || key == BACKSPACE) background(#1a232a);

  if (key == '1') filled = false;
  if (key == '2') filled = true;

    if (key == 'B') filter(BLUR, 1);
    if (key == 'E') filter(ERODE);
    if (key == 'D') filter(DILATE);

  // ------ pdf export ------
  // press 'r' to start pdf recording and 'e' to stop it
  // ONLY by pressing 'e' the pdf is saved to disk!
  if (key =='r' || key =='R') {
    if (recordPDF == false) {
      beginRecord(PDF, "_##.pdf");
      println("recording started");
      recordPDF = true;
      stroke(0, 50);
    }
  } else if (key == 'e' || key =='E') {
    if (recordPDF) {
      println("recording stopped");
      endRecord();
      recordPDF = false;
      background(255);
    }
  }

  // switch draw loop on/off
  if (key == 'f' || key == 'F') freeze = !freeze;
  if (freeze == true) noLoop();
  else loop();
}
