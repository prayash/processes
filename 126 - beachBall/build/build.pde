// Processes - Day 126
// Prayash Thapa - May 5, 2016

import peasy.*;
PeasyCam cam;

PVector[][] bBall;
int total = 8;

// ************************************************************************************

void setup() {
  size(600, 600, P3D);
  cam = new PeasyCam(this, 500);
  colorMode(HSB);
  bBall = new PVector[total + 1][total + 1];
}

// ************************************************************************************

void draw() {
  background(#E4E4E4);
  noStroke();
  lights();
  float r = 200;
  for (int i = 0; i < total + 1; i++) {
    float lat = map(i, 0, total, 0, PI);
    for (int j = 0; j < total + 1; j++) {
      float lon = map(j, 0, total, 0, TWO_PI);
      float x = r * sin(lat) * cos(lon);
      float y = r * sin(lat) * sin(lon);
      // float y = r * sin(lat) * sin(lat);
      float z = r * cos(lat);
      bBall[i][j] = new PVector(x, y, z);
    }
  }

  for (int i = 0; i < total; i++) {
    float hu = map(i, 0, total, 0, 255*6);
    fill(hu  % 155, 155, 255, 100);
    beginShape(TRIANGLE_STRIP);
    for (int j = 0; j < total + 1; j++) {
      PVector v1 = bBall[i][j];
      vertex(v1.x, v1.y, v1.z);
      PVector v2 = bBall[i+1][j];
      vertex(v2.x, v2.y, v2.z);
    }
    endShape();
  }
}

void keyPressed() {
  if (key == 's') saveFrame("##.png");
}
