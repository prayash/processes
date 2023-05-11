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

// Processes - Day 137
// Prayash Thapa - May 16, 2016

Firefly[] ff = new Firefly[20];
int frames = 90;
float theta;

// ************************************************************************************

public void setup() {
  
  for (int i = 0; i < ff.length; i++) {
    ff[i] = new Firefly(random(width), random(height));
  }
}

// ************************************************************************************

public void draw() {
  background(51);

  for (int i = 0; i < ff.length; i++) {
    ff[i].update();
  }

  loadPixels();

  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      int index = x + y * width;
      float sum = 0;
      for (Firefly f : ff) {
        float d = dist(x, y, f.pos.x, f.pos.y);
        sum += f.r / d * 15;
      }
      pixels[index] = color(sum / 2, sum / 2, sum / 0.75f);
    }
  }

  updatePixels();

  theta += TWO_PI / frames;
  // if (frameCount<=frames) saveFrame("image-###.gif");
}


// ************************************************************************************

class Firefly {
  PVector pos, orig;
  float r, d, offSet;

  Firefly(float _x, float _y) {
    orig = new PVector(_x, _y);
    pos = new PVector(0, 0);
    r = random(20, 60);
    d = random(25, 150);
    offSet = random(-PI, PI);
  }

  public void update() {
    pos.x = orig.x + cos(theta + offSet) * d;
    pos.y = orig.y + sin(theta + offSet) * d;
  }
}
  public void settings() {  size(750, 540); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "build" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
