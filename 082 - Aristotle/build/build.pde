// Processes - Day 82
// Prayash Thapa - March 22, 2016

import processing.pdf.*;
boolean recordPDF = false;

float x = 0, y = 0;
float stepSize = 5.0;

PFont font;
PImage img;
String letters = "It is the mark of an educated mind to be able to entertain a thought without accepting it.";
int fontSizeMin = 3;
float angleDistortion = 0.0;
int counter = 0;
boolean showImage = true;

// ************************************************************************************

void setup() {
  // use full screen size
  size(displayWidth, displayHeight);
  background(255);
  smooth();
  cursor(CROSS);

  x = mouseX;
  y = mouseY;

  font = createFont("American Typewriter", 10);
  //font = createFont("ArnhemFineTT-Normal", 10);
  textFont(font,fontSizeMin);
  textAlign(LEFT);
  fill(0);


  // load an image in background
  img = loadImage("data.jpg");
  if (showImage) image(img, 0, 0, width, height);
}

// ************************************************************************************

void draw() {
  if (mousePressed) {
    float d = dist(x, y, mouseX, mouseY);
    textFont(font, fontSizeMin+d/2);
    char newLetter = letters.charAt(counter);
    stepSize = textWidth(newLetter);

    if (d > stepSize) {
      float angle = atan2(mouseY-y, mouseX-x);

      pushMatrix();
      translate(x, y);
      rotate(angle + random(angleDistortion));
      text(newLetter, 0, 0);
      popMatrix();

      counter++;
      if (counter > letters.length() - 1) counter = 0;

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
      beginRecord(PDF, "_##.pdf");
      println("recording started");
      recordPDF = true;
      textAlign(LEFT);
      fill(0);
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

  if (key == 'h') showImage = false;
}

void keyPressed() {
  // angleDistortion ctrls arrowkeys up/down
  if (keyCode == UP) angleDistortion += 0.1;
  if (keyCode == DOWN) angleDistortion -= 0.1;
}
