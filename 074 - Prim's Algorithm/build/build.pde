// Processes - Day 74
// Prayash Thapa - March 14, 2016

PVector[] vertices = new PVector[0];
void setup() {
  size(640, 360);
  background(#202020);
  fill(255);
  noStroke();
}

void draw() {

  PVector[] reached = new PVector[0];
  PVector[] unreached = new PVector[0];

  for (int i = 0; i < vertices.length; i++) {
    unreached = (PVector[]) append(unreached, vertices[i]);
    // stroke(255); strokeWeight(1);
    // line(vertices[i].x, vertices[i].y, 50, 50);
  }

  // unreached = (PVector[]) splice(unreached, 0, 1);
  // ellipse(unreached[0].x, unreached[0].y, 10, 10);

  for (int i = 0; i < vertices.length; i++) {
    ellipse(vertices[i].x, vertices[i].y, 16, 16);
  }

}

void mousePressed() {
  PVector v = new PVector(mouseX, mouseY);
  vertices = (PVector[]) append(vertices, new PVector(mouseX, mouseY));
}
