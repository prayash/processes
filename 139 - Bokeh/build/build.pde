// Processes - Day 139
// Prayash Thapa - May 18, 2016

// ************************************************************************************

PGraphics fg, bg;

ArrayList<Bokeh> particles = new ArrayList<Bokeh>();

void setup() {
  size(800, 540);
  colorMode(HSB);
  fg = createGraphics(width, height);
  bg = createGraphics(width, height);

  for (int i = 0; i < 20; i++) {
    particles.add(new Bokeh(
      random(1, (width + height) * 0.03),
      random(width),
      random(height),
      random(0, 2 * PI),
      random(0.1, 0.5),
      random(0, 10000)
    ));
  }
}

void draw() {
  // bg.background(#404040);

  for (Bokeh p : particles) p.render();
  image(bg, 0, 0);
  blend(fg, 0, 0, width, height, 0, 0, width, height, LIGHTEST);
}

class Bokeh {
  float radius, x, y, angle, velocity, tick;
  Bokeh(float _radius, float _x, float _y, float _angle, float _velocity, float _tick) {
    radius = _radius;
    x = _x;
    y = _y;
    angle = _angle;
    velocity = _velocity;
    tick = _tick;
  }

  void update() {
    x += cos(angle) * velocity;
    y += sin(angle) * velocity;
    angle += random(-0.05, 0.05);
    tick++;
  }

  void render() {
    update();

    fg.beginDraw();
    fg.stroke(0, 0, 100, 0.075 + cos(tick * 0.02) * 0.05);
    fg.ellipse(x, y, radius, radius);
    fg.endDraw();
  }
}

// ************************************************************************************

void keyReleased() {
  if (key == 's') saveFrame("_##.png");
}

void mouseClicked() {

}
