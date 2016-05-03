// Processes - Day 116
// Prayash Thapa - April 25, 2016

int   num     = 1000;
float nAmp    = 1;
float nScale  = 80;

ArrayList<Wurm> wurms = new ArrayList<Wurm>();

// ************************************************************************************

void setup() {
  size(600, 300);
  for (int i = 0; i < 300; i++) wurms.add(new Wurm());
}

// ************************************************************************************

void draw() {
  fill(#FFFFFF, 20); noStroke();
  rect(0, 0, width, height);

  for (Wurm w : wurms) w.render();
}

// ************************************************************************************

class Wurm {

  PVector position, velocity;
  float speed, angle;

  Wurm() {
    position = new PVector(random(width), random(height), random(2, 8));
    velocity = new PVector(cos(0), sin(0));
    speed = random(1, 3);
  }

  void update() {
    // Calculate next step using noise
    angle = noise(position.x / nScale, position.y / nScale, frameCount / nScale) * TWO_PI * nAmp;

    // Constantly re-calculate velocity using noise angle
    velocity = new PVector(cos(angle), sin(angle));

    // We scale velocity with the particle's respective speed
    velocity.mult(speed);
    position.add(velocity);

    // Boundary-check
    if (position.x < 0 || position.x > width) position = new PVector(random(width), random(height), random(2, 8));
    if (position.y < 0 || position.y > height) position = new PVector(random(width), random(height), random(2, 8));
  }

  void render() {
    update();

    // Color gets calculated using distance between position & center of canvas
    colorMode(HSB, 360, 100, 100);
    fill(dist(position.x, position.y, width/2, height/2) * 2, 50, 100);
    ellipse(position.x, position.y, position.z, position.z);
  }
}

// ************************************************************************************

void mousePressed() {
  nScale = random(10, 200);
  nAmp = random(0.3, 10);
  wurms.clear(); setup();
}
