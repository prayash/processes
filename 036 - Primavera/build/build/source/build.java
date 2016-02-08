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

// Processes - Day 36
// Prayash Thapa - February 6, 2016

// ************************************************************************************

public void setup() {
  
  background(255);
  frameRate(15);
}

public void draw() {
  noStroke();
  fill(245, 15);
  rectMode(CORNER); rect(0, 0, width, height);

  for (int x = 70; x < 431; x += 36) {
    for (int y = 70; y < 431; y += 38) {
      if (random(1) > .5f) {
        fill(x/2, y/2, 20, 50);
        rectMode(CENTER); rect(x, y, 30, 30);
      } else {
        fill(x/2, y/2, 20, 150);
        arc(x, y, 30, 30, random(-6, 1), random(-6, 1));
      }
    }
  }
}

// ************************************************************************************

public void keyReleased() {
  if (key == 's') saveFrame("_##.png");
}
  public void settings() {  size(250, 500); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "build" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
