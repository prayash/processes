// Processes - Day 111
// Prayash Thapa - April 20, 2016

PVector [] particles = new PVector [1000];

// ************************************************************************************

void setup() {
  size(600, 200);

  for(int i = 0; i < particles.length; i++) {
    particles[i] = new PVector(random(width), random(-2 * height, -10), random(1, 10));
  }
}

// ************************************************************************************

void draw() {
  background(#57385c);
  fill(255); noStroke();
  float translation = map(abs(mouseX - width/2), 0, width/2, 0, 100);

  for (PVector particle : particles) {
    fill(lerpColor(#ffedbc, #a75265, map(particle.z, 1, 10, 1, 0)));
    ellipse(particle.x + translation * sin(map(particle.z, 1, 10, 0, PI/2)), particle.y, particle.z, particle.z);

    particle.y = particle.y + map(particle.z, 1, 10, 0.1, 1);
    if(particle.y > height) particle = new PVector(random(width), random(-height, -10), random(1, 10));
  }
}
