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

// Processes - Day 44
// Prayash Thapa - February 13, 2016

// ************************************************************************************

public void setup() {
  
  background(0xff2F2F2F);
  colorMode(HSB, 100);
}

// ************************************************************************************

public void draw() {
  background(0xff2F2F2F);
  noStroke();

  float angle = map(dist(mouseX, mouseY, width / 2, height / 2), 0, width / 2, 0, PI);
  for(int i = 10; i > 0; i--) {
    fill(i * 10, 100, 100);
    pushMatrix();
      translate(width / 2, height / 2);
      rotate(radians(i * frameCount * 0.5f));
      arc(0, 0, i * 50, i * 50, 0, angle);
    popMatrix();
  }

  pushMatrix();
    translate(width / 2, height / 2);
    fill(0, 0, 100);
    ellipse(0, 0, 25, 25);
  popMatrix();
  filter(DILATE);

  // if (mousePressed) saveFrame("frame_###.png");
}
  public void settings() {  size(500, 300); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "build" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
