// Processes - Day 130
// Prayash Thapa - May 9, 2016

float speed;
Star[] stars = new Star[400];

// ************************************************************************************

void setup() {
  size(800, 800, P3D);
  for (int i = 0;  i < stars.length; i++) {
    stars[i] = new Star();
  }
}

// ************************************************************************************

void draw() {
  background(0);

  speed = map(mouseX, 0, width, 0, 50);
  translate(width/2, height/2);
  for (int i = 0;  i < stars.length; i++) {
    stars[i].render();
  }
}

class Star {
  float x, y, z;
  float pz;

  Star() {
    x = random(-width, width);
    y = random(-height, height);
    z = random(0, width);
    pz = z;
  }

  void update() {
    z -= speed;
    if (z < 1) {
      x = random(-width, width);
      y = random(-height, height);
      z = width;
      pz = z;
    }
  }

  void render() {
    update();

    float sx = map(x / z, 0, 1, 0, width);
    float sy = map(y / z, 0, 1, 0, height);
    float r = map(z, 0, width, 16, 0);

    fill(255);
    noStroke();

    float px = map(x / pz, 0, 1, 0, width);
    float py = map(y / pz, 0, 1, 0, height);

    pz = z;
    stroke(255);
    line(px, py, sx, sy);
  }
}
