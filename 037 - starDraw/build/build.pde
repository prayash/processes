// Processes - Day 38
// Prayash Thapa - February 7, 2016

// ************************************************************************************

void setup() {
  size(500, 250);
}

void draw() {
  fill(#55acee, 5);
  noStroke();
  rect(0, 0, width, height);

  stroke(255, 50);
  for (int i = 0; i <= width; i += 100) {
    line(i, random(height), mouseX, mouseY);
    line(random(width), i, mouseX, mouseY);
    line(i, random(height), mouseX, mouseY);
    line(random(width), i, mouseX, mouseY);
  }
}

// ************************************************************************************

void keyReleased() {
  if (key == 's') saveFrame("_##.png");
}
