// Processes - Day 22
// Prayash Thapa - January 22, 2016

import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;
import processing.pdf.*;

HDrawablePool hexPool;
HColorPool colors;
boolean record = false;

// ************************************************************************************

void setup() {
	size(700, 350);
	H.init(this).background(#FFFFFF);
	colors = new HColorPool(#1a86c7, #b71c00, #f5f428, #af3b22, #cca292, #1a86c7, #8dcde8, #f8c023);
	
	// Hexagons
	hexPool = new HDrawablePool(225);
	hexPool.autoAddToStage()
		.add(new HShape("svg1.svg"))
		.layout(
			new HGridLayout()
			.startX(0)
			.startY(0)
			.spacing(50, 50)
			.cols(15)
		)
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
						.fill(colors.getColor(), (int)random(120, 180))
						.size(150)
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