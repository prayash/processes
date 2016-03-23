// Processes - Day 74
// Prayash Thapa - March 14, 2016

color col = color(181, 157, 0, 100);
float lineLength = 0;
float angle = 0;
float angleSpeed = 1.0;

int gradientVariance = 5;
int colorCounter = 0;

// ************************************************************************************

void setup() {
  size(800, 800);
  background(#d92b6a);
  cursor(CROSS);
}

// ************************************************************************************

void draw() {
  if (mousePressed) {
    pushMatrix();
      strokeWeight(1.0);
      noFill();
      stroke(200, 3 * sin(frameCount) + 100);
      translate(mouseX, mouseY);
      rotate(radians(angle));
      line(0, 0, lineLength, 0);
    popMatrix();

    angle += angleSpeed;
  }
}

// ************************************************************************************

void mousePressed() {
  lineLength = random(125, 300);
}

void keyReleased() {
  if (key == DELETE || key == BACKSPACE) background(#d92b6a);
  if (key == 's' || key == 'S') saveFrame("_##.png");

  // reverse direction and mirrow angle
  if (key=='d' || key=='D') {
    angle = angle + 180;
    angleSpeed = angleSpeed * -1;
  }

  // r g b alpha
  if (key == ' ') col = color(random(255), random(255), random(255), random(80, 150));
}

void keyPressed() {
  if (keyCode == UP) lineLength += 5;
  if (keyCode == DOWN) lineLength -= 5;
  if (keyCode == LEFT) angleSpeed -= 0.5;
  if (keyCode == RIGHT) angleSpeed += 0.5;
}
