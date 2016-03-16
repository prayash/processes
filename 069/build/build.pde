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

int direction = SOUTH;
float angleCount = 7;
float angle = getRandomAngle(direction);
float stepSize = 3;
int minLength = 10;

// ************************************************************************************

void setup() {
  size(600, 600);
  colorMode(HSB, 360, 100, 100, 100);
  smooth();
  background(360);

  posX = int(random(0, width));
  posY = 5;
  posXcross = posX;
  posYcross = posY;
}

// ************************************************************************************

void draw() {
  for (int i = 0; i <= mouseX * 0.25; i++) {

    // ------ draw dot at current position ------
    if (!recordPDF) {
      strokeWeight(1);
      stroke(180);
      point(posX, posY);
    }

    // ------ make step ------
    posX += cos(radians(angle)) * stepSize;
    posY += sin(radians(angle)) * stepSize;


    // ------ check if agent is near one of the display borders ------
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

    // ------ if agent is crossing his path or border was reached ------
    int px = (int) posX;
    int py = (int) posY;
    if (get(px, py) != color(360) || reachedBorder) {
      angle = getRandomAngle(direction);
      float distance = dist(posX, posY, posXcross, posYcross);
      if (distance >= minLength) {
        strokeWeight(3);
        stroke(0);
        line(posX, posY, posXcross, posYcross);
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

  // ------ pdf export ------
  // press 'r' to start pdf recording and 'e' to stop it
  // ONLY by pressing 'e' the pdf is saved to disk!
  if (key =='r' || key =='R') {
    if (recordPDF == false) {
      beginRecord(PDF, "###.pdf");
      println("recording started");
      recordPDF = true;
      colorMode(HSB, 360, 100, 100, 100);
      background(360);
      posX = int(random(0, width));
      posY = 5;
      posXcross = posX;
      posYcross = posY;
    }
  }
  else if (key == 'e' || key =='E') {
    if (recordPDF) {
      println("recording stopped");
      endRecord();
      recordPDF = false;
      background(360);
    }
  }
}
