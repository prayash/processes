// Processes - Day 124
// Prayash Thapa - May 3, 2016

int cols, rows;
int scale = 20;
int w = 1200, h = 900;
float[][] terrain;
float flight = 0;

// ************************************************************************************

void setup() {
  size(400, 600, P3D);
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
      terrain[x][y] =  map(noise(xOff, yOff), 0, 1, -150, 150);
      xOff += 0.1;
    }
    yOff += 0.1;
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
