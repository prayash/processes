// Processes - Day 140
// Prayash Thapa - May 19, 2016

import processing.pdf.*;

PFont font;
String[] lines;
String joinedText;
String alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ,. ";

int posX, posY;
int tracking = 29;
int[] counters = new int[alphabet.length()];

boolean savePDF = false;

// ************************************************************************************

void setup() {
  fullScreen();
  background(#d23f31);
  lines = loadStrings("data.txt");
  joinedText = join(lines, " ");
  font = createFont("Courier", 8);
  countCharacters();
}

// ************************************************************************************

void draw() {
  if (savePDF) beginRecord(PDF, "_##.pdf");
  background(#d23f31);
  colorMode(HSB, 360, 100, 100, 100);
  textFont(font);
  textSize(20);
  noStroke();

  posX = 80;
  posY = height/3;

  for (int i = 0; i < joinedText.length(); i++) {
    String s = str(joinedText.charAt(i)).toUpperCase();
    char uppercaseChar = s.charAt(0);
    int index = alphabet.indexOf(uppercaseChar);
    if (index < 0) continue;

    float charAlpha = counters[index];

    float my = map(mouseY, 50, height - 50, 0, 1);
    my = constrain(my, 0, 1);
    float charSize = counters[index] * my * 3;

    float mx = map(mouseX, 50, width - 50, 0, 1);
    mx = constrain(mx, 0, 1);

    pushMatrix();
      translate(posX, posY);
      fill(215, 73, 95, charAlpha);
      rectMode(CENTER);
      rect(0, 0, charSize/10, charSize/10);
    popMatrix();

    posX += textWidth(joinedText.charAt(i));
    if (posX >= width - 200 && uppercaseChar == ' ') {
      posY += int(tracking * my + 30);
      posX = 80;
    }
  }

  if (savePDF) {
    savePDF = false;
    endRecord();
  }
}

// ************************************************************************************

void countCharacters() {
  for (int i = 0; i < joinedText.length(); i++) {
    String s = str(joinedText.charAt(i)).toUpperCase();
    char uppercaseChar = s.charAt(0);
    int index = alphabet.indexOf(uppercaseChar);
    if (index >= 0) counters[index]++;
  }
}

void keyReleased() {
  if (key == 's' || key == 'S') saveFrame("_##.png");
  if (key == 'p' || key=='P') savePDF = true;
}
