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

float theta = 0.0f;

// ************************************************************************************

public void setup() {
  background(255);
  
  frameRate(15);
}

// ************************************************************************************

public void draw() {
  background(255);
  noStroke();
  float n = sin(theta) * 385;
  translate(width/2, height/2);

  for (int i = 0; i < 5; i++) {
    rotate(millis() / random(4000.0f, 6000.0f));
    fill(random(255), random(255), random(255), 100);
    arc(0, 0, 400, 400, random(-2, 1), HALF_PI);
  }

  fill(255);
  ellipse(0, 0, n, n);
  theta += .1f;

  if (frameCount % 2 == 0 && frameCount < 60) saveFrame("image-####.gif");
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
