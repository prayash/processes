// Processes - Day 20
// Prayash Thapa - January 20, 2016

// ************************************************************************************

import generativedesign.*;

int colorCount = 20;
int[] hueValues = new int[colorCount];
int[] saturationValues = new int[colorCount];
int[] brightnessValues = new int[colorCount];

int actRandomSeed = 0;

void setup() {
  size(800, 800); 
  colorMode(HSB, 360, 100, 100);
  noStroke();
}

// ************************************************************************************

void draw() { 
  background(#FFFFFF);
  randomSeed(actRandomSeed);

  for (int i = 0; i < colorCount; i++) {
    if (i % 2 == 0) {
      hueValues[i] = (int)random(0, 360);
      saturationValues[i] = 100;
      brightnessValues[i] = (int)random(0, 100);
    } else {
      hueValues[i] = 195;
      saturationValues[i] = (int)random(0, 20);
      brightnessValues[i] = 100;
    }
  }

  int counter = 0;
  int rowCount = (int)random(10, 15);
  float rowHeight = (float)height / (float)rowCount;

  for(int i = rowCount; i >= 0; i--) {
    int partCount = i + 1;
    float[] parts = new float[0];

    for(int j = 0; j < partCount; j++) {
      if (random(1.0) < 0.075) {
        int fragments = (int)random(2, 20);
        partCount += fragments;
        for(int k = 0; k < fragments; k++) parts = append(parts, random(20));
      } else {
        parts = append(parts, random(0.5));
      }
    }

    float sumPartsTotal = 0;
    for(int j = 0; j < partCount; j++) sumPartsTotal += parts[j];

    float sumPartsNow = 0;
    for(int j = 0; j < parts.length; j++) {
      sumPartsNow += parts[j];

      if (random(1.0) < 0.45) {
        float x = map(sumPartsNow, 0, sumPartsTotal, 0, width) + random(-10, 10);
        float y = rowHeight * i + random(-10, 10);
        float w = map(parts[j], 0, sumPartsTotal, 0, width) * -1 + random(-10, 10);
        float h = rowHeight * 1.5;

        beginShape();
          fill(0, 0, 0, 180);
          vertex(x, y);
          vertex(x + w, y);
          int index = counter % colorCount;
          fill(hueValues[index], saturationValues[index], brightnessValues[index], 100);
          vertex(x + w, y + h);
          vertex(x, y + h);
        endShape(CLOSE);
      }

      counter++;
    }
  }  
}

// ************************************************************************************

void mouseReleased() {
  actRandomSeed = (int)random(100000);
}

void keyReleased() {  
  if (key == 's') saveFrame("_####.png");
}