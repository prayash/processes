// Processes - Day 110
// Prayash Thapa - April 19, 2016

// ************************************************************************************

void setup () {
  size (600, 600);
}

// ************************************************************************************

void draw () {
  background (#ffedbc);
  fill (#57385c, 10);
  stroke(#ffedbc, 0);

  float angle = map(frameCount, 0, width, 0, PI/2);

  translate(width/2, height/2);
  recursiveRect(200 + angle * 300, angle);
}

// ************************************************************************************

void recursiveRect(float rectSize, float angle) {
  if (rectSize > 5) {
    rotate(angle);
    rect(-rectSize/2, -rectSize/2, rectSize, rectSize);
    recursiveRect(rectSize - 5, angle);
  }
}

void keyPressed() {
  if (key == 's') saveFrame("##.png");
}
