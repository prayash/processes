// Processes - Day 122
// Prayash Thapa - May 1, 2016

import processing.opengl.*;

boolean smoothFade;
int amount = 30, lineAlpha = 50;

Elastic eL_1 = new Elastic(amount, 0.25, 0.65);
Elastic eL_2 = new Elastic(amount, 0.1, 0.65);
Elastic eL_3 = new Elastic(amount + 1, 0.3, 0.65);

// ************************************************************************************

void setup()  {
  size(900, 450);
  frameRate(240);
  background(228, 238, 228); noFill();
}

// ************************************************************************************

void draw() {
  if (mousePressed == true)  {
    eL_1.render(255, 0, 0, lineAlpha);
    eL_2.render(56, 126, 245, lineAlpha);
  }

  if (smoothFade) {
    fill(255, 12);
    rect(0, 0, width, height);
  }
}

// ************************************************************************************

class Elastic {
  int amount = 1000, colorR, colorG, colorB;

  float[] x = new float[amount];
  float[] y = new float[amount];
  float[] accelerationX = new float[amount];
  float[] accelerationY = new float[amount];
  float[] elasticity = new float[amount];
  float[] ease = new float[amount];
  float[] deltaX = new float[amount];
  float[] deltaY = new float[amount];

  float pointX, pointY;

  Elastic(int _amount, float _elasticity, float _ease) {
    amount = _amount;

    for (int i = 0; i < amount; i++){
      elasticity[i] = _elasticity * (.07 * (i + 1));
      ease[i] = _ease - (0.02 * i);
    }
  }

  void calcPoints(float _pointX, float _pointY) {
    pointX = _pointX;
    pointY = _pointY;

    for (int i = 0; i < amount; i++){
      if (i == 0) {
        deltaX[i] = (pointX - x[i]);
        deltaY[i] = (pointY - y[i]);
      } else {
        deltaX[i] = (x[i-1]-x[i]);
        deltaY[i] = (y[i-1]-y[i]);
      }
      deltaX[i] *= elasticity[i];    // create elasticity effect
      deltaY[i] *= elasticity[i];
      accelerationX[i] += deltaX[i];
      accelerationY[i] += deltaY[i];
      x[i] += accelerationX[i];       // move it
      y[i] += accelerationY[i];
      accelerationX[i] *= ease[i];    // slow down elasticity
      accelerationY[i] *= ease[i];
    }
  }

  void calcPointsStart()  {
    for (int i = 0; i < amount; i++) {
      x[i] = mouseX;
      y[i] = mouseY;
    }
  }

  void render(int colorR, int colorG, int colorB, int lineAlpha)  {
    calcPoints(mouseX, mouseY);

    stroke(colorR, colorG, colorB, lineAlpha); noFill();
    beginShape();
      for (int i = 0; i < amount; i++) { curveVertex(x[i], y[i]); }
    endShape();
  }
}

// ************************************************************************************

void mousePressed()  {
  eL_1.calcPointsStart();
  eL_2.calcPointsStart();
  // eL_3.calcPointsStart();
}

void keyPressed() {
  if (key == 'f') smoothFade = !smoothFade;
  if (key == 's') saveFrame("##.png");
}
