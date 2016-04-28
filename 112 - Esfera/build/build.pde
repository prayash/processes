// Processes - Day 112
// Prayash Thapa - April 21, 2016

// ************************************************************************************

void setup () {
  size (600, 600);
  noLoop();
}

// ************************************************************************************

void draw () {
  background (#FFFDEF);
  stroke(#57385c, 200);
  Esfera(width/2, height/2, 250, 200);
}

// ************************************************************************************

void Esfera(float centroX, float centroY, float radio, int cantidad) {
  for (int i = 0; i < cantidad; i++) {
    float anguloUno = random(0, TWO_PI);
    float x1 = centroX + cos(anguloUno) * radio;
    float y1 = centroY + sin(anguloUno) * radio;

    float anguloDos = random(0, TWO_PI);
    float x2 = centroX + cos(anguloDos) * radio;
    float y2 = centroY + sin(anguloDos) * radio;

    if (random(1) > 0.7) strokeWeight(random(5));
    else strokeWeight(1);

    line(x1, y1, x2, y2);
  }
}

void mousePressed() {
  redraw();
}

void keyPressed() {
  if (key == 's') saveFrame("##.png");
}
