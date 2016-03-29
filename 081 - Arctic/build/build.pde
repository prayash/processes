// Processes - Day 81
// Prayash Thapa - March 21, 2016

import processing.pdf.*;
boolean record = false;
boolean paused = false;

HDrawablePool pool;
HColorPool colors;

// ************************************************************************************

void setup() {
	size(640,640, P3D);
	H.init(this).background(#FFFFFF).use3D(true);
	frameRate(24);

	colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #CCCCCC, #999999, #666666, #4D4D4D, #333333);

	pool = new HDrawablePool(70);
	pool.autoAddToStage()
		.add( new HPath() )
		.layout(
			new HHexLayout()
			.spacing(60)
			.offsetX(15)
			.offsetY(15)
		)
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					int i = pool.currentIndex();
					HPath d = (HPath) obj;
					d
						.polygon(6)
						.size(210)
						.anchorAt(H.CENTER)
						// .stroke(#ffffff)
						.strokeWeight(0)
						// .noFill()
						.noStroke()
					;
					colors.applyColor(d);

					new HOscillator()
						.target(d)
						.property(H.SIZE)
						.relativeVal(d.y())
						.range(25, 70)
						.speed(2)
						.freq(1.5)
						.currentStep(i)
					;


				}
			}
		).requestAll();
}

// ************************************************************************************

void draw() {
	H.drawStage();
	// if (frameCount % 1 == 0 && frameCount < 360) saveFrame("../frames/image-#####.png");
}

// ************************************************************************************

void keyPressed() {
	if (key == ' ') {
		if (paused) {
			loop();
			paused = false;
		} else {
			noLoop();
			paused = true;
		}
	}

	if (key == 'r') {
		record = true;
		saveFrame("png/render_####.png");
		saveVector();
		H.drawStage();
	}
}


void saveVector() {
	PGraphics tmp = null;
	tmp = beginRecord(PDF, "pdf/render_#####.pdf");

	if (tmp == null) {
		H.drawStage();
	} else {
		H.stage().paintAll(tmp, false, 1); // PGraphics, uses3D, alpha
	}

	endRecord();
}
