// Processes - Day 129
// Prayash Thapa - May 8, 2016

import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;
import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

// Lorenz attractor — initial conditions.
// Lorenz used the values σ = 10, β =  8 / 3 and ρ = 28.
// The system exhibits chaotic behavior for these (and nearby) values.
// https://en.wikipedia.org/wiki/Lorenz_system
float sigma = 10;
float rho = 8.0 / 3.0;
float beta = 28;
float x = 0.01, y = 0, z = 0;

boolean precomputeLorenz = true;
int numPrecomputedPoints = 2000;
ArrayList<PVector> points = new ArrayList<PVector>();

// Post-processing FX.
PostFX effectsChain;
float bloomThreshold = 0.2;
int bloomBlurSize = 20;
float bloomSigma = 50;

// Orbital controls.
PeasyCam camera;

// ************************************************************************************

void setup() {
    fullScreen(P3D);
    colorMode(HSB);
    
    // Compile shaders in setup for perf
    effectsChain = new PostFX(this);
    effectsChain.preload(BloomPass.class);
    
    // Camera setup
    camera = new PeasyCam(this, 500);
    camera.setWheelScale(0.1);
    
    // In the interest of time...
    if (precomputeLorenz) {
        for (int i = 0; i < numPrecomputedPoints; i++) {
            points.add(computeLorenzAttractorPoints());
        }
    }
}

// ************************************************************************************

void draw() {
    background(#E4E4E4);
  
    points.add(computeLorenzAttractorPoints());
    
    translate(0, 0, -80);
    scale(5);
    noFill();

    float hue = 0;
    beginShape();
      
        for (PVector v : points) {
            stroke(hue, 205, 255);
            strokeWeight((sin(hue) * 2) + 2);
            point(v.x, v.y, v.z);
            
            PVector offset = PVector.random3D();
            offset.mult(0.0005);
            v.add(offset);
            hue += 0.1;
            
            if (hue > 255) {
              hue = 0;
            }
        }
      
    endShape();
    
    // Bloom + RGB split pass
    effectsChain
      .render()
      .bloom(bloomThreshold, bloomBlurSize, bloomSigma)
      .rgbSplit(500)
      .compose();
}

// Lorenz equation: https://mathworld.wolfram.com/LorenzAttractor.html
PVector computeLorenzAttractorPoints() {
    float dt = 0.02;
    float dx = (sigma * (y - x)) * dt;
    float dy = (x * (beta - z)  - y) * dt;
    float dz = (x * y - rho * z) * dt;
    x += dx;
    y += dy;
    z += dz;
    
    return new PVector(x, y, z);
}
