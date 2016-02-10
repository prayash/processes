// Processes - Day 38
// Prayash Thapa - February 8, 2016

// ************************************************************************************

int num = 150;
Orbit[] oArr   = new Orbit[num];

void setup() {
  size(800, 400);
  background(#CA1244);
  noFill();

  float startX = random(width/2) + (width/2);
  float startY = random(height/2) + (height/2);
  for (int i = 0; i < num; i++) oArr[i] = new Orbit(startX, startY);
}

// ************************************************************************************

void draw() {
  for (int i = 0; i < num; i++) oArr[i].update();
}

// ************************************************************************************

class Orbit {
  float centreX = width/2,  centreY = height/2;
  float angleIncrease, radiusNoise, strokeCol;
  float angle = 0, radius = 100;
  float lastX = 9999, lastY = 0;

  Orbit (float _x, float _y) {
    centreX = _x;
    centreY = _y;
    radiusNoise = random(10);
    lastX = 9999;
    strokeCol = random(255);
    angle = 0;
    angleIncrease = random(1) + 1;
  }

  void update() {
    radiusNoise += 0.001;
    radius = (noise(radiusNoise) * (width)) - 100;
    angle += angleIncrease;

    if (angle > 360) angle -= 360;
    else if (angle < 0) angle += 360;

    float rad = radians(angle + 90);
    float x = centreX + (radius * cos(rad));
    float y = centreY + (radius * sin(rad));

    // Orbiting
    if (lastX != 9999) {
      strokeWeight(1);
      stroke(strokeCol, random(20) + 50);
      line(x, y, lastX, lastY);
      // This could be so fucking cool if I mapped the lines to stray off-path according to audio!


      // Texturing
      if (random(5) > 4) {
        strokeWeight(1);
        stroke(strokeCol, 1);
        line(x, y, random(width), random(height));
      }

      // Arbitrary Ellipticals
      if (random(1) > 0.85) ellipse(x, y, 5, 5);
    }

    lastX = x;
    lastY = y;
  }
}

// ************************************************************************************

void mousePressed() {
  background(#CA1244);
}

void keyReleased() {
  if (key == 's') saveFrame("_##.png");
}
