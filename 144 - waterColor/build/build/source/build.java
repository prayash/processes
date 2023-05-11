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

// Processes - Day 144
// Prayash Thapa - May 23, 2016

ArrayList<Brush> brushes;

// ************************************************************************************

public void setup() {
  
  background(255);
  brushes = new ArrayList<Brush>();
  for (int i = 0; i < 50; i++) {
    brushes.add(new Brush());
  }
}

// ************************************************************************************

public void draw() {
  for (Brush brush : brushes) {
    brush.paint();
  }
}

// ************************************************************************************

class Brush {
  float angle;
  int components[];
  float x, y;
  int clr;

  Brush() {
    angle = random(TWO_PI);
    x = random(width);
    y = random(height);
    clr = color(random(255), random(255), random(255), 5);
    components = new int[2];
    for (int i = 0; i < 2; i++) {
      components[i] = PApplet.parseInt(random(1, 5));
    }
  }

  public void paint() {
    float a = 0;
    float r = 0;
    float x1 = x;
    float y1 = y;
    float u = random(0.5f, 1);

    fill(clr);
    noStroke();

    beginShape();
    while (a < TWO_PI) {
      vertex(x1, y1);
      float v = random(0.85f, 1);
      x1 = x + r * cos(angle + a) * u * v;
      y1 = y + r * sin(angle + a) * u * v;
      a += PI / 180;
      for (int i = 0; i < 2; i++) {
        r += sin(a * components[i]);
      }
    }
    endShape(CLOSE);

    if (x < 0 || x > width ||y < 0 || y > height) {
      angle += HALF_PI;
    }

    x += 2 * cos(angle);
    y += 2 * sin(angle);
    angle += random(-0.15f, 0.15f);
  }
}

public void mouseClicked() {
  setup();
}
  public void settings() {  fullScreen(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "build" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
