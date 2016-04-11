// Processes - Day 92
// Prayash Thapa - April 1, 2016

float a1 = random(0, 1);
float b1 = random(0, 2);
float c1 = random(0, 5);
float a2 = random(30, 120);
float b2 = random(150, 230);
float c2 = random(80, 160);

int s = second();
int m = minute();
int h = hour();

// ************************************************************************************

void setup() {
  background(52, 52, 52);
  size(500, 500);
  noCursor();
}

// ************************************************************************************

void draw() {
  randomSeed((int) random(100000));
  fill(237, 255, 0, random(100)); noStroke();
  ellipse(250, 250, 50 + s, 50 + s);

  float sAci = map(second(), 0, 60, 150, width);
  float mAci = map(minute(), 0, 60, 0, width);
  float hAci = map(hour(), 0, 24, 0, width);

  float duration = s % 250;
  translate(250, 250);

  rotate(sAci);
  fill(35, 43, 43, 100);
  arc(0, 0, duration + a2, duration + a2, a1, 3);

  rotate(sAci);
  fill(255, 255, 255, 100);
  arc(0, 0, duration + b2, duration + b2, b1, 3);

  rotate(sAci);
  fill(229, 26, 76, 100);
  arc(0, 0, duration + c2, duration + c2, c1, 3);

  fill(52, 52, 52);
  ellipse(0, 0, duration, duration);

  // if (frameCount % 25 == 0) saveFrame("image-####.gif");
}
