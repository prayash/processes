import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class build extends PApplet {

// Processes - Day 38
// Prayash Thapa - February 8, 2016

// ************************************************************************************

int num = 15;
Orbit[] oArr   = new Orbit[num];

public void setup() {
  
  background(0xffCA1244);
  noFill();

  float startX = random(width/2) + (width/2);
  float startY = random(height/2) + (height/2);
  for (int i = 0; i < num; i++) oArr[i] = new Orbit(startX, startY);
}

// ************************************************************************************

public void draw() {
  for (int i = 0; i < num; i++) oArr[i].update();
}

// ************************************************************************************

class Orbit {
  float centreX = width/2,  centreY = height/2;
  float angleIncrease, radiusNoise, strokeCol;
  float angle = 0, radius = 100;
  float lastX = 9999, lastY = 0;

  Orbit (float _x, float _y) {
    centreX = _x;
    centreY = _y;
    radiusNoise = random(10);
    lastX = 9999;
    strokeCol = random(255);
    angle = 0;
    angleIncrease = random(1) + 1;
  }

  public void update() {
    radiusNoise += 0.001f;
    radius = (noise(radiusNoise) * (width)) - 100;
    angle += angleIncrease;

    if (angle > 360) angle -= 360;
    else if (angle < 0) angle += 360;

    float rad = radians(angle + 90);
    float x = centreX + (radius * cos(rad));
    float y = centreY + (radius * sin(rad));

    // Orbiting
    if (lastX != 9999) {
      strokeWeight(4);
      stroke(strokeCol, random(20) + 50);
      line(x, y, lastX, lastY);
      // This could be so fucking cool if I mapped the lines to stray off-path according to audio!


      // Texturing
      if (random(5) > 4) {
        strokeWeight(2);
        stroke(strokeCol, 1);
        line(x, y, random(width), random(height));
      }

      // Arbitrary Ellipticals
      if (random(1) > 0.85f) ellipse(x, y, 5, 5);
    }

    lastX = x;
    lastY = y;
  }
}

// ************************************************************************************

public void mousePressed() {
  background(0xffCA1244);
}

public void keyReleased() {
  if (key == 's') saveFrame("_##.png");
}
  public void settings() {  size(800, 400); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "build" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
