// Processes - Day 114
// Prayash Thapa - April 23, 2016

int numVertices = 50;
ArrayList<Node> nodes = new ArrayList<Node>();

// ************************************************************************************

void setup() {
  size(500, 200);
  background(#FFFFFF);
  nodes.clear();

  for (int i = 0; i < numVertices; i++) nodes.add(new Node());
}

// ************************************************************************************

void draw() {
  noStroke(); fill(color(228, 238, 238), 5);
  rect(0, 0, width, height);
  for (Node n : nodes) n.render();
  if (frameCount % 6 == 0 && frameCount < 360) saveFrame("_###.png");
}

// ************************************************************************************

class Node {
  float x, y, radius;
  PVector position, velocity;

  Node() {
    radius = random(5, 20);
    position = new PVector(random(width), random(height));
    velocity = new PVector(random(-1, 1), random(-1, 1));
  }

  void render() {
    update();
    renderEdges();
    renderNodes();
  }

  void update() {
    // Movement
    position.add(velocity);

    // Boundary checking
    if (position.x < 0) {
      position.x = 0; velocity.x *= -1;
    } else if (position.x > width) {
      position.x = width; velocity.x *= -1;
    } else if (position.y < 0) {
      position.y = 0; velocity.y *= -1;
    } else if (position.y > height) {
      position.y = height; velocity.y *= -1;
    }
  }

  void renderEdges() {
    stroke(#D92B6A, 120);
    for (Node n : nodes) {
      // Calculate distance from current node to every other
      float distance = dist(position.x, position.y, n.position.x, n.position.y);

      // Only draw if certain distance between nodes
      if (distance > 20 && distance < 60) line(position.x, position.y, n.position.x, n.position.y);
    }
  }

  void renderNodes() {
    // colorValue maps to nodeRadius
    float colorValue = map(radius, 5, 20, 0, 1);

    // fillColor & strokeColor interpolate depending on nodeRadius
    color fillColor = lerpColor(#D92B6A, #DC5978, colorValue);
    color strokeColor = lerpColor(#D92B6A, #DC5978, 1 - colorValue);

    fill(fillColor); stroke(strokeColor);
    if (random(1) > 0.98) ellipse(position.x, position.y, radius, radius);
  }
}

// ************************************************************************************

void mousePressed() {
  setup();
}
