// Processes - Day 10
// Prayash Thapa - January 10, 2016

int circlePool = 22;
int temp = 0;
float randConvergence = random(450, 600);
boolean record = false;
color[] palette = {#febd45, #e12b64, #569dc7, #D882AE, #E2D0D8, #E9D8DE, #E0DDE2};

// ************************************************************************************

void setup() {
	size(700, 700, P2D);
	background(#292f33);
	fill(#FFFFFF);	

	for (int i = 0; i < width; i += 15) {
		stroke(255, 50);
		line(i, temp, i, height);
		temp += 15;
		line(0, i, width, height);
		// line(width, width, i+15, 0);
	}

	// PImage image = loadImage("texture.jpg");
	beginShape();
		// texture(image);
		fill(#55acee);
		ellipse(width / 2, height / 2, 250, 250);
	endShape();

	for (int i = 0; i < circlePool; i++) {
		noFill();
		stroke(palette[(int)random(6)]);
		strokeWeight(random(10, 10));
		if (i % 5 == 4) fill(#FFFFFF);
		int randRadius = (int)random(10, 75);
		int randWidth = (int)random(width);
		int randHeight = (int)random(height);
		ellipse(randWidth, randHeight, randRadius, randRadius);
		
		beginShape();
			strokeWeight(2);
			stroke(#FFFFFF, 155);
			line(randWidth, randHeight, randConvergence, randConvergence);
		endShape();

		ellipse(randWidth, randHeight, 10, 10);
	}
	
}

// ************************************************************************************

void draw() {

}

// ************************************************************************************

void keyPressed() {
  if (key == 's') saveFrame("render-###.png");
}