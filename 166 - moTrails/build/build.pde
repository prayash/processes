import processing.video.*;
Capture video;

int numPixels;
int[] previousFrame;
int[][] diffPoints;
int diffAmount = 0;

int particleMin = 2;
int particleAlpha = 100;

void setup() {
  size(1280, 720);
  background (255);
  noStroke();
  frameRate(30);
  fill(100);

  // video = new Capture(this, width, height, 30);
  String[] cameras = Capture.list();

  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }

    // The camera can be initialized directly using an
    // element from the array returned by list():
    video = new Capture(this, cameras[0]);
    video.start();
  }

  numPixels = width * height;
  previousFrame = new int[numPixels];
  diffPoints = new int[height][width];

}

void draw() {
  if (video.available() == true) {
    video.read();

    // image(video, 0, 0);
    // The following does the same, and is faster when just drawing the image
    // without any additional resizing, transformations, or tint.
    // set(0, 0, cam);

    diffAmount = 0;
    for (int i = 0; i < numPixels; i++) {
      diffPoints[abs(i / width)][i % width] = 0;
      color currColor = video.pixels[i];
      color prevColor = previousFrame[i];
      // Extract the red, green, and blue components from current pixel
      int currR = (currColor >> 16) & 0xFF; // Like red(), but faster
      int currG = (currColor >> 8) & 0xFF;
      int currB = currColor & 0xFF;
      // Extract red, green, and blue components from previous pixel
      int prevR = (prevColor >> 16) & 0xFF;
      int prevG = (prevColor >> 8) & 0xFF;
      int prevB = prevColor & 0xFF;
      // Compute the difference of the red, green, and blue values
      int diffR = abs(currR - prevR);
      int diffG = abs(currG - prevG);
      int diffB = abs(currB - prevB);
      // Render the difference image to the screen
      color diff = color(diffR, diffG, diffB);
      int isPointDiff = 0;
      //-16777216
      if (diff > -15000000) {
        isPointDiff = 1;
        ++diffAmount;
      }
      diffPoints[abs(i / width)][i % width] = isPointDiff;
    }
    checkForNewPoint(diffAmount);

    arraycopy(video.pixels, previousFrame);
  }
}

void checkForNewPoint(int diffAmount) {
  if (diffAmount > 100000) return;
  float milliseconds = millis();
  if (milliseconds < 1000) return;
  if (diffAmount < 40) return;
  int blocks = 0;
  for (int i = 0; i < height; i++) {
    for (int j = 0; j < width; j++) {
      if (i > 1 && j > 1 && diffPoints[i][j] == 1) {
        if (diffPoints[i - 1][j] == 1 && diffPoints[i - 2][j] == 1 || diffPoints[i][j - 1] == 1 && diffPoints[i][j - 2] == 1) {
          ++blocks;
          int randNum = 10;
          int randX = int((randNum / 2) - random(randNum));
          int randY = int((randNum / 2) - random(randNum));
          color c = previousFrame[(i * width) + j];
          fill(c, particleAlpha);
          int particleSize = diffAmount / 1000;

          if (random(particleSize) > (particleSize - (.9999999 / particleSize))) {
            ellipse(j, i, particleMin + particleSize, particleMin + particleSize);
          }
        }
      }
    }
  }
}

void mousePressed() {
  fill(255);
  rect(0, 0, width, height);
}
