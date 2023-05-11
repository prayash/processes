// Processes - Day 145
// Prayash Thapa - May 24, 2016

final float g = 0.1;
Body bs[];

// ************************************************************************************

void setup() {
  size(500, 500);
  colorMode(RGB, 1);
  background(1);
  fill(1, 0.1);
  cursor(CROSS);

  bs = new Body[50];
  for (int i = 0; i < bs.length; i++) {
    bs[i] = new Body(1, new PVector(random(width), random(height)));
  }
}

// ************************************************************************************

void draw() {
  noStroke();
  rect(0, 0, width, height);

  stroke(0);
  for (Body b: bs) b.render();
}

// ************************************************************************************

class Body {
  float m;
  PVector p, q, s;

  Body(float m, PVector p) {
    this.m = m;
    this.p = p;
    q = p;
    this.s = new PVector(0, 0);
  }

  void update() {
    s.mult(0.98);
    p = PVector.add(p, s);
  }

  void attract(Body b) {
    float d = constrain(PVector.dist(p, b.p), 10, 100);
    PVector f = PVector.mult(PVector.sub(b.p, p), b.m * m * g / (d * d));
    PVector a = PVector.div(f, m);
    s.add(a);
  }

  void render() {
    update();
    attract(new Body(1000, new PVector(mouseX, mouseY)));
    line(p.x, p.y, q.x, q.y);
    q = p;
  }
}
