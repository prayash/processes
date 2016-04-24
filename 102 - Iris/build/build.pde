// Processes - Day 102
// Prayash Thapa - April 11, 2016

float dX = 50;
float dY = 28;

// ************************************************************************************

void setup() {
  size(500, 500);
  frameRate(30);
  background(255);
  cursor(CROSS);
}

// ************************************************************************************

void draw() {
  stroke(#CA1244, 20);

  for (float y = 0; y < height + dY; y += dY) {
    for (float x = 0; x < width + dX; x += dX) drawSite(x, y);

    y += dY;

    for (float x = 0.5 * dX; x < width + dX; x += dX) drawSite(x, y);
  }
}

// ************************************************************************************

void drawSite(float x, float y) {
  float weight = dX * 128 / (32 + dist(x, y, mouseX, mouseY)) + frameCount;
  if (weight > 1) {
    strokeWeight(weight);
    point(x, y);
  }
}

void keyPressed() {
  if (key == 's') saveFrame("##.png");
}
