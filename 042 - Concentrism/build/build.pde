// Processes - Day 42
// Prayash Thapa - February 11, 2016

// ************************************************************************************

int NARCS = 20;
Concentrism[] cArr = new Concentrism[NARCS];

color[] palette = { #EFFFCD, #555152, #DCE9BE, #2E2633, #991739 };
float theta; boolean save; int f;

void setup() {
  size(700, 700);
  background(20);
  rectMode(CENTER);
  strokeCap(SQUARE);
  frameRate(random(20, 60));

  for (int i = 0; i < cArr.length; i++) {
    int size = (int)random(width);
    float rotation = (PI/cArr.length) * i;
    color hue = (int)random(0, 5);
    float start = random(0, TWO_PI);
    float stop = start + random(PI/4, PI);

    cArr[i] = new Concentrism(size, rotation, hue, start, stop);
  }
}

// ************************************************************************************

void draw() {
  noStroke();
  fill(20, 80);
  rect(width/2, height/2, width, height);
  translate(width/2, height/2);
  for (int i = 0; i < cArr.length; i++) {
    pushMatrix();
      noFill();
      rotate(theta * (i + 1) / 5);
      stroke(palette[i % 5], 200);
      cArr[i].display();
    popMatrix();
  }

  theta += 0.0523;
  filter(DILATE);
  if (save) if (frameCount % 4 == 0 && frameCount < f + 121) saveFrame("image-###.gif");
}

// ************************************************************************************

class Concentrism {
  float size, rotation, start, stop; color hue;
  Concentrism(float _size, float _rotation, color _color, float _start, float _stop) {
    size = _size;
    rotation = _rotation;
    hue = _color;
    start = _start;
    stop = _stop;
  }

  void display() {
    strokeWeight(random(25, 50));
    arc(0, 0, size, size, start, stop);
  }
}

// ************************************************************************************

void mouseClicked() { setup(); }
void keyPressed() {
  f = frameCount;
  save = true;
}

// void settings() {
//   fullScreen();
// }
