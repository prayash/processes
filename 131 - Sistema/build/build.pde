// Processes - Day 131
// Prayash Thapa - May 10, 2016

Planet sun;

// ************************************************************************************

void setup() {
  size(600, 600);
  sun = new Planet(50, 0, 0);
  sun.spawnMoons(5, 1);
}

// ************************************************************************************

void draw() {
  background(#333333);

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

  void orbit() {
    angle += orbitSpeed * 0.01;

    if (planets != null) {
      for (int i = 0; i < planets.length; i++) planets[i].orbit();
    }
  }

  void spawnMoons(int total, int level) {
    planets = new Planet[total];
    for (int i = 0; i < planets.length; i++) {
      float r = radius / 2;
      float d = random(75, 300);
      float o = random(0.02, 0.1);
      planets[i] = new Planet(r, d, o);
      if (level < 2) {
        int num = int(random(0, 4));
        planets[i].spawnMoons(num, level + 1);
      }
    }
  }

  void render() {
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
