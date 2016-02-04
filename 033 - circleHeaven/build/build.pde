// Processes - Day 33
// Prayash Thapa - February 2, 2016

// ************************************************************************************

PGraphics backdropImg;
 
void setup() {
  size(800, 800);
  backdropImg = createGraphics(width, height);
  drawBackdrop(backdropImg);
}
 
void draw() {
  image(backdropImg, 0, 0);
}
 
void drawBackdrop(PGraphics pg) {
  pg.beginDraw();
  pg.colorMode(HSB, 1, 1, 1, 1);
  pg.background(random(1), 1, 1);
  for (int i = 0; i < 400; i++) {
    pg.strokeWeight(random(400 - i));
    pg.stroke(random(1), 1, 1, 0.7);
    pg.point(random(pg.width), random(pg.height));
  }
  pg.endDraw();
}

// ************************************************************************************

void keyReleased() {
  if (key == 's') saveFrame("_##.png");
}
 
void mouseClicked() {
  drawBackdrop(backdropImg);
}