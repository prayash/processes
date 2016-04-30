// Processes - Day 109
// Prayash Thapa - April 18, 2016

int cantidad = 50;
boolean clear = false;

ArrayList<Pelota> pelotas = new ArrayList<Pelota>();

// ************************************************************************************

void setup() {
  size(600, 600);
  background(color(228, 238, 238));

  for (int i = 0; i < cantidad; i++) pelotas.add(new Pelota());
}

// ************************************************************************************

void draw() {
  if (clear) background(color(228, 238, 238));
  for (Pelota p : pelotas) p.render();
}

// ************************************************************************************

class Pelota {

  PVector position, velocity;
  float force, diameter;
  color hue;

  Pelota() {
    position = new PVector(random(width), random(height));
    velocity = PVector.random2D(); velocity.setMag(random(1.5, 7));
    force = random(0.5, 1);
    diameter = random(5, 30);
    if (random(1) > 0.5) hue = #38489d;
    else hue = #ad9f54;
  }

  void attract() {
    float speed = velocity.mag();
    float angle = atan2(mouseY - position.y, mouseX - position.x);

    PVector target = PVector.fromAngle(angle);
    target.mult(force);
    velocity.add(target);

    velocity.setMag(speed);
  }

  void update() {
    position.add(velocity);
    if (!mousePressed) attract();

    // * Boundary check
    if (position.x < 0) {
      position.x = 0; velocity.x *= -1;
    } else if (position.x > width) {
      position.x = width; velocity.x *= -1;
    } else if (position.y < 0) {
      position.y = 0; velocity.y *= -1;
    } else if (position.y > height) {
      position.y = height; velocity.y *= -1;
    }
  }

  void render() {
    update();

    strokeWeight(0); noStroke(); fill(hue, 80);
    ellipse(position.x, position.y, diameter, diameter);
  }
}

// ************************************************************************************

void keyPressed() {
  if (key == 's') saveFrame("##.png");
  if (key == 'b') clear = !clear;
  if (key == DELETE || key == BACKSPACE) background(color(228, 238, 238));
}
