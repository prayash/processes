// Processes - Day 86
// Prayash Thapa - March 26, 2016

String textTyped = "";
float[] fontSizes = new float[textTyped.length()];
float minFontSize = 15;
float maxFontSize = 800;
float newFontSize = 0;

int pMillis;
float maxTimeDelta = 5000.0;

float spacing = 2;
float tracking = 0;
PFont font;

color palette[] = {#DC5978, #ECF0F1, #7877f9, #3498DB, #ffa446};

// ************************************************************************************

void setup() {
  size(800, 600);
  surface.setResizable(true);
  font = createFont("Menlo", 10);
  noCursor();

  for (int i = 0; i < textTyped.length(); i++) fontSizes[i] = minFontSize;
  pMillis = millis();
}

// ************************************************************************************

void draw() {
  background(255);
  textAlign(LEFT);
  noStroke();

  spacing = map(mouseY, 0, height, 0, 60);
  translate(0, 200 + spacing);

  float x = 0, y = 0, fontSize = 20;

  for (int i = 0; i < textTyped.length(); i++) {
    fontSize = fontSizes[i];
    textFont(font, fontSize);
    char letter = textTyped.charAt(i);
    float letterWidth = textWidth(letter) + tracking;

    if (x + letterWidth > width) {
      x = 0;
      y += spacing;
    }

    // * Draw + update coordinate
    text(letter, x, y);
    x += letterWidth;
  }

  // * Cursor
  float timeDelta = millis() - pMillis;
  newFontSize = map(timeDelta, 0,maxTimeDelta, minFontSize,maxFontSize);
  newFontSize = min(newFontSize, maxFontSize);

  fill(0);
  if (frameCount/10 % 2 == 0) fill(255);
  rect(x, y, newFontSize/2, newFontSize/20);
}

// ************************************************************************************

void keyReleased() {
  if (keyCode == CONTROL) saveFrame("_##.png");
}

void keyPressed() {
  switch(key) {
    case BACKSPACE:
      if (textTyped.length() > 0) {
        textTyped = textTyped.substring(0, max(0, textTyped.length() - 1));
        fontSizes = shorten(fontSizes);
      }
      break;
    default:
      textTyped += key;
      fontSizes = append(fontSizes, newFontSize);
  }

  pMillis = millis();
}
