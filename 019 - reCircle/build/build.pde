// Processes - Day 19
// Prayash Thapa - January 19, 2016

// ************************************************************************************

int hex = 25, colorCounter = 0;
float radius = 270;

void setup() {
  size(440, 700);
  noStroke();
}

void draw() {
  background(#FFFFFF);
  fill(255);
  translate(width, height / 2);

  for (int i = 0; i < hex; i++) {
    pushMatrix();
      rotate(TWO_PI / hex * i);
      colorMode(HSB, 100, 1, 1);
      fill(12.5 * sin((colorCounter * 0.25 ) / 200.0) + 87.5, 1, 1, 40);
      ellipse(radius/2, 0, radius, radius);
    popMatrix();
  }
  colorCounter += 10;
}

// ************************************************************************************

void keyPressed() {
  if (key == 's') saveFrame("render-###.png");
}
