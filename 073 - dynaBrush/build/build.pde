/**
 * draw tool. draw with a rotating line.
 *
 * MOUSE
 * drag                : draw
 *
 * KEYS
 * 1-4                 : switch default colors
 * del, backspace      : clear screen
 * d                   : reverse direction and mirrow angle
 * space               : new random color
 * arrow left          : rotaion speed -
 * arrow right         : rotaion speed +
 * arrow up            : line length +
 * arrow down          : line length -
 * s                   : save png
 * r                   : start pdf recording
 * e                   : stop pdf recording
 */

import processing.pdf.*;
import java.util.Calendar;

boolean recordPDF = false;

color col = color(181, 157, 0, 100);
float lineLength = 0;
float angle = 0;
float angleSpeed = 1.0;

int gradientVariance = 5;
int colorCounter = 0;

void setup() {
  // use full screen size
  size(800, 800);
  background(#d92b6a);
  cursor(CROSS);
}

void draw() {
  if (mousePressed) {
    pushMatrix();
      strokeWeight(1.0);
      noFill();
      stroke(200, 3 * sin(frameCount) + 100);
      translate(mouseX, mouseY);
      rotate(radians(angle));
      line(0, 0, lineLength, 0);
    popMatrix();

    angle += angleSpeed;
  }
}

void mousePressed() {
  // create a new random line length
  lineLength = random(125, 300);
}

void keyReleased() {
  if (key == DELETE || key == BACKSPACE) background(#d92b6a);
  if (key == 's' || key == 'S') saveFrame(timestamp()+"_##.png");


  // reverse direction and mirrow angle
  if (key=='d' || key=='D') {
    angle = angle + 180;
    angleSpeed = angleSpeed * -1;
  }

  // r g b alpha
  if (key == ' ') col = color(random(255), random(255), random(255), random(80, 150));
}

void keyPressed() {
  if (keyCode == UP) lineLength += 5;
  if (keyCode == DOWN) lineLength -= 5;
  if (keyCode == LEFT) angleSpeed -= 0.5;
  if (keyCode == RIGHT) angleSpeed += 0.5;
}

// timestamp
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
