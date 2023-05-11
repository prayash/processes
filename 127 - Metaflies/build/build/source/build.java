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

// Processes - Day 127
// Prayash Thapa - May 6, 2016

Particle[] particles = new Particle[8];

// ************************************************************************************

public void setup() {
  
  colorMode(HSB);

  for (int i = 0; i < particles.length; i++) {
    particles[i] = new Particle(random(width), random(height));
  }
}

// ************************************************************************************

public void draw() {
  background(51);

  loadPixels();

  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      int i = x + y * width;
      float sum = 0;
      for (Particle p : particles) {
        float d = dist(x, y, p.pos.x, p.pos.y);
        sum += p.radius / d;
      }

      pixels[i] = color(sum % 255, 255, 255);
    }
  }

  updatePixels();

  for (Particle p : particles) p.render();

}

class Particle {
  PVector pos, vel;
  float radius;

  Particle(float _x, float _y) {
    pos = new PVector(_x, _y);
    vel = PVector.random2D();
    vel.mult(random(2, 5));
    radius = random(30, 150) * 150;
  }

  public void update() {
    pos.add(vel);
  }

  public void render() {
    update();

    if (pos.x > width || pos.x < 0) {
      vel.x *= -1;
    } else if (pos.y > height || pos.y < 0) {
      vel.y *= -1;
    }

    noFill();
    ellipse(pos.x, pos.y, radius * 2, radius * 2);
  }
}
  public void settings() {  size(640, 360); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "build" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
