// Processes - Day 95
// Prayash Thapa - April 4, 2016

ArrayList<Node> node = new ArrayList();

// ************************************************************************************

void setup() {
  size(300, 400);

  for (int i = 0; i < 50; i++) {
    float r = random(50);
    node.add(new Node(random(r, width - r), random(r, height - r), r));
  }
}

// ************************************************************************************

void draw() {
  background(255);
  for (int i = 0; i < node.size(); i++) node.get(i).render();
  // if (frameCount % 4 == 0) saveFrame("image-####.gif");
}

// ************************************************************************************

class Node {
  float x, y, xc, yc, theta, dt, r;
  Node(float xc, float yc, float r) {
    this.xc = xc;
    this.yc = yc;
    this.r = r;

    if (dt != 0) dt = dt;
    else dt = random(-1, 1);
  }

  void render() {
    fill(0);
    x = xc + r * cos(theta * PI/180);
    y = yc + r * sin(theta * PI/180);
    ellipse(x, y, random(1, 5), random(1, 5));
    theta += dt;

    for (int i = 0; i < node.size(); i++) {
      Node P = node.get(i);
      if (P != this) {
        if (dist(x, y, P.x, P.y) < 80) {
          stroke(0, 50);
          line(x, y, P.x, P.y);
        }
      }
    }
  }
}
