// Processes - Day 114
// Prayash Thapa - April 23, 2016

int numVertices = 50;
float[] nodeRadius = new float[numVertices];
float[] nodeX = new float[numVertices];
float[] nodeY = new float[numVertices];

float[] velocityX = new float[numVertices];
float[] velocityY = new float[numVertices];

// ************************************************************************************

void setup() {
  size(600, 200);
  background(#57385c);

  // Init
  for (int i = 0; i < numVertices; i++) {
    nodeRadius[i] = random(5, 20);

    nodeX[i] = random(width);
    nodeY[i] = random(height);

    velocityX[i] = random(-2, 2);
    velocityY[i] = random(-2, 2);
  }
}

// ************************************************************************************

void draw() {
  background(#57385c);

  // * Kinetic Graph
  renderEdges();
  renderNodes();
  update();
}

// ************************************************************************************

void update() {
  for (int i = 0; i < numVertices; i++) {
    // Movement of nodes
    nodeX[i] = nodeX[i] + velocityX[i];
    nodeY[i] = nodeY[i] + velocityY[i];

    // Boundary checking
    if (nodeX[i] < nodeRadius[i] / 2) {
      nodeX[i] = nodeRadius[i] / 2;
      velocityX[i] = velocityX[i] * -1;
    } else if (nodeX[i] > width- nodeRadius[i] / 2) {
      nodeX[i] = width- nodeRadius[i] / 2;
      velocityX[i] = velocityX[i] * -1;
    } else if (nodeY[i] < nodeRadius[i] / 2) {
      nodeY[i] = nodeRadius[i] / 2;
      velocityY[i] = velocityY[i] * -1;
    } else if (nodeY[i] > height- nodeRadius[i] / 2) {
      nodeY[i] = height- nodeRadius[i] / 2;
      velocityY[i] = velocityY[i]* -1;
    }
  }
}

void renderEdges() {
  stroke(#ffedbc, 120);
  for (int i = 0; i < numVertices; i++) {
    float nodeX1 = nodeX[i];
    float nodeY1 = nodeY[i];

    for (int j = 0; j < numVertices; j++) {
      float nodeX2 = nodeX[j];
      float nodeY2 = nodeY[j];

      // Calculate distance from one node to every other
      float distance = dist(nodeX1, nodeY1, nodeX2, nodeY2);

      // Only draw if certain distance between nodes
      if (distance > 30 && distance < 60) line(nodeX1, nodeY1, nodeX2, nodeY2);
    }
  }
}

void renderNodes() {
  for (int i = 0; i < numVertices; i++) {
    // colorValue maps to nodeRadius
    float colorValue = map(nodeRadius[i], 5, 20, 0, 1);

    // fillColor & strokeColor interpolate depending on nodeRadius
    color fillColor = lerpColor(#ffedbc, #57385c, colorValue);
    color strokeColor = lerpColor(#ffedbc, #57385c, 1 - colorValue);

    fill(fillColor); stroke(strokeColor);
    ellipse(nodeX[i], nodeY[i], nodeRadius[i], nodeRadius[i]);
  }
}

// ************************************************************************************

void mousePressed() {
  setup();
}
