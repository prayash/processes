color dark_green = #132234;  // bluish dark green used on the back montains
color light_green = #7C903F;  // yellowish light green used on the fore montains
color blue = #325876;  // sky blue used on the clouds
color yellow = #FFF6B4;  // light yellow used on the sky
color tree_green = #172C11;  // dark green used on the trees

float dx = 200;
float dy = 50;

void setup() {
  size(600, 400);
  landscape();
  noLoop();
}

void mouseReleased() {
  noiseSeed((long) random(1000000));
  landscape();
}

void landscape() {
  // background (gradient from white on top to yellow on bottom)
  for (int j = 0; j < height; j++) {
    stroke(lerpColor(255, yellow, float(j)/height));
    line(0, j, width, j);
  }

  noStroke();
  float n;
  for (int j = 0; j < height; j++) {

    // montains
    beginShape();
    fill(lerpColor(dark_green, light_green, j/height));
    vertex(0, height);
    for (int i = 0; i <= width; i +=2) {
      n = noise(i/dx, j/dy);
      n = map(n, 0, 1, 0, height - j);
      vertex(i, height - n);
    }
    vertex(width, height);
    endShape();


    // trees
    for (int i = 0; i <= width; i++) {
      n = noise(i/dx, j/dy);
      if (random(0.5) > n) {
        fill(lerpColor(dark_green, tree_green, j/height), 50);
        n = map(n, 0, 1, 0, height - j);
        ellipse(i, height - n, 5, map(j, 0, height, 5, 10));
      } else if (random(1) > n) { // texture
        fill(lerpColor(dark_green, tree_green, j/height), 3);
        n = map(n, 0, 1, 0, height - j);
        ellipse(i, height - n, 5, 5);
      }
    }

    // clouds
    for (int i = 0; i <= width; i += 2) {
      n = noise(i/dx, j/dy);
      n = map(j, 0, 0.6*height, 500, 0)*n;  // clouds fade from top to bottom
      fill(blue, constrain(n, 0, 255));  // blue clouds
      ellipse(i, j, 2, 2);
    }

  }
}
