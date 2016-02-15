// Processes - Day 22
// Prayash Thapa - January 22, 2016

import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;
import processing.pdf.*;

HDrawablePool assetPool;
boolean record = false;

// ************************************************************************************

void setup() {
	size(700, 700);
	H.init(this).background(#1F1F1F);
	HImage hitObj = new HImage("torii.png");
	H.add(hitObj).visibility(false);
	HShapeLayout shapeLayout = new HShapeLayout().target(hitObj);

	// Torii
	assetPool = new HDrawablePool(700);
	assetPool.autoAddToStage()
		.add(new HShape("smudge1.svg"))
		.add(new HShape("smudge2.svg"))
		.add(new HShape("smudge5.svg"))
		.add(new HShape("smudge7.svg"))
		.layout(shapeLayout)
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d
						.enableStyle(false)
						.strokeJoin(ROUND)
						.strokeCap(ROUND)
						.strokeWeight(0)
						.anchorAt(H.CENTER)
						.fill(0xFF)
						.size(random(2, 60))
						// .rotation(random(1, 75))
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
