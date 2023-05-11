import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.Iterator; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class build extends PApplet {

// Processes - Day 163
// Prayash Thapa - June 11, 2016



int count = 0;
int radius = 250;
int maxParticles = 200;
ArrayList particles;

Gravity gravity;
boolean dragging;

// ************************************************************************************

public void setup() {
  background(0xffE4E4E4);
  
  gravity = new Gravity();
  particles = new ArrayList();
}

// ************************************************************************************

public void draw() {
  gravity.exist();

  for (Iterator it = particles.iterator();  it.hasNext();) {
    Particle particle = (Particle) it.next();
    particle.exist();
  }

  // Only generate particles if mouse pressed!
  if (dragging) {
    float angle = random(0, TWO_PI);
    float x = width/2 + cos(angle) * radius;
    float y = height/2 + sin(angle) * radius;

    particles.add(new Particle(count, particles, x, y));
    count++;
  }
}

public void mousePressed() {
  dragging = true;
}

public void mouseReleased() {
  dragging = false;
}

public void keyPressed() {
  if (key == ' ') background(0xffE4E4E4);
}

// ************************************************************************************

class Gravity {
  int index;

  float x, y;

  float damp;
  float E, R, F, P, A;
  float Q, M;

  Gravity() {
    x = width/2;
    y = height/2;

    M = 0.005f;
    Q = 0.01f;

    damp = 0.97f;
  }

  public void exist() {
    attractParticles();
    render();
  }

  public void attractParticles() {

    for (Iterator it = particles.iterator(); it.hasNext();) {
      Particle me = (Particle) it.next();

      R = dist(x, y, me.x, me.y);
      M = 0.05f * ((R/100.0f));
      Q = M * 2.0f;
      E = me.Q / (R * R);
      P = abs(Q) * abs(me.Q) / pow(R, 3);
      F = (Q * E) + P;
      A = (F/M) * 6.0f;

      if (R > 50) {
        me.xv += A * (x - me.x);
        me.yv += A * (y - me.y);
      } else if (R > 2.0f && R < 50) {
        me.xv -= A * (x - me.x);
        me.yv -= A * (y - me.y);
      }
    }
  }

  public void render() {
    // fill(0);
    // ellipse(x, y, 20, 20);
  }
}

// ************************************************************************************

class Particle {
  int index;

  float x, y;
  float xv, yv;
  float radius;

  float damp;
  float E, R, F, P, A;
  float Q, M;
  float hue, saturation, lightness, alpha;

  boolean gone;

  ArrayList parent;

  Particle(int sentIndex, ArrayList parentSent, float xSent, float ySent) {
    index     = sentIndex;
    parent    = parentSent;
    radius    = (int) random(4, 8);
    M         = .5f;
    Q         = 2;
    damp      = .9f;

    x         = (float)xSent;
    y         = (float)ySent;
    hue       = random(55, 255);
    saturation= random(55, 255);
    lightness = random(55, 255);
    alpha     = random(1, 20);
  }

  public void exist() {
    repelParticles();
    move();
    render();
  }

  public void repelParticles() {
    for (Iterator it = parent.iterator(); it.hasNext(); ) {
      Particle me = (Particle) it.next();
      if (me != this) {
        R = dist(x, y, me.x, me.y);
        E = me.Q/(R * R);
        P = Q * me.Q / pow(R,6);
        F = (Q * E) + P;
        A = (F/M) * 2.0f;

        if (R > 2.0f) {
          xv += A * (x - me.x) / R;
          yv += A * (y - me.y) / R;
        }
      }
    }
    xv *= damp;
    yv *= damp;
  }

  public void move() {
    x += xv;
    y += yv;
  }

  public void render() {
    colorMode(HSB, 255);
    fill(hue, saturation, lightness, alpha);
    noStroke();
    ellipse(x, y, radius, radius);
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
