// Processes - Day 90
// Prayash Thapa - March 30, 2016

import processing.pdf.*;
boolean savePDF = false;

PFont font;
String joinedText;

String alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZÄÖÜß,.;:!? ";
int[] counters = new int[alphabet.length()];

float charSize;
color charColor = 0;
int posX, posY;

// ************************************************************************************

void setup() {
  size(700, 500);
  frameRate(15);

  font = createFont("Roboto Mono", 15);
  String[] lines = loadStrings("data.txt");
  joinedText = join(lines, " ");

  countCharacters();
}

// ************************************************************************************

void draw() {
  if (savePDF) beginRecord(PDF, "##.pdf");

  textFont(font);
  background(#202020);
  noStroke();

  posX = 20;
  posY = 80;

  for (int i = 0; i < joinedText.length(); i++) {
    String s = str(joinedText.charAt(i)).toUpperCase();
    char uppercaseChar = s.charAt(0);
    int index = alphabet.indexOf(uppercaseChar);
    if (index < 0) continue;

    fill(255, counters[index] * 10);
    textSize((int) random(45, 50));

    float sortY = index * 20 + 40;
    float m = map(frameCount * 8, 50, width - 50, 1, 0);
    m = constrain(m, 0, 3);
    float interY = lerp(posY, sortY, m);

    text(joinedText.charAt(i), posX, interY);

    posX += textWidth(joinedText.charAt(i));
    if (posX >= width - 120 && uppercaseChar == ' ') {
      posY += 50;
      posX = 20;
    }

    fill(255, (int) random(105, 205));
    if (random(1) > 0.9987) rect(random(width), random(height), random(5, 250), random(145));
  }

  if (savePDF) {
    savePDF = false;
    endRecord();
  }

  // if (frameCount % 4 == 0) saveFrame("image-####.gif");
}

// ************************************************************************************

void countCharacters() {
  for (int i = 0; i < joinedText.length(); i++) {
    char c = joinedText.charAt(i);
    String s = str(c);
    s = s.toUpperCase();
    char uppercaseChar = s.charAt(0);
    int index = alphabet.indexOf(uppercaseChar);

    if (index >= 0) counters[index]++;
  }
}


void keyReleased() {
  if (key == 's') saveFrame("_##.png");
  if (key=='p') savePDF = true;
}
