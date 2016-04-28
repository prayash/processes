// Processes - Day 107
// Prayash Thapa - April 16, 2016

import processing.pdf.*;
boolean record = false;
boolean paused = false;
boolean mirror = false;

HDrawablePool pool;
HDrawablePool pool2;
HDrawablePool pool3;
HDrawablePool pool4;
HDrawablePool pool5;

HColorPool colors;
HColorPool colors2;
HColorField colorField;
HPixelColorist pcolors;

PShader flipHalf;

// ************************************************************************************

void setup(){
	size(640, 640, P3D);
	H.init(this).background(#ffffff).use3D(true);

	flipHalf = loadShader("flipHalf.glsl");
	// blendMode(DIFFERENCE);

	frameRate(24);

	colors = new HColorPool()
		.add(#ffffff,20) //white
		.add(#cccccc,5) //grey
		.add(#ff8d37) //light orange
		.add(#e7e7e7,20) // grey
 		.add(#1c0d68) //purple
		.add(#5001be) //light purp
		// .add(#02fcfa) //teal
		.add(#fe39a2) //pink
		// .add(#7bfc88) //green
		// .add(#dee7ff)
		// .add(#c7f6fe)
		// .add(#2f3b5c)
		.fillOnly()
	;

	colors2 = new HColorPool()
		.add(#ffffff) //white
		.add(#cccccc) //grey
		// .add(#ff8d37) //light orange
		.add(#e7e7e7) // grey
		.fillOnly()
	;

	pool = new HDrawablePool(800);
	pool.autoAddToStage()
		.add (new HPath())
		.layout (
			new HGridLayout()
			.startX(32)
			.startY(32)
			.spacing(10,100)
			.cols(64)
		)

		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HPath d = (HPath) obj;
					int i = pool.currentIndex();
					d
						.polygon(3)
						.size(140)
						.anchorAt(H.CENTER)
						// .stroke(#ffffff)
						// .strokeWeight(.5)
						// .noFill()
						// .noStroke()
					;

					d.fill(colors2.getColor()).noStroke();

					// new HOscillator()
					// 	.target(d)
					// 	.property(H.X)
					// 	// .relativeVal(d.y())
					// 	.range(width, 0)
					// 	.speed(2)
					// 	.freq(1.5)
					// 	// .currentStep(i)
					// ;

					new HOscillator()
						.target(d)
						.property(H.ROTATIONX)
						.range(0, 360)
						.speed(.2)
						.freq(1.5)
						// .waveform(H.SAW)
						.currentStep(i)
					;

					new HOscillator()
						.target(d)
						.property(H.ROTATIONZ)
						.range(0, 180)
						.speed(.2)
						.freq(2)
						// .waveform(H.SAW)
						.currentStep(i)
					;

					new HOscillator()
						.target(d)
						.property(H.X)
						.range(width, 0)
						.speed(.7)
						.freq(1)
						.currentStep(i+100)
					;

					new HOscillator()
						.target(d)
						.property(H.Z)
						.range(80, -180)
						.speed(.5)
						.freq(4)
						// .waveform(H.SAW)
						.currentStep(i)
					;

					new HOscillator()
						.target(d)
						.property(H.SIZE)
						.range(100, 300)
						.speed(1)
						.freq(1)
						// .waveform(H.SAW)
						.currentStep(i)
					;

				}
			}
		)

		.requestAll()
	;


	pool2 = new HDrawablePool(100);
	pool2.autoAddToStage()
		.add ( new HPath() )
		.layout (
			new HGridLayout()
			.startX(32)
			.startY(32)
			.spacing(10,50)
			.cols(64)
		)

		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					int i = pool2.currentIndex();
					HPath d = (HPath) obj;
					d
						.polygon(3)
						.size(210)
						.anchorAt(H.CENTER)
						// .stroke(#ffffff)
						// .strokeWeight(.5)
						// .noFill()
						.noStroke()
						.z(-300)
					;

					d
						.loc( (int)random(width), (int)random(height-100) )
						.size((int)random(200))
						.fill(colors2.getColor())
						// .noStroke()
						.z(-100)
					;

					new HOscillator()
						.target(d)
						.property(H.ROTATIONZ)
						.range(0, 360)
						.speed(.2)
						.freq(1.5)
						// .waveform(H.SAW)
						.currentStep(i)
					;

					new HOscillator()
						.target(d)
						.property(H.X)
						.range(width+50, -50)
						.speed(.5)
						.freq(1)
						.currentStep(i*2)
					;

					new HOscillator()
						.target(d)
						.property(H.SIZE)
						.range(20, 200)
						.speed(1)
						.freq(2)
						// .waveform(H.SAW)
						.currentStep(i*2)
					;
				}
			}
		).requestAll();
}

// ************************************************************************************

void draw() {
	pointLight(255, 68, 63,  0, 200, 100);        // orange
	pointLight(228, 94, 255,  width, height/2, 300);   // purple
	pointLight(255, 204, 0,  width/2, height/2, 100); // yellow

	H.drawStage();

  // apply texture shader
	filter(flipHalf);

	// if(frameCount % 1 == 0 && frameCount < 360) saveFrame("../frames/image-#####.png");
}


// +        = redraw() advances 1 iteration
// r        = render to PDF
// c        = recolor

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

	// if (key == '+') {
	// 	drawThings();
	// }

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
