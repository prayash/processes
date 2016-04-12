// Processes - Day 96
// Prayash Thapa - April 5, 2016

int numParticles = 20;
Particle[] particles = new Particle[numParticles];
Attractor a = new Attractor();

// ************************************************************************************

void setup() {
  size(600, 400);
  background(#202020);

  for (int i = 0; i < particles.length; i++) {
    particles[i] = new Particle(random(0.5, 2), random(width), random(height));
  }
}

// ************************************************************************************

void draw() {
  for (int i = 0; i < particles.length; i++) {
    PVector f = a.attract(particles[i]);
    particles[i].accelerate(f);
    particles[i].run();
  }
}

// ************************************************************************************
// - Attractor

class Attractor {
  float mass = 20, gravity = 4;
  PVector location = new PVector(width / 2, height / 2);;

  PVector attract(Particle p) {
    PVector force = PVector.sub(location, p.location);
    float distance = constrain(force.mag(), 5.0, 50.0);
    float strength = (gravity * mass * p.mass) / (distance * distance);
    force.normalize();
    force.mult(strength);
    return force;
  }
}

// ************************************************************************************
// - Particle

class Particle {
  PVector location, velocity, acceleration;
  float size, mass;

  Particle(float _mass, float _x, float _y) {
    location = new PVector(_x, _y);
    velocity = new PVector(random(-4, 4), random(-4, 4));
    acceleration = new PVector(0, 0);
    mass = _mass;
    size = 2;
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0.2);
  }

  void display() {
    fill(255, 50); noStroke();
    if (random(1) > 0.95) ellipse(location.x, location.y, size, size);

    for (int i = 0; i < particles.length; i++) {
      Particle o = particles[i];
      float distance = dist(location.x, location.y, o.location.x, o.location.y);
      stroke(255, 10);
      if (distance > 0 && distance < 100) line(location.x, location.y, o.location.x, o.location.y);
    }
  }

  void accelerate(PVector force) {
    acceleration.add(PVector.div(force, mass));
  }

  void run() { update(); display(); }
}

void keyReleased() {
  if (key == DELETE || key == BACKSPACE) background(#202020);
  if (key == 's') saveFrame("_##.png");
  if (key == 'b') filter(BLUR, 1);
  if (key == 'e') filter(ERODE);
  if (key == 'd') filter(DILATE);
}
