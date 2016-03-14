// Processes - Day 62
// Prayash Thapa - March 2, 2016

// ************************************************************************************

import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;
import processing.pdf.*;

HShape shape;

// ************************************************************************************

void setup() {
  size(500, 500);
  H.init(this).background(#ff6666).autoClear(false);

  shape = new HShape("shape.svg");
    shape
      .enableStyle(false)
      .strokeWeight(0.01)
      .anchorAt(H.CENTER)
      .stroke(#ffffff)
      .noFill()
      .size(200)
      .loc(width/2, height/2)
    ;
  H.add(shape);

  new HOscillator()
    .target(shape)
    .property(H.ROTATION)
    .range(-180, 360)
    .speed(0.5)
    .freq(2)
  ;

  new HOscillator()
    .target(shape)
    .property(H.SCALE)
    .range(1, 4)
    .speed(0.25)
    .freq(5)
  ;
}

// ************************************************************************************

void draw() {
  H.drawStage();
}

// ************************************************************************************

void keyReleased() {
  if (key == 's' || key == 'S') saveFrame("_##.png");
}
