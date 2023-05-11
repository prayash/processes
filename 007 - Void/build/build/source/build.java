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

PVector[] tabPoint;
int vertices = 7;
int radius = 96;

public void setup() {
    
    background(0);

    tabPoint = new PVector[vertices];
    float angle = PI / 3;

    for (int i = 0; i < vertices; i++) {
        tabPoint[i] = new PVector(radius * cos(angle * i), radius * sin(angle * i));
    }

    println(tabPoint);
}

public void draw() {
    noFill();
    stroke(255, 20);
    strokeWeight(1);

    translate(width / 2, height / 2);
    beginShape();
    for(int i = 0; i < vertices; i++) {
        vertex(tabPoint[i].x, tabPoint[i].y);
    }
    endShape();

    for(int i = 0; i < vertices; i++) {
        PVector move = new PVector();
        move.x = tabPoint[i].x;
        move.y = tabPoint[i].y;
        move.normalize();
        move.mult(random(-3.5f, 3.75f));

        tabPoint[i].add(move);
    }
}

public void keyPressed() {
  if (key == 's') {
    saveFrame("render.png");
  }
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
