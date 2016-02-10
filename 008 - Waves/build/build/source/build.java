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

// Processes - Day 8
// Prayash Thapa - January 8, 2016

int 	points 				= 100;
int 	degrees 			= 270;
int 	numCircle 	  = 1;
int 	totalTweens 	= 40;

float xOrigin 			= 0;
float outRadius 		= random(100, 420);
float currentTween 	= 0;

float[][] radii 		= new float[points][degrees];

// ************************************************************************************

public void setup() {
	 background(0xffFF5F78);
  stroke(0xffFFFFFF); strokeWeight(.5f); noFill();

  // Setting up
  for (int i = 0; i < points; i++) {
    float random = random(2, 3);
    radii[i] = generate(random, random--);
  }
}

// ************************************************************************************

public void draw() {
  if (currentTween == totalTweens) {
    currentTween = 0; // Reset
  } else {
  	// Drawing happens here
	  translate(xOrigin, height / 2);
	  rotate(radians(frameCount * 0.95125f));
	 	float[] mesh = new float[degrees];
	  beginShape();
		  for (int j = 0; j < degrees; j++) {
		  	mesh[j] = lerp(radii[numCircle][j] * -1, radii[numCircle + 1][j] * -0.55f, currentTween / totalTweens);
		    float x = sin(radians(j)) * mesh[j] * 2;
		    float y = cos(radians(j)) * mesh[j];
		    vertex(x, y);
		  }
	  endShape();

  	// Advance the drawing
    xOrigin += 3;
    currentTween++;
  }
}

// ************************************************************************************

public float[] generate(float _x, float _y) {
  float nX, nY; float radius = 1.3f;
  float[] theCircle = new float[degrees];
  for (int i = 0; i < degrees ; i++) {
    nX = sin(radians(i)) * radius + _x;
    nY = cos(radians(i)) * radius + _y;
    theCircle[i] = map(noise(nX, nY), 0, 1, 0, outRadius);
  }
  return theCircle;
}

// ************************************************************************************

public void keyPressed() {
  if (key == 's') saveFrame("render-###.png");
}
  public void settings() { 	size(700, 700); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "build" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
