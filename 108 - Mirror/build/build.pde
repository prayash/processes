// Processes - Day 107
// Prayash Thapa - April 16, 2016

import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;

HDrawablePool trianglePool;
HColorPool palette;
PShader MIRROR;

// ************************************************************************************

void setup() {
	size(640, 320, P3D);
	H.init(this).background(#FFFFFF).use3D(true);
	MIRROR = loadShader("mirror.glsl");

	palette = new HColorPool(#1A86C7, #B71C00, #F5F428, #AF3B22, #CCA292, #1A86C7, #8DCDE8, #F8C023).fillOnly();

	trianglePool = new HDrawablePool(200);
	trianglePool.autoAddToStage()
		.add (new HPath())
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					int i = trianglePool.currentIndex();
					HPath d = (HPath) obj;
					d
						.polygon(3)
						.loc((int) random(width), (int) random(height))
						.size(random(50, 500))
						.fill(palette.getColor(), (int) random(125))
						.anchorAt(H.CENTER)
						.noStroke()
						.z(-100)
					;

					new HOscillator()
						.target(d)
						.property(H.ROTATIONZ)
						.range(0, 360)
						.speed(.2)
						.freq(1.5)
						.currentStep(i)
					;

					new HOscillator()
						.target(d)
						.property(H.X)
						.range(width + 50, -50)
						.speed(.5)
						.freq(1)
						.currentStep(i * 2)
					;

					new HOscillator()
						.target(d)
						.property(H.SIZE)
						.range(20, 200)
						.speed(1)
						.freq(2)
						.waveform(H.SINE)
						.currentStep(i * 2)
					;

					new HOscillator()
						.target(d)
						.property(H.X)
						.range(width, 0)
						.speed(.7)
						.freq(1)
						.currentStep(i)
					;

					new HOscillator()
						.target(d)
						.property(H.Z)
						.range(80, -180)
						.speed(.5)
						.freq(4)
						.currentStep(i)
					;
				}
			}
		).requestAll();
}

// ************************************************************************************

void draw() {
	pointLight(255, 255, 255, 0, 200, 100);
	H.drawStage();
	filter(MIRROR);

	// if(frameCount % 1 == 0 && frameCount < 360) saveFrame("_###.png");
}

// ************************************************************************************

void keyPressed() {
	if (key == 's') saveFrame("_####.png");
}
