// Processes - Day 111
// Prayash Thapa - April 20, 2016

PVector[] particles = new PVector[1000];

// ************************************************************************************

void setup() {
  size(600, 200);

  for(int i = 0; i < particles.length; i++) {
    particles[i] = new PVector(random(width), random(-2 * height, -10), random(1, 10));
  }
}

// ************************************************************************************

void draw() {
  background(color(228, 238, 238));
  noStroke();
  float translation = map((mouseX - width/2), 0, width/2, 0, 50);

  for (PVector particle : particles) {
    float speed = map(particle.z, 1, 10, 0.1, 1);
    float size = map(particle.z, 1, 10, 0, PI/2);

    fill(lerpColor(#ffedbc, #a75265, map(particle.z, 1, 10, 1, 0)));
    ellipse(particle.x + translation * sin(size), particle.y, particle.z, particle.z);

    if(particle.y > height) particle = new PVector(random(width), random(-height, -10), random(1, 10));
    particle.y += speed;
  }

  // if (frameCount % 6 == 0 && frameCount < 360) saveFrame("_###.png");
}
