// Processes - Day 124
// Prayash Thapa - May 3, 2016

import peasy.*;

PeasyCam cam;

int cols, rows;
int scale = 20;
int w = 2200, h = 1500;
float [][] terrain;
float flight = 0;

// ************************************************************************************

void setup() {
  fullScreen(P3D);
  // size(400, 600, P3D);
  cam = new PeasyCam(this, 2000);
  cols = w / scale;
  rows = h / scale;
  terrain = new float[cols][rows];
}

// ************************************************************************************

void draw() {
  flight -= 0.01;
  float yOff = flight;
  for (int y = 0; y < rows; y++) {
    float xOff = 0;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] =  map(random(xOff, yOff), 0, 1, -150, 150);
      xOff += 0.2;
    }
    yOff += 0.2;
  }

  background(40, 40, 40);
  stroke(228, 238, 238); noFill();

  translate(width/2, height/2);
  rotateX(PI/3);
  translate(-w/2, -h/2);
  for (int y = 0; y < rows - 1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      vertex(x * scale, y * scale, terrain[x][y]);
      vertex(x * scale, (y + 1) * scale, terrain[x][y + 1]);
    }
    endShape();
  }

  // if (frameCount % 8 == 0) saveFrame("####.png");
}

void keyPressed() {
  if (key == 's') saveFrame("###.png");
}
