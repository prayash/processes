// Processes - Day 109
// Prayash Thapa - April 18, 2016

PVector[] positions = new PVector[50];
PVector[] velocities = new PVector[positions.length];
float[] forces = new float[positions.length];
float[] diameters = new float[positions.length];
color[] palette = createColorCollection(5);
int[] colorIndices = new int[positions.length];

boolean drawBackground = false;

void setup() {
  size(600, 600);
  initialize();
  background(#57385c);
}

void draw() {
  if (drawBackground) background(#57385c);

  int i = 0;
  while (i < positions.length) {
    if (!mousePressed) attract(i);
    update(i);
    display(i);
    i++;
  }
}

void attract(int i) {
  PVector position = positions[i];
  PVector velocity = velocities[i];

  float force = forces[i];
  float speed = velocity.mag();
  float angle = atan2(mouseY - position.y, mouseX - position.x);

  PVector target = PVector.fromAngle(angle);
  target.mult(force);
  velocity.add(target);

  velocity.setMag(speed);
  velocities[i] = velocity;
}

void update(int i) {
  PVector position = positions[i];
  PVector velocity = velocities[i];

  position.add(velocity);
  positions[i] = position;

  if (position.x < 0) {
    position.x = 0;
    velocity.x = velocity.x * -1;
  } else if (position.x > width) {
    position.x = width;
    velocity.x = velocity.x * -1;
  }

  if (position.y < 0) {
    position.y = 0;
    velocity.y = velocity.y * -1;
  } else if (position.y > height) {
    position.y = height;
    velocity.y = velocity.y * -1;
  }

  velocities[i] = velocity;
  positions[i] = position;
}

void display(int i) {
  PVector position = positions[i];
  float diameter = diameters[i];
  int colorIndex = colorIndices[i];
  color hue = palette[colorIndex];

  strokeWeight(0); noStroke();
  stroke(255, 120); fill(hue, 80);
  ellipse(position.x, position.y, diameter, diameter);
}

PVector createRandomPosition() {
  float x = random(0, width);
  float y = random(0, height);
  PVector randomPosition = new PVector(x, y);
  return randomPosition;
}

color[] createColorCollection(int number) {
  color[] colors = new color[number];
  int i = 0;
  while (i < colors.length) {
    colors[i] = createRandomColor();
    i++;
  }
  return colors;
}

color createRandomColor() {
  float r = random(0, 255);
  float g = random(0, 255);
  float b = random(0, 255);
  color c = color(r, g, b);
  return c;
}

PVector createRandomVelocity() {
  float speed = random(1.5, 7);
  PVector randomVelocity = PVector.random2D();

  randomVelocity.setMag(speed);
  return randomVelocity;
}

void initialize() {
  for(int i = 0; i < positions.length; i++) {
    PVector position = createRandomPosition();
    PVector velocity = createRandomVelocity();

    float force = random(0.5, 1);
    float diameter = random(5, 30);
    int colorIndex = (int) random(0, palette.length);

    positions[i] = position;
    velocities[i] = velocity;
    forces[i] = force;
    diameters[i] = diameter;
    colorIndices[i] = colorIndex;
  }
}

void keyPressed() {
  if (key == 's') saveFrame("##.png");
  if (key == ' ') {
    background(#57385c);
    initialize();
  } else if (key == 'b') {
    if (drawBackground) drawBackground = false;
    else drawBackground = true;
  }
}
