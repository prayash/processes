// Processes - Day 85
// Prayash Thapa - March 25, 2016

PFont font;
String letter = "X";

// ************************************************************************************

void setup(){
  size(800, 800);
  background(#202020);
  fill(255, 100);

  font = createFont("Helvetica", 12);
  textFont(font);
  textAlign(CENTER, CENTER);
}
// ************************************************************************************

void draw() {
  if (mousePressed) {
    textSize(abs((mouseX - width/2) * 5 + 1));
    text(letter, width/2, mouseY);
  }
}

// ************************************************************************************

void keyReleased() {
  if (key == 's') saveFrame("_##.png");
  if (key != CODED && (int)key > 32) letter = str(key);
  if (key == DELETE || key == BACKSPACE) background(#202020);
}
