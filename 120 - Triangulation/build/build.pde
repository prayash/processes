// Processes - Day 120
// Prayash Thapa - April 29, 2016

int max = 100;
int min = 5;

ArrayList<Particle> particles = new ArrayList();

// ************************************************************************************

void setup() {
  size(800, 600);
  for (int i = 0; i < 100; i++) particles.add(new Particle());
}

// ************************************************************************************

void draw() {
  noStroke(); fill(#EEEEEE, 80);
  rect(0, 0, width, height);

  for (Particle p : particles) p.render();
  if (frameCount % 4 == 0) saveFrame("image-####.gif");
}

// ************************************************************************************

class Particle {

  PVector position, velocity;
  float radius = 5;
  float mult = 1.5;
  float opacity;

  Particle() {
    position = new PVector(random(radius, width - radius), random(radius, height - radius));
    velocity = new PVector(mult * cos(random(TWO_PI)), mult * sin(random(TWO_PI)));
    opacity = random(min, max);
  }

  Particle update() {
    position.add(velocity);
    if (position.x < radius || position.x >= width - radius) velocity.x *= -1;
    if (position.y < radius || position.y >= height - radius) velocity.y *= -1;
    return this;
  }

  void display() {
    fill(#202020, opacity * 4);
    ellipse(position.x, position.y, radius, radius);

    for (int i = 1; i < particles.size() - 1; i++) {
      Particle p2 = particles.get(i);

      // Calculate distance from current node to every other
      float dist = distance(position, p2.position);

      // Only draw if certain distance between nodes
      if (dist > 20 && dist < 100) {
        float t = (opacity + p2.opacity) / 1.5;
        stroke(#202020, t); strokeWeight(1);
        line(position.x, position.y, p2.position.x, p2.position.y);
      }

      // Inner loop further enumerates to all other vertices to calculate triangulation
      for (int j = i + 1; j < particles.size(); j++) {
        Particle p3 = particles.get(j);

        // Triangulation
        if (dist <= 80 && distance(p2.position, p3.position) <= 80 && distance(p3.position, position) <= 80) {
          float t = (opacity + p2.opacity + p3.opacity) / 4;
          noStroke(); fill(#202020, t);
          triangle(position.x, position.y, p2.position.x, p2.position.y, p3.position.x, p3.position.y);
        }
      }
    }
  }

  void render() {
    update().display();
  }

  float distance(PVector _p1, PVector _p2) {
    return PVector.dist(_p1, _p2);
  }
}

// ************************************************************************************

void mousePressed() {
  particles.clear();
  setup();
}
