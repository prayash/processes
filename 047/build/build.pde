// Processes - Day 47
// Prayash Thapa - February 16, 2016

// ************************************************************************************

import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;
import processing.pdf.*;

boolean paused = false;
boolean record = false;

HDrawablePool pool;
HPolarLayout layout;
HColorPool colors;

// ************************************************************************************

void setup(){
	size(640, 640, P3D);
	H.init(this).background(#d92b6a).use3D(true).autoClear(true);
	frameRate(15);
	colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095A8, #00616F, #FF3300, #FF6600);

	pool = new HDrawablePool(1600);
	pool.autoAddToStage()
		.add(
			new HRect(8)
			.anchor(-100, -30)
			.noStroke()
			.fill(#ffffff)
			.rotation(45)
		)

		.add (
			new HEllipse(4)
			.anchor(-30, -100)
			.noStroke()
			.fill(#ffffff)
		)

		.layout (
			new HGridLayout()
			.startX(0)
			.startY(100)
			.spacing(30, 20)
			.cols(40)
		)

		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					int i = pool.currentIndex();
					HDrawable d = (HDrawable) obj;
					new HOscillator()
						.target(d)
						.property(H.Y)
						.range(320, 400)
						.speed(1)
						.freq(2)
						.waveform(H.SAW)
						.currentStep( i )
					;

					new HOscillator()
						.target(d)
						.property(H.ROTATION)
						.range(0, 560)
						.speed(1)
						.freq(2)
						.waveform(H.SAW)
						.currentStep( i+100 )
					;

					new HOscillator()
						.target(d)
						.property(H.Z)
						.range(-200, 200)
						.speed(1)
						.freq(2)
						.waveform(H.SAW)
						.currentStep( i )
					;
				}
			}
		).requestAll();
}

// ************************************************************************************

void draw() {
	H.drawStage();
	// if (frameCount % 1 == 0 && frameCount < 180) saveFrame("../frames/image-#####.png");
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
	if (tmp == null) H.drawStage(); else H.stage().paintAll(tmp, false, 1); // PGraphics, uses3D, alpha
	endRecord();
}
