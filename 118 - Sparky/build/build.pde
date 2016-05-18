// Processes - Day 118
// Prayash Thapa - April 27, 2016

int num = 200;
ArrayList<Sparkle> particles = new ArrayList<Sparkle>();

// ************************************************************************************

void setup() {
  size(600, 600);

  for (int i = 0; i < num; i++) particles.add(new Sparkle());
}

// ************************************************************************************

void draw() {
  fill(#E4E4E4, 30); noStroke();
  rect(0, 0, width, height);

  for (Sparkle s : particles) s.render();
}

// ************************************************************************************

class Sparkle {

  PVector location, direction;
  float angle = random(TWO_PI);
  float speed;

  Sparkle() {
    location = new PVector(width/2, height/2, random(2, 8));
    direction = new PVector(cos(angle) * 1, sin(angle) * 1);
    speed = random(3, 10);
  }

  void update() {
    angle = atan2(mouseY - location.y, mouseX - location.x);
    PVector target = new PVector(cos(angle), sin(angle));
    target.mult(0.075);

    direction.add(target);
    direction.normalize();

    PVector velocity = direction.get();
    velocity.mult(speed);
    location.add(velocity);

    if (location.x < 0) {
      location.x = 0;
      direction.x = direction.x * -1;
    } else if (location.x > width) {
      location.x = width;
      direction.x = direction.x * -1;
    } else if (location.y < 0) {
      location.y = 0;
      direction.y = direction.y * -1;
    } else if (location.y > height) {
      location.y = height;
      direction.y = direction.y * -1;
    }
  }

  void render() {
    update();
    noStroke(); fill(#008BCA, 105);
    ellipse(location.x, location.y, location.z, location.z);
  }
}

// ************************************************************************************

void mousePressed() {
  particles.clear(); setup();
}

void keyPressed() {
  if (key == 's') saveFrame("##.png");
}
