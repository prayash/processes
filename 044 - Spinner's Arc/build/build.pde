// Processes - Day 44
// Prayash Thapa - February 13, 2016

// ************************************************************************************

void setup() {
  size(500, 300);
  background(#2F2F2F);
  colorMode(HSB, 100);
}

// ************************************************************************************

void draw() {
  background(#2F2F2F);
  noStroke();

  float angle = map(dist(mouseX, mouseY, width / 2, height / 2), 0, width / 2, 0, PI);
  for(int i = 10; i > 0; i--) {
    fill(i * 10, 100, 100);
    pushMatrix();
      translate(width / 2, height / 2);
      rotate(radians(i * frameCount * 0.5));
      arc(0, 0, i * 50, i * 50, 0, angle);
    popMatrix();
  }

  pushMatrix();
    translate(width / 2, height / 2);
    fill(0, 0, 100);
    ellipse(0, 0, 25, 25);
  popMatrix();
  filter(DILATE);

  // if (mousePressed) saveFrame("frame_###.png");
}
