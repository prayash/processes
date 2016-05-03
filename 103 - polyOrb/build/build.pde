// Processes - Day 103
// Prayash Thapa - April 12, 2016

import ddf.minim.*;
import ddf.minim.analysis.*;

Minim         minim;
AudioInput    in;
FFT           fft;
boolean       showVisualizer   = false;
int           myAudioRange     = 11;
int           myAudioMax       = 100;
float         myAudioAmp       = 40.0;
float         myAudioIndex     = 0.2;
float         myAudioIndexAmp  = myAudioIndex;
float         myAudioIndexStep = 0.35;
float[]       myAudioData      = new float[myAudioRange];

int volume        = 0;
int bass          = 0;
int numPoints     = 300;
int numForms      = 5;
int threshold     = 80;

ArrayList<OrbVertex> points = new ArrayList<OrbVertex>();

// ************************************************************************************

void setup() {
  size(700, 700, P3D);
  background(#EAE8CB);
  noCursor();

  minim = new Minim(this);
  in = minim.getLineIn();

  // - Fast Fourier Transform
  fft = new FFT(in.bufferSize(), in.sampleRate());
  fft.linAverages(myAudioRange);
  fft.window(FFT.GAUSS);

  // - polyOrb
  for (int x = 0; x < numPoints; x++) points.add(new OrbVertex());
}

// ************************************************************************************

void draw() {
  fill(#EAE8CB, (2 * volume) + 25); noStroke();
  rect(0, 0, width, height);

  // - Audio Mapping
  fft.forward(in.mix);
  myAudioDataUpdate();
  volume = (int) map((in.mix.level() * 10), 0, 10, 0, 10);
  bass = (int) map(myAudioData[0] + myAudioData[1] , 0, 10, 0, 10);

  for (OrbVertex p : points) p.render();

  if (showVisualizer) myAudioDataWidget();
  // if (frameCount % 3 == 0 && frameCount < 181) saveFrame("_###.gif");
}

// ************************************************************************************

class OrbVertex {

  PVector position;
  float radius, radNoise;
  int myForm = (int) random(numForms);
  float s = random(width), t = random(height);

  OrbVertex() {
    radNoise = random(10);
    position = new PVector(random(width), random(height), random(height));
  }

  void update() {
    radNoise += 0.1;
    radius = 250 + (noise(radNoise) * 20) * (bass * 0.02);

    // These coordinates define a 3D sphere made with noise
    float x = radius * cos(s) * sin(t);
    float y = radius * sin(s) * sin(t);
    float z = radius * cos(t);

    // Position vector is now all the points of the sphere
    position = new PVector(x, y, z);
  }

  void render() {
    update();
    pushMatrix();

      translate(width/2, height/2, 0);
      rotateY((frameCount * 0.01) + volume); rotateX((frameCount * 0.01) + (volume));

      // Compare self to all other points
      for (OrbVertex allP : points) {
        PVector p = allP.position;
        stroke(color(56, 126, 245), 35 + (5 * volume)); strokeWeight(1);

        // Draw edges between vectors only under threshold
        float distance = PVector.dist(position, p);
        if (distance < threshold) line(position.x, position.y, position.z, p.x, p.y, p.z);

        // Throw in a few random points
        strokeWeight(5);
        if (random(1) > 0.98) point(position.x, position.y, position.z);
      }

    popMatrix();
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
    float tempIndexAvg = (fft.getAvg(i) * myAudioAmp) * myAudioIndexAmp;
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
