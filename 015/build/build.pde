// Processes - Day 15
// Prayash Thapa - January 15, 2016

int NSTRIPES = 5;
color palette[] = {#d7626b, #666ff2, #4c537d, #fefdbc};

Stripe[] stripes = new Stripe[NSTRIPES];
 
// ************************************************************************************

void setup() {
  size(700, 350);
  background(#FFFFFF);
  noStroke();

  for (int i = 0; i < stripes.length; i++) stripes[i] = new Stripe();
}

// ************************************************************************************

void draw() {
  background(#FFFFFF);
  for (int i = 0; i < stripes.length; i++) {
    fill(stripes[i].hue);
    stripes[i].update();
    stripes[i].draw();
  }
}

// ************************************************************************************

class Stripe {
  float x, y, length, breadth, speed, weight;
  boolean isVertical; color hue;

  Stripe() {
    x = random(width - 0.5 * random(30, 60));
    y = random(300, height) - random(height);
    length = random(300, 600);
    breadth = random(30, 150);
    speed = random(1, 2);
    hue = randomColor();
    isVertical = (random(1) < 0.5);
    weight = random(5, 25);
  }

  void update() {
    if (isVertical) y += speed;
    if (!isVertical) x += speed;
    if (x > width) x = random(width - 0.5 * random(30, 60));
    if (y > height) y = -random(300, 700) - random(700);
  }

  void draw() {
    if (isVertical) {
      for (float _y = y; _y < y + length; _y += weight * 2) {
        float _x = x;
        beginShape();
          vertex(_x, _y);
          vertex(_x, _y + weight);
          vertex(_x + breadth, _y + breadth + weight);
          vertex(_x + breadth, _y + breadth);
          vertex(_x, _y);
        endShape();
      }
    } else {
      for (float _x = x; _x < x + length; _x += weight * 2) {
        float _y = y;
        beginShape();
          vertex(_x, _y);
          vertex(_x - weight, _y);
          vertex(_x + breadth - weight, _y + breadth);
          vertex(_x + breadth, _y + breadth);
          vertex(_x, _y);
        endShape();
      }
    }
  }
}

color randomColor() {
  return palette[int(random(palette.length))];
}

// ************************************************************************************

void keyPressed() {
  if (key == 's') saveFrame("render-###.png");
}