// Processes - Day 15
// Prayash Thapa - January 15, 2016

int NSTRIPES = 15;
float randomWeight = random(3, 9);
color palette[] = {#d7626b, #666ff2, #4c537d, #fefdbc};

Stripe[] stripes = new Stripe[NSTRIPES];
 
// ************************************************************************************

void setup() {
  size(700, 700);
  background(#FFFFFF);
  strokeWeight(randomWeight);
  strokeCap(SQUARE);

  for (int i = 0; i < stripes.length; i++) stripes[i] = new Stripe();
}

// ************************************************************************************

void draw() {
  background(#FFFFFF);
  for (int i = 0; i < stripes.length; i++) {
    stroke(stripes[i].hue);

    if (stripes[i].isVertical) {
      for (float y = stripes[i].y; y < stripes[i].y + stripes[i].length; y += randomWeight * 2) {
        float x = stripes[i].x;
        line(x, y, x + stripes[i].breadth, y + stripes[i].breadth);
      }
      stripes[i].y += stripes[i].speed;

      if (stripes[i].y > height) stripes[i].y = random(300, 600) - random(600);
    } else {
      for (float x = stripes[i].x; x < stripes[i].x + stripes[i].length; x += randomWeight * 2) {
        float y = stripes[i].y;
        line(x, y, x + stripes[i].breadth, y + stripes[i].breadth);
      }
      stripes[i].x += stripes[i].speed;

      if (stripes[i].x > width) stripes[i].x = random(width - 0.5 * random(30, 60));
    }
  }
}

// ************************************************************************************

class Stripe {
  float x, y, length, breadth, speed;
  boolean isVertical; color hue;

  Stripe() {
    x = random(width - 0.5 * random(30, 60));
    y = random(300, 600) - random(600);
    length = random(300, 600);
    breadth = random(30, 150);
    speed = random(1, 3);
    hue = randomColor();
    isVertical = (random(1) < 0.5);
    stroke(randomColor());
  }
}

color randomColor() {
  return palette[int(random(palette.length))];
}

// ************************************************************************************

void keyPressed() {
  if (key == 's') saveFrame("render-###.png");
}