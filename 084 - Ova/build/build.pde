// Processes - Day 84
// Prayash Thapa - March 24, 2016

import processing.pdf.*;
boolean recordPDF = false;

float x = 0, y = 0;
float stepSize = 5.0;
float moduleSize = 25;

PShape lineModule;

// ************************************************************************************

void setup() {
  size(500, 500);
  background(255);

  x = mouseX;
  y = mouseY;
  cursor(CROSS);
  stroke(#d92b6a);
  noFill();
  strokeWeight(2);
  lineModule = loadShape("1.svg");
  lineModule.disableStyle();
}

// ************************************************************************************

void draw() {
  if (mousePressed) {
    float d = dist(x,y, mouseX,mouseY);

    if (d > stepSize) {
      float angle = atan2(mouseY-y, mouseX-x);

      pushMatrix();
        translate(mouseX, mouseY);
        rotate(angle+PI);
        shape(lineModule, 0, 0, d, moduleSize);
      popMatrix();

      x = x + cos(angle) * stepSize;
      y = y + sin(angle) * stepSize;
    }
  }
}

// ************************************************************************************

void mousePressed() {
  x = mouseX;
  y = mouseY;
}

void keyReleased() {
  if (key == 's' || key == 'S') saveFrame("_##.png");
  if (key == DELETE || key == BACKSPACE) background(255);

  // ------ pdf export ------
  // press 'r' to start pdf recordPDF and 'e' to stop it
  // ONLY by pressing 'e' the pdf is saved to disk!
  if (key =='r' || key =='R') {
    if (recordPDF == false) {
      beginRecord(PDF, "##.pdf");
      println("recording started");
      recordPDF = true;
    }
  }
  else if (key == 'e' || key =='E') {
    if (recordPDF) {
      println("recording stopped");
      endRecord();
      recordPDF = false;
      background(255);
    }
  }
}
