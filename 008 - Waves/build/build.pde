// Processes - Day 8
// Prayash Thapa - January 8, 2016

int 	points 				= 100;
int 	degrees 			= 270;
int 	numCircle 	  = 1;
int 	totalTweens 	= 40;

float xOrigin 			= 0;
float outRadius 		= random(100, 420);
float currentTween 	= 0;

float[][] radii 		= new float[points][degrees];

// ************************************************************************************

void setup() {
	size(700, 700); background(#FF5F78);
  stroke(#FFFFFF); strokeWeight(.5); noFill();

  // Setting up
  for (int i = 0; i < points; i++) {
    float random = random(2, 3);
    radii[i] = generate(random, random--);
  }
}

// ************************************************************************************

void draw() {
  if (currentTween == totalTweens) {
    currentTween = 0; // Reset
  } else {
  	// Drawing happens here 
	  translate(xOrigin, height / 2);
	  rotate(radians(frameCount * 0.95125));
	 	float[] mesh = new float[degrees];
	  beginShape();
		  for (int j = 0; j < degrees; j++) {
		  	mesh[j] = lerp(radii[numCircle][j] * -1, radii[numCircle + 1][j] * -0.05, currentTween / totalTweens);
		    float x = sin(radians(j)) * mesh[j] * 2;
		    float y = cos(radians(j)) * mesh[j];
		    vertex(x, y);
		  }
	  endShape();

  	// Advance the drawing
    xOrigin += 3;
    currentTween++;
  }
}

// ************************************************************************************

float[] generate(float _x, float _y) {
  float nX, nY; float radius = 1.3;
  float[] theCircle = new float[degrees];
  for (int i = 0; i < degrees ; i++) {
    nX = sin(radians(i)) * radius + _x;
    nY = cos(radians(i)) * radius + _y;
    theCircle[i] = map(noise(nX, nY), 0, 1, 0, outRadius);
  }
  return theCircle;
}

// ************************************************************************************

void keyPressed() {
  if (key == 's') saveFrame("render-###.png");
}