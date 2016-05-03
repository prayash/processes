// Processes - Day 117
// Prayash Thapa - April 26, 2016

float nScale  = 80;
float nAmp    = 1;
int gridSize  = 30;

// ************************************************************************************

void setup() {
  size(600, 600);
  noStroke();
}

void draw() {
  background(#b77aa1);

  // Map noise scale to mouseX
  nScale = map(mouseX, 0, width, 0, 100);
  for (int i = 0; i < width; i += gridSize) {
    for (int j = 0; j < height; j += gridSize) {
      float noiseVal = noise(i / nScale, j / nScale, frameCount / nScale) * 255 * nAmp;
      fill(#e45a7d, noiseVal * 2);
      rect(i, j, gridSize, gridSize);
    }
  }
}
