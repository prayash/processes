// Processes - Day 98
// Prayash Thapa - April 7, 2016

float boost = 0.05;
int num = 30;
int numNodes = 6;
Particle[] pArr = new Particle[num];
Node[] nodes = new Node[numNodes];

// ************************************************************************************

void setup() {
  size(700, 400);
  background(#D92B6A);

  for(int i = 0; i < num; i++) pArr[i] = new Particle();
  for(int i = 0; i < numNodes; i++) nodes[i] = new Node();
}

// ************************************************************************************

void draw() {
  // background(#D92B6A, 5);
  for(int i = 0; i < num; i++) pArr[i].run();
}

// ************************************************************************************

class Particle {
  float xPos = random(width);
  float yPos = random(height);
  float vX, vY, gain;
  color col = color(255, 15);

  void update() {
    for (int i = 0; i < numNodes; i++) {
      gain = dist(xPos, yPos, nodes[i].xPos, nodes[i].yPos);
      if (gain > 1) {
        vX += ((nodes[i].xPos - xPos) * boost) / gain;
        vY += ((nodes[i].yPos - yPos) * boost) / gain;
        xPos += vX;
        yPos += vY;
      }
    }
  }

  void display() {
    strokeWeight(random(3));
    for (int i = 0; i < num; i++) {
      float dis = dist(xPos, yPos, pArr[i].xPos, pArr[i].yPos);
      if (dis > 80) {
        if (dis > 198) dis = 198;
        stroke(col, 200 - dis);
        line(xPos, yPos, pArr[i].xPos, pArr[i].yPos);

        if (random(1) > 0.99) ellipse(xPos, yPos, 2, 2);
      }
    }
  }

  void run() {
    update();
    display();
  }
}

class Node {
  float xPos, yPos;
  Node() {
   xPos = random(-200, width + 200);
   yPos = random(-200, height + 200);
  }
}

// ************************************************************************************

void keyReleased() {
  if (key == DELETE || key == BACKSPACE) setup();
  if (key == 's') saveFrame("_##.png");
  if (key == 'b') filter(BLUR, 1);
  if (key == 'e') filter(ERODE);
  if (key == 'd') filter(DILATE);
}
