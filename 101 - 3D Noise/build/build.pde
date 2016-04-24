// Processes - Day 101
// Prayash Thapa - April 10, 2016

float noiseScale = 80.0;
float rotation = 0;
float zoom = 400;
int boxSize = 300;

// ************************************************************************************

void setup() {
  size(600, 600, P3D);
  frameRate(30);
  hint(DISABLE_DEPTH_TEST);
}

// ************************************************************************************

void draw() {
  background(#DC5978);

  rotation = map(mouseX, 0, 360, -width, width);
  zoom = map(mouseY, 0, height, 1, 1200);

  if (mousePressed && mouseButton == RIGHT) noiseScale = map(mouseX, 0, width, 1, boxSize);

  stroke(255, 120); strokeWeight(1); noFill();
  camera(0, rotation, zoom, 0, 0, 0, 1, 0, 0);
  box(boxSize);

  stroke(#ffedbc, 80);

  int x = 0;
  while(x < boxSize) {
    int y = 0;
    while(y < boxSize) {
      int z = 0;
      while(z < boxSize) {
        float d = noise(frameCount * 0.025 + x / noiseScale, y / noiseScale, z / noiseScale) * 6;
        strokeWeight(d);
        if (d > 4) point(x - 150, y - 150, z - 150);
        z += 12;
      }
      y += 12;
    }
    x += 12;
  }

  saveFrame("image-####.gif");
}
