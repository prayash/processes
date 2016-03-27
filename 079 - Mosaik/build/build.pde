// Processes - Day 79
// Prayash Thapa - March 19, 2016

import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;

HDrawablePool pool;
HDrawablePool pool2;
int cellSize = 40;

// ************************************************************************************

void setup() {
	size(800, 800);
	H.init(this).background(#202020);
	smooth();

	final HPixelColorist colors = new HPixelColorist("wave.jpg")
		.fillOnly()
		// .strokeOnly()
		// .fillAndStroke()
	;

	pool = new HDrawablePool(729);
	pool.autoAddToStage()
		.add(new HShape ("japan.svg"))
		.add(new HShape ("japan2.svg"))
		.add(new HShape ("japan3.svg"))
		.add(new HShape ("japan4.svg"))
		.add(new HShape ("japan5.svg"))
		.layout (
			new HGridLayout()
			.startX(35)
			.startY(35)
			.spacing(cellSize+4,cellSize+4)
			.cols(27)
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

	pool2 = new HDrawablePool(675);
	pool2.autoAddToStage()
		.add (
			new HEllipse()
			.rotate(45)
		)
		.layout (
			new HGridLayout()
			.startX(58)
			.startY(58)
			.spacing(cellSize+4,cellSize+4)
			.cols(26)
		)
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d
						.noStroke()
						.anchorAt(H.CENTER)
						.size(8)
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
