// Processes - Day 104
// Prayash Thapa - April 13, 2016

float ngNoise     = random(10);
float radNoise    = random(10);
float arcNoise    = random(10);
float xNoise      = random(10);
float yNoise      = random(10);
float angle       = -PI/2;
float radius      = 150;

float strokeCol = random(1, 254);
int strokeChange = -1;
int mX, mY;

// ************************************************************************************

void setup() {
  size(500, 500);
  background(255);
  colorMode(HSB);
  mX = width/2; mY = height/2;
}

// ************************************************************************************

void draw() {

  radNoise += 0.005; ngNoise += 0.005; arcNoise += 0.01;
  xNoise += 0.01; yNoise += 0.01;

  radius = (noise(radNoise) * 200) + 10;
  angle += (noise(ngNoise) * 10.0) - 5.0;

  float centreX = mX + (noise(xNoise) * 100) - 50;
  float centreY = mY + (noise(yNoise) * 100) - 50;
  float arcLength = noise(arcNoise) * PI * 5;

  strokeCol += strokeChange;
  if (strokeCol > 254) { strokeChange *= -1; }
  if (strokeCol < 1) { strokeChange *= -1; }
  stroke(strokeCol, 255, 255, 30); strokeWeight(random(3));
  noFill();
  arc(centreX, centreY, radius * 2, radius * 2, radians(angle), radians(angle) + arcLength);
}

// ************************************************************************************

void mousePressed() {
  mX = mouseX;
  mY = mouseY;
}

void keyPressed() {
  if (key == DELETE || key == BACKSPACE) setup();
  if (key == 's' || key == 'S') saveFrame("_##.png");
}
