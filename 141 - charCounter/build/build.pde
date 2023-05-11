// Processes - Day 141
// Prayash Thapa - May 20, 2016

import processing.pdf.*;

PFont font;
String[] lines;
String joinedText;

String alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ,.";
int[] counters = new int[alphabet.length()];

float charSize;
color charColor = 0;
int posX = 40;
int posY = 50;
int radius = 8;
int yOff = 125;

boolean savePDF = false;

// ************************************************************************************

void setup() {
  fullScreen();
  background(#4285F4);
  lines = loadStrings("data.txt");
  joinedText = join(lines, " ");
  font = createFont("Courier", 10);
  countCharacters();
}

// ************************************************************************************

void draw() {
  if (savePDF) beginRecord(PDF, "##.pdf");

  colorMode(HSB, 360, 100, 100, 100);
  textFont(font);
  background(#4285F4);
  noStroke();
  fill(0, 0, 100, 100);

  translate(50, 0);

  posX = 20;
  posY = 200;
  float[] sortPositionsX = new float[alphabet.length()];

  // * Counters
  textSize(10);
  for (int i = 0; i < alphabet.length(); i++) {
    textAlign(LEFT);
    text(alphabet.charAt(i), -15, i * 20 + yOff + 3);
    textAlign(RIGHT);
    text(counters[i], -20, i * 20 + yOff + 3);
  }

  textAlign(LEFT);
  textSize(20);

  for (int i = 0; i < joinedText.length(); i++) {
    String s = str(joinedText.charAt(i)).toUpperCase();
    char uppercaseChar = s.charAt(0);
    int index = alphabet.indexOf(uppercaseChar);
    if (index < 0) continue;

    float charAlpha = constrain(counters[index], 0, 100);
    float m = constrain(map(mouseX, 50, width - 25, 0, 1), 0, 1);

    float sortX = sortPositionsX[index];
    float interX = lerp(posX, sortX, m);

    float sortY = index * 20 + yOff;
    float interY = lerp(posY, sortY, 1);

    // Render components
    noStroke();
    fill(0, 0, 100, charAlpha);
    ellipse(interX, sortY, radius, radius);

    sortPositionsX[index] += textWidth(joinedText.charAt(i));
    posX += textWidth(joinedText.charAt(i));
    if (posX >= width - 200 && uppercaseChar == ' ') {
      posY += 40;
      posX = 20;
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
  if (keyCode == 's') {
    saveFrame("_##.png");
    savePDF = true;
  }
}
