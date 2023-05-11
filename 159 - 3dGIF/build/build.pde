// Processes - Day 159
// Prayash Thapa - June 7, 2016

int numFrames = 24;
PImage[] images = new PImage[numFrames];
PImage capture;

// ************************************************************************************

void setup() {
  size(600, 400, P3D);
  frameRate(numFrames);
  for (int i = 0; i < images.length; i++) {
    String imageName = (i) + ".jpg";
    images[i] = loadImage(imageName);
  }
}

// ************************************************************************************

void draw() {
  background(0);
  camera(mouseX, mouseY, (height/1.3) / tan(PI/6), mouseX, height/1.3, 0, 0, 1, 0);
  int frame = frameCount % numFrames;
  translate(0, 100, 0);
  capture = images[frame].get();

  int steps = 7;
  for (int i = 0; i < width/steps; i++) {
    for (int j = 0; j < height/steps; j++) {
      pushMatrix();
        color c = capture.get(i * steps, j * steps);
        float z = brightness(c);
        fill(c);
        stroke(c);
        translate(i * steps, j * steps, z);
        box(steps - 2, steps - 2, steps - 2);
      popMatrix();
    }
  }
}
