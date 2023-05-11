import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class build extends PApplet {

// Processes - Day 139
// Prayash Thapa - May 18, 2016

// ************************************************************************************

PGraphics fg, bg;

ArrayList<Bokeh> particles = new ArrayList<Bokeh>();

public void setup() {
  
  colorMode(HSB);
  fg = createGraphics(width, height);
  bg = createGraphics(width, height);

  for (int i = 0; i < 20; i++) {
    particles.add(new Bokeh(
      random(1, (width + height) * 0.03f),
      random(width),
      random(height),
      random(0, 2 * PI),
      random(0.1f, 0.5f),
      random(0, 10000)
    ));
  }
}

public void draw() {
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

  public void update() {
    x += cos(angle) * velocity;
    y += sin(angle) * velocity;
    angle += random(-0.05f, 0.05f);
    tick++;
  }

  public void render() {
    update();

    fg.beginDraw();
    fg.stroke(0, 0, 100, 0.075f + cos(tick * 0.02f) * 0.05f);
    fg.ellipse(x, y, radius, radius);
    fg.endDraw();
  }
}

// ************************************************************************************

public void keyReleased() {
  if (key == 's') saveFrame("_##.png");
}

public void mouseClicked() {

}
  public void settings() {  size(800, 540); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "build" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
