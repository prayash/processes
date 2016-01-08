// Processes - Day 3
// Prayash Thapa - January 3, 2016

import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;
import processing.pdf.*;
boolean record = false;

HColorPool colors;
HDrawablePool pool;

// ************************************************************************************

void setup() {
	size(800, 800);
	H.init(this).background(#FFFFFF);

	colors = new HColorPool(#D31996,#708D91,#342A5D,#19DD89,#2A1A3D,#41326A,#3F3062,#292243,#705DB0,#241D32,#56436C,#695587,#413855,#9B7CB8,#6B567F).fillOnly();

	pool = new HDrawablePool((int)random(25, 55));
	pool.autoAddToStage()
		.add (new HShape("svg3.svg").strokeJoin(ROUND).strokeCap(ROUND).anchorAt(H.CENTER))
		.add (new HShape("svg4.svg").strokeJoin(ROUND).strokeCap(ROUND).anchorAt(H.CENTER))
		.add (new HShape("svg2.svg").strokeJoin(ROUND).strokeCap(ROUND).anchorAt(H.CENTER), 20)
		.add (new HShape("svg1.svg").strokeJoin(ROUND).strokeCap(ROUND).anchorAt(H.CENTER))
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d
						.strokeWeight(0)
						.rotation( (int)random(180) )
						.size( (int)random(200, 500) )
						.loc(random(width / 2.25, width), random(height / 2, height))
					;
					d.randomColors(colors);
				}
			}
		)
		.requestAll();

	H.drawStage();
	noLoop();

}

// ************************************************************************************

void draw() {
	PGraphics tmp = null;

	if (record) {
		tmp = beginRecord(PDF, "render-######.pdf");
	}

	if (tmp == null) {
		H.drawStage();
	} else {
		PGraphics g = tmp;
		boolean uses3D = false;
		float alpha = 1;
		H.stage().paintAll(g, uses3D, alpha);
	}

	if (record) {
		endRecord();
		record = false;
	}
}

// ************************************************************************************

void keyPressed() {
	if (key == 's') {
		record = true;
		draw();
	}
}