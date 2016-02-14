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

// Processes - Day 17
// Prayash Thapa - January 17, 2016

int colorCounter = 0, num = 150, frames = 480, edge = 40;
Fragment[] fragments = new Fragment[num];
float theta;

// ************************************************************************************

public void setup() {
  
  hint(ENABLE_STROKE_PURE);

  // Fragments
  for (int i = 0; i < num; i++) {
    float x = random(width);
    float y = (height - 2) / PApplet.parseFloat(num) * i;
    fragments[i] = new Fragment(x, y);
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

  // ---------------
  // Fragments
  colorMode(RGB);
  stroke(0xffFFFFFF, 75);
  strokeWeight(2);
  for (int i = 0; i < fragments.length; i++) {
    fragments[i].run();
  }
  theta += TWO_PI/frames * 0.35f;
}

// ************************************************************************************
// Fragment
class Fragment {
  float x, y;
  float px, py, offSet, radius;
  int dir;
  int col;

  Fragment(float _x, float _y) {
    x = _x;
    y = _y;
    offSet = random(TWO_PI);
    radius = random(5, 10);
    dir = random(1) > .5f ? 1 : -1;
  }

  public void run() {
    update();
    showLines();
  }

  public void update() {
    float vari = map(sin(theta + offSet), -1, 1, -2, -2);
    px = map(sin(theta + offSet) , -1, 1, 0, width);
    py = y + sin(theta * dir) * radius * vari;
  }

  public void showLines() {
    for (int i = 0; i < fragments.length; i++) {
      float distance = dist(px, py, fragments[i].px, fragments[i].py);
      vertex(px,py);
      if (distance > 0 && distance < 100) {
        strokeWeight(5);

        strokeWeight(1);
        line(px, py, fragments[i].px, fragments[i].py);
      }
    }
  }
}

// ************************************************************************************

public void keyPressed() {
  if (key == 's') saveFrame("render-###.png");
}
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
