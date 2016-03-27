// Processes - Day 77
// Prayash Thapa - March 17, 2016

import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;
import processing.pdf.*;

boolean record = false;
boolean paused = true;
HDrawablePool pool;

// ************************************************************************************

void setup() {
	size(700, 700);
	H.init(this).background(#FFFFFF);
	HImage hitObj = new HImage("chevron.png");
	H.add(hitObj).visibility(false);
	HShapeLayout shapeLayout = new HShapeLayout().target(hitObj);

	pool = new HDrawablePool(4000);
	pool.autoAddToStage()
		.add (new HRect())
		.colorist(new HColorPool(#303030,#373737,#3A3A3A,#2A77E8, #3BC4FF,#414141,#495DFF,#9D9D9D,#AAAAAA,#B8B8B8,#BFBFBF).fillOnly())
		.layout(shapeLayout)
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d
						.noStroke()
						.size( (int)random(1, 9) )
						.anchorAt(H.CENTER)
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
