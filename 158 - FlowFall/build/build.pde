// Global variables
ArrayList<Pixel> allPixels = new ArrayList<Pixel>();
ArrayList<PVector> flowField = new ArrayList<PVector>();
ArrayList<ArrayList<PVector>> flowFieldPresets = new ArrayList<ArrayList<PVector>>();
int presetIndex = 0;
int columnCount = 10;
int columnSize;
int particlesPerFrame = 4;
int activatorPosX = 200;


class Pixel {
  PVector pos = new PVector(0, 0);
  PVector vel = new PVector(0, 0);
  PVector acc = new PVector(0, 0);
  color pixelColor;
  float speed = 1.0;
  boolean active = false;
  float fallRate = 0;
  float speedLimit = 1.0;

  Pixel(int x, int y, color inputColor) {
    this.pos.set(x, y);
    this.pixelColor = inputColor;
  }

  int getColumnIndex() {
    int index = (int)this.pos.x/columnSize;
    return index;
  }

  void draw() {
    strokeWeight(1);
    stroke(this.pixelColor);
    point(this.pos.x, this.pos.y);
  }
}


void setup() {
  size(800, 300);
  noFill();
  background(0, 30, 50);

  columnSize = width/columnCount;

  float[] preset1 = new float[] {-1.0, 1.0, -1.0, 1.0, -1.0, 1.0, -1.0, 1.0, -1.0, 0.5};
  float[] preset2 = new float[] {0, -0.3, -0.2, -0.1, 0, 1.0, 1.25, -1.0, -1.0, 0.5};
  float[] preset3 = new float[] {0, 0.5, 0.25, -0.4, 1.15, -1.35, 0.25, 0.75, 0.5, 0};
  float[] preset4 = new float[] {-0.5, 0.5, -0.5, 0.5, -1, -0.2, -0.4, 0, 0, 0.75};
  float[] preset5 = new float[] {1.25, -1.25, 1.25, -1.25, 1.25, -1.25, 1.25, -1.25, 1.25, -0.25};
  float[] preset6 = new float[] {-0.8, 1.0, -1.2, 1.3, -1.2, 1.0, -0.8, 0.6, -0.4, 0.2};

  addFlowPreset(preset1);
  addFlowPreset(preset2);
  addFlowPreset(preset3);
  addFlowPreset(preset4);
  addFlowPreset(preset5);
  addFlowPreset(preset6);
}


void addFlowPreset(float[] rotateValues) {
  ArrayList<PVector> preset = new ArrayList<PVector>();

  // Point left and rotate from that axis
  for (int i = 0; i < rotateValues.length; i++) {
    PVector direction = new PVector(-1, 0);
    rotateVector(direction, rotateValues[i]);
    direction.normalize();
    preset.add(direction);
  }

  flowFieldPresets.add(preset);
}


// PVector.rotate() doesn't work in js mode.
void rotateVector(PVector vec, float angle) {
  float prevX = vec.x;
  vec.x = vec.x*cos(angle) - vec.y*sin(angle);
  vec.y = prevX*sin(angle) + vec.y*cos(angle);
}


void draw() {
  // Motion blur
  noStroke();
  fill(0, 30, 50, 80);
  rect(0, 0, width*2, height*2);

  // Create a new set of particles
  for (int x = 0; x < particlesPerFrame; x ++) {
    color pixelColor = color(255-(x*40), 255-(x*10), 255);
    float sourceHeight = (height/2)+sin(frameCount/20.0)*20;
    float pinch = 15+(sin(frameCount/50.0)*20);
    Pixel newPixel = new Pixel(width-1, (int)random(sourceHeight-pinch, sourceHeight+pinch), pixelColor);
    newPixel.speed = random(0.075, 0.1);
    newPixel.speedLimit = newPixel.speed * 20.0;
    newPixel.fallRate = random(0.05, 0.15);
    allPixels.add(newPixel);
  }

  for (int i = allPixels.size()-1; i > -1; i--) {
    Pixel p = allPixels.get(i);

    if (p.pos.x < (int)random(activatorPosX-50, activatorPosX)) {
      // Set as active if it goes pass the line
      p.active = true;
    } else if (p.pos.x < activatorPosX+80) {
      // Set a few as active if it's near the line for a nicer effect
      if ((int)random(0, 10000) < 10) {
        p.active = true;
      }
    }

    if (p.active) {
      // Drop with gravity
      PVector gravity = new PVector(0, p.fallRate);
      p.acc.add(gravity);
    } else {
      // Follow the flow field
      int index = (int)p.getColumnIndex();
      if (index < 0) { continue; }
      PVector direction = new PVector(flowFieldPresets.get(presetIndex).get(index).x, flowFieldPresets.get(presetIndex).get(index).y);
      direction.normalize();
      direction.mult(p.speed);
      p.acc.add(direction);
    }

    p.vel.add(p.acc);

    // Clamp to particle's speed limit
    if (! p.active) {
      if (p.vel.mag() > p.speedLimit) {
        p.vel.normalize();
        p.vel.mult(p.speedLimit);
      }
    }

    p.pos.add(p.vel);
    p.acc.mult(0);

    p.draw();

    // Kill particle if it goes off screen
    if (p.pos.x < 0 || p.pos.y > height+100) {
      allPixels.remove(p);
    }
  }

  // Draw line
  stroke(255, 255, 0);
  strokeWeight(0);
  line(activatorPosX, 0, activatorPosX, height);

  // Draw tip
  fill(255);
  textSize(10);
  textAlign(CENTER);
  text("Click for a new flow.", width/2, height-20);
}


// Change to next preset
void mousePressed() {
  allPixels.clear();
  presetIndex += 1;
  if (presetIndex > flowFieldPresets.size()-1) { presetIndex = 0; }
}


void mouseMoved() {
  activatorPosX = mouseX;
}
