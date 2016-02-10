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

// Processes - Day 39
// Prayash Thapa - February 9, 2016

// ************************************************************************************

float a = random(4000.0f, 6000.0f);
float b = random(4000.0f, 6000.0f);
float c = random(4000.0f, 6000.0f);
float a1 = random(-2, 1);
float b1 = random(-2, 1);
float c1 = random(-2, 1);
float xoff = 0.0f;

public void setup() {
  background(255);
  
}

// ************************************************************************************

public void draw() {
  background(255);
  noStroke();
  xoff += .01f;
  float n = noise(xoff) * 385;

  translate(width/2, height/2);
  // rotate(millis()/a);
  fill(255, 0, 0, 100);
  arc(0, 0, 400, 400, a1, HALF_PI);
  // rotate(millis()/b);
  // fill(0, 255, 0, 100);
  // arc(0, 0, 400, 400, b1, HALF_PI);
  // rotate(millis()/c);
  // fill(0, 0, 255, 100);
  // arc(0, 0, 400, 400, c1, HALF_PI);

  fill(255);
  // ellipse(0, 0, n, n);
}

// ************************************************************************************

public void keyReleased() {
  if (key == 's') saveFrame("_##.png");
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
