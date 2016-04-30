// Processes - Day 103
// Prayash Thapa - April 12, 2016

import ddf.minim.*;
import ddf.minim.analysis.*;

Minim         minim;
AudioInput    in;
FFT           myAudioFFT;
boolean       showVisualizer   = false;
int           myAudioRange     = 11;
int           myAudioMax       = 100;
float         myAudioAmp       = 40.0;
float         myAudioIndex     = 0.2;
float         myAudioIndexAmp  = myAudioIndex;
float         myAudioIndexStep = 0.35;
float[]       myAudioData      = new float[myAudioRange];

int volume = 0, bass;
int numPoints     = 300;
int numForms      = 5;
float maxNoise    = 5;
int threshold     = 80;
float maxRad;

HPoint[] pointArr = {};
Form[] formArr = {};

// ************************************************************************************

void setup() {
  size(700, 700, P3D);
  background(#EAE8CB);
  noCursor();

  minim = new Minim(this);
  in = minim.getLineIn(); // getLineIn(type, bufferSize, sampleRate, bitDepth);

  // Fast Fourier Transform
  myAudioFFT = new FFT(in.bufferSize(), in.sampleRate());
  myAudioFFT.linAverages(myAudioRange);
  myAudioFFT.window(FFT.GAUSS);

  // - Form
  for (int x = 0; x < numForms; x++) formArr = (Form[]) append(formArr, new Form());

  // - Points
  for (int x = 0; x < numPoints; x++) pointArr = (HPoint[]) append(pointArr, new HPoint());
}

// ************************************************************************************

void draw() {
  fill(#EAE8CB, (2 * volume) + 50); noStroke();
  rect(0, 0, width, height);

  // - Audio
  myAudioFFT.forward(in.mix);
  myAudioDataUpdate();
  volume = (int) map((in.mix.level() * 10), 0, 10, 0, 10);
  bass = (int) map(myAudioData[0] + myAudioData[1] , 0, 10, 0, 10);

  // - Noise
  maxNoise = 5.001;
  maxRad = noise(maxNoise) * 100;

  // - Update
  for (Form f : formArr) f.update();
  for (HPoint hP : pointArr) hP.update();

  pushMatrix();

    translate(width/2, height/2, 0);
    rotateY((frameCount * 0.01) + volume); rotateX((frameCount * 0.01) + (volume));

    for (HPoint p : pointArr) {
      for (HPoint allOtherP : pointArr) {
        stroke(color(56, 126, 245), 15 + (5 * volume)); strokeWeight(1);
        float distance = dist(p.x, p.y, p.z, allOtherP.x, allOtherP.y, allOtherP.z);
        if (distance < threshold) line(p.x, p.y, p.z, allOtherP.x, allOtherP.y, allOtherP.z);

        strokeWeight(5);
        if (random(1) > 0.98) point(p.x, p.y, p.z);
      }
    }

  popMatrix();
  if (showVisualizer) myAudioDataWidget();
  // if (frameCount % 3 == 0 && frameCount < 181) saveFrame("_###.gif");
}

// ************************************************************************************

class Form {
  float radius, radNoise;

  Form() {
    radNoise = random(10);
  }

  void update() {
    radNoise += 0.01;
    radius = 250 + (noise(radNoise) * 20) * (bass * 0.02);
  }
}

class HPoint {
  float s, t;
  float x, y, z;
  int myForm;
  color col;

  HPoint() {
    s = random(width); t = random(height);
    col = color(255 - (10 * myForm), 160, (10 * myForm), 100);
    myForm = (int) random(numForms);
  }

  void update() {
    Form F = formArr[myForm];
    x = F.radius * cos(s) * sin(t);
    y = F.radius * sin(s) * sin(t);
    z = F.radius * cos(t);
  }
}

// ************************************************************************************

void keyPressed() {
  if (key == DELETE || key == BACKSPACE) setup();
  if (key == 's' || key == 'S') saveFrame("_##.png");
}

// ************************************************************************************
// Audio Data

void myAudioDataUpdate() {
  for (int i = 0; i < myAudioRange; ++i) {
    float tempIndexAvg = (myAudioFFT.getAvg(i) * myAudioAmp) * myAudioIndexAmp;
    float tempIndexCon = constrain(tempIndexAvg, 0, myAudioMax);
    myAudioData[i]     = tempIndexCon;
    myAudioIndexAmp   += myAudioIndexStep;
    // println(myAudioData);
  }
  myAudioIndexAmp = myAudioIndex;
  myAudioData[0] *= 0.5;
}

void myAudioDataWidget() {
  noStroke(); fill(0, 200); rect(0, height - 112, width, 102);
  for (int i = 0; i < myAudioRange; ++i) {
    fill(#CCCCCC); rect(10 + (i * 15), (height - myAudioData[i]) - 11, 10, myAudioData[i]);
  }
}

void stop() {
  minim.stop();
  super.stop();
}
