// Processes - Day 38
// Prayash Thapa - February 7, 2016

// ************************************************************************************

void setup() {
  size(500, 500);
}

void draw() {
  fill(0, 5);
  noStroke();
  rect(0, 0, width, height);

  stroke(255, 50);
  for (int i = 0; i <= width; i += 100) {
    line(i, height, mouseX, mouseY);
    line(width, i, mouseX, mouseY);
    line(i, 0, mouseX, mouseY);
    line(0, i, mouseX, mouseY);
  }
}

// ************************************************************************************

void keyReleased() {
  if (key == 's') saveFrame("_##.png");
}
