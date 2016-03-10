// Processes - Day 54
// Prayash Thapa - February 23, 2016

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
	H.init(this).background(#e7e7e7).use3D(true).autoClear(true);
	frameRate(5);
	colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095A8, #00616F, #FF3300, #FF6600);

	pool = new HDrawablePool( 400 );
	pool.autoAddToStage()
		.add ( new HPath() )
		.layout(
			new HHexLayout()
			.spacing(10)
			.offsetX(0)
			.offsetY(0)
		)

		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					int i = pool.currentIndex();
					HPath d = (HPath) obj;
					d
						.polygon(6)
						.size(40)
						.anchorAt(H.CENTER)
						.fill(#8205ff)
						.stroke(#e7e7e7)
						.noStroke()
						.fill(colors.getColor())
					;

					new HOscillator()
						.target(d)
						.property(H.SCALE)
						.range(0.25, 1.5)
						.speed(1)
						.freq(2)
						.currentStep( i )
					;

					new HOscillator()
						.target(d)
						.property(H.ROTATION)
						.range(-0, 360)
						.speed(1)
						.freq(2)
						.currentStep( i )
					;

					new HOscillator()
						.target(d)
						.property(H.Y)
						.range(50, height-50)
						.speed(.1)
						.freq(14)
						.waveform(H.TRIANGLE)
						.currentStep( i )
					;

					new HOscillator()
						.target(d)
						.property(H.X)
						.range(50, width-50)
						.speed(.4)
						.freq(9)
						.waveform(H.TRIANGLE)
						.currentStep( i )
					;

					new HOscillator()
						.target(d)
						.property(H.Z)
						.range(-800, 50)
						.speed(0.3)
						.freq(10)
						.waveform(H.SAW)
						.currentStep( i )
					;
				}
			}
		)
		.requestAll()
	;
}

// ************************************************************************************

void draw() {
	H.drawStage();
	// if(frameCount % 1 == 0 && frameCount < 240) saveFrame("../image-#####.png");
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
