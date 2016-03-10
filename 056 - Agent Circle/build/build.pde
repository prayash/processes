// Processes - Day 56
// Prayash Thapa - February 25, 2016

// ************************************************************************************

boolean recordPDF = false;

int NORTH = 0;
int EAST = 1;
int SOUTH = 2;
int WEST = 3;

float posX, posY;
float posXcross, posYcross;

int direction = SOUTH;
float angleCount = 7;
float angle = getRandomAngle(direction);
float stepSize = 10;
int minLength = 10;

// width and brightness of the stroke depend on line length
int dWeight = 50;
int dStroke = 4;
int drawMode = 1;

// ************************************************************************************

void setup() {
  size(600, 600);
  colorMode(HSB, 360, 100, 100, 100);
  background(#f9d74f);

  posX = int(random(0, width));
  posY = 5;
  posXcross = posX;
  posYcross = posY;
}

// ************************************************************************************

void draw() {
  for (int i = 0; i <= mouseX; i++) {
    strokeWeight(random(3, 50));
    stroke(360, 25);
    point(posX, posY);

    // Step
    posX += cos(radians(angle)) * stepSize;
    posY += sin(radians(angle)) * stepSize;

    // Check borders
    boolean reachedBorder = false;

    if (posY <= 5) {
      direction = SOUTH;
      reachedBorder = true;
    } else if (posX >= width-5) {
      direction = WEST;
      reachedBorder = true;
    } else if (posY >= height-5) {
      direction = NORTH;
      reachedBorder = true;
    } else if (posX <= 5) {
      direction = EAST;
      reachedBorder = true;
    }

    // Path / border detection.
    int px = (int) posX;
    int py = (int) posY;
    if (get(px, py) != color(360) || reachedBorder) {
      angle = getRandomAngle(direction);
      float distance = dist(posX, posY, posXcross, posYcross);
      if (distance >= minLength) {
        strokeWeight(distance/dWeight);
        if (drawMode == 1) stroke(0);
        if (drawMode == 2) stroke(52, 100, distance/dStroke);
        if (drawMode == 3) stroke(192, 100, 64, distance/dStroke);
        // line(posX, posY, posXcross, posYcross);
      }
      posXcross = posX;
      posYcross = posY;
    }
  }
}

// ************************************************************************************

float getRandomAngle(int theDirection) {
  float a = (floor(random(-angleCount, angleCount)) + 0.5) * 90.0/angleCount;

  if (theDirection == NORTH) return (a - 90);
  if (theDirection == EAST) return (a);
  if (theDirection == SOUTH) return (a + 90);
  if (theDirection == WEST) return (a + 180);
  return 0;
}

void keyReleased() {
  if (key == DELETE || key == BACKSPACE) background(360);
  if (key == 's' || key == 'S') saveFrame("_##.png");
  if (key == ' ') noLoop();
}
