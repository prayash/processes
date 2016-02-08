// Processes - Day 36
// Prayash Thapa - February 6, 2016

// ************************************************************************************

void setup() {
  size(250, 500);
  background(255);
  frameRate(15);
}

void draw() {
  noStroke();
  fill(245, 15);
  rectMode(CORNER); rect(0, 0, width, height);

  for (int x = 70; x < 431; x += 36) {
    for (int y = 70; y < 431; y += 38) {
      if (random(1) > .5) {
        fill(x/2, y/2, 20, 50);
        rectMode(CENTER); rect(x, y, 30, 30);
      } else {
        fill(x/2, y/2, 20, 150);
        arc(x, y, 30, 30, random(-6, 1), random(-6, 1));
      }
    }
  }
}

// ************************************************************************************

void keyReleased() {
  if (key == 's') saveFrame("_##.png");
}
