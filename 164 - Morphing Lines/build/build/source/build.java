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

// Processes - Day 164
// Prayash Thapa - June 12, 2016

// To create the morphing shape, a randomly generated closed curve is created using a
// fractal subdivision process. This curve slowly morphs into another randomly generated
// closed curve, by linearly interpolating between the radius values for the initial curve
// and the destination curve. Once the curve completely  morphs into the destination
// curve, we reset the destination curve and the shape then begins to morph from its
// current configuration into the next destination curve. As the shape morphs, we gradually
// move its center across the canvas, creating the traced-out structures.

int iterations = 8;
int drawsPerFrame = 8;
int numCircles = 1;
int maxMaxRad = 300;
int minMaxRad = 200;
float minRadFactor = 0.1f;

ArrayList<Circle> circles = new ArrayList();

// ************************************************************************************

public void setup() {
  background(0xffE4E4E4);
  

  // * Generate
  for (int i = 0; i < numCircles; i++) {
    float maxR = minMaxRad + random(1) * (maxMaxRad - minMaxRad);
    float minR = minRadFactor * maxR;
    int hue = color(255, 255, 255, 25);
    int fillColor = color(0, 0, 185, 5);
    circles.add(new Circle(-maxR, height/2, maxR, minR, hue, fillColor, 0, 1.0f / 300.0f, random(1) * TWO_PI));
  }
}

// ************************************************************************************

public void draw() {
  float x, y;
  float rad, theta;
  float cosParam;
  float xSqueeze = 0.75f;

  for (int j = 0; j < drawsPerFrame; j++) {
    for (int i = 0; i < numCircles; i++) {
      Circle c = circles.get(i);
      c.param += c.changeSpeed;

      if (c.param >= 1) {
        c.param = 0;
        c.pointList1 = c.pointList2;
        c.pointList2 = setLinePoints(iterations);
      }

      cosParam = 0.5f - 0.5f * cos(PI * c.param);

      stroke(c.hue); strokeWeight(c.lineWidth);
      fill(c.fillColor);

      Point point1 = c.pointList1.first;
      Point point2 = c.pointList2.first;

      // Slow rotation
      c.phase += 0.001f;
      theta = c.phase;
      rad = c.minRad + (point1.y + cosParam * (point2.y - point1.y)) * (c.maxRad - c.minRad);

      // Movement across canvas
      c.centerX += 0.25f;

      pushMatrix();
      translate(c.centerX, c.centerY);
      scale(xSqueeze, 1);

      beginShape();
      x = xSqueeze * rad * cos(theta);
      y = rad * sin(theta);
      vertex(x, y);

      // Stepping through a linked list of points defined by a fractal subdivision process
      while (point1.next != null) {
        point1 = point1.next;
        point2 = point2.next;
        theta = TWO_PI * (point1.x + cosParam * (point2.x - point1.x)) + c.phase;
        rad = c.minRad + (point1.y + cosParam * (point2.y - point1.y)) * (c.maxRad - c.minRad);
        x = xSqueeze * rad * cos(theta);
        y = rad * sin(theta);
        vertex(x, y);
      }
      endShape();
      popMatrix();

    }
  }
}

// ************************************************************************************

class Circle {

  float centerX, centerY;
  float maxRad, minRad;
  int hue, fillColor;
  float param, changeSpeed, phase;
  int lineWidth = 2;

  PointList pointList1 = setLinePoints(iterations);
  PointList pointList2 = setLinePoints(iterations);

  Circle(float cX, float cY, float maxR, float minR, int _hue, int _fillColor, float _param, float _changeSpeed, float _phase) {
    centerX = cX; centerY = cY;
    maxRad = maxR; minRad = minR;
    hue = _hue; fillColor = _fillColor;
    param = _param; changeSpeed = _changeSpeed;
    phase = _phase;
  }
}

public PointList setLinePoints(int iterations) {
  PointList pointList = new PointList();
  Point point, nextPoint;

  float minY = 1, maxY = 1;
  float dX, newX, newY;
  float minRatio = 0.5f;

  pointList.first.next = pointList.last;
  for (int i = 0; i < iterations; i++) {
    point = pointList.first;

    while (point.next != null) {
      nextPoint = point.next;

      dX = nextPoint.x - point.x;

      newX = 0.5f * (point.x + nextPoint.x);
      newY = 0.5f * (point.y + nextPoint.y);
      newY += dX * (random(1) * 2 - 1);

      Point newPoint = new Point(newX, newY);

      if (newY < minY) {
        minY = newY;
      } else if (newY > maxY) {
        maxY = newY;
      }

      newPoint.next = nextPoint;
      point.next = newPoint;

      point = nextPoint;
    }
  }

  if (maxY != minY) {
    float normalizeRate = 1 / (maxY - minY);
    point = pointList.first;

    while (point != null) {
      point.y = normalizeRate * (point.y - minY);
      point = point.next;
    }
  } else {
    point = pointList.first;
    while (point != null) {
      point.y = 1;
      point = point.next;
    }
  }

  return pointList;
}

// ************************************************************************************

// Linked List of Points
class PointList {

  Point point, nextPoint;
  Point first = new Point(0, 1);
  Point last = new Point(1, 1);

  PointList() {}
}

class Point {

  float x, y;
  Point next;

  Point(float _x, float _y) {
    x = _x; y = _y;
  }
}

public void keyPressed() {
  if (key == ' ') background(0xffE4E4E4);
}
  public void settings() {  fullScreen(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "build" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
