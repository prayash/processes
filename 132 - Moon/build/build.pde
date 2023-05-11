// Processes - Day 132
// Prayash Thapa - May 11, 2016

import peasy.*;

Planet sun;
PeasyCam cam;

// ************************************************************************************

void setup() {
  size(600, 600, P3D);
  cam = new PeasyCam(this, 600);
  sun = new Planet(50, 0, 2);
  sun.spawnMoons(2, 1);
}

// ************************************************************************************

void draw() {
  background(#333333);
  // lights();
  pointLight(255, 255, 255, 0, 0, 0);
  sun.render();
}

class Planet {
  float radius, angle, distance, orbitSpeed;
  Planet[] planets;
  PVector v;

  Planet(float r, float d, float o) {
    v = PVector.random3D();

    radius = r;
    distance = d;
    v.mult(distance);
    angle = random(TWO_PI);
    orbitSpeed = o;
  }

  void orbit() {
    angle += orbitSpeed;

    if (planets != null) {
      for (int i = 0; i < planets.length; i++) planets[i].orbit();
    }
  }

  void spawnMoons(int total, int level) {
    planets = new Planet[total];
    for (int i = 0; i < planets.length; i++) {
      float r = radius / (level * 2);
      float d = random((radius + r), (radius + r) * 2);
      float o = random(-0.1, 0.1);
      planets[i] = new Planet(r, d, o);
      if (level < 3) {
        int num = int(random(0, 4));
        planets[i].spawnMoons(num, level + 1);
      }
    }
  }

  void render() {
    orbit();

    pushMatrix();
      PVector v2 = new PVector(1, 0, 1);
      PVector p = v.cross(v2);
      rotate(angle/2, p.x, p.y, p.z);

      translate(v.x, v.y, v.z);
      fill(255); noStroke();
      sphere(radius);

      if (planets != null) {
        for (int i = 0; i < planets.length; i++) {
          planets[i].render();
        }
      }
    popMatrix();
  }
}
