// Processes - Day 127
// Prayash Thapa - May 6, 2016

Particle[] particles = new Particle[8];

// ************************************************************************************

void setup() {
  size(640, 360);
  colorMode(HSB);

  for (int i = 0; i < particles.length; i++) {
    particles[i] = new Particle(random(width), random(height));
  }
}

// ************************************************************************************

void draw() {
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

  void update() {
    pos.add(vel);
  }

  void render() {
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
