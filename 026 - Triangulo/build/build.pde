// Processes - Day 26
// Prayash Thapa - January 26, 2016

// ************************************************************************************

void setup() {
  size(720, 720);
  background(#4b4e79);
  noFill();
}

// ************************************************************************************

void draw() {
  if (mousePressed) {
    pushMatrix();
      translate(width / 2, height / 2);
      float radius = mouseX - width / 2 + 0.5;
      float angle = TWO_PI / 3;
      strokeWeight(2);
      stroke(255, 25);

      beginShape();
        for (int i = 0; i <= 3; i++){
          float x = 0 + cos(angle * i) * radius;
          float y = 0 + sin(angle * i) * radius;
          vertex(x, y);
          ellipse(x, y, 10, 10);
        }
      endShape();
    popMatrix();
  }
}

// ************************************************************************************

void keyReleased(){
  if (key == DELETE || key == BACKSPACE) background(#4b4e79);
  if (key=='s' || key=='S') saveFrame("##.png");
}