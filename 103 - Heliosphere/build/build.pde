// Processes - Day 103
// Prayash Thapa - April 12, 2016

int numPoints     = 500;
int numForms      = 5;
float maxNoise    = 5;
int threshold; float maxRad;

HPoint[] pointArr = {};
Form[] formArr = {};

// ************************************************************************************

void setup() {
  size(700, 700, P3D);
  background(255);
  noCursor();

  // - Form
  for (int x = 0; x < numForms; x++) {
    formArr = (Form[]) append(formArr, new Form());
  }

  // - Points
  for (int x = 0; x < numPoints; x++) {
    pointArr = (HPoint[]) append(pointArr, new HPoint(random(360), random(360)));
  }
}

// ************************************************************************************

void draw() {
  background(255);

  // - Noise
  maxNoise = 5.001;
  maxRad = noise(maxNoise) * 100;
  threshold = int(maxRad);

  // - Update
  for (Form f : formArr) f.update();
  for (HPoint hP : pointArr) hP.update();

  pushMatrix();

    translate(width/2, height/2, 0);
    rotateY(frameCount * 0.01); rotateX(frameCount * 0.01);

    for (HPoint p : pointArr) {
      stroke(p.col + (frameCount % 250), 150 * maxRad);
      for (HPoint otherP : pointArr) {
        float diff = dist(p.x, p.y, p.z, otherP.x, otherP.y, otherP.z);
        if (diff < threshold) line(p.x, p.y, p.z, otherP.x, otherP.y, otherP.z);
        strokeWeight(2);
        if (random(1) > 0.9) point(p.x, p.y, p.z);
      }
    }

  popMatrix();
}

// ************************************************************************************

class Form {
  float radius, radNoise;

  Form() {
    radNoise = random(10);
  }

  void update() {
    radNoise += 0.01;
    radius = 200 + (noise(radNoise) * 20);
  }
}

class HPoint {
  float s, t;
  float x, y, z;
  int myForm;
  color col;

  HPoint(float _s, float _t) {
    s = _s; t = _t;
    col = color(255 - (10 * myForm), 160, (10 * myForm), 100);
    myForm = int(random(numForms));
  }

  void update() {
    Form F = formArr[myForm];
    x = F.radius * cos(s) * sin(t);
    y = F.radius * sin(s) * tan(t);
    z = F.radius * cos(t) * tan(t);

    // x = F.radius * cos(s) * sin(t);
    // y = F.radius * sin(s) * sin(t);
    // z = F.radius * cos(t);
  }
}

// ************************************************************************************

void keyPressed() {
  if (key == DELETE || key == BACKSPACE) setup();
  if (key == 's' || key == 'S') saveFrame("_##.png");
}
