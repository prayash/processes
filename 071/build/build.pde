// Processes - Day 71
// Prayash Thapa - March 11, 2016

int maxCount = 5000;
int currentCount = 1;

float[] x = new float[maxCount];
float[] y = new float[maxCount];
float[] r = new float[maxCount];

boolean freeze    = false;

// ************************************************************************************

void setup() {
  size(600, 300);
  frameRate(60);

  // first circle
  x[0] = width/2;
  y[0] = height/2;
  r[0] = 10;
  //r[0] = 400;
}

// ************************************************************************************

void draw() {
  background(255);
  strokeWeight(0.5);
  //noFill();

  // create a radom set of parameters
  float newR = random(1, 7);
  float newX = random(0 + newR, width - newR);
  float newY = random(0 + newR, height - newR);

  float closestDist = 100000000;
  int closestIndex = 0;
  // which circle is the closest?
  for(int i = 0; i < currentCount; i++) {
    float newDist = dist(newX, newY, x[i], y[i]);
    if (newDist < closestDist) {
      closestDist = newDist;
      closestIndex = i;
    }
  }

  // show random position and line
  fill(230);
  ellipse(newX, newY, newR * 2, newR * 2);
  line(newX, newY, x[closestIndex], y[closestIndex]);

  // aline it to the closest circle outline
  float angle = atan2(newY - y[closestIndex], newX - x[closestIndex]);

  x[currentCount] = x[closestIndex] + cos(angle) * (r[closestIndex]+newR);
  y[currentCount] = y[closestIndex] + sin(angle) * (r[closestIndex]+newR);
  r[currentCount] = newR;
  currentCount++;

  // draw them
  for (int i = 0 ; i < currentCount; i++) {
    fill(#55acee, 150); noStroke();
    // fill(50);
    ellipse(x[i], y[i], r[i] * 2, r[i] * 2);
    stroke(#55acee, 50); strokeWeight((int)random(1, 3));
    line(width/2, height/2, x[i], y[i]);
  }

  if (currentCount >= maxCount) noLoop();
}

// ************************************************************************************

void keyReleased() {
  if (key == 's' || key == 'S') saveFrame("_##.png");
  if (key == 'f' || key == 'F') freeze = !freeze;
  if (freeze == true) noLoop(); else loop();
}
