// Processes - Day 72
// Prayash Thapa - March 12, 2016

color col = color(181,157,0,100);
float lineModuleSize = 0;
float angle = 0;
float angleSpeed = 1.0;
PShape lineModule = null;

int clickPosX = 0;
int clickPosY = 0;

// ************************************************************************************

void setup() {
  size(700, 700);
  background(255);
  cursor(CROSS);
}

// ************************************************************************************

void draw() {
  if (mousePressed) {
    int x = mouseX;
    int y = mouseY;
    if (keyPressed && keyCode == SHIFT) {
      if (abs(clickPosX-x) > abs(clickPosY-y)) y = clickPosY;
      else x = clickPosX;
    }

    strokeWeight(0.75);
    noFill();
    stroke(col);
    pushMatrix();
      translate(x, y);
      rotate(radians(angle));

      if (lineModule != null) shape(lineModule, 0, 0, lineModuleSize, lineModuleSize);
      else line(0, 0, lineModuleSize, lineModuleSize);
      angle = angle + angleSpeed;
    popMatrix();
  }
}

// ************************************************************************************

void mousePressed() {
  // create a new random color and line length
  lineModuleSize = random(50,160);

  // remember click position
  clickPosX = mouseX;
  clickPosY = mouseY;
}

void keyReleased() {
  if (key == DELETE || key == BACKSPACE) background(255);
  if (key == 's' || key == 'S') saveFrame("_##.png");

  // reverse direction and mirrow angle
  if (key=='d' || key=='D') {
    angle = angle + 180;
    angleSpeed = angleSpeed * -1;
  }

  // r g b alpha
  if (key == ' ') col = color(random(255),random(255),random(255),random(80,150));

  //default colors from 1 to 4
  if (key == '1') col = color(181,157,0,100);
  if (key == '2') col = color(0,130,164,100);
  if (key == '3') col = color(87,35,129,100);
  if (key == '4') col = color(197,0,123,100);

  // load svg for line module
  if (key=='5') lineModule = null;
  if (key=='6') lineModule = loadShape("02.svg");
  if (key=='7') lineModule = loadShape("03.svg");
  if (key=='8') lineModule = loadShape("04.svg");
  if (key=='9') lineModule = loadShape("05.svg");
  if (lineModule != null) lineModule.disableStyle();
}


void keyPressed() {
  if (keyCode == UP) lineModuleSize += 5;
  if (keyCode == DOWN) lineModuleSize -= 5;
  if (keyCode == LEFT) angleSpeed -= 0.5;
  if (keyCode == RIGHT) angleSpeed += 0.5;
}
