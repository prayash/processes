// Processes - Day 35
// Prayash Thapa - February 5, 2016

// ************************************************************************************

int num = 180, edge = 200;
ArrayList orbs;
 
void setup() {
  size(800, 600);
  background(#1C1C1C);
  orbs = new ArrayList();
  createStuff();
}

// ************************************************************************************

void draw() {
  //background(0);
  fill(#1C1C1C, 20);
  noStroke();
  rect(0, 0, width, height);
   
  for (int i=0; i < orbs.size(); i++) {
    Orb mb = (Orb)orbs.get(i);
    mb.run();
  }
}

// ************************************************************************************
 
void createStuff() {
  orbs.clear();
  for (int i = 0; i < num; i++) {
    PVector org = new PVector(random(edge, width-edge), random(edge, height-edge));
		float radius = random(50, 450);
    PVector loc = new PVector(org.x + radius, org.y);
    float offSet = random(TWO_PI);
    int dir = 1;
    if (random(1) > .5) dir =-1;
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

  void run() {
    move();
    lineBetween();
  }

  void move() {
    loc.x = org.x + sin(theta+offSet) * radius;
    loc.y = org.y + cos(theta + offSet) * radius;
    theta += (0.0523/4 * dir);
  }

  void lineBetween() {
    for (int i = 0; i < orbs.size(); i++) {
      Orb other = (Orb) orbs.get(i);
      float distance = loc.dist(other.loc);
      if (distance > 0 && distance < d) {
        stroke(#FFFFFF, 10);
        line(loc.x, loc.y, other.loc.x, other.loc.y);       
      }
    }
  }
}

void mouseReleased() {
  background(0);
  createStuff();
}

void keyReleased() {
  if (key == 's') saveFrame("_##.png");
}