// Processes - Day 18
// Prayash Thapa - January 18, 2016

int num = 50, frames = 240, colorCounter = 0;
Orb[] orbs = new Orb[num];
float theta;
color[] palette = { #A0ECD0, #ECD893, #E7AF7E, #B78376 };

// ************************************************************************************

void setup() {
  size(800, 400);
  for (int i = 0; i < num; i++) {
    float d = 150;
    float x = width / 2 + cos(TWO_PI / num * i) * d;
    float y = height / 2 + sin(TWO_PI / num * i) * d;;
    orbs[i] = new Orb(x, y, random(10, 20));
  }
}

// ************************************************************************************

void draw() {
  // ---------------
  // Background
  fill(0);
  colorMode(HSB, 100, 1, 1);
  noStroke();
  beginShape();
    // Yellows and Reds
    fill(12.5 * sin((colorCounter * 0.025 ) / 100.0) + 12.5, 1, 1);
    vertex(-width, -height);

    // Yellows and Whites
    fill(12.5 * cos((colorCounter * 0.025 ) / 200.0) + 37.5, 1, 1);
    vertex(width, -height);

    // Blues and Greens
    fill(12.5 * cos((colorCounter * 0.025 ) / 100.0) + 62.5, 1, 1);
    vertex(width, height);

    // Reds + Purples
    fill(12.5 * sin((colorCounter * 0.25 ) / 200.0) + 87.5, 1, 1);
    vertex(-width, height);
  endShape();
  colorCounter += 5;

  colorMode(RGB);
  for (int i=0; i<orbs.length; i++) {
    stroke(#FFFFFF);
    orbs[i].run();
  }
  theta += TWO_PI/frames * 0.05;
}

// ************************************************************************************

class Orb {
  float x, y, size, px, py, offSet, radius;
  int dir; color col;

  Orb(float _x, float _y, float _size) {
    x = _x;
    y = _y;
    size = _size;
    offSet = random(TWO_PI);
    radius = random(20, 150);
    dir = random(1) > .5 ? 1 : -1;
    col = palette[int(random(palette.length))];
  }

  void run() {
    update();
    showLines();
    display();
  }

  void update() {
    float vari = map(sin(theta), -1, 1, 1, 2);
    px = x + cos(theta * dir + offSet) * radius * vari;
    py = y + sin(theta * dir) * radius * vari;
  }

  void showLines() {
    for (int i = 0; i < orbs.length; i++) {
      float distance = dist(px, py, orbs[i].px, orbs[i].py);
      if (distance > 0 && distance < 100) {
        line(px, py, orbs[i].px, orbs[i].py);
      }
    }
  }

  void display() {
    colorMode(RGB);
    noStroke();
    for (int i = 0; i < 7; i++) {
      col = 255;
      fill(col, 55 + 200.0 / 7 * i, 255);
      float scale = map(i, 0, 6, 1, .5) * size;
      ellipse(px, py, scale, scale);
    }
  }
}

// ************************************************************************************

void keyPressed() {
  if (key == 's') saveFrame("render-###.png");
}
