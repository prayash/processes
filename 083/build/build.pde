// Processes - Day 83
// Prayash Thapa - March 23, 2016

import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.math.noise.*;
import toxi.processing.*;

float NS = 0.05f;
float SIZE = 100;
float AMP = SIZE * 4;

Mesh3D mesh;
ToxiclibsSupport gfx;

// ************************************************************************************

void setup() {
  size(680, 382, P3D);
  cursor(CROSS);
  gfx = new ToxiclibsSupport(this);
}

// ************************************************************************************

void draw() {
  updateMesh();
  background(#202020);
  translate(width / 2, height / 2, 20);
  rotateX(mouseY * 0.01f);
  rotateY(frameCount * 0.0125);

  // gfx.origin(100); // axes
  noFill();
  stroke(255);
  gfx.mesh(mesh, true);

  // saveFrame("image-####.gif");
}

void updateMesh() {
  float phase = frameCount * NS * 0.1;
  BezierPatch patch = new BezierPatch();
  for (int y = 0; y < 4; y++) {
    for (int x = 0; x < 4; x++) {
      float xx = x * SIZE;
      float yy = y * SIZE;
      float zz = (float) (SimplexNoise.noise(xx * NS, yy * NS, phase) * AMP);
      patch.set(x, y, new Vec3D(xx, yy, zz));
    }
  }

  mesh = patch.toMesh(5);
  mesh.center(null);
}
