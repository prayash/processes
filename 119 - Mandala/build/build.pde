// Processes - Day 119
// Prayash Thapa - April 28, 2016

ArrayList<Mandala> cArr = new ArrayList();
boolean clear = true;

// ************************************************************************************

void setup() {
  size(600, 400);
  for(int i = 0; i < 10; i++) cArr.add(0, new Mandala(width/2, height/2));
}

// ************************************************************************************

void draw() {
  if (clear) clear();
  else background(#FFFFFF);

  for (Mandala c : cArr) c.update();
  if (mousePressed && mouseButton == LEFT) cArr.add(0, new Mandala(mouseX, mouseY));
}

// ************************************************************************************

class Mandala {
  int num;
  color c;
  PVector location;
  float radius, ellipseSize;
  float startAngle, angleSpeed;

  Mandala(float x, float y) {
    radius = random(10, 100);
    num = round(random(3, 30));

    location = new PVector(x, y);
    ellipseSize = random(3, 15);

    startAngle = random(TWO_PI);
    angleSpeed = map(radius, 10, 100, 0.03, 0.01);

    if (random(1) < 0.5) angleSpeed *= -1;

    setRandomColor();
  }

  void setRandomColor() {
    int randCol = (int) random(4);

    if (randCol == 0) c = #E5E1D1;
    else if (randCol == 1) c = #52616D;
    else if (randCol == 2) c = #2C343B;
    else c = #C44741;
  }

  void update() {
    fill(c);
    noStroke();

    for (int i = 0; i < num; i = i + 1 ) {
      float angle = startAngle + map(i, 0, num, 0, TWO_PI);

      float x = location.x + cos(angle) * radius;
      float y = location.y + sin(angle) * radius;

      ellipse(x, y, ellipseSize, ellipseSize);
    }

    startAngle += angleSpeed;
  }
}

// ************************************************************************************

void clear() {
  fill(#FFFFFF, 5);
  noStroke();
  rect(0, 0, width, height);
}

void mousePressed() {
  if (mouseButton == RIGHT) if(cArr.size() > 0) cArr.remove(cArr.size() - 1);
}

void keyPressed() {
  if (key == ' ') cArr.clear();
  if (key == 'n') clear = !clear;
  if (key == 's') saveFrame("_##.png");
}
