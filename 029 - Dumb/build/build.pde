// Processes - Day 29
// Prayash Thapa - January 29, 2016
// Algorithms that generate images.

// ************************************************************************************

int NORTH = 0;
int NORTHEAST = 1; 
int EAST = 2;
int SOUTHEAST = 3;
int SOUTH = 4;
int SOUTHWEST = 5;
int WEST = 6;
int NORTHWEST= 7;

float stepSize = 30;
float diameter = 15;

int direction;
float posX, posY;

// ************************************************************************************

void setup() {
  size(800, 300);
  background(#6306ac);
  noStroke();
  posX = width/2;
  posY = height/2;
}

// ************************************************************************************

void draw() {
  direction = (int) random(0, 8);

  if (direction == NORTH) posY -= stepSize;
  else if (direction == SOUTH) posY += stepSize;
  else if (direction == EAST) posX += stepSize;
  else if (direction == WEST) posX -= stepSize;

  else if (direction == NORTHEAST) {
    posX += stepSize;
    posY -= stepSize;
  } else if (direction == SOUTHEAST) {
    posX += stepSize;
    posY += stepSize;
  } else if (direction == SOUTHWEST) {
    posX -= stepSize;
    posY += stepSize;
  } else if (direction == NORTHWEST) {
    posX -= stepSize;
    posY -= stepSize;
  }

  if (posX > width) posX = 0;
  if (posX < 0) posX = width;
  if (posY < 0) posY = height;
  if (posY > height) posY = 0;

  fill(255, 50);
  rect(posX + stepSize/2, posY + stepSize/2, diameter, diameter);
}

// ************************************************************************************

void keyReleased() {
  if (key == 's') saveFrame("_##.png");
}