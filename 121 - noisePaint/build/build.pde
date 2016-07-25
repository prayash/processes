// Processes - Day 121
// Prayash Thapa - April 30, 2016

ArrayList<Particle> pArr = new ArrayList();

// ************************************************************************************

void setup() {
  size(500, 250);
  background(255);

  for (int i = 0; i < 1000; i++) pArr.add(new Particle());
}

// ************************************************************************************

void draw() {
  for (Particle particle : pArr) {
    float radian = map(noise(mouseX + particle.position.x * 0.02, mouseY + particle.position.y * 0.02), 0, 1, 0, TWO_PI * 5) + random(PI / 6.0);
    particle.update(radian);
    particle.render();
  }
}

// ************************************************************************************

class Particle {

  PVector position, pPos;
  float step;
  color hue;

  Particle() {
    position = new PVector(random(width), random(height));
    step = map(1, 0, 1, 1, 1.5);
    colorMode(HSB);
    hue = color(random(255), random(255), random(255));
  }

  void update(float radian) {
    pPos = position;
    position = PVector.add(position, new PVector(step * cos(radian), step * sin(radian)));
    if (position.x < 0 || position.x >= width || position.y < 0 || position.y >= height) {
      position = new PVector(random(width), random(height));
      pPos = new PVector(position.x, position.y);
    }
  }

  void render() {
    stroke(hue, 100); strokeWeight(1);
    line(pPos.x, pPos.y, position.x, position.y);
  }
}

// ************************************************************************************

void keyPressed() {
  if (key == 's') saveFrame("####.png");
}
