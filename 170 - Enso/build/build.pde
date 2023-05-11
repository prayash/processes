// Enso

float x = 0;

void setup() {
  size(2560, 1440);
  
  background(222);
  stroke(22, 50);
  noFill();
}

void draw() {
  float diameter = 300 + frameCount % 250;
  float terminal = map(noise(x), 0, 1.5, PI, TWO_PI);
  float base = map(noise(x), 0, 2, 0, PI);
  
  // An arc at the center of the screen with a modulated start & stop
  arc(width/2, height/2, diameter, diameter, base, terminal);
  
  // Mutate the noise source
  x += 0.15;
  
  // Terminate draw loop after 3000 frames
  if (frameCount > 3000) {
    noLoop();
  }
}

void mousePressed() {
  save("enso-render.tif");
}
