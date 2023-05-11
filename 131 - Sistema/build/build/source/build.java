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

// Processes - Day 131
// Prayash Thapa - May 10, 2016

Planet sun;

// ************************************************************************************

public void setup() {
  
  sun = new Planet(50, 0, 0);
  sun.spawnMoons(5, 1);
}

// ************************************************************************************

public void draw() {
  background(0xff333333);

  translate(width/2, height/2);
  sun.render();
}

class Planet {
  float radius, angle, distance, orbitSpeed;
  Planet[] planets;

  Planet(float r, float d, float o) {
    radius = r;
    distance = d;
    angle = random(TWO_PI);
    orbitSpeed = o;
  }

  public void orbit() {
    angle += orbitSpeed * 0.01f;

    if (planets != null) {
      for (int i = 0; i < planets.length; i++) planets[i].orbit();
    }
  }

  public void spawnMoons(int total, int level) {
    planets = new Planet[total];
    for (int i = 0; i < planets.length; i++) {
      float r = radius / 2;
      float d = random(75, 300);
      float o = random(0.02f, 0.1f);
      planets[i] = new Planet(r, d, o);
      if (level < 2) {
        int num = PApplet.parseInt(random(0, 4));
        planets[i].spawnMoons(num, level + 1);
      }
    }
  }

  public void render() {
    orbit();

    pushMatrix();
      rotate(angle);
      translate(distance, 0);
      fill(255); noStroke();
      ellipse(0, 0, radius, radius);

      if (planets != null) {
        for (int i = 0; i < planets.length; i++) {
          planets[i].render();
        }
      }
    popMatrix();
  }
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
