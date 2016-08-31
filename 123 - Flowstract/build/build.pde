// Processes - Day 123
// Prayash Thapa - May 2, 2016

float theta;

// ************************************************************************************

void setup() {
  size(800, 800);
  background(#303030);
  noFill(); strokeWeight(1);
  strokeJoin(ROUND); strokeCap(ROUND);
}

// ************************************************************************************

void draw() {
  translate(width/2, height/2);
  theta = frameCount * 0.001;

  for (int x= -600; x <= 601; x += 400) {
    for (int y= -600; y <= 601; y += 400) {
      float point_1 = map(sin(-theta), -1, 1, 300, -300);
      float point_2 = map(cos(-theta), -1, 1, -300, 300);
      float point_3 = map(cos(theta), 0, 1, (x + y), 0);
      float point_4 = map(sin(theta), 0, 1, 0, (x + y));

      stroke(#E0E8EB, 10);
      line(point_1, point_2, x - point_3, y + point_4);
    }
  }
}

// ************************************************************************************

void keyPressed() {
  if (key == 's') saveFrame("####.png");
}
