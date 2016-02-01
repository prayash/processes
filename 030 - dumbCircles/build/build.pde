// Processes - Day 30
// Prayash Thapa - January 30, 2016

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
int counter = 0;
// stepSize = 10;
// diameter = 5;

int direction;
float posX, posY;

// ************************************************************************************

void setup() {
  size(800, 300);
  background(#FFFFFF);
  noStroke();
  posX = width/2;
  posY = height/2;
}

// ************************************************************************************

void draw() {
  counter++;
  direction = (int) random(0, 7);    // all directions without NORTHWEST

  if (direction == NORTH) {  
    posY -= stepSize;  
  } 
  else if (direction == NORTHEAST) {
    posX += stepSize;
    posY -= stepSize;
  } 
  else if (direction == EAST) {
    posX += stepSize;
  } 
  else if (direction == SOUTHEAST) {
    posX += stepSize;
    posY += stepSize;
  }
  else if (direction == SOUTH) {
    posY += stepSize;
  }
  else if (direction == SOUTHWEST) {
    posX -= stepSize;
    posY += stepSize;
  }
  else if (direction == WEST) {
    posX -= stepSize;
  }
  else if (direction == NORTHWEST) {
    posX -= stepSize;
    posY -= stepSize;
  }

  if (posX > width) posX = 0;
  if (posX < 0) posX = width;
  if (posY < 0) posY = height;
  if (posY > height) posY = 0;

  if (counter >= 100){
    counter = 0;
    fill(252, 100, 64, 80);
    ellipse(posX+stepSize/2, posY+stepSize/2, diameter+7, diameter+7);
  }

  ellipse(posX+stepSize/2, posY+stepSize/2, diameter, diameter);
}

// ************************************************************************************

void keyReleased() {
  if (key == 's') saveFrame("_##.png");
}