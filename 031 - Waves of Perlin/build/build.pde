// Processes - Day 31
// Prayash Thapa - January 31, 2016

float div = 100;
float r = 30;
float n = random(100);
float widthDiv, heightDiv;

// ************************************************************************************

void setup() {
  size(600, 600);
  colorMode(HSB, 360, 100, 100, 100);
  widthDiv = width / div;
  heightDiv = height / div;
}

// ************************************************************************************
 
void draw() {
  background(0);
  noStroke();
  
  for (int i = -2; i < div + 6; i++) {
    fill(320, 60, 60 * (i * (1 / div)));
    beginShape();
      vertex(-2 * widthDiv, (div * r * 2) + i * heightDiv);
      vertex(-2 * widthDiv, i * heightDiv);

      for (int j = -2; j < div + 6; j++) {
        float theta = map(noise(n, i * 0.5, j * 0.015), 0, 1, 0, TWO_PI);
        theta += frameCount * 0.05;
        float x = (cos(theta) * r) + (j * widthDiv);
        float y = (sin(theta) * r) + (i * heightDiv);
        curveVertex(x, y);
      }
       
      vertex((div + 6) * widthDiv, (i * heightDiv));
      vertex((div + 6) * widthDiv, (div * r * 2) + i * heightDiv);
    endShape();
  }
  n += 0.03;
}

// ************************************************************************************

void keyReleased() {
  if (key == 's') saveFrame("_##.png");
}