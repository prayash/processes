// Processes - Day 27
// Prayash Thapa - January 27, 2016

// ************************************************************************************

int tileCount = 20;
color hue = color(197, 0, 123);
int alpha = 50;
int randomSeed = 0;

// ************************************************************************************

void setup() {
  size(600, 600);
  colorMode(HSB, 360, 100, 100, 100);
  noFill();
  strokeCap(PROJECT);
}

// ************************************************************************************

void draw() {
  background(360);
  randomSeed(randomSeed);

  for (int gridY = 0; gridY < tileCount; gridY++) {
    for (int gridX = 0; gridX < tileCount; gridX++) {
      int posX = width / tileCount * gridX;
      int posY = height / tileCount * gridY;

      // Our randomization scheme
      int toggle = (int) random(0, 2);
      if (toggle == 0) {
        stroke(hue, alpha);
        strokeWeight(mouseX / 10);
        line(posX, posY, posX + width / tileCount, posY + height / tileCount);
      }
    }
  }
}

void mousePressed() {
  randomSeed = (int) random(100000);
}

void keyReleased(){
  if (key == 's') saveFrame("##.png");
}