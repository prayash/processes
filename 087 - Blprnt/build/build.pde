// Processes - Day 87
// Prayash Thapa - March 27, 2016

import processing.pdf.*;
boolean savePDF = false;

PFont font;
String textTyped = "";

PShape shapeSpace, shapeSpace2, shapePeriod, shapeComma;
PShape shapeQuestionmark, shapeExclamationmark, shapeReturn;

int centerX = 0, centerY = 0, offsetX = 0, offsetY = 0;
float zoom = 0.75; int actRandomSeed = 6;

// ************************************************************************************

void setup() {
  size(displayWidth, displayHeight);
  cursor(HAND);

  textTyped += "\n.We  ,  are,  .  Infinite. Consciousness?.    having a human experience.\n\n";
  textTyped += "\n.We  ,  are,  .  Infinite?. Consciousness.    having a human experience.\n\n";
  textTyped += "\n.We  ,  are,  .  Infinite. Consciousness?.    having a human experience.\n\n";
  textTyped += "\n.We  ,  are,  .  Infinite?. Consciousness?.    having a human experience.\n\n";

  centerX = width/2; centerY = height/2;
  font = createFont("miso-bold.ttf", 20);

  shapeSpace = loadShape("space.svg");
  shapeSpace2 = loadShape("space2.svg");
  shapePeriod = loadShape("period.svg");
  shapeComma = loadShape("comma.svg");
  shapeExclamationmark = loadShape("exclamationmark.svg");
  shapeQuestionmark = loadShape("questionmark.svg");
  shapeReturn = loadShape("return.svg");
}

// ************************************************************************************

void draw() {
  if (savePDF) beginRecord(PDF, "##.pdf");

  background(255);
  noStroke();
  textAlign(LEFT);
  translate(centerX, centerY);
  scale(zoom);
  randomSeed(actRandomSeed);

  // * Cursor
  fill(0); if (frameCount/10 % 2 == 0) rect(0, 0, 15, 2);

  for (int i = 0; i < textTyped.length(); i++) {
    textFont(font, 30);
    char letter = textTyped.charAt(i);
    float letterWidth = textWidth(letter);

    switch(letter) {
      case ' ':
        // 50% left, 50% right
        int dir = floor(random(0, 2));
        if (dir == 0) {
          shape(shapeSpace, 0, 0);
          translate(1.9, 0);
          rotate(PI/2);
        } else if (dir == 1) {
          shape(shapeSpace2, 0, 0);
          translate(13, -50);
          rotate(-PI/4);
        }
        break;

      case ',':
        shape(shapeComma, 0, 0);
        translate(34, 15);
        rotate(PI/4);
        break;

      case '.':
        shape(shapePeriod, 0, 0);
        translate(56, -54);
        rotate(-PI/2);
        break;

      case '!':
        shape(shapeExclamationmark, 0, 0);
        translate(42, -17.4);
        rotate(-PI/4);
        break;

      case '?':
        shape(shapeQuestionmark, 0, 0);
        translate(42, -18);
        rotate(-PI/4);
        break;

      case '\n':
        shape(shapeReturn, 0, 0);
        translate(0, 10);
        rotate(PI);
        break;

      default:
        fill(0);
        text(letter, 0, 0);
        translate(letterWidth, 0);
    }
  }

  if (mousePressed == true) {
    centerX = mouseX - offsetX;
    centerY = mouseY - offsetY;
  }

  if (savePDF) {
    savePDF = false;
    endRecord();
    saveFrame("##.png");
  }
}

// ************************************************************************************

void mousePressed() {
  offsetX = mouseX - centerX;
  offsetY = mouseY - centerY;
}

void keyReleased() {
  if (keyCode == CONTROL) savePDF = true;
  if (keyCode == ALT) actRandomSeed++;
}

void keyPressed() {
  if (key != CODED) {
    switch(key) {
      case BACKSPACE:
        textTyped = textTyped.substring(0, max(0, textTyped.length() - 1));
        break;
      case RETURN: textTyped += "\n"; break;
      default: textTyped += key;
    }
  }

  if (keyCode == UP) zoom += 0.05;
  if (keyCode == DOWN) zoom -= 0.05;
}
