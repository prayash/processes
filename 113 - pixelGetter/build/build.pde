// Processes - Day 113
// Prayash Thapa - April 22, 2016

PImage img;

// ************************************************************************************

void setup() {
  size (600, 600); background (#57385C);
  frameRate(24);
  img = loadImage ("asset.jpg");

}

// ************************************************************************************

void draw() {
  int distance = (int) map(mouseX, 0, width, 10, 40);

  for (int x = 0; x < img.width; x += 20) {
    for (int y = 0; y < img.height; y += 20) {
      color c = img.get(x, y);
      float pixelLight = brightness(c);
      float d = map(pixelLight, 0, 255, 1, distance);

      fill(c, random(105, 205)); noStroke();
      rectMode(CENTER);
      if (random(1) > 0.55) rect(x + distance / 2, y + distance / 2, d, d);
    }
  }
}

void keyPressed() {
  if (key == 's') saveFrame("##.png");
}
