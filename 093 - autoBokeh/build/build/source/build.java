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

// Processes - Day 93
// Prayash Thapa - April 2, 2016

// ************************************************************************************

int num = 40, frames = 165;
float x, y, angle = 165, ease = 0.5f;
boolean easing = true;

PVector target;
PVector[] points = new PVector[num];

// ************************************************************************************

public void setup() {
  
  background(0xff202020);
  colorMode(HSB, 360, 100, 100);

  for (int i = 0; i < num; i++) points[i] = new PVector(width/2, height/2);
}

// ************************************************************************************

public void draw() {
  noStroke();

  float d = 150;
  x = width/2 + cos(angle) * d * random(50);
  y = height/2 + sin(angle) * d * random(10);

  target = new PVector(x, y);
  PVector leader = new PVector(target.x, target.y);

  for (int i = 0; i < num; i++) {
    fill(180 / num * (i + frameCount), 70, 90, random(1, 2));

    PVector distance = PVector.sub(leader, points[i]);
    PVector velocity = PVector.mult(distance, ease);

    points[i].add(velocity);
    ellipse(points[i].x, points[i].y, 70, 70);
    leader = points[i];
  }

  angle += frames;
}

public void keyReleased() {
  if (key == 's' || key == 'S') saveFrame("_##.png");
  if (key == DELETE || key == BACKSPACE) background(0xff202020);
}
  public void settings() {  size(500, 500); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "build" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
