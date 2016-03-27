// Processes - Day 79
// Prayash Thapa - March 19, 2016

import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;

HDrawablePool pool;
HDrawablePool pool2;
int cellSize = 20;

// ************************************************************************************

void setup() {
	size(1000, 563);
	H.init(this).background(#FFFFFF);
	smooth();

	final HPixelColorist colors = new HPixelColorist("aspen.jpg")
		// .fillOnly()
		// .strokeOnly()
		.fillAndStroke()
	;

	pool = new HDrawablePool(1248);
	pool.autoAddToStage()
		.add(new HShape ("japan.svg"))
		.add(new HShape ("japan2.svg"))
		.add(new HShape ("japan3.svg"))
		.add(new HShape ("parallel.svg"))
		.add(new HShape ("japan5.svg"))
		.layout (
			new HGridLayout()
			.startX(35)
			.startY(35)
			.spacing(cellSize, cellSize)
			.cols(48)
		)
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d
						.enableStyle(false)
						.noStroke()
						.anchorAt(H.CENTER)
						.size(cellSize)
					;
					colors.applyColor(d);
				}
			}
		).requestAll();



	H.drawStage();
	noLoop();
}

// ************************************************************************************

void draw() {

}

// ************************************************************************************

void keyReleased() {
  if (key == 's') saveFrame("_##.png");
  if (key == 'b') filter(BLUR, 1);
  if (key == 'e') filter(ERODE);
  if (key == 'd') filter(DILATE);
}
