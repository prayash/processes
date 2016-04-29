// Processes - Day 106
// Prayash Thapa - April 15, 2016

color black = color(34, 34, 34);
color white = color(238, 238, 238);
color red = color(225, 76, 69);
color blue = color(56, 126, 245);

int columns = 3, rows = 3; int segment = 125;
ArrayList <Circle> circles = new ArrayList<Circle>();

// ************************************************************************************

void setup() {
  size(500, 500);
  background(white);
  stroke(black, 20); noFill();

  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < columns; j++) {
      float x = (j + 1) * segment;
      float y = (i + 1) * segment;
      circles.add(new Circle(x, y));
    }
  }
}

// ************************************************************************************

void draw() {
  for (Circle c : circles) c.display();
}

// ************************************************************************************

class Circle {

  float x, y;
  float a1, a2;
  float r1, r2;
  int num; float c;

  Circle(float _x, float _y) {
    x = _x; y = _y;
    a1 = PI/2 + random(PI);
    a2 = a1 * 2 + random(PI);
    r1 = segment * 0.1;
    r2 = segment * 0.4;
    num = int(map(a2 - a1, a1 + PI, a1, 500, 100));
    c = random(1);
  }

  void display() {
    pushMatrix();
      translate(x, y);
      for (int i = 0; i < num; i++) {
        float angle = random(random(a1, a1 * 2), a2); // take an angle
        float radius = random(r1, r2); // take radius
        float x = radius * cos(angle);
        float y = radius * sin(angle);

        if (c > 0.9) stroke(red, 30);
        else if (c > 0.5 && c < 0.9) stroke(blue, 30);
        else stroke(black, 20);

        point(x, y);
      }
    popMatrix();
  }
}

// ************************************************************************************

void mouseReleased() {
  setup();
}

void keyPressed() {
  if (key =='s') saveFrame("_##.png");
}
