// Processes - Day 80
// Prayash Thapa - March 20, 2016

import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;
import processing.pdf.*;

HDrawablePool circuitPool;
HColorPool colors;
boolean record = false;

// ************************************************************************************

void setup() {
	size(700, 700);
	H.init(this).background(#202020).autoClear(true);
	colors = new HColorPool(#bb2018, #bcd329, #43355f, #58af36, #6a1e20, #874d66, #5f9c97);

	HImage hitObj = new HImage("map.png");
	H.add(hitObj).visibility(false);
	HShapeLayout shapeLayout = new HShapeLayout().target(hitObj);

	// Circuits
	circuitPool = new HDrawablePool(300);
	circuitPool.autoAddToStage()
		.add (new HShape("optics2.svg"))
		.layout(shapeLayout)
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d
						.enableStyle(false)
						.anchorAt(H.CENTER)
						.noStroke()
						.size( (int)random(10, 400) )
						.fill(colors.getColor(), (int)random(150, 200))
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
