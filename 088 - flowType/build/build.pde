// Processes - Day 88
// Prayash Thapa - March 28, 2016

PGraphics pg;
int maxParticles = 2000;
ArrayList <Particle> particles = new ArrayList <Particle> ();
color BACKGROUND_COLOR = color(255);
color PGRAPHICS_COLOR = color(255);

// ************************************************************************************

void setup() {
  size(1280, 450, P2D);
  background(BACKGROUND_COLOR);

  pg = createGraphics(width, height, JAVA2D);
  pg.beginDraw();
    pg.textSize(200);
    pg.textAlign(CENTER, CENTER);
    pg.fill(PGRAPHICS_COLOR);
    pg.text("processes", pg.width/2, pg.height/3);
  pg.endDraw();
}

// ************************************************************************************

void draw() {
  for (Particle p : particles) p.run();

  while (particles.size () < maxParticles) particles.add(new Particle());

  for (int i = particles.size() - 1; i >= 0; i--) {
    Particle p = particles.get(i);
    if (p.life <= 0) particles.remove(i);
  }
  // saveFrame("image-####.gif");
}

// ************************************************************************************

class Particle {
  PVector loc;
  float maxLife, life, lifeRate;

  Particle() {
    getRandPos();
    maxLife = 1.25;
    life = random(0.5 * maxLife, maxLife);
    lifeRate = random(0.01, 0.02);
  }

  void update() {
    float angle = noise(loc.x * 0.01, loc.y * 0.01) * TWO_PI;
    PVector vel = PVector.fromAngle(angle);
    loc.add(vel);
    life -= lifeRate;
  }

  void display() {
    fill(0, 7);
    strokeWeight(0);
    float r = 8 * life/maxLife;
    ellipse(loc.x, loc.y, r, r);

    fill(255, 125);
    if (random(1) > 0.9) rect(loc.x, loc.y, r * 2, r * 2);
  }

  void run() {
    update();
    display();
  }

  void getRandPos() {
    while (loc == null || !isInText (loc)) loc = new PVector(random(width), random(height));
  }

  boolean isInText(PVector v) {
    return pg.get(int(v.x), int(v.y)) == PGRAPHICS_COLOR;
  }
}

void mousePressed() {
  background(BACKGROUND_COLOR);
  particles.clear();
}

void keyPressed() {
  if (key == 's') saveFrame("_##.png");
}
