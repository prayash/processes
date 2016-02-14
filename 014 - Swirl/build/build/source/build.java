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

// Processes - Day 14
// Prayash Thapa - January 14, 2016

int x, y;
int numberOfArcs = 100;
float rotation = -(HALF_PI / 3);
int arcSize;
int step = 40;
float start, stop;
int[] palette = {0xff3583B7,0xff8EB4C4,0xff84BBCC,0xffB1C7CC,0xffB7D5CE,0xffEFEADA};

// ************************************************************************************

public void setup() {
  
  background(0xff1C1C1C);
  noFill();
  ellipseMode(CENTER);
  strokeCap(PROJECT);
  noLoop();
}

// ************************************************************************************

public void draw() {
  for (int i = 0; i < numberOfArcs; i++) {
    stroke(palette[(int)random(5)]);
    strokeWeight(i);
    x = width / 2;
    y = height / 2;
    arcSize = 200 + (step * i);
    start = random(rotation * i);
    stop = rotation * i + TWO_PI - HALF_PI;
    arc(x, y, arcSize, arcSize, start, stop);
  }
}

// ************************************************************************************

public void keyPressed() {
  if (key == 's') saveFrame("render-###.png");
}
  public void settings() {  size(700, 300); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "build" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
