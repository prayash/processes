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
// Prayash Thapa - February 2, 2016

// ************************************************************************************

int NVERTS = 6;

float vertX1[] = new float[NVERTS];
float vertY1[] = new float[NVERTS];
float vertX2[] = new float[NVERTS];
float vertY2[] = new float[NVERTS];

float vertX[] = new float[NVERTS];
float vertY[] = new float[NVERTS];

int yRand = 1000;
float sizeRand;
int count = 0;
int countRate = (int)random(0, 50);

PGraphics multigonImg, backdropImg;

public void setup() {
  
  multigonImg = createGraphics(width, height);
  backdropImg = createGraphics(width, height);
  resetMultigon();
}

public void draw() {
  // drawMultigon(multigonImg);
  drawBackdrop(backdropImg);
  image(backdropImg, 0, 0);
  // blend(multigonImg, 0, 0, width, height, 0, 0, width, height, LIGHTEST);
}

public void resetMultigon() {
  for (int i = 0; i < NVERTS; i++) {
    vertX1[i] = random(width);
    vertY1[i] = random(width);
    vertX2[i] = random(width);
    vertY2[i] = random(width);
  }
}

public void drawMultigon(PGraphics pg) {
  float t = 0.5f * millis() * 1e-3f;
  for (int i = 0; i < NVERTS; i++) {
    vertX[i] = map(cos(t), -1, +1, vertX1[i], vertX2[i]);
    vertY[i] = map(sin(t), -1, +1, vertY1[i], vertY2[i]);
  }
  pg.beginDraw();
  pg.strokeWeight(5);
  pg.background(0xff);
  for (int i = 0; i < NVERTS - 1; i++) {
    for (int j = i + 1; j < NVERTS; j++) {
      pg.line(vertX[i], vertY[i], vertX[j], vertY[j]);
    }
  }
  pg.endDraw();
}

public void drawBackdrop(PGraphics pg) {
  pg.beginDraw();
  pg.colorMode(HSB, 1, 1, 1, 1);
  pg.background(0xffca2687);
  for (int i = 0; i < 400; i++) {
    pg.strokeWeight(random(400 - i));
    pg.stroke(random(1), 1, 1, 0.7f);
    // pg.point(random(pg.width), random(pg.height));
    pg.pushMatrix();
      pg.rotate(random(-360, 360));
      pg.noStroke();
      pg.fill(255, random(50, 150));
      pg.rect(random(pg.width), random(pg.height), 100, 100);
      pg.ellipse(count, (pg.height/2 + 40) + random(-yRand, yRand), sizeRand, sizeRand);
    pg.popMatrix();
  }
  // pg.ellipse(count, (pg.height/2 + 40) + random(-yRand, yRand), sizeRand, sizeRand);
  pg.endDraw();
}

// ************************************************************************************

public void keyReleased() {
  if (key == 's') saveFrame("_##.png");
}

public void mouseClicked() {
  resetMultigon();
  drawBackdrop(backdropImg);
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
