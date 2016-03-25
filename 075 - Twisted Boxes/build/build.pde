// Processes - Day 75
// Prayash Thapa - March 15, 2016

import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;

HDrawablePool pool;
HPixelColorist colors;
int boxSixe = 75;

void setup() {
	size(640, 640, P3D);
	H.init(this).background(#ffffff).use3D(true).autoClear(true);
	frameRate(24);

	colors = new HPixelColorist("color.jpg").fillOnly();

	pool = new HDrawablePool(500);
	pool.autoAddToStage()
		.add ( new HBox() )
		.layout (
			new HGridLayout()
			.startX(75)
			.startY(75)
			.spacing(40, 40)
			.cols(50)
		)
		.onCreate (
			 new HCallback() {
				public void run(Object obj) {
					int i = pool.currentIndex();
					HBox d = (HBox) obj;
					d
						.depth(boxSixe)
						.width(5)
						.height(random(7, 15))
						.noStroke()
						.fill(#ffffff)
						.z(0)
					;
					colors.applyColor(d);

					new HOscillator()
						.target(d)
						.property(H.ROTATIONX)
						.range(-180, 180)
						.speed(0.6)
						.freq(1)
						.currentStep(i*2)
					;

					new HOscillator()
						.target(d)
						.property(H.ROTATIONY)
						.range(-180, 180)
						.speed(0.3)
						.freq(1)
						.currentStep(i*2)
					;

					new HOscillator()
						.target(d)
						.property(H.ROTATIONZ)
						.range(-360, 360)
						.speed(0.9)
						.freq(1)
						.currentStep(i*2)
					;

					new HOscillator()
						.target(d)
						.property(H.Z)
						.range(-200, 600)
						.speed(.1)
						.freq(2)
						.waveform(H.TRIANGLE)
						.currentStep(i*2)
					;

					new HOscillator()
						.target(d)
						.property(H.Y)
						.range(200, 440)
						.speed(1)
						.freq(1)
						.currentStep(i-400)
					;

					new HOscillator()
						.target(d)
						.property(H.X)
						.range(440, 200)
						.speed(1)
						.freq(1)
						.currentStep(i+100)
					;
				}
			}
		).requestAll();
}

void draw() {
	H.drawStage();

	for(HDrawable d : pool) {
		if ( colors.getColor( d.x(),d.y() ) != 0 ) {
			colors.applyColor(d);
		}
	}

	if (keyPressed) {
		filter(BLUR, 5); filter(ERODE); filter(DILATE);
	}

	// if (frameCount % 1 == 0 && frameCount < 360) saveFrame("../frames/image-#####.png");
}
void keyPressed() {
	if (key == 'r') saveFrame("render_####.png");

	if (key == ' ') {
		if (paused) {
			loop();
			paused = false;
		} else {
			noLoop();
			paused = true;
		}
	}
}
