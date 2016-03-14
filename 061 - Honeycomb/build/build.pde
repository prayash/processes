// Processes - Day 61
// Prayash Thapa - March 1, 2016

// ************************************************************************************

import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;
import processing.pdf.*;

HDrawablePool hexPool; HColorField colorField;
HColorPool colors;
boolean record = false;

// ************************************************************************************

void setup() {
	size(700, 350);
	H.init(this).background(#DFDFDF).autoClear(true);
	final HPixelColorist colors = new HPixelColorist("5.jpg").fillOnly();

	// Hexagons
	hexPool = new HDrawablePool(20);
	hexPool.autoAddToStage()
		.add (new HShape("shape.svg"))
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d
						.enableStyle(false)
						.anchorAt(H.CENTER)
						.noStroke()
						.loc( (int)random(width), (int)random(height))
						.size( (int)random(20, 350) )
						.rotation( 0 )
						.fill(#000000)
					;
					colors.applyColor(d);
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
