// Processes - Day 57
// Prayash Thapa - February 26, 2016

// ************************************************************************************

float boxSize = 50;
float margin = 65;

void setup() {
  size(700, 500, P3D);
  frameRate(12);
  noStroke();
}

// ************************************************************************************

void draw() {
  background(255);

  // Center and spin grid
  translate(width/2, height/2, 0);
  rotateY(frameCount * 0.01);
  rotateX(frameCount * 0.01);

  // Build grid using multiple translations
  for (float i =- height+margin; i <= height-margin; i += margin){
    pushMatrix();
      for (float j =- height+margin; j <= height-margin; j += margin){
        pushMatrix();
          for (float k =- width+margin; k <= width-margin; k += margin){
            pushMatrix();
              translate(k, j, i * 5);
              fill(0, 0, 255, 20);
              box(boxSize, boxSize, boxSize);
            popMatrix();
          }
        popMatrix();
      }
    popMatrix();
  }
}

// ************************************************************************************

void keyReleased() {
  if (key == DELETE || key == BACKSPACE) background(255);
  if (key == 's' || key == 'S') saveFrame("_##.png");
}
