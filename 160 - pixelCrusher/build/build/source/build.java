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

// Processes - Day 159
// Prayash Thapa - June 7, 2016

PImage img;

int lengthofline = 100; //change this to set brush size
int x; //mouse X location
int y; //mouse Y location
int loc; //location of selected pixel inside pixel grid
int verticalmovement; //width of given img, this variable is used for vertical movement in pixel grid.
int [] carray = new int[lengthofline]; // color array which stores color data
float floatlength = carray.length; // length of color array converted to floating number;
float [] dist = new float[carray.length]; // stores distance of given "color-picking" cell at the top
float cellsize; // horizontal dimension of "color picking" cell, calculated from width of image and length of color array.
float distance; //distance between each cell.

// ************************************************************************************

public void setup() {
  img = loadImage("data.jpg");
  
  image(img, 0, 0);

  noStroke();
  cellsize = width / floatlength;

  for (int i = 0; i < dist.length; i++) {
    dist[i] += distance;
    distance += cellsize;
  }
}

// ************************************************************************************

public void draw() {
  verticalmovement+=width; // move to lower line of pixels
  img.loadPixels();
  loadPixels();

  //Fill array with given pixels color data

  x = mouseX-50;
  y = mouseY;

  loc = x + y * width;
  loc = constrain(loc, 0, pixels.length);

  for (int i = 0; i < carray.length; i++) {
    carray[i] = img.pixels[loc+i];
  }

  // Copy and draw given pixels over original image

  loc = constrain(loc + verticalmovement, 0, pixels.length - width);
  for (int i  = 0; i < carray.length; i ++) {
    pixels[loc+i] = carray[i];
  }

  // reset "melting" point
  if (mousePressed) verticalmovement = 0;

  updatePixels();
  // draw color-picking top bar

  for (int i = 0; i < carray.length; i++ ) {
    fill(carray[i]);
    rect(dist[i], 0, width/carray.length, width/carray.length*5);
  }

  // press R to start over

  if (keyPressed) {
    if (key == 'r' || key == 'R') {
      loadPixels();
      img.loadPixels();
      for ( int i = 0; i < pixels.length; i++) {
        int c = img.pixels[i];
        pixels[i] = c;
      }
    }

    updatePixels();
  }
}
  public void settings() {  size(637, 817); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "build" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
