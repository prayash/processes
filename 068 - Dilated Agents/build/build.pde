// Processes - Day 68
// Prayash Thapa - March 8, 2016

import processing.pdf.*;
import java.util.Calendar;

int NORTH       = 0;
int NORTHEAST   = 1;
int EAST        = 2;
int SOUTHEAST   = 3;
int SOUTH       = 4;
int SOUTHWEST   = 5;
int WEST        = 6;
int NORTHWEST   = 7;

float stepSize  = 5;
float diameter  = 3;

int drawMode  = 3;
int counter     = 0;

PImage img;
int direction;
float posX, posY;
boolean recordPDF = false;

// ************************************************************************************

void setup() {
  size(550, 550);

  colorMode(HSB, 360, 100, 100, 100);
  background(360);
  noStroke();

  posX = width/2;
  posY = height/2;

  img = loadImage("image.jpg");
}

// ************************************************************************************

void draw() {
  for (int i = 0; i <= (mouseX / 5); i++) {
    counter++;

    if (drawMode == 2) direction = round(random(0, 3));
    else direction = (int) random(0, 7);

    if (direction == NORTH) posY -= stepSize;
    else if (direction == SOUTH) posY += stepSize;
    else if (direction == EAST) posX += stepSize;
    else if (direction == WEST) posX -= stepSize;

    else if (direction == NORTHEAST) {
      posX += stepSize;
      posY -= stepSize;
    } else if (direction == SOUTHEAST) {
      posX += stepSize;
      posY += stepSize;
    } else if (direction == SOUTHWEST) {
      posX -= stepSize;
      posY += stepSize;
    } else if (direction == NORTHWEST) {
      posX -= stepSize;
      posY -= stepSize;
    }

    if (posX > width) posX = 0;
    if (posX < 0) posX = width;
    if (posY < 0) posY = height;
    if (posY > height) posY = 0;

    if (drawMode == 3) {
      if (counter >= 100) {
        counter = 0;
        ellipse(posX+stepSize/2, posY+stepSize/2, diameter+7, diameter+7);
      }
    }

    float a = random(100, 200);
    fill(img.get((int)posX, (int)posY), a);
    ellipse(posX+stepSize/2, posY+stepSize/2, diameter, diameter);
  }
}

// ************************************************************************************

void keyReleased() {
  if (key == DELETE || key == BACKSPACE) background(360);
  if (key == 's' || key == 'S') saveFrame("_##.png");

  if (key == '1') {
    drawMode = 1;
    stepSize = 1;
    diameter = 1;
  }
  if (key == '2') {
    drawMode = 2;
    stepSize = 1;
    diameter = 1;
  }
  if (key == '3') {
    drawMode = 3;
    stepSize = 10;
    diameter = 5;
  }

  if (key == 'b') filter(BLUR, 1);
  if (key == 'e') filter(ERODE);
  if (key == 'd') filter(DILATE);

  // * PDF Export - R to Start -> E to Stop
  if (key =='r') {
    if (recordPDF == false) {
      beginRecord(PDF, "###.pdf");
      println("recording started");
      recordPDF = true;
      setup();
    }
  } else if (key == 'e') {
    if (recordPDF) {
      println("recording stopped");
      endRecord();
      recordPDF = false;
      background(255);
    }
  }
}
