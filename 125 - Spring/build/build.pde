// Processes - Day 125
// Prayash Thapa - May 4, 2016

import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;

VerletPhysics2D physics;
Particle p1;
Particle p2;
Particle p3;

// ************************************************************************************

void setup() {
  size(800, 300);
  frameRate(30);
  background(228, 238, 228);

  // Initialize the physics
  physics = new VerletPhysics2D();
  physics.addBehavior(new GravityBehavior(new Vec2D(0, 0.5)));

  // Set the world's bounding box
  physics.setWorldBounds(new Rect(0, 0, width, height));

  // Make two particles
  p1 = new Particle(new Vec2D(width/2, 20));
  p2 = new Particle(new Vec2D(width, 280));
  p3 = new Particle(new Vec2D(width, 380));
  // Lock in initial position
  // p1.lock();

  // Make a spring connecting both Particles
  VerletSpring2D spring = new VerletSpring2D(p1, p2, 80, 0.01);
  VerletSpring2D spring2 = new VerletSpring2D(p1, p3, 80, 0.01);

  // Anything we make, we have to add into the physics world
  physics.addParticle(p1);
  physics.addParticle(p2);
  physics.addParticle(p3);
  physics.addSpring(spring);
  physics.addSpring(spring2);
}

// ************************************************************************************

void draw() {
  physics.update();
  fill(#E4E4E4, 2); rect(0, 0, width, height);
  // background(#E4E4E4);

  stroke(#008BCA); strokeWeight(4);
  line(p1.x, p1.y, p2.x, p2.y);
  line(p2.x, p2.y, p3.x, p3.y);

  p1.display();
  p2.display();
  p3.display();

  // Move the second one according to the mouse
  if (mousePressed) {
    p2.lock();
    p2.x = mouseX;
    p2.y = mouseY;
    p2.unlock();
  }
}

// ************************************************************************************

// Notice how we are using inheritance here!
// We could have just stored a reference to a VerletParticle object
// inside the Particle class, but inheritance is a nice alternative

class Particle extends VerletParticle2D {

  Particle(Vec2D loc) {
    super(loc);
  }

  void display() {
    fill(#008BCA);
    // stroke(0);
    // strokeWeight(2);
    ellipse(x, y, 32, 32);
  }
}

void keyPressed() {
  if (key == ' ') background(228, 238, 228);
  if (key == 's') saveFrame("##.png");
}

void settings() {
  fullScreen();
}
