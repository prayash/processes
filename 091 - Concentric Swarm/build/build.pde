// Processes - Day 91
// Prayash Thapa - March 31, 2016

float arcLength = 4.14;
float theta = 0;

// ************************************************************************************

void setup() {
  size(500, 500);
  background(#FF5F78);
}

// ************************************************************************************

void draw() {
  noFill(); stroke(#05225C, (int) random(2, 20)); strokeCap(SQUARE);
  theta += 0.0523;

  translate(width/2, height/2);
  for(int r = 10; r < 400; r += 5) {
    rotate(theta + random(2));
    strokeWeight(r / 30);
    arc(0 + r, 0 + r, r, r, 0, arcLength);
  }

  if (keyPressed) {
    if (key == 'z') arcLength += 0.1;
    if (key == 'x') arcLength -= 0.1;
  }

  if (frameCount % 4 == 0) saveFrame("image-####.gif");
}
