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

// Processes - Day 31
// Prayash Thapa - January 31, 2016

float div = 100;
float r = 30;
float n = random(100);
float widthDiv, heightDiv;

// ************************************************************************************

public void setup() {
  
  colorMode(HSB, 360, 100, 100, 100);
  widthDiv = width / div;
  heightDiv = height / div;
}

// ************************************************************************************

public void draw() {
  background(0);
  noStroke();

  for (int i = -2; i < div + 6; i++) {
    fill(320, 60, 60 * (i * (1 / div)));
    beginShape();
      vertex(-2 * widthDiv, (div * r * 2) + i * heightDiv);
      vertex(-2 * widthDiv, i * heightDiv);

      for (int j = -2; j < div + 6; j++) {
        float theta = map(noise(n, i * 0.5f, j * 0.015f), 0, 1, 0, TWO_PI);
        theta += frameCount * 0.05f;
        float x = (cos(theta) * r) + (j * widthDiv);
        float y = (sin(theta) * r) + (i * heightDiv);
        curveVertex(x, y);
      }

      vertex((div + 6) * widthDiv, (i * heightDiv));
      vertex((div + 6) * widthDiv, (div * r * 2) + i * heightDiv);
    endShape();
  }
  n += 0.03f;
}

// ************************************************************************************

public void keyReleased() {
  if (key == 's') saveFrame("_##.png");
}
  public void settings() {  size(600, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "build" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
