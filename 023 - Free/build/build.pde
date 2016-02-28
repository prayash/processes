// Processes - Day 23
// Prayash Thapa - January 23, 2016

int yRand = 1000;
float sizeRand;
int patternRand = (int)random(50, 400);
int count = 0;
int countRate = (int)random(0, 50);

// ************************************************************************************

void setup() {
  size(400, 800);
  background(#ca2687);
}

// ************************************************************************************

void draw() {
  if (count % patternRand == 0) {
    noStroke();
    noFill();
    stroke(255, random(44, 106));
    strokeWeight(floor(random(1, 5)));
    sizeRand = floor(random(5, 50));

    pushMatrix();
      rotate(random(-360, 360));
      curve(count, (height/2+40) + random(-yRand, yRand), (height/2+40) + random(-yRand, yRand), count, (height/2+40) + random(-yRand, yRand), (height/2+40) + random(-yRand, yRand), (height/2+40) + random(-yRand, yRand), (height/2+40*PI)+random(-yRand, yRand));
    popMatrix();

  }

  pushMatrix();
    rotate(random(-360, 360));
    noStroke();
    fill(255, random(50, 150));
    ellipse(count, (height/2 + 40) + random(-yRand, yRand), sizeRand, sizeRand);
  popMatrix();

  count += countRate;
  if (count > width) count = 0;
}

void keyPressed() {
  if (key == 's') saveFrame();
}