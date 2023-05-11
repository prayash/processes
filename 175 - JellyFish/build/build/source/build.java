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

public void setup() {
  
  
  background(0x444);
  stroke(250, 5);
}

public void draw() {
  for (int i = 0; i < 1000; i++) {
    float x = random(-1, 1);
    float y = random(-1, 1);
    float xx = map(noise(x, y), 0, 1, 50, 550);
    float yy = map(noise(y, x), 0, 1, 50, 550);

    point(xx, yy);
  }
}
  public void settings() {  size(600, 600);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "build" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
