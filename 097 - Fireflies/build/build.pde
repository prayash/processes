// Processes - Day 97
// Prayash Thapa - April 6, 2016

// ************************************************************************************

void setup() {
  size(600, 400);
  background(255);
  noStroke();
}

// ************************************************************************************

void draw() {
  fill(255, 10);
  rect(0, 0, width, height);

  float a = random(10, 20);
  for (int j = 0; j < 10; j++) {
    ellipse(random(width + 50), random(height + 50), a, a);
    fill(0, random(100, 200), random(100, 200));
  }

  filter(ERODE);
  if (frameCount % 4 == 0 && frameCount < 121) saveFrame("image-####.gif");
}
