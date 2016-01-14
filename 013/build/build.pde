// Processes - Day 13
// Prayash Thapa - January 13, 2016

int x = 10;
color[] palette = {#3583B7,#8EB4C4,#84BBCC,#B1C7CC,#B7D5CE,#EFEADA};
 
int rings = 27;
int ringDensity = 40;
int number = 24;
// ************************************************************************************

void setup() {
	size(500, 700);
	background(#EFEADA);
	noStroke();

	for (int i = 0; i < 28; i += 4) {
		fill(#3583B7, 150);
		ellipse(x, height / 2, 25 * i, 25 * i);
	}

	noFill();
	stroke(palette[0]);
  for (int h=1; h<(ringDensity*2); h=h+2) {
    for (int i=h; i<(rings*10); i=i+10) {
      for (int j=1; j<number+1; j++) {
        stroke(palette[(int)random(5)]);
        int randMult = (int)random(7, 20);
        arc(x, height / 2, i * randMult, i * randMult, radians(j*(360/number) + 200), radians((j+1)*(360/number) + 200));
      }
    }
  }
}

// ************************************************************************************

void draw() {

}

// ************************************************************************************

void keyPressed() {
  if (key == 's') saveFrame("render-###.png");
}