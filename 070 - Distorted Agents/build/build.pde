// Processes - Day 70
// Prayash Thapa - March 10, 2016

int formResolution = 8;
int stepSize = 1;
float initRadius = 75;
float centerX, centerY;
float ease = 0.1;
float[] x = new float[formResolution];
float[] y = new float[formResolution];

boolean filled = false;
boolean freeze = false;

// ************************************************************************************

void setup() {
  size(500, 500);

  centerX = width/2;
  centerY = height/2;
  float angle = radians(360 / float(formResolution));
  for (int i = 0; i < formResolution; i++) {
    x[i] = cos(angle * i) * initRadius;
    y[i] = sin(angle * i) * initRadius;
  }

  stroke(255, 55);
  background(#1a232a);
}

// ************************************************************************************

void draw() {
  // floating towards mouse position
  if (mouseX != 0 || mouseY != 0) {
    centerX += (mouseX - centerX) * ease;
    centerY += (mouseY - centerY) * ease;
  }

  // calculate new points
  for (int i = 0; i < formResolution; i++){
    x[i] += random(-stepSize, stepSize);
    y[i] += random(-stepSize, stepSize);
  }

  strokeWeight(0.75);
  if (filled) fill(random(255));
  else noFill();

  beginShape();
    // Start Point
    vertex(x[formResolution - 1] + centerX, y[formResolution - 1] + centerY);

    // only these points are drawn
    for (int i = 0; i < formResolution; i++) {
      vertex(x[i] + centerX, y[i] + centerY);
      // ellipse(x[i] + centerX, y[i] + centerY, 5, 5);
    }

    vertex(x[0] + centerX, y[0] + centerY);

    // End Point
    vertex(x[1] + centerX, y[1] + centerY);
  endShape();
}

// ************************************************************************************

void mousePressed() {
  centerX = mouseX;
  centerY = mouseY;
  float angle = radians(360 / float(formResolution));
  float radius = initRadius * random(0.5,1.0);
  for (int i = 0; i < formResolution; i++){
    x[i] = cos(angle * i) * radius;
    y[i] = sin(angle * i) * radius;
  }
}

void keyReleased() {
  if (key == 's' || key == 'S') saveFrame("_##.png");
  if (key == DELETE || key == BACKSPACE) background(#1a232a);

  if (key == '1') filled = false;
  if (key == '2') filled = true;

  if (key == 'B') filter(BLUR, 1);
  if (key == 'E') filter(ERODE);
  if (key == 'D') filter(DILATE);

  if (key == 'f' || key == 'F') freeze = !freeze;
  if (freeze == true) noLoop();
  else loop();
}
