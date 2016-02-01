// Processes - Day 32
// Prayash Thapa - February 1, 2016

// ************************************************************************************

int M = 25, N = 25;
color c1 = #d7626b;
color c2 = #9ab6cb;

float fragWidth = 75;
float fragHeight = 75;
 
float [][] pointX = new float [M][N];
float [][] pointY = new float [M][N];
color [][] fragColor = new color [M][N];

// ************************************************************************************

void setup() {
  size(800, 800);
  noStroke();
  generate();
}

void draw() {
  float t = millis() * 1e-4;
  translate(0.5 * width, 0.5 * height);
  scale(2, 1);
  rotate(t);
  for (int i = 0; i < M - 1; i++) {
    for (int j = 0; j < N - 1; j++) {
      fill(fragColor[i][j]);
      quad(pointX[i][j], pointY[i][j], pointX[i+1][j], pointY[i+1][j], pointX[i+1][j+1], pointY[i+1][j+1], pointX[i][j+1], pointY[i][j+1]);
    }
  }
}

// ************************************************************************************

void generate() {
  for (int i = 0; i < M; i++) {
    for (int j = 0; j < N; j++) {
      pointX[i][j] = (i - random(1) - 0.5 * (M - 2)) * fragWidth;
      pointY[i][j] = (j - random(1) - 0.5 * (N - 2)) * fragHeight;
      
      float f = round(random(5)) / 5.0;
      fragColor[i][j] = lerpColor(c1, c2, f);
    }
  }
}

void mousePressed() {
  generate();
}

void keyReleased() {
  if (key == 's') saveFrame("_##.png");
}