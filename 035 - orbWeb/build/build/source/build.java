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

// Processes - Day 35
// Prayash Thapa - February 5, 2016

// ************************************************************************************

int num = 180, edge = 200;
ArrayList orbs;

public void setup() {
  
  background(0xff1C1C1C);
  orbs = new ArrayList();
  createStuff();
}

// ************************************************************************************

public void draw() {
  //background(0);
  fill(0xff1C1C1C, 20);
  noStroke();
  rect(0, 0, width, height);

  for (int i=0; i < orbs.size(); i++) {
    Orb mb = (Orb)orbs.get(i);
    mb.run();
  }
}

// ************************************************************************************

public void createStuff() {
  orbs.clear();
  for (int i = 0; i < num; i++) {
    PVector org = new PVector(random(edge, width-edge), random(edge, height-edge));
		float radius = random(50, 450);
    PVector loc = new PVector(org.x + radius, org.y);
    float offSet = random(TWO_PI);
    int dir = 1;
    if (random(1) > .5f) dir =-1;
    orbs.add(new Orb(org, loc, radius, dir, offSet));
  }
}

class Orb {
  PVector org, loc;
  float sz = 10;
  float theta, radius, offSet;
  int s, dir, d = 100;

  Orb(PVector _org, PVector _loc, float _radius, int _dir, float _offSet) {
    org = _org;
    loc = _loc;
    radius = _radius;
    dir = _dir;
    offSet = _offSet;
  }

  public void run() {
    move();
    lineBetween();
  }

  public void move() {
    loc.x = org.x + sin(theta+offSet) * radius;
    loc.y = org.y + cos(theta + offSet) * radius;
    theta += (0.0523f/4 * dir);
  }

  public void lineBetween() {
    for (int i = 0; i < orbs.size(); i++) {
      Orb other = (Orb) orbs.get(i);
      float distance = loc.dist(other.loc);
      if (distance > 0 && distance < d) {
        stroke(0xffFFFFFF, 10);
        line(loc.x, loc.y, other.loc.x, other.loc.y);
      }
    }
  }
}

public void mouseReleased() {
  background(0);
  createStuff();
}

public void keyReleased() {
  if (key == 's') saveFrame("_##.png");
}
  public void settings() {  size(800, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "build" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
