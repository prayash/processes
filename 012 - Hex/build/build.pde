// Processes - Day 12
// Prayash Thapa - January 12, 2016

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
	size(700, 700);
	H.init(this).background(#FFFFFF);
	colors = new HColorPool(#1a86c7, #b71c00, #f5f428, #af3b22, #cca292, #1a86c7, #8dcde8, #f8c023);
	
	// Hexagons
	hexPool = new HDrawablePool(125);
	hexPool.autoAddToStage()
		.add (new HPath())
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HPath d = (HPath) obj;
					d
						.polygon(6, 0)
						.anchorAt(H.CENTER)
						.noStroke()
						.fill(colors.getColor(), (int)random(120, 180))
						.size(125)
						.rotate(90)
						.loc(random(width), random(height))
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