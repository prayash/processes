// Processes - Day 100
// Prayash Thapa - April 9, 2016

ArrayList points = new ArrayList();
boolean drawing = false;
float radius;
PImage source;

// ************************************************************************************

void setup() {
  size(500, 500);
  background(255);
  source = loadImage("data.gif");
  noStroke();
}

// ************************************************************************************

void draw() {
  if (drawing) points.add(new Point(new PVector(mouseX + random(-10, 10), mouseY + random(-10, 10)), new PVector(0, 0), 200));

  for (int i = 0; i < points.size(); i++) {
    Point localPoint = (Point) points.get(i);
    if (localPoint.isDead) points.remove(i);
    for (int j = 0; j < 20; j++) localPoint.run();
  }
}

// ************************************************************************************

class Point {

  PVector pos, vel, noiseVec;
  float noiseFloat, lifeTime, age;
  boolean isDead;
  int pixelGrab;

  public Point(PVector _pos, PVector _vel, float _lifeTime) {
    pos = _pos;
    vel = _vel;
    lifeTime = _lifeTime;
    age = 0;
    isDead = false;
    noiseVec = new PVector();
    pixelGrab = source.get((int) pos.x, (int) pos.y);
  }

  void update() {
    if (1.0 - (age/lifeTime) <= 0 || pos.x < 0 || pos.x > width || pos.y < 0 || pos.y > height) {
      isDead = true;
      return;
    }

    // * Noise
    noiseFloat = noise(pos.x * 0.001, pos.y * 0.001, frameCount * 0.000001);
    noiseVec.x = cos(((noiseFloat) * TWO_PI));
    noiseVec.y = sin(((noiseFloat) * TWO_PI));

    vel.add(noiseVec);
    vel.div(2);
    pos.add(vel);
    age++;
  }

  void draw() {
    float r;
    if (age < lifeTime/2) {
      fill(red(pixelGrab), green(pixelGrab), blue(pixelGrab), map(age, 0, lifeTime/2, 0, 100));
      r = map(age, 0, lifeTime/2, 0, radius);
    } else {
      fill(red(pixelGrab), green(pixelGrab), blue(pixelGrab), map(age, lifeTime/2, lifeTime, 100, 0));
      r = map(age, lifeTime/2, lifeTime, radius, 0);
    }

    strokeWeight(r);
    stroke(0, 5);
    ellipse(pos.x, pos.y, r, r);
  }

  void run() {
    update();
    draw();
  }
}

// ************************************************************************************

void keyPressed() {
  if (key == 's') saveFrame("##.png");
}

void mousePressed() {
  drawing = true;
  radius = random(1, 5);
  filter(BLUR, 1); filter(DILATE);
}

void mouseReleased() {
  drawing = false;
}
