// Processes - Day 115
// Prayash Thapa - April 24, 2016

float startRadius;
float endRadius;

float noiseScale = 300;
int num = 15;
float m = 0;

// ************************************************************************************

void setup() {
  size(600, 300);
  startRadius = random(width/2-50);
  endRadius = random(width/2-50);
}

// ************************************************************************************

void draw() {
  fill(#FFFFFF, 5); noStroke();
  rect(0, 0, width, height);

  fill(#57385c);
  float rad = lerp(startRadius, endRadius, sin(m));

  num = (int) map(rad, 20, width, 5, 20);
  noiseScale = map(mouseY, 0, height, 1, 500);

  for (int i = 0; i < num; i++) {
    float angle = noise(frameCount + noiseScale) * TWO_PI + map(i, 0, num, 0, TWO_PI);
    float x = width/2 + cos(angle) * rad;
    float y = height/2 + sin(angle) * rad;

    rect(x, y, 10, 10);
  }

  m += 0.02;

  if (m >= PI/2) {
    m = 0;
    startRadius = endRadius;
    endRadius = random(width/2 - 50);
  }
}

// ************************************************************************************

void keyPressed() {
  if (key == 's') saveFrame("_##.png");
}
