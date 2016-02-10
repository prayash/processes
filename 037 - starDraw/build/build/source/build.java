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

// Processes - Day 38
// Prayash Thapa - February 7, 2016

// ************************************************************************************

public void setup() {
  
}

public void draw() {
  fill(0xff55acee, 5);
  noStroke();
  rect(0, 0, width, height);

  stroke(255, 50);
  for (int i = 0; i <= width; i += 100) {
    line(i, random(height), mouseX, mouseY);
    line(random(width), i, mouseX, mouseY);
    line(i, random(height), mouseX, mouseY);
    line(random(width), i, mouseX, mouseY);
  }
}

// ************************************************************************************

public void keyReleased() {
  if (key == 's') saveFrame("_##.png");
}
  public void settings() {  size(500, 250); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "build" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
