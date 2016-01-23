// Processes - Day 11
// Prayash Thapa - January 11, 2016

import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;
import processing.pdf.*;

HDrawablePool boxPool;
HColorPool colors;
boolean record = false;

// ************************************************************************************

void setup() {
	size(700, 700);
	H.init(this).background(#DC5978).autoClear(true);
	colors = new HColorPool(#ECF0F1, #7877f9, #3498DB, #ffa446);
	
	// Boxes
	boxPool = new HDrawablePool(576);
	boxPool.autoAddToStage()
		.add (new HRect())
		.layout(
			new HGridLayout()
			.startX(21)
			.startY(21)
			.spacing(26, 26)
			.cols(24)
		)
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d
						.anchorAt(H.CENTER)
						.noStroke()
						.fill(colors.getColor())
						.size( (int)random(20, 400) )
						.rotation(45)
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