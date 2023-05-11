// Processes - Day 17
// Prayash Thapa - January 17, 2016

int colorCounter = 0, num = 150, frames = 480, edge = 40;
Fragment[] fragments = new Fragment[num];
float theta;

// ************************************************************************************

void setup() {
  size(700, 700);
  hint(ENABLE_STROKE_PURE);

  // Fragments
  for (int i = 0; i < num; i++) {
    float x = random(width);
    float y = (height - 2) / float(num) * i;
    fragments[i] = new Fragment(x, y);
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

  // ---------------
  // Fragments
  colorMode(RGB);
  stroke(#FFFFFF, 75);
  strokeWeight(2);
  for (int i = 0; i < fragments.length; i++) {
    fragments[i].run();
  }
  theta += TWO_PI/frames * 0.35;
}

// ************************************************************************************
// Fragment
class Fragment {
  float x, y;
  float px, py, offSet, radius;
  int dir;
  color col;

  Fragment(float _x, float _y) {
    x = _x;
    y = _y;
    offSet = random(TWO_PI);
    radius = random(5, 10);
    dir = random(1) > .5 ? 1 : -1;
  }

  void run() {
    update();
    showLines();
  }

  void update() {
    float vari = map(sin(theta + offSet), -1, 1, -2, -2);
    px = map(sin(theta + offSet) , -1, 1, 0, width);
    py = y + sin(theta * dir) * radius * vari;
  }

  void showLines() {
    for (int i = 0; i < fragments.length; i++) {
      float distance = dist(px, py, fragments[i].px, fragments[i].py);
      if (distance > 0 && distance < 100) {
        line(px, py, fragments[i].px, fragments[i].py);
      }
    }
  }
}

// ************************************************************************************

void keyPressed() {
  if (key == 's') saveFrame("render-###.png");
}
