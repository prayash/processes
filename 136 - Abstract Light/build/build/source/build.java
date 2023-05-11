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

// Processes - Day 136
// Prayash Thapa - May 15, 2016

Ray[] rays = new Ray[40];

// ************************************************************************************

public void setup() {
  
  colorMode(HSB, 255);
  frameRate(15);
  background(40);

  for (int i = 0; i < rays.length; i++) {
    rays[i] = new Ray(random(55, 255), random(65, 200), random(5, 255));
  }
}

// ************************************************************************************

public void draw() {
  for (Ray c : rays) c.render();
}

// ************************************************************************************

class Ray {
  float x, y;
  float vx, vy;
  float hue, saturation, lightness;
  float w, a;
  float maxVel = 5;

  Ray(float _hue, float _saturation, float _lightness) {
    x = random(width);
    y = height / 2;
    vx = 0; vy = 0;
    hue = _hue;
    saturation = _saturation;
    lightness = _lightness;
    a = random(1, 20);
    w = 1;
  }

  public void update() {
    vx += random(2) - 1;
    vy += random(2) - 1;
    x += vx;
    y += vy;

    if (vx > maxVel) vx = maxVel;
    if (vx < -maxVel) vx = -maxVel;
    if (vy > maxVel) vy = maxVel;
    if (vy < -maxVel) vy = -maxVel;
    if (x >= width || x <= 0) vx = -vx;
    if (y >= height || y <= 0) vy = -vy;
  }

  public void render() {
    update();
    stroke(hue, saturation, lightness, a);
    strokeWeight(w);

    for (int i = 0; i < rays.length; i++) {
      Ray r = rays[i];
      float dx = r.x - x;
      float dy = r.y - y;
      float dist = sqrt(dx * dx + dy * dy);
      if (dist <= 150) line(x, y, r.x, r.y);
    }
  }
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
