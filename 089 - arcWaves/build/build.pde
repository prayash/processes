// Processes - Day 89
// Prayash Thapa - March 29, 2016

Arc[] arcs = new Arc[10];
float ray = 0; int maxI;

// ************************************************************************************

void setup() {
  size(600, 400);
  background(#FCF7E1);

  noFill(); stroke(#DC5978, 225);
  strokeWeight(random(5, 10)); strokeCap(SQUARE);

  maxI = (int) sqrt(440 * 330 + 440 * 330) * 2;
  for(int a = 0; a < 10; a++) arcs[a] = new Arc(440, 330, (int)random(300) + 50 + a);
}

// ************************************************************************************

void draw() {
  background(255);

  for (int a = 0; a < arcs.length; a++) arcs[a].dessine();

  if (ray > 45) {
    ray = 0;
    for (int a = 0; a < arcs.length; a++) arcs[a].r += 45;
    arcs = (Arc[]) append (arcs, new Arc(440, 330, 50));
    if (arcs[0].r > maxI) arcs = (Arc[]) subset (arcs, 1);
  }

  ray += 0.9;
}

// ************************************************************************************

class Arc {
  int x, y;
  Movement m;
  float r, a, l, v;

  Arc(int _x, int _y, int _r) {
    m = new Movement();
    x = _x;
    y = _y;
    r = _r;
    a = random(TWO_PI);
    l = random(0.3, 0.7);
    v=random(-0.04, 0.04);
  }

  void dessine() {
    arc(x, y, r + ray, r + ray, a, a + l * PI);
    arc(x, y, r + ray, r + ray, a + PI, a + PI + l * PI);
    l = l + (1 - l) * 0.002;
    a += m.bouge();
  }
}

class Movement {
  float n, v, v2;
  Movement() {
    n = 0;
    v = PI/100;
    v2 = random(0.01, 0.05);
  }

  float bouge() {
    n += v;
    return cos(n) * v2;
  }
}

void keyReleased() {
  if (key == 's') saveFrame("_##.png");
}
