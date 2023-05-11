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

// Processes - Day 159
// Prayash Thapa - June 7, 2016

int numFrames = 24;
PImage[] images = new PImage[numFrames];
PImage capture;

// ************************************************************************************

public void setup() {
  
  frameRate(numFrames);
  for (int i = 0; i < images.length; i++) {
    String imageName = (i) + ".jpg";
    images[i] = loadImage(imageName);
  }
}

// ************************************************************************************

public void draw() {
  background(0);
  camera(mouseX, mouseY, (height/1.3f) / tan(PI/6), mouseX, height/1.3f, 0, 0, 1, 0);
  int frame = frameCount % numFrames;
  translate(0, 100, 0);
  capture = images[frame].get();

  int steps = 7;
  for (int i = 0; i < width/steps; i++) {
    for (int j = 0; j < height/steps; j++) {
      pushMatrix();
        int c = capture.get(i * steps, j * steps);
        float z = brightness(c);
        fill(c);
        stroke(c);
        translate(i * steps, j * steps, z);
        box(steps - 2, steps - 2, steps - 2);
      popMatrix();
    }
  }
}
  public void settings() {  size(600, 400, P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "build" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
