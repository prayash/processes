import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.*; 
import ddf.minim.analysis.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class build extends PApplet {

// Processes - Day 143
// Prayash Thapa - May 22, 2016




Minim       minim;
AudioPlayer myAudio;
FFT         fft;

boolean     showVisualizer   = true;

int         myAudioRange     = 1400 / 20;
int         myAudioMax       = 100;

float       myAudioAmp       = 40.0f;
float       myAudioIndex     = 0.2f;
float       myAudioIndexAmp  = myAudioIndex;
float       myAudioIndexStep = 0.35f;

float[]     myAudioData      = new float[myAudioRange];

int cols, rows;
int scale = 20;
int w = 1400, h = 900;
float[][] terrain;
float flight = 0;

// ************************************************************************************

public void setup() {
    // size(400, 600, P3D);
    
    cols = w / scale;
    rows = h / scale;
    terrain = new float[cols][rows];

    minim   = new Minim(this);
    myAudio = minim.loadFile("Nothing It Can.mp3");
    myAudio.loop();

    fft = new FFT(myAudio.bufferSize(), myAudio.sampleRate());
    fft.linAverages(myAudioRange);
    fft.window(FFT.GAUSS);
}

// ************************************************************************************

public void draw() {
    background(0xffab95c6);
    fft.forward(myAudio.mix);
    myAudioDataUpdate();

    flight -= 0.01f;
    float yOff = flight;
    for (int y = 0; y < rows; y++) {
        float xOff = 0;
        for (int x = 0; x < cols; x++) {
            float offset = lerp(terrain[x][y], myAudioData[x], 0.1f);
            float aOff = map(offset, 0, 1, 0.0f, 0.001f);
            terrain[x][y] =  map(noise(xOff, yOff), 0, 1, -150, 150);
            xOff += 0.1f;
        }
        yOff += 0.1f;
    }

    pushMatrix();
      translate(width/2, height/2);
      rotateX(-PI/2);

      lightSpecular(155, 155, 155);
      directionalLight(174, 146, 195, 10, 0, 0);
      directionalLight(31, 24, 94, -1, -1, -1);
      pointLight(251, 202, 126, 0, 40, 0);
      ambientLight(31, 24, 94);

      fill(0xffcfbbbd); noStroke();
      specular(55, 55, 155);
      sphere(width / 10);

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

    if (showVisualizer) myAudioDataWidget();
    // if (frameCount % 8 == 0) saveFrame("####.png");
}

public void myAudioDataUpdate() {
    for (int i = 0; i < myAudioRange; ++i) {
        float tempIndexAvg = (fft.getAvg(i) * myAudioAmp) * myAudioIndexAmp;
        float tempIndexCon = constrain(tempIndexAvg, 0, myAudioMax);
        myAudioData[i]     = tempIndexCon;
        myAudioIndexAmp += myAudioIndexStep;
    }

    myAudioIndexAmp = myAudioIndex;
}

public void myAudioDataWidget() {
    noLights();
    hint(DISABLE_DEPTH_TEST);
    noStroke(); fill(0,200); rect(0, height-112, width, 102);

    for (int i = 0; i < myAudioRange; ++i) {
        if (i == 0) fill(0xff237D26); // base  / subitem 0
        else if (i == 3) fill(0xff80C41C); // snare / subitem 3
        else fill(0xffCCCCCC); // others

        rect(10 + (i * 15), (height - myAudioData[i]) - 11, 10, myAudioData[i]);
    }

    hint(ENABLE_DEPTH_TEST);
}

public void stop() {
    myAudio.close();
    minim.stop();
    super.stop();
}
  public void settings() {  fullScreen(P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "build" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
