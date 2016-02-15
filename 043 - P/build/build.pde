// Processes - Day 43
// Prayash Thapa - February 12, 2016

import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;
import processing.pdf.*;

boolean record = false;
boolean paused = true;
HDrawablePool pool;
HColorPool colors;

// ************************************************************************************

void setup() {
	size(700, 700);
	H.init(this).background(#FFFFFF);
	HImage hitObj = new HImage("P.png");
	H.add(hitObj).visibility(false);
	HShapeLayout shapeLayout = new HShapeLayout().target(hitObj);

	colors = new HColorPool(#1a86c7, #b71c00, #f5f428, #af3b22, #cca292, #1a86c7, #8dcde8, #f8c023);

	pool = new HDrawablePool(600);
	pool.autoAddToStage()
		.add(new HShape("smudge2.svg"))
		.add(new HShape("smudge5.svg"))
		.add(new HShape("smudge7.svg"))
		.colorist(new HColorPool(#1a86c7, #b71c00, #f5f428, #af3b22, #cca292, #1a86c7, #8dcde8, #f8c023).fillOnly())
		.layout(shapeLayout)
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d
						.enableStyle(false)
						.strokeJoin(ROUND)
						.strokeCap(ROUND)
						.noStroke()
						.size( (int)random(1, 55) )
						.anchorAt(H.CENTER)
						.rotation(180)
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
