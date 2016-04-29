// Processes - Day 106
// Prayash Thapa - April 15, 2016

color black   = color(40, 40, 40);
color white   = color(228, 238, 238);
color red     = color(225, 76, 69);
color blue    = color(56, 126, 245);

int columns   = 3;
int rows      = 3;
int segment   = 125;

ArrayList<Donut> donuts = new ArrayList<Donut>();

// ************************************************************************************

void setup() {
  size(500, 500);
  background(white);
  noFill(); stroke(black, 20);

  // Place each donut equally across defined rows & columns
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < columns; j++) {
      float x = (j + 1) * segment;
      float y = (i + 1) * segment;
      donuts.add(new Donut(x, y));
    }
  }
}

// ************************************************************************************

void draw() {
  for (Donut d : donuts) d.render();
}

// ************************************************************************************

class Donut {

  float x, y;
  float anguloUno, anguloDos;
  float radioUno, radioDos;
  float rando;

  Donut(float _x, float _y) {
    x = _x; y = _y;
    anguloUno = PI/2 + random(PI);
    anguloDos = anguloUno * 2 + random(PI);
    radioUno = segment * 0.1;
    radioDos = segment * 0.4;
    rando = random(1);
  }

  void render() {
    pushMatrix();
      translate(x, y);
      for (int i = 0; i < 100; i++) {
        float angle = random(random(anguloUno, anguloUno * 2), anguloDos);
        float radius = random(radioUno, radioDos);
        float x = radius * cos(angle);
        float y = radius * sin(angle);

        // Defining our colors using random()
        if (rando > 0.9) stroke(red, 30);
        else if (rando > 0.5 && rando < 0.9) stroke(blue, 30);
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
