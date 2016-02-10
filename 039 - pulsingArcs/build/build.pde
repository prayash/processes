// Processes - Day 39
// Prayash Thapa - February 9, 2016

float theta = 0.0;

// ************************************************************************************

void setup() {
  background(255);
  size(500, 500);
  frameRate(15);
}

// ************************************************************************************

void draw() {
  background(255);
  noStroke();
  float n = sin(theta) * 385;
  translate(width/2, height/2);

  for (int i = 0; i < 5; i++) {
    rotate(millis() / random(4000.0, 6000.0));
    fill(random(255), random(255), random(255), 100);
    arc(0, 0, 400, 400, random(-2, 1), HALF_PI);
  }

  fill(255);
  ellipse(0, 0, n, n);
  theta += .1;

  // if (frameCount % 2 == 0 && frameCount < 60) saveFrame("image-####.gif");
}

// ************************************************************************************

void keyReleased() {
  if (key == 's') saveFrame("_##.png");
}
