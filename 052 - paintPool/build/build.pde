// Processes - Day 52
// Prayash Thapa - February 21, 2016

import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;
import processing.pdf.*;

boolean record = false;
HDrawablePool pool4;
HShapeLayout map;

HColorPool colors;
HPixelColorist pcolors;

// ************************************************************************************

void setup() {
	size(800, 800);
	H.init(this).background(#FFFFFF).autoClear(true);

	HImage hitObj = new HImage("cloudy3.png");
	H.add(hitObj).anchorAt(H.CENTER).locAt(H.CENTER).size(1200).visibility(false);
	map = new HShapeLayout().target(hitObj);

	colors = new HColorPool()
		.add(#98C32F) //yellowish
		.add(#0A5282,2) // blue
 		.add(#2EECCB,4) //light teal
		.add(#1DFDAC,2) //teal
		.add(#53B517,6) //green
		.add(#0AAE2A,4) //b green
		.add(#00C1BA,8) //light blue
		.add(#004D37,4) //d. green
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

	pool4 = new HDrawablePool(200);
	pool4.autoAddToStage()
		.add (new HShape("smudge1.svg").anchorAt(H.CENTER))
		.add (new HShape("smudge2.svg").anchorAt(H.CENTER))
		.add (new HShape("smudge3.svg").anchorAt(H.CENTER))
		.add (new HShape("smudge4.svg").anchorAt(H.CENTER))
		.add (new HShape("smudge5.svg").anchorAt(H.CENTER),3)
		.add (new HShape("smudge6.svg").anchorAt(H.CENTER),2)
		.add (new HShape("smudge7.svg").anchorAt(H.CENTER))
		.colorist(colors)
		.layout(map)
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d
						.enableStyle(false)
						.anchorAt(H.CENTER)
						.noStroke()
						.rotation((int)random(360))
						.size((int)random(100,400))
						.loc(random(width),random(height))
					;
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
