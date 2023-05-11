void setup() {
  size(600, 600);
  smooth();
  background(0x444);
  stroke(250, 5);
}

void draw() {
  for (int i = 0; i < 1000; i++) {
    float x = random(-1, 1);
    float y = random(-1, 1);
    float xx = map(noise(x, y), 0, 1, 50, 550);
    float yy = map(noise(y, x), 0, 1, 50, 550);

    point(xx, yy);
  }
}
