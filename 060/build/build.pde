// Processes - Day 60
// Prayash Thapa - February 29, 2016

// ************************************************************************************

PImage img;

void setup() {
  img = loadImage("image.jpg");
  size(800, 800);
  // image(img, 0, 0);
}

// ************************************************************************************

void draw() {
  int x = (int)random(width);
  int y = (int)random(height);
  float a = random(100, 200);
  fill(img.get(x, y), a);
  noStroke();
  float w = random(1, 10);
  float h = random(5, 100);
  if (random(1) > 0.5) rect(x, y, w, h);
  else rect(y, x, h, w);
}

void keyReleased() {
  if (key == 's' || key == 'S') saveFrame("_##.png");
}
