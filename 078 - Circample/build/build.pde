// Processes - Day 78
// Prayash Thapa - March 18, 2016

PImage sample;
float angle = 0;
float angleSpeed = 1.0;

// ************************************************************************************

void setup() {
  size(380, 380);
  sample = loadImage("image.jpg");
}

// ************************************************************************************

void draw() {
  pushMatrix();
    translate(width/2, height/2);
    rotate(radians(angle));

    if (frameCount < 350) image(sample, mouseX - 100, mouseY - 100);
    angle = angle + angleSpeed;
  popMatrix();
}

// ************************************************************************************

void keyReleased() {
  if (key == 's') saveFrame("_##.png");
  if (key == 'b') filter(BLUR, 1);
  if (key == 'e') filter(ERODE);
  if (key == 'd') filter(DILATE);
}
