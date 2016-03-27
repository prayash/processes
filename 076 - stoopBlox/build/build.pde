// Processes - Day 76
// Prayash Thapa - March 16, 2016

import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;

HDrawablePool pool;
HDrawablePool pool2;
HDrawablePool pool3;

HShapeLayout hsl;
HShapeLayout hsl2;
HShapeLayout hsl3;

HColorPool colors;

// ************************************************************************************

void setup() {
	size(640, 640);
	H.init(this).background(#202020).autoClear(true);

	HEllipse hitObj = new HEllipse(400);
	H.add(hitObj).anchorAt(H.CENTER).locAt(H.CENTER).visibility(false);
	hsl=new HShapeLayout().target(hitObj);

	HEllipse hitObj2 = new HEllipse(350);
	H.add(hitObj2).anchorAt(H.CENTER).locAt(H.CENTER).visibility(false);
	hsl2=new HShapeLayout().target(hitObj2);

	HImage hitObj3 = new HImage("wavy.png");
	H.add(hitObj3).anchorAt(H.CENTER).locAt(H.CENTER).size(1100).visibility(false);
	hsl3 = new HShapeLayout().target(hitObj3);

	colors = new HColorPool(#303030,#373737,#3A3A3A,#2A77E8, #3BC4FF,#414141,#495DFF,#9D9D9D,#AAAAAA,#B8B8B8,#BFBFBF).fillOnly();
	drawThings();
}

// ************************************************************************************

void draw() {

}

// ************************************************************************************

void drawThings() {
	H.clearStage();

	pool3 = new HDrawablePool(40); //BG
	pool3.autoAddToStage()
		.add (new HShape("grid1.svg").anchorAt(H.CENTER),3)
		.add (new HShape("grid1.svg").anchorAt(H.CENTER),2)
		.add (new HShape("grid2.svg").anchorAt(H.CENTER))
		.add (new HShape("grid1.svg").anchorAt(H.CENTER),3)
		.add (new HShape("grid2.svg").anchorAt(H.CENTER),2)
		.colorist(colors)
		.layout(hsl)
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d
						.enableStyle(false)
						.fill(#0b052b, 25)
						.noStroke()
						.size((int)random(200,500))
					;
				}
			}
		).requestAll();

	pool2 = new HDrawablePool(4);
	pool2.autoAddToStage()
		.add (new HShape("grid2.svg").anchorAt(H.CENTER))
		.layout(hsl2)
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d
						.anchorAt(H.CENTER)
						.strokeWeight(0.3)
						.stroke(#010103)
						.rotation((int)random(360))
						.size((int)random(300,600))
					;
					d.randomColors(colors.fillOnly());

				}
			}
		).requestAll();

	pool = new HDrawablePool(70); //top shapes
	pool.autoAddToStage()
		.add (new HShape("grid2.svg").anchorAt(H.CENTER),3)
		.add (new HShape("grid1.svg").anchorAt(H.CENTER),4)
		.add (new HShape("grid2.svg").anchorAt(H.CENTER),2)
		.add (new HShape("grid1.svg").anchorAt(H.CENTER))
		.add (new HShape("grid2.svg").anchorAt(H.CENTER),3)
		.add (new HShape("grid1.svg").anchorAt(H.CENTER),2)
		.layout(hsl3)
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d
						.anchorAt(H.CENTER)
						.strokeJoin(ROUND)
						.strokeCap(ROUND)
						.strokeWeight(0.5)
						.stroke(#010103)
						.size((int)random(100,250))
						.rotation((int)random(0,360))
					;
					 d.randomColors(colors.fillOnly());

				}
			}
		).requestAll();
	H.drawStage();
}

// ************************************************************************************

void keyPressed() {
	if (key == '+') drawThings();
	if (key == 'r') saveFrame("render_####.png");
	if (key == 'b') filter(BLUR, 1);
  if (key == 'e') filter(ERODE);
  if (key == 'd') filter(DILATE);
}
