// Processes - Day 25
// Prayash Thapa - January 25, 2016

import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;
import processing.pdf.*;

boolean record = false;
boolean paused = true;
HDrawablePool pool, circuitPool;
HColorPool colors;

// ************************************************************************************

void setup() {
	size(700, 350);
	H.init(this).background(#1C1C1C);
	HImage hitObj = new HImage("hex.png");
	H.add(hitObj).visibility(false);
	HShapeLayout shapeLayout = new HShapeLayout().target(hitObj);

	colors = new HColorPool(#1a86c7, #b71c00, #f5f428, #af3b22, #cca292, #1a86c7, #8dcde8, #f8c023);
	
	pool = new HDrawablePool(500);
	pool.autoAddToStage()
		.add (new HRect())
		.colorist(new HColorPool(#1a86c7, #b71c00, #f5f428, #af3b22, #cca292, #1a86c7, #8dcde8, #f8c023).fillOnly())
		.layout(shapeLayout)
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d
						.noStroke()
						.size( (int)random(1, 12) )
						.anchorAt(H.CENTER)
						.rotation(45)
					;
				}
			}
		)
		.requestAll();

	// Circuits
	circuitPool = new HDrawablePool(25);
	circuitPool.autoAddToStage()
		.add (new HShape("svg1.svg"))
		.add (new HShape("svg2.svg"))
		.layout(shapeLayout)
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d
						.anchorAt(H.CENTER)
						.noStroke()
						.size( (int)random(20, 400) )
						// .rotation( 0 )
					;
					d.randomColors(colors.fillOnly());
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