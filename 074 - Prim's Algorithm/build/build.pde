// Processes - Day 74
// Prayash Thapa - March 14, 2016

// ************************************************************************************
// 
// PVector[] vertices = new PVector[0];
//
// void setup() {
//   size(640, 360);
//   background(#202020);
//   fill(255);
//   noStroke();
// }
//
// // ************************************************************************************
//
// void draw() {
//
//   PVector[] reached = new PVector[0];
//   PVector[] unreached = new PVector[0];
//
//   for (int i = 0; i < vertices.length; i++) {
//     unreached = (PVector[]) append(unreached, vertices[i]);
//     stroke(255); strokeWeight(1);
//     line(vertices[i].x, vertices[i].y, 50, 50);
//   }
//
//   // unreached = (PVector[]) splice(unreached, 0, 1);
//   // ellipse(unreached[0].x, unreached[0].y, 10, 10);
//
//   for (int i = 0; i < vertices.length; i++) {
//     ellipse(vertices[i].x, vertices[i].y, 16, 16);
//   }
//
// }
//
// // ************************************************************************************
//
// void mousePressed() {
//   PVector v = new PVector(mouseX, mouseY);
//   vertices = (PVector[]) append(vertices, new PVector(mouseX, mouseY));
// }
//
// void keyReleased() {
//   if (key == 's') saveFrame("_##.png");
// }


ArrayList<PVector> vertices = new ArrayList<PVector>();

void setup() {
  size(640, 360);

  for (int i = 0; i < 20; i++) {
    PVector v = new PVector(random(width), random(height));
    vertices.add(v);
  }

}

void mousePressed() {
  PVector v = new PVector(mouseX, mouseY);
  vertices.add(v);
}

void draw() {
  background(51);

  ArrayList<PVector> reached = new ArrayList<PVector>();
  ArrayList<PVector> unreached = new ArrayList<PVector>();

  for (PVector v : vertices) {
    unreached.add(v);
  }

  reached.add(unreached.get(0));
  unreached.remove(0);

  while (unreached.size() > 0) {
    float record = 100000;
    int rIndex = 0;
    int uIndex = 0;
    for (int i = 0; i < reached.size(); i++) {
      for (int j = 0; j < unreached.size(); j++) {
        PVector v1 = reached.get(i);
        PVector v2 = unreached.get(j);
        float d = dist(v1.x, v1.y, v2.x, v2.y);
        if (d < record) {
          record = d;
          rIndex = i;
          uIndex = j;
        }
      }
    }
    stroke(255);
    strokeWeight(2);
    PVector p1 = reached.get(rIndex);
    PVector p2 = unreached.get(uIndex);
    line(p1.x,p1.y, p2.x, p2.y);
    reached.add(p2);
    unreached.remove(uIndex);
  }


  for (PVector v : vertices) {
    fill(255);
    stroke(255);
    ellipse(v.x, v.y, 16, 16);
  }

}
