// Processes - Day 107
// Prayash Thapa - April 16, 2016

import processing.pdf.*;
boolean paused = false;
boolean record = false;

HSwarm swarm;
HDrawablePool hexPool;
HDrawablePool dotPool;
HDrawablePool shapePool;
HDrawablePool bgHexPool;
HTimer timer;
HColorPool colors;
HShape cross;

// ************************************************************************************

void setup() {
	size(500, 500);
	H.init(this).background(#F9CDAD).autoClear(false);

	HImage hitObj = new HImage("circles.png");
	H.add(hitObj).anchorAt(H.CENTER).locAt(H.CENTER).visibility(false);
	HShapeLayout dotMap = new HShapeLayout().target(hitObj);

	HImage hitObj2 = new HImage("shapeMap.png");
	H.add(hitObj2).anchorAt(H.CENTER).locAt(H.CENTER).visibility(false);
	HShapeLayout shapeMap = new HShapeLayout().target(hitObj2);

	cross = new HShape("cross.svg");

	colors = new HColorPool()
		.add(#FE4365)
		.add(#FC9D9A)
		.add(#F9CDAD)
		.fillOnly()
	;

	swarm = new HSwarm()
		.addGoal(H.mouse())
		.speed(3)
		.turnEase(0.05f)
		.twitch(5)
	;

	hexPool = new HDrawablePool(8);
	hexPool.autoAddToStage()
		.add (new HPath(10))
		.colorist(colors)
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HPath d = (HPath) obj;
					int i = hexPool.currentIndex();
					d
						.polygon(6)
						.strokeWeight(0)
						.stroke(#bac5cb)
						.loc( width/2, height/2 )
						.anchorAt( H.CENTER )
					;

					new HOscillator()
					.target(d)
					.property(H.SCALE)
					.range(0, 2)
					.speed((int)random(5))
					.freq((int)random(2,4))
					.currentStep(i)
					;

					swarm.addTarget(d);
				}
			}
		);



	dotPool = new HDrawablePool(60);
	dotPool.autoAddToStage()
		.add (new HEllipse())
		.add (new HShape("cross.svg").enableStyle(false))
		.colorist(colors)
		.layout(shapeMap)

		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d
						.fill(#d24150)
						.strokeWeight(2)
						.noStroke()
						.size((int)random(4,15))
					;
				}
			}
		).requestAll();

	shapePool = new HDrawablePool(20);
	shapePool.autoAddToStage()
		.add (new HEllipse())
		.add (new HShape("cross.svg").enableStyle(false))
		.layout(dotMap)
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d
						.fill(#bac5cb)
						.strokeWeight(2)
						.noStroke()
						.size((int)random(6,20))
					;
				}
			}
		).requestAll();

	timer = new HTimer()
		.numCycles( hexPool.numActive() )
		.interval(400)
		.callback(
			new HCallback() {
				public void run(Object obj) {
					hexPool.request();
				}
			}
		)
	;
}

// ************************************************************************************

void draw() {
	H.drawStage();
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

	if (key == 's') saveFrame("##.png");
}
