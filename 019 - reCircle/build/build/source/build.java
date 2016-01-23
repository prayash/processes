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

// Processes - Day 19
// Prayash Thapa - January 19, 2016

// ************************************************************************************

int hex = 25, colorCounter = 0;
float radius = 270;

public void setup() {
  
  noStroke();
}

public void draw() {
  background(0xffFFFFFF);
  fill(255);
  translate(width, height / 2);

  for (int i = 0; i < hex; i++) {
    pushMatrix();
      rotate(TWO_PI / hex * i);
      colorMode(HSB, 100, 1, 1);
      fill(12.5f * sin((colorCounter * 0.25f ) / 200.0f) + 87.5f, 1, 1, 40);
      ellipse(radius/2, 0, radius, radius);
    popMatrix();
  }
  colorCounter += 10;
}

// ************************************************************************************

public void keyPressed() {
  if (key == 's') saveFrame("render-###.png");
}
  public void settings() {  size(440, 700); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "build" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
