// Processes - Day 41
// Prayash Thapa - February 10, 2016

// ************************************************************************************

int NVERTS = 6;

float vertX1[] = new float[NVERTS];
float vertY1[] = new float[NVERTS];
float vertX2[] = new float[NVERTS];
float vertY2[] = new float[NVERTS];

float vertX[] = new float[NVERTS];
float vertY[] = new float[NVERTS];

int yRand = 1000;
float sizeRand;
int count = 0;
int countRate = (int)random(0, 50);

PGraphics multigonImg, backdropImg;

void setup() {
  size(800, 800);
  multigonImg = createGraphics(width, height);
  backdropImg = createGraphics(width, height);
  resetMultigon();
}

void draw() {
  // drawMultigon(multigonImg);
  drawBackdrop(backdropImg);
  image(backdropImg, 0, 0);
  // blend(multigonImg, 0, 0, width, height, 0, 0, width, height, LIGHTEST);
}

void resetMultigon() {
  for (int i = 0; i < NVERTS; i++) {
    vertX1[i] = random(width);
    vertY1[i] = random(width);
    vertX2[i] = random(width);
    vertY2[i] = random(width);
  }
}

void drawMultigon(PGraphics pg) {
  float t = 0.5 * millis() * 1e-3;
  for (int i = 0; i < NVERTS; i++) {
    vertX[i] = map(cos(t), -1, +1, vertX1[i], vertX2[i]);
    vertY[i] = map(sin(t), -1, +1, vertY1[i], vertY2[i]);
  }
  pg.beginDraw();
  pg.strokeWeight(5);
  pg.background(0xff);
  for (int i = 0; i < NVERTS - 1; i++) {
    for (int j = i + 1; j < NVERTS; j++) {
      pg.line(vertX[i], vertY[i], vertX[j], vertY[j]);
    }
  }
  pg.endDraw();
}

void drawBackdrop(PGraphics pg) {
  pg.beginDraw();
  pg.colorMode(HSB, 1, 1, 1, 1);
  pg.background(#ca2687);
  for (int i = 0; i < 400; i++) {
    pg.strokeWeight(random(400 - i));
    pg.stroke(random(1), 1, 1, 0.7);
    // pg.point(random(pg.width), random(pg.height));
    pg.pushMatrix();
      pg.rotate(random(-360, 360));
      pg.noStroke();
      pg.fill(255, random(50, 150));
      pg.rect(random(pg.width), random(pg.height), 100, 100);
      pg.ellipse(count, (pg.height/2 + 40) + random(-yRand, yRand), sizeRand, sizeRand);
    pg.popMatrix();
  }
  // pg.ellipse(count, (pg.height/2 + 40) + random(-yRand, yRand), sizeRand, sizeRand);
  pg.endDraw();
}

// ************************************************************************************

void keyReleased() {
  if (key == 's') saveFrame("_##.png");
}

void mouseClicked() {
  resetMultigon();
  drawBackdrop(backdropImg);
}
