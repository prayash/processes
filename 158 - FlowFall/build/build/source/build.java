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

/*
Flow field waterfall

Controls:
- Click to change to the next flow preset.
- Move mouse along x axis to set where gravity takes over.

Author: Jason Labbe
Site: jasonlabbe3d.com
*/


// Global variables
ArrayList<Pixel> allPixels = new ArrayList<Pixel>();
ArrayList<PVector> flowField = new ArrayList<PVector>();
ArrayList<ArrayList<PVector>> flowFieldPresets = new ArrayList<ArrayList<PVector>>();
int presetIndex = 0;
int columnCount = 10;
int columnSize;
int particlesPerFrame = 4;
int activatorPosX = 200;


class Pixel {
  PVector pos = new PVector(0, 0);
  PVector vel = new PVector(0, 0);
  PVector acc = new PVector(0, 0);
  int pixelColor;
  float speed = 1.0f;
  boolean active = false;
  float fallRate = 0;
  float speedLimit = 1.0f;

  Pixel(int x, int y, int inputColor) {
    this.pos.set(x, y);
    this.pixelColor = inputColor;
  }

  public int getColumnIndex() {
    int index = (int)this.pos.x/columnSize;
    return index;
  }

  public void draw() {
    strokeWeight(1);
    stroke(this.pixelColor);
    point(this.pos.x, this.pos.y);
  }
}


public void setup() {
  
  noFill();
  background(0, 30, 50);

  columnSize = width/columnCount;

  float[] preset1 = new float[] {-1.0f, 1.0f, -1.0f, 1.0f, -1.0f, 1.0f, -1.0f, 1.0f, -1.0f, 0.5f};
  float[] preset2 = new float[] {0, -0.3f, -0.2f, -0.1f, 0, 1.0f, 1.25f, -1.0f, -1.0f, 0.5f};
  float[] preset3 = new float[] {0, 0.5f, 0.25f, -0.4f, 1.15f, -1.35f, 0.25f, 0.75f, 0.5f, 0};
  float[] preset4 = new float[] {-0.5f, 0.5f, -0.5f, 0.5f, -1, -0.2f, -0.4f, 0, 0, 0.75f};
  float[] preset5 = new float[] {1.25f, -1.25f, 1.25f, -1.25f, 1.25f, -1.25f, 1.25f, -1.25f, 1.25f, -0.25f};
  float[] preset6 = new float[] {-0.8f, 1.0f, -1.2f, 1.3f, -1.2f, 1.0f, -0.8f, 0.6f, -0.4f, 0.2f};

  addFlowPreset(preset1);
  addFlowPreset(preset2);
  addFlowPreset(preset3);
  addFlowPreset(preset4);
  addFlowPreset(preset5);
  addFlowPreset(preset6);
}


public void addFlowPreset(float[] rotateValues) {
  ArrayList<PVector> preset = new ArrayList<PVector>();

  // Point left and rotate from that axis
  for (int i = 0; i < rotateValues.length; i++) {
    PVector direction = new PVector(-1, 0);
    rotateVector(direction, rotateValues[i]);
    direction.normalize();
    preset.add(direction);
  }

  flowFieldPresets.add(preset);
}


// PVector.rotate() doesn't work in js mode.
public void rotateVector(PVector vec, float angle) {
  float prevX = vec.x;
  vec.x = vec.x*cos(angle) - vec.y*sin(angle);
  vec.y = prevX*sin(angle) + vec.y*cos(angle);
}


public void draw() {
  // Motion blur
  noStroke();
  fill(0, 30, 50, 80);
  rect(0, 0, width*2, height*2);

  // Create a new set of particles
  for (int x = 0; x < particlesPerFrame; x ++) {
    int pixelColor = color(255-(x*40), 255-(x*10), 255);
    float sourceHeight = (height/2)+sin(frameCount/20.0f)*20;
    float pinch = 15+(sin(frameCount/50.0f)*20);
    Pixel newPixel = new Pixel(width-1, (int)random(sourceHeight-pinch, sourceHeight+pinch), pixelColor);
    newPixel.speed = random(0.075f, 0.1f);
    newPixel.speedLimit = newPixel.speed * 20.0f;
    newPixel.fallRate = random(0.05f, 0.15f);
    allPixels.add(newPixel);
  }

  for (int i = allPixels.size()-1; i > -1; i--) {
    Pixel p = allPixels.get(i);

    if (p.pos.x < (int)random(activatorPosX-50, activatorPosX)) {
      // Set as active if it goes pass the line
      p.active = true;
    } else if (p.pos.x < activatorPosX+80) {
      // Set a few as active if it's near the line for a nicer effect
      if ((int)random(0, 10000) < 10) {
        p.active = true;
      }
    }

    if (p.active) {
      // Drop with gravity
      PVector gravity = new PVector(0, p.fallRate);
      p.acc.add(gravity);
    } else {
      // Follow the flow field
      int index = (int)p.getColumnIndex();
      if (index < 0) { continue; }
      PVector direction = new PVector(flowFieldPresets.get(presetIndex).get(index).x, flowFieldPresets.get(presetIndex).get(index).y);
      direction.normalize();
      direction.mult(p.speed);
      p.acc.add(direction);
    }

    p.vel.add(p.acc);

    // Clamp to particle's speed limit
    if (! p.active) {
      if (p.vel.mag() > p.speedLimit) {
        p.vel.normalize();
        p.vel.mult(p.speedLimit);
      }
    }

    p.pos.add(p.vel);
    p.acc.mult(0);

    p.draw();

    // Kill particle if it goes off screen
    if (p.pos.x < 0 || p.pos.y > height+100) {
      allPixels.remove(p);
    }
  }

  // Draw line
  stroke(255, 255, 0);
  strokeWeight(0);
  line(activatorPosX, 0, activatorPosX, height);

  // Draw tip
  fill(255);
  textSize(10);
  textAlign(CENTER);
  text("Click for a new flow.", width/2, height-20);
}


// Change to next preset
public void mousePressed() {
  allPixels.clear();
  presetIndex += 1;
  if (presetIndex > flowFieldPresets.size()-1) { presetIndex = 0; }
}


public void mouseMoved() {
  activatorPosX = mouseX;
}
  public void settings() {  size(800, 300); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "build" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
