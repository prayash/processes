// Processes - Day 59
// Prayash Thapa - February 28, 2016

// ************************************************************************************

void setup() {
  size(500, 500);
  background(255);
}

// ************************************************************************************

void draw() {
  fill(#d92b6a, 5); noStroke(); rect(0, 0, 500, 500);
  translate(random(-10, 510), random(-10, 510));
  stroke(#d92b6a);
  line(0, 0, 30, 30);
  filter(ERODE); filter(BLUR);
}

void keyReleased() {
  if (key == 's' || key == 'S') saveFrame("_##.png");
}
