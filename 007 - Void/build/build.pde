// Processes - Day 7
// Prayash Thapa - January 7, 2016

PVector[] tabPoint;
int vertices = 30;
int circleSize = 100;

// ************************************************************************************

void setup() {
  size(700, 700);
  background(0);
  tabPoint = new PVector[vertices];
  float angle = TWO_PI/vertices;
  for (int i = 0; i < vertices; i++) {
    tabPoint[i] = new PVector(circleSize * cos(angle * i), circleSize * sin(angle * i));
    if (i == vertices - 1) tabPoint[vertices - 1] = new PVector(circleSize * cos(angle * (i + 1)), circleSize * sin(angle * i));
    // fuck me i can't figure out how to complete this damn circle -.-
    println(tabPoint[i]);
  }
}

// ************************************************************************************

void draw() {
  PVector move = new PVector();

  noFill();
  stroke(255, 20);
  strokeWeight(1);
  translate(width/2, height/2);

  beginShape();
    for(int i = 0; i < vertices; i++) {
      vertex(tabPoint[i].x, tabPoint[i].y);
    }
  endShape(); 
  
  // ** Animation
  for(int i = 0; i < vertices; i++) {
    move.x = tabPoint[i].x;
    move.y = tabPoint[i].y;
    move.normalize();
    move.mult(random(-3.5, 3.75));
    tabPoint[i].x += move.x;
    tabPoint[i].y += move.y;
  } 
}

// ************************************************************************************

void keyPressed() {
  if (key == 's') {
    saveFrame("render.png");
  }
}