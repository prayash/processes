// Processes - Day 94
// Prayash Thapa - April 3, 2016

int num = int(30 + random(70));
Circle[] circleArr = {};

// ************************************************************************************

void setup() {
  size(500, 300);
  fill(255, 50); strokeWeight(1);
  for (int i = 0; i < num; i++) circleArr = (Circle[]) append(circleArr, new Circle());
}

// ************************************************************************************

void draw() {
  fill(#D92B6A, 25); noStroke();
  rect(0, 0, width, height);
  for (int i = 0; i < circleArr.length; i++) circleArr[i].render();
}

// ************************************************************************************

class Circle {
  float x, y;
  float radius, alpha;
  float xMove, yMove;

  Circle() {
    x = random(width); y = random(height);
    radius = random(50) + 10; alpha = random(1, 5);
    xMove = random(6) - 3; yMove = random(6) - 3;
  }

  void render() {
    x += xMove; y += yMove;

    if (x > (width + radius))   { x = 0 - radius; }
    if (x < (0 - radius))       { x = width + radius; }
    if (y > (height + radius))  { y = 0 - radius; }
    if (y < (0 - radius))       { y = height + radius; }

    for (int i = 0; i < circleArr.length; i++) {
      Circle otherCirc = circleArr[i];
      if (otherCirc != this) {    // don't test against ourself

        // calculate the distance between them
        float dis = dist(x, y, otherCirc.x, otherCirc.y);
        float overlap = dis - radius - otherCirc.radius;
        if (overlap < 0) {

          // draw a circle of the intersect
          // first work out the central point between our two touching circs
          float intx, inty;
          if (x < otherCirc.x) intx = x + (otherCirc.x - x)/2;
          else intx = otherCirc.x + (x - otherCirc.x)/2;

          if (y < otherCirc.y) inty = y + (otherCirc.y - y)/2;
          else inty = otherCirc.y + (y - otherCirc.y)/2;

          stroke(255, random(1, 5)); noFill();
          overlap *= -3;  // make it into a positive number

          ellipse(intx, inty, overlap, overlap);
        }
      }
    }

    noStroke(); fill(255, alpha);
    ellipse(x, y, radius * 2, radius * 2);
  }
}

// ************************************************************************************

void mouseReleased() {
  num = int(30 + random(70));
  circleArr = (Circle[]) expand(circleArr, 0);
  setup();
}

void keyReleased() {
  if (key == 's') saveFrame("_##.png");
}
