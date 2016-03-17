// Processes - Day 69
// Prayash Thapa - March 9, 2016

import processing.pdf.*;
import java.util.Calendar;
boolean recordPDF = false;

int NORTH   = 0;
int EAST    = 1;
int SOUTH   = 2;
int WEST    = 3;

float posX, posY;
float posXcross, posYcross;

PImage img;
int direction = SOUTH;
float angleCount = 7;
float angle = getRandomAngle(direction);
float stepSize = 3;
int minLength = 10;

// ************************************************************************************

void setup() {
  size(600, 600);
  colorMode(HSB, 360, 100, 100, 100);
  background(360);
  img = loadImage("image.jpg");
  posX = int(random(0, width));
  posY = 5;
  posXcross = posX;
  posYcross = posY;
}

// ************************************************************************************

void draw() {
  for (int i = 0; i <= mouseX * 0.25; i++) {

    // Dots all the way.
    strokeWeight(1);
    stroke(180);
    point(posX, posY);

    // Step
    posX += cos(radians(angle)) * stepSize;
    posY += sin(radians(angle)) * stepSize;


    // Check if agent is near one of the display borders.
    boolean reachedBorder = false;

    if (posY <= 5) {
      direction = SOUTH;
      reachedBorder = true;
    } else if (posX >= width - 5) {
      direction = WEST;
      reachedBorder = true;
    } else if (posY >= height - 5) {
      direction = NORTH;
      reachedBorder = true;
    } else if (posX <= 5) {
      direction = EAST;
      reachedBorder = true;
    }

    // Collision detection against self.
    int px = (int) posX;
    int py = (int) posY;
    if (get(px, py) != color(360) || reachedBorder) {
      angle = getRandomAngle(direction);
      float distance = dist(posX, posY, posXcross, posYcross);
      if (distance >= minLength) {
        strokeWeight(random(5, 10));
        stroke(img.get((int)posX, (int)posY), random(255));
        point(posX, posY);
        if (random(1) > 0.9) {
          strokeWeight(random(15, 20)); point(posXcross, posYcross);
        }
      }
      posXcross = posX;
      posYcross = posY;
    }
  }
}

// ************************************************************************************

float getRandomAngle(int theDirection) {
  float a = (floor(random(-angleCount, angleCount)) + 0.5) * 90.0/angleCount;
  if (theDirection == NORTH) return (a - 90);
  if (theDirection == EAST) return (a);
  if (theDirection == SOUTH) return (a + 90);
  if (theDirection == WEST) return (a + 180);
  return 0;
}

void keyReleased(){
  if (key == DELETE || key == BACKSPACE) background(360);
  if (key == 's' || key == 'S') saveFrame("_##.png");
  if (key == ' ') noLoop();

  // * PDF Export
  if (key =='r' || key =='R') {
    if (recordPDF == false) {
      beginRecord(PDF, "###.pdf");
      println("recording started");
      recordPDF = true;
      setup();
    }
  } else if (key == 'e' || key =='E') {
    if (recordPDF) {
      println("recording stopped");
      endRecord();
      recordPDF = false;
      background(360);
    }
  }
}
