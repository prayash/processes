// Processes - Day 103
// Prayash Thapa - April 12, 2016

int numPoints     = 300;
int numForms      = 5;
float maxNoise    = 5;
int threshold     = 80;
float maxRad;

HPoint[] pointArr = {};
Form[] formArr = {};

// ************************************************************************************

void setup() {
  size(700, 700, P3D);
  background(#EAE8CB);
  noCursor();

  // - Form
  for (int x = 0; x < numForms; x++) formArr = (Form[]) append(formArr, new Form());

  // - Points
  for (int x = 0; x < numPoints; x++) pointArr = (HPoint[]) append(pointArr, new HPoint());
}

// ************************************************************************************

void draw() {
  fill(#EAE8CB, 15); noStroke();
  rect(0, 0, width, height);

  // - Noise
  maxNoise = 5.001;
  maxRad = noise(maxNoise) * 100;

  // - Update
  for (Form f : formArr) f.update();
  for (HPoint hP : pointArr) hP.update();

  pushMatrix();

    translate(width/2, height/2, 0);
    rotateY(frameCount * 0.01); rotateX(frameCount * 0.01);

    for (HPoint p : pointArr) {
      stroke(p.col + (frameCount % 250), 150);
      stroke(color(56, 126, 245), 15);
      for (HPoint allOtherP : pointArr) {
        strokeWeight(1);
        float diff = dist(p.x, p.y, p.z, allOtherP.x, allOtherP.y, allOtherP.z);
        if (diff < threshold) line(p.x, p.y, p.z, allOtherP.x, allOtherP.y, allOtherP.z);
        strokeWeight(5);
        if (random(1) > 0.98) point(p.x, p.y, p.z);
      }
    }

  popMatrix();

  if (frameCount % 3 == 0 && frameCount < 181) saveFrame("_###.gif");
}

// ************************************************************************************

class Form {
  float radius, radNoise;

  Form() {
    radNoise = random(10);
  }

  void update() {
    radNoise += 0.01;
    radius = 250 + (noise(radNoise) * 20);
  }
}

class HPoint {
  float s, t;
  float x, y, z;
  int myForm;
  color col;

  HPoint() {
    s = random(width); t = random(height);
    col = color(255 - (10 * myForm), 160, (10 * myForm), 100);
    myForm = (int) random(numForms);
  }

  void update() {
    Form F = formArr[myForm];
    x = F.radius * cos(s) * sin(t);
    y = F.radius * sin(s) * sin(t);
    z = F.radius * cos(t);
  }
}

// ************************************************************************************

void keyPressed() {
  if (key == DELETE || key == BACKSPACE) setup();
  if (key == 's' || key == 'S') saveFrame("_##.png");
}
