
void setup() {
  size(900, 900, P2D);
  smooth(8);
  blendMode(ADD);
  background(0);
}

void draw() {
  background(0);
  stroke(125, 125, 200, 50);
  
  float r = 500;
  int perFrame = int(r * 1.5);
  PVector m = new PVector(width / 2, height / 2);
  
  for (int i = 0; i < perFrame; i++) {
    float t = 2 * PI * i / perFrame;
    PVector p = PVector.fromAngle(t).mult(r).add(m);
    noiseLine(m.x, m.y, p.x, p.y, 5 + r * 1.5 * mouseX / width);
  }
}

void noiseLine(float x1, float y1, float x2, float y2, float maxNoise) {
  PVector a = new PVector(x1, y1);
  PVector b = new PVector(x2, y2);
  PVector diff = b.copy().sub(a);
  PVector dir = diff.copy().normalize();
  PVector n = new PVector(-dir.y, dir.x);
  float mag = diff.mag();
  float half = mag / 2;
  noFill();
  beginShape();
  //vertex(a.x, a.y);

  for (int i = 0; i < mag; i += 4) {
    PVector p = dir.copy().mult(i).add(a);
    float df = 1 - abs(i - half) / half;

    p.add(n.copy().mult(df * maxNoise * (0.5 - noise(p.x * 0.01 + frameCount * 0.017, p.y * 0.01 + frameCount * 0.009))));
    vertex(p.x, p.y);
  }

  endShape();
}
