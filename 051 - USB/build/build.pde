// Processes - Day 50
// Prayash Thapa - February 19, 2016

import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;
import processing.pdf.*;

boolean record = false;
HDrawablePool pool3, pool4;
HShapeLayout hsl2, hsl3;

HColorPool colors, colors2;
HPixelColorist pcolors;

// ************************************************************************************

void setup() {
	size(700, 700);
	H.init(this).background(#1E1E1E).autoClear(true);

	HImage hitObj = new HImage("usb.png");
	H.add(hitObj).anchorAt(H.CENTER).locAt(H.CENTER).size(700).visibility(false);
	hsl2 = new HShapeLayout().target(hitObj);

	HImage hitObj_2 = new HImage("usb.png");
	H.add(hitObj_2).anchorAt(H.CENTER).locAt(H.CENTER).size(700).visibility(false);
	hsl3 = new HShapeLayout().target(hitObj_2);

 	pcolors = new HPixelColorist("sunrise.jpg").fillOnly();

	colors = new HColorPool()

		.add(#98C32F) //yellowish
		.add(#0A5282,2) // blue
 		.add(#2EECCB,4) //light teal
		.add(#1DFDAC,2) //teal
		.add(#53B517,6) //green
		.add(#0AAE2A,4) //b green
		.add(#00C1BA,8) //light blue
		.add(#004D37,4) //d. green
		// .add(#ffffff)
		.fillOnly()
	;

	colors2 = new HColorPool()
		.add(#ffffff,2)
		.add(#e7e7e7,3) //lightest
		.add(#0A5282) // blue
		.add(#B5C6D7,2) //v.light blue
		.fillOnly()
	;
	drawThings();
}

// ************************************************************************************

void draw() {

}

// ************************************************************************************

void drawThings() {
	H.clearStage();
	pool4 = new HDrawablePool(350);
	pool4.autoAddToStage()
		.add (new HShape("smudge1.svg").anchorAt(H.CENTER))
		.add (new HShape("smudge2.svg").anchorAt(H.CENTER))
		.add (new HShape("smudge3.svg").anchorAt(H.CENTER))
		.add (new HShape("smudge4.svg").anchorAt(H.CENTER))
		.add (new HShape("smudge5.svg").anchorAt(H.CENTER),3)
		.add (new HShape("smudge6.svg").anchorAt(H.CENTER),2)
		.add (new HShape("smudge7.svg").anchorAt(H.CENTER))
		.add (new HShape("smudge8.svg").anchorAt(H.CENTER))
		.layout(hsl3)
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d
						.enableStyle(false)
						.anchorAt(H.CENTER)
						.noStroke()
						.rotation((int)random(360))
						.size((int)random(15, 60))
					;
					pcolors.applyColor(d);

				}
			}
		).requestAll();

	pool3 = new HDrawablePool(650);
	pool3.autoAddToStage()
		.add (new HShape("smudge1.svg").anchorAt(H.CENTER))
		.add (new HShape("smudge2.svg").anchorAt(H.CENTER))
		.add (new HShape("smudge3.svg").anchorAt(H.CENTER),2)
		.add (new HShape("smudge4.svg").anchorAt(H.CENTER),2)
		.add (new HShape("smudge5.svg").anchorAt(H.CENTER),2)
		.add (new HShape("smudge6.svg").anchorAt(H.CENTER))
		.add (new HShape("smudge7.svg").anchorAt(H.CENTER))
		.add (new HShape("smudge8.svg").anchorAt(H.CENTER))
		.layout(hsl2)
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d
						.enableStyle(false)
						.anchorAt(H.CENTER)
						.noStroke()
						.rotation((int)random(360))
						.size((int)random(10, 20))
					;
					pcolors.applyColor(d);

				}
			}
		).requestAll();
	H.drawStage();
}

// ************************************************************************************

void keyPressed() {
	if (key == ']') drawThings();
	if (key == 'r') {
		record = true;
		saveVector();
	}
}

void saveVector() {
	PGraphics tmp = null;
	tmp = beginRecord(PDF, "render_#####.pdf");

	if (tmp == null) {
		H.drawStage();
	} else {
		H.stage().paintAll(tmp, false, 1); // PGraphics, uses3D, alpha
	}

	endRecord();
}
