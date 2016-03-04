// Processes - Day 53
// Prayash Thapa - February 22, 2016

import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;
import processing.pdf.*;

boolean record = false;
HDrawablePool pool;
HPolarLayout layout;
HColorPool colors;

// ************************************************************************************

void setup() {
	size(640, 640, P3D);
	H.init(this).background(#DC5978).use3D(true).autoClear(true);
	frameRate(15);

	colors = new HColorPool(#ECF0F1, #7877f9, #3498DB, #ffa446);

	pool = new HDrawablePool(1000);
	pool.autoAddToStage()
		.add(new HRect(8).anchor(-100, -30))
		.add(new HRect(4).anchor(-10, 30))
		.add(new HRect(4).anchor(-30, 10))
		.add(new HRect(2).anchor(30, -10))
		.add(new HRect(9).anchor(30, -10))
		.add(new HEllipse(2).anchor(15, -5))
		.colorist(colors)
		.layout (
			new HGridLayout()
			.startX(300)
			.startY(0)
			.spacing(0,0)
			.cols(80)
		)
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					int i = pool.currentIndex();
					HDrawable d = (HDrawable) obj;
					d.noStroke();

					new HOscillator()
						.target(d)
						.property(H.X)
						.range(100, 500)
						.speed(1.5)
						.freq(3)
						// .waveform(H.TRIANGLE)
						.currentStep( i )
					;

					new HOscillator()
						.target(d)
						.property(H.Y)
						.range(100, 600)
						.speed(2)
						.freq(3)
						.currentStep( i )
					;

					new HOscillator()
						.target(d)
						.property(H.SCALE)
						.range(0.25, 4)
						.speed(3)
						.freq(3)
						// .waveform(H.SAW)
						.currentStep( i )
					;
				}
			}
		).requestAll();
}

// ************************************************************************************

void draw(){
	H.drawStage();
	// if(frameCount % 1 == 0 && frameCount < 240) saveFrame("../frames/image-#####.png");
}

// ************************************************************************************

void keyPressed() {
	if (key == 'r') {
		record = true;
		saveFrame("render_####.png");
		saveVector();
	}
}

void saveVector() {
	PGraphics tmp = null;
	tmp = beginRecord(PDF, "render_#####.pdf");
	if (tmp == null) H.drawStage(); else H.stage().paintAll(tmp, false, 1); // PGraphics, uses3D, alpha
	endRecord();
}
