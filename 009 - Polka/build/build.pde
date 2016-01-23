// Processes - Day 9
// Prayash Thapa - January 9, 2016

int spacer; 
float[][] distances;
float maxDistance;
color[] colors = new color[4];

// ************************************************************************************

void setup() {
  size(640, 360);
  colors[0] = color(#4285f4); colors[1] = color(#ea4335); colors[2] = color(#495CC5); colors[3] = color(#fbbc05);
  maxDistance = dist(width/2, height/2, width, height);
  distances = new float[width][height];
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      float distance = dist(width/2, height/2, x, y);
      distances[x][y] = distance / maxDistance * 255;
    }
  }
  spacer = 15;
  strokeWeight(7.5);
  noLoop();
}

// ************************************************************************************

void draw() {
  background(#FFFFFF);
  for (int y = 0; y < height; y += spacer) {
    for (int x = 0; x < width; x += spacer) {
      color hue = colors[(int)random(0, 4)];
      stroke(hue, distances[x][y]);
      point(x + spacer/2, y + spacer/2);
    }
  }
}

// ************************************************************************************

void keyPressed() {
  if (key == 's') saveFrame("render-###.png");
}