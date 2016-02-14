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

// Processes - Day 18
// Prayash Thapa - January 18, 2016

int num = 50, frames = 240, colorCounter = 0;
Orb[] orbs = new Orb[num];
float theta;
int[] palette = { 0xffA0ECD0, 0xffECD893, 0xffE7AF7E, 0xffB78376 };

// ************************************************************************************

public void setup() {
  
  for (int i = 0; i < num; i++) {
    float d = 150;
    float x = width / 2 + cos(TWO_PI / num * i) * d;
    float y = height / 2 + sin(TWO_PI / num * i) * d;;
    orbs[i] = new Orb(x, y, random(10, 20));
  }
}

// ************************************************************************************

public void draw() {
  // ---------------
  // Background
  fill(0);
  colorMode(HSB, 100, 1, 1);
  noStroke();
  beginShape();
    // Yellows and Reds
    fill(12.5f * sin((colorCounter * 0.025f ) / 100.0f) + 12.5f, 1, 1);
    vertex(-width, -height);

    // Yellows and Whites
    fill(12.5f * cos((colorCounter * 0.025f ) / 200.0f) + 37.5f, 1, 1);
    vertex(width, -height);

    // Blues and Greens
    fill(12.5f * cos((colorCounter * 0.025f ) / 100.0f) + 62.5f, 1, 1);
    vertex(width, height);

    // Reds + Purples
    fill(12.5f * sin((colorCounter * 0.25f ) / 200.0f) + 87.5f, 1, 1);
    vertex(-width, height);
  endShape();
  colorCounter += 5;

  colorMode(RGB);
  for (int i=0; i<orbs.length; i++) {
    stroke(0xffFFFFFF);
    orbs[i].run();
  }
  theta += TWO_PI/frames * 0.5f;
}

// ************************************************************************************

class Orb {
  float x, y, size, px, py, offSet, radius;
  int dir; int col;

  Orb(float _x, float _y, float _size) {
    x = _x;
    y = _y;
    size = _size;
    offSet = random(TWO_PI);
    radius = random(20, 150);
    dir = random(1) > .5f ? 1 : -1;
    col = palette[PApplet.parseInt(random(palette.length))];
  }

  public void run() {
    update();
    showLines();
    display();
  }

  public void update() {
    float vari = map(sin(theta), -1, 1, 1, 2);
    px = x + cos(theta * dir + offSet) * radius * vari;
    py = y + sin(theta * dir) * radius * vari;
  }

  public void showLines() {
    for (int i = 0; i < orbs.length; i++) {
      float distance = dist(px, py, orbs[i].px, orbs[i].py);
      if (distance > 0 && distance < 100) {
        line(px, py, orbs[i].px, orbs[i].py);
      }
    }
  }

  public void display() {
    colorMode(RGB);
    noStroke();
    for (int i = 0; i < 7; i++) {
      col = 255;
      fill(col, 55 + 200.0f / 7 * i, 255);
      float scale = map(i, 0, 6, 1, .5f) * size;
      ellipse(px, py, scale, scale);
    }
  }
}

// ************************************************************************************

public void keyPressed() {
  if (key == 's') saveFrame("render-###.png");
}
  public void settings() {  size(800, 400); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "build" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
