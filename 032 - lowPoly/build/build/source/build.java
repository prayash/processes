import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class build extends PApplet {

// Processes - Day 32
// Prayash Thapa - February 1, 2016

// ************************************************************************************

int M = 25, N = 25;
int c1 = 0xffd7626b;
int c2 = 0xff9ab6cb;

float fragWidth = 75;
float fragHeight = 75;

float [][] pointX = new float [M][N];
float [][] pointY = new float [M][N];
int [][] fragColor = new int [M][N];

// ************************************************************************************

public void setup() {
  
  noStroke();
  generate();
}

public void draw() {
  float t = millis() * 1e-4f;
  translate(0.5f * width, 0.5f * height);
  scale(2, 1);
  rotate(t);
  for (int i = 0; i < M - 1; i++) {
    for (int j = 0; j < N - 1; j++) {
      fill(fragColor[i][j]);
      quad(pointX[i][j], pointY[i][j], pointX[i+1][j], pointY[i+1][j], pointX[i+1][j+1], pointY[i+1][j+1], pointX[i][j+1], pointY[i][j+1]);
    }
  }
}

// ************************************************************************************

public void generate() {
  for (int i = 0; i < M; i++) {
    for (int j = 0; j < N; j++) {
      pointX[i][j] = (i - random(1) - 0.5f * (M - 2)) * fragWidth;
      pointY[i][j] = (j - random(1) - 0.5f * (N - 2)) * fragHeight;

      float f = round(random(5)) / 5.0f;
      fragColor[i][j] = lerpColor(c1, c2, f);
    }
  }
}

public void mousePressed() {
  generate();
}

public void keyReleased() {
  if (key == 's') saveFrame("_##.png");
}
  public void settings() {  size(800, 800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "build" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
