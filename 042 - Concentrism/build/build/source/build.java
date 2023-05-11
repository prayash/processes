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

// Processes - Day 42
// Prayash Thapa - February 11, 2016

// ************************************************************************************

int NARCS = 20;
Concentrism[] cArr = new Concentrism[NARCS];

int[] palette = { 0xffEFFFCD, 0xff555152, 0xffDCE9BE, 0xff2E2633, 0xff991739 };
float theta; boolean save; int f;

public void setup() {
  
  background(20);
  rectMode(CENTER);
  strokeCap(SQUARE);
  frameRate(random(20, 60));

  for (int i = 0; i < cArr.length; i++) {
    int size = (int)random(width);
    float rotation = (PI/cArr.length) * i;
    int hue = (int)random(0, 5);
    float start = random(0, TWO_PI);
    float stop = start + random(PI/4, PI);

    cArr[i] = new Concentrism(size, rotation, hue, start, stop);
  }
}

// ************************************************************************************

public void draw() {
  noStroke();
  fill(20, 25);
  rect(width/2, height/2, width, height);
  translate(width/2, height/2);
  for (int i = 0; i < cArr.length; i++) {
    pushMatrix();
      noFill();
      rotate(theta * (i + 1) / 5);
      stroke(palette[i % 5], 200);
      cArr[i].display();
    popMatrix();
  }

  theta += 0.0523f;
  // filter(DILATE);
  if (save) if (frameCount % 4 == 0 && frameCount < f + 121) saveFrame("image-###.gif");
}

// ************************************************************************************

class Concentrism {
  float size, rotation, start, stop; int hue;
  Concentrism(float _size, float _rotation, int _color, float _start, float _stop) {
    size = _size;
    rotation = _rotation;
    hue = _color;
    start = _start;
    stop = _stop;
  }

  public void display() {
    // strokeWeight(random(25, 50));
    arc(0, 0, size, size, start, stop);
  }
}

// ************************************************************************************

public void mouseClicked() { setup(); }
public void keyPressed() {
  f = frameCount;
  save = true;
}

// void settings() {
//   fullScreen();
// }
  public void settings() {  size(700, 700); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "build" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
