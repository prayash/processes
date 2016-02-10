import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import generativedesign.*; 
import processing.pdf.*; 
import java.util.Calendar; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class build extends PApplet {

// Processes - Day 16
// Prayash Thapa - January 16, 2016





PImage img;
int[] colors;

String sortMode = null;
boolean savePDF = false;

// ************************************************************************************

public void setup(){
  
  colorMode(HSB, 360, 100, 100, 100);
  noStroke();
  noCursor();
  img = loadImage("image.jpg");
}

// ************************************************************************************

public void draw(){
  if (savePDF) {
    beginRecord(PDF, timestamp()+".pdf");
    colorMode(HSB, 360, 100, 100, 100);
    noStroke();
  }

  int tileCount = width / max(mouseY, 5);
  float rectSize = width / PApplet.parseFloat(tileCount);

  int i = 0;
  colors = new int[tileCount*tileCount];
  for (int gridY=0; gridY<tileCount; gridY++) {
    for (int gridX=0; gridX<tileCount; gridX++) {
      int px = (int) (gridX * rectSize);
      int py = (int) (gridY * rectSize);
      colors[i] = img.get(px, py);
      i++;
    }
  }

  if (sortMode != null) colors = GenerativeDesign.sortColors(this, colors, sortMode);

  i = 0;
  for (int gridY=0; gridY<tileCount; gridY++) {
    for (int gridX=0; gridX<tileCount; gridX++) {
      fill(colors[i]);
      rect(gridX*rectSize, gridY*rectSize, rectSize, rectSize);
      i++;
    }
  }

  if (savePDF) {
    savePDF = false;
    endRecord();
  }
}

// ************************************************************************************

public void keyReleased(){
  if (key=='s' || key=='S') saveFrame(timestamp()+"_##.png");
  if (key=='p' || key=='P') savePDF = true;

  if (key == '4') sortMode = null;
  if (key == '5') sortMode = GenerativeDesign.HUE;
  if (key == '6') sortMode = GenerativeDesign.SATURATION;
  if (key == '7') sortMode = GenerativeDesign.BRIGHTNESS;
  if (key == '8') sortMode = GenerativeDesign.GRAYSCALE;
}

public String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
  public void settings() {  size(700, 700); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "build" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
