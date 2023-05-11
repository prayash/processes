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

// Processes - Day 120
// Prayash Thapa - April 29, 2016

int max = 100;
int min = 5;

ArrayList<Particle> particles = new ArrayList();

// ************************************************************************************

public void setup() {
  
  for (int i = 0; i < 100; i++) particles.add(new Particle());
}

// ************************************************************************************

public void draw() {
  noStroke(); fill(0xffDC5978, 255);
  rect(0, 0, width, height);

  for (Particle p : particles) p.render();
  // if (frameCount % 4 == 0) saveFrame("image-####.gif");
}

// ************************************************************************************

class Particle {

  PVector position, velocity;
  float radius = 5;
  float mult = 1.5f;
  float opacity;

  Particle() {
    position = new PVector(random(radius, width - radius), random(radius, height - radius));
    velocity = new PVector(mult * cos(random(TWO_PI)), mult * sin(random(TWO_PI)));
    opacity = random(min, max);
  }

  public Particle update() {
    position.add(velocity);
    if (position.x < radius || position.x >= width - radius) velocity.x *= -1;
    if (position.y < radius || position.y >= height - radius) velocity.y *= -1;
    return this;
  }

  public void display() {
    fill(0xffEBEBEB, opacity * 4);
    ellipse(position.x, position.y, radius, radius);

    for (int i = 1; i < particles.size() - 1; i++) {
      Particle p2 = particles.get(i);

      // Calculate distance from current node to every other
      float dist = distance(position, p2.position);

      // Only draw if certain distance between nodes
      if (dist > 20 && dist < 100) {
        float t = (opacity + p2.opacity) / 1.5f;
        stroke(0xffEBEBEB, t); strokeWeight(1);
        line(position.x, position.y, p2.position.x, p2.position.y);
      }

      // Inner loop further enumerates to all other vertices to calculate triangulation
      for (int j = i + 1; j < particles.size(); j++) {
        Particle p3 = particles.get(j);

        // Triangulation
        if (dist <= 80 && distance(p2.position, p3.position) <= 80 && distance(p3.position, position) <= 80) {
          float t = (opacity + p2.opacity + p3.opacity) / 4;
          noStroke(); fill(0xffEBEBEB, t);
          triangle(position.x, position.y, p2.position.x, p2.position.y, p3.position.x, p3.position.y);
        }
      }
    }
  }

  public void render() {
    update().display();
  }

  public float distance(PVector _p1, PVector _p2) {
    return PVector.dist(_p1, _p2);
  }
}

// ************************************************************************************

public void mousePressed() {
  particles.clear();
  setup();
}
  public void settings() {  size(800, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "build" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
