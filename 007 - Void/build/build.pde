PVector[] vertices;
int numVertices = 7;
int radius = 96;

void setup() {
    size(700, 700);
    background(0);

    vertices = new PVector[numVertices];
    float angle = PI / 3;

    for (int i = 0; i < numVertices; i++) {
        vertices[i] = new PVector(radius * cos(angle * i), radius * sin(angle * i));
    }

    println(vertices);
}

void draw() {
    noFill();
    stroke(255, 20);
    strokeWeight(1);

    translate(width / 2, height / 2);
    beginShape();
    
    for(int i = 0; i < numVertices; i++) {
        vertex(vertices[i].x, vertices[i].y);
    }
    
    endShape();

    for(int i = 0; i < numVertices; i++) {
        PVector move = new PVector();
        move.x = vertices[i].x;
        move.y = vertices[i].y;
        move.normalize();
        move.mult(random(-3.5, 3.75));

        vertices[i].add(move);
    }
}

void keyPressed() {
  if (key == 's') {
    saveFrame("render.png");
  }
}
