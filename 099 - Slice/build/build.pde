// Processes - Day 99
// Prayash Thapa - April 8, 2016

PImage img;
int stepX, stepY, divider;

// ************************************************************************************

void setup() {
  size(500, 500);
  img = loadImage("data.jpg");
  stepX = (int) random(width);
  stepY = (int) random(height);
}

// ************************************************************************************

void draw() {
  divider = (int) map(mouseX, 0, width, 0, 50) + 1;
  int i = 0;

  for (int x = 0; x < width; x += stepX) {
    copy(img, x, 0, stepX, height, x, i * stepY, stepX, height);
    copy(img, x, height - i * stepY, stepX, i * stepY, x, 0, stepX, i * stepY);
    i++;
  }
}

// ************************************************************************************

void mouseClicked() {
  stepX = (int) random(width / divider);
  stepY = (int) random(height / divider);
}

void keyPressed() {
  if (key == 's') saveFrame("_##.png");
}
