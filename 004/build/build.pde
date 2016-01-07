// Processes - Day 4
// Prayash Thapa - January 4, 2016

import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;
import processing.pdf.*;
boolean record = false;

HDrawablePool pool;
HColorPool colors;
HShape s1;

// ************************************************************************************

void setup() {
	size(700, 700);
	H.init(this).background(#FFFFFF);

	HImage i1 = new HImage("diamond.png");
	H.add(i1).visibility(false);
	HShapeLayout s1 = new HShapeLayout().target(i1);

	colors = new HColorPool(#482964,#563D66,#535E81,#495CC5,#4E72CA,#7A86AF,#7692D1,#8B9ECB,#A6B6D6);

	pool = new HDrawablePool(150);
	pool.autoAddToStage()
		.add(new HShape("diamond.svg"))
		.layout(s1)
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d
						.enableStyle(false)
						.strokeJoin(ROUND)
						.strokeCap(ROUND)
						.noStroke()
						.fill(colors.getColor(), 200)
						.anchorAt(H.CENTER)
						.rotate(135)
						.size( (int)random(5) * 50 )
					;
				}
			}
		)
		.requestAll();

	pool = new HDrawablePool(50);
	pool.autoAddToStage()
		.add(new HShape("diamond.svg"))
		.layout(s1)
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d
						.enableStyle(false)
						.strokeJoin(ROUND)
						.strokeCap(ROUND)
						.noStroke()
						.fill(colors.getColor(), 200)
						.anchorAt(H.CENTER)
						.rotate(135)
						.size( (int)random(5) * 100 )
					;
				}
			}
		)
		.requestAll();

	H.drawStage();
}

// ************************************************************************************

void draw() {
	PGraphics tmp = null;

	if (record) tmp = beginRecord(PDF, "render-######.pdf");

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
