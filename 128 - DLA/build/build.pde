// Processes - Day 128
// Prayash Thapa - May 7, 2016

int count = 0;
int countMax = 800;
int iterations = 50;
int radius = 12;

color startHue = (int) random(0, 360);
color rangeHue = (int) random(90, 360);

boolean stop = false;
boolean angleType = false;

ArrayList<Walker> walkers = new ArrayList<Walker>();
ArrayList<Walker> standers = new ArrayList<Walker>();

// ************************************************************************************

void setup() {
  size(640, 360);
  standers.add(new Walker(width / 2, height / 2, radius, startHue, true));
}

// ************************************************************************************

void draw() {
  background(255);

  // for (int i = standers.size(); i > 0; i--) {
  //   if (isFinal)
  // }

  for (int i = walkers.size(); i > 0; i--) {
    walkers.get(i).step(i);
  }

  for (int i = 0; i < iterations; i++) {
    step();
    if (standers.size() > countMax - 2) {
      stop = true;
      break;
    }
  }
}

// ************************************************************************************

class Walker {
  float x, y, r;
  float hitAngle;
  color hue;
  boolean standing;

  Walker(float _x, float _y, float _r, color _hue, boolean _standing) {
    count++;
    x = _x;
    y = _y;
    r = _r;
    hue = _hue;
    standing = _standing;
  }

  void step(int i) {
    if (standing) return;
    x += rand(-r * 2, r * 2);
    y += rand(-r * 2, r * 2);

    x = min(width, max(0, x));
    y = min(height, max(0, y));

    for (int j = standers.size(); j > 0; j--) {
      Walker other = standers.get(j);
      float compDist = r + other.r;

      if (dist(this.x, this.y, other.x, other.y) <= compDist && !this.standing) {
        float distOrigin = dist(this.x, this.y, standers.get(0).x, standers.get(0).y);
        this.standing = true;
        this.r = max(1, radius - (distOrigin / (width/2)) * radius * 1.1);
        // this.hue = (int) startHue + (distOrigin/2) * rangeHue;
        float dx = other.x - this.x;
        float dy = other.y - this.y;

        // this.hitAngle = angle;
        standers.add(this);
        walkers.remove(i);
      }
    }
  }

  void render(boolean _final) {
    if (_final) {
      stroke(hue);
      pushMatrix();
      float size = r * 2;
      translate(x, y);
      rotate(rand(0, TAU));
    } else {
      stroke(0);
      rect(x, y, 2, 2);
    }
  }
}

void step() {
  if (!stop && count < countMax - 1) {
    walkers.add(new Walker(
      (float) (rand(0, 1) < 0.5 ? 0 : width),
      (float) (rand(0, 1) < 0.5 ? 0 : height),
      (float) (radius),
      255,
      false
    ));
  }

  for (int i = standers.size(); i > 0; i--) standers.get(i).step(i);
  for (int i = walkers.size(); i > 0; i--) walkers.get(i).step(i);
}

float rand(float min, float max) {
  return random(1) * (max - min) + min;
}
