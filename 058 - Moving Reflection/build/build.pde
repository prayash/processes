// Processes - Day 58
// Prayash Thapa - February 27, 2016

// ************************************************************************************

int numberOfWaves = 12;
float theta;
float amplitude;

void setup() {
  size(350, 450);
  noStroke();
}

// ************************************************************************************

void draw() {
  background(0);
  for (int i = 0; i < numberOfWaves; i++) drawWave(i); theta += 0.0523;
  // if (theta <= TWO_PI) saveFrame("image-###.gif");
  // if (frameCount % 4 == 0 && frameCount < 121) saveFrame("image-####.gif");
}

// ************************************************************************************

void drawWave(int i) {
  randomSeed(420);
  for (int y = 0; y <= height; y += 10) {
    amplitude = map(i, 0, numberOfWaves-1, 1, 100);
    float offSet = TWO_PI/width * random(5, 200); // the offSet is used so that not all points of a wave go up and down at the same moment
    float x = width/2 + sin(theta + offSet) * amplitude; // this makes the ellipses of each wave go up and down (to a maximum limited by their respective amplitude value)
    fill(random(255)/numberOfWaves * i, random(255)/numberOfWaves * i, random(255)/numberOfWaves * i); // try using this instead of the previous fill to get shades of colors
    ellipse(x, y, 4, 4);
  }
}

void keyReleased() {
  if (key == 's' || key == 'S') saveFrame("_##.png");
}
