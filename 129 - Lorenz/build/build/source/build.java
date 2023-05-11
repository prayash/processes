import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import peasy.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class build extends PApplet {

// Processes - Day 129
// Prayash Thapa - May 8, 2016



float x = 0.01f, y = 0, z = 0;
float sigma = 10;
float beta = 28;
float rho = 8.0f/3.0f;

ArrayList<PVector> points = new ArrayList<PVector>();
PeasyCam cam;

// ************************************************************************************

public void setup() {
  
  colorMode(HSB);
  cam = new PeasyCam(this, 500);
}

// ************************************************************************************

public void draw() {
  background(0xffE4E4E4);

  float dt = 0.02f;
  float dx = (sigma * (y - x)) * dt;
  float dy = (x * (beta - z)  - y) * dt;
  float dz = (x * y - rho * z) * dt;
  x += dx;
  y += dy;
  z += dz;

  points.add(new PVector(x, y, z));

  translate(0, 0, -80);
  scale(5); strokeWeight(1);
  noFill();

  float hue = 0;
  beginShape();
    for (PVector v : points) {
      stroke(hue, 205, 255);
      strokeWeight(hue % 10);
      point(v.x, v.y, v.z);
      PVector offset = PVector.random3D();
      offset.mult(0.0005f);
      v.add(offset);
      hue += 0.1f;
      if (hue > 255) hue = 0;
    }
  endShape();
}
  public void settings() {  fullScreen(P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "build" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
