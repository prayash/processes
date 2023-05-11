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

float n=0;

public void setup() {
  
  background(238);
  stroke(34, 50);
  noFill();
  strokeWeight(1);
}

public void draw() {
  float d = 300 + frameCount % 250;
  float end = map(noise(n), 0, 1, PI, TWO_PI);
  arc(width/2, height/2, d, d, HALF_PI, end);
  n += 0.15f;
  if (frameCount > 2800) noLoop();
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
