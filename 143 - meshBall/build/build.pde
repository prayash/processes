// Processes - Day 143
// Prayash Thapa - May 22, 2016

import ddf.minim.*;
import ddf.minim.analysis.*;
import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;
import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;

// Terrain parameters
float[][] terrain;
float flight = 0;
int cols, rows;
int scale = 20;
int w = 1400, h = 900;

// Audio file loading helper.
Minim minim;

// Audio adapter.
AudioPlayer audioPlayer;
float audioAmp = 40.0;
float audioIndex = 0.2;
float audioIndexAmp = audioIndex;
float audioIndexStep = 0.35;

// FFT analysis.
FFT fft;
boolean showVisualizer = true;
int audioRange = 1400 / 20;
int audioMax = 100;
float[] audioData = new float[audioRange];

// Post-processing FX.
PostFX effectsChain;
float bloomThreshold = 0.2;
int bloomBlurSize = 20;
float bloomSigma = 50;

// Orbital controls.
PeasyCam camera;

// ****************************************************************************

void setup() {
    // size(400, 600, P3D);
    fullScreen(P3D);
    smooth(8);
    
    cols = w / scale;
    rows = h / scale;
    terrain = new float[cols][rows];

    minim = new Minim(this);
    audioPlayer = minim.loadFile("Nothing It Can.mp3");
    audioPlayer.loop();

    fft = new FFT(audioPlayer.bufferSize(), audioPlayer.sampleRate());
    fft.linAverages(audioRange);
    fft.window(FFT.GAUSS);
    
    // Compile shaders in setup for perf
    effectsChain = new PostFX(this);
    effectsChain.preload(BloomPass.class);
    
    // Camera setup
    camera = new PeasyCam(this, displayWidth / 2, displayHeight / 2, 0, 1000);
    camera.setWheelScale(0.25);
}

// ****************************************************************************

void draw() {
    background(#ab95c6);
    fft.forward(audioPlayer.mix);
    audioDataUpdate();

    flight -= 0.01;
    float yOff = flight;
    for (int y = 0; y < rows; y++) {
        float xOff = 0;
        for (int x = 0; x < cols; x++) {
            float offset = lerp(terrain[x][y], audioData[x], 0.1);
            float aOff = map(offset, 0, 1, 0.0, 0.001);
            terrain[x][y] = map(noise(xOff, yOff), 0, 1, -150, 150);
            xOff += 0.1;
        }
        yOff += 0.1;
    }

    pushMatrix();
      translate(width/2, height/2);
      rotateX(-PI / 2);

      lightSpecular(155, 155, 155);
      directionalLight(174, 146, 195, 10, 0, 0);
      directionalLight(31, 24, 94, -1, -1, -1);
      pointLight(251, 202, 126, 0, 40, 0);
      ambientLight(31, 24, 94);

      fill(#cfbbbd);
      noStroke();
      specular(55, 55, 155);
      sphere(displayWidth * 0.08);

      translate(-w/2, -h/2);

      for (int y = 0; y < rows - 1; y++) {
          beginShape(TRIANGLE_STRIP);

          for (int x = 0; x < cols; x++) {
              vertex(x * scale, y * scale, terrain[x][y]);
              vertex(x * scale, (y + 1) * scale, terrain[x][y + 1]);
          }

          endShape();
      }
    popMatrix();
    
    // Bloom pass
    effectsChain.render()
      .bloom(bloomThreshold, bloomBlurSize, bloomSigma)
      .compose();
    
    if (showVisualizer) {
        camera.beginHUD();
        audioDataWidget();
        camera.endHUD();
    }
    
     //if (frameCount % 8 == 0) saveFrame("####.png");
}

void audioDataUpdate() {
    for (int i = 0; i < audioRange; ++i) {
        float tempIndexAvg = (fft.getAvg(i) * audioAmp) * audioIndexAmp;
        float tempIndexCon = constrain(tempIndexAvg, 0, audioMax);
        audioData[i] = tempIndexCon;
        audioIndexAmp += audioIndexStep;
    }

    audioIndexAmp = audioIndex;
}

void audioDataWidget() {
    noLights();
    hint(DISABLE_DEPTH_TEST);
    noStroke();
    fill(0, 200);
    rect(0, displayHeight - 200, displayWidth, 150);

    for (int i = 0; i < audioRange; ++i) {
        if (i == 0) {
            fill(#237D26); // base  / subitem 0
        } else if (i == 3) {
            fill(#80C41C); // snare / subitem 3
        } else {
            fill(#CCCCCC); // others
        }

        rect(150 + (i * 15), (displayHeight - 50 - audioData[i]) - 11, 10, audioData[i]);
    }

    hint(ENABLE_DEPTH_TEST);
}

void stop() {
    audioPlayer.close();
    minim.stop();
    super.stop();
}
