// Processes - Day 13
// Prayash Thapa - January 13, 2016

int x, y;
int numberOfArcs = 100;
float rotation = -(HALF_PI / 3);
int arcSize;
int step = 40;
float start, stop;
color[] palette = {#3583B7,#8EB4C4,#84BBCC,#B1C7CC,#B7D5CE,#EFEADA};

// ************************************************************************************

void setup() {
  size(700, 300);
  background(#1C1C1C);
  noFill();
  ellipseMode(CENTER);
  strokeCap(PROJECT);
  noLoop();
}

// ************************************************************************************

void draw() {
  for (int i = 0; i < numberOfArcs; i++) {
    stroke(palette[(int)random(5)]);
    strokeWeight(i);
    x = width / 2;
    y = height / 2;
    arcSize = 200 + (step * i);
    start = random(rotation * i);
    stop = rotation * i + TWO_PI - HALF_PI;
    arc(x, y, arcSize, arcSize, start, stop);
  }
}

// ************************************************************************************

void keyPressed() {
  if (key == 's') saveFrame("render-###.png");
}