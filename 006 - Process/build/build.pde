// Processes - Day 6
// Prayash Thapa - January 6, 2016

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
	size(700, 350);
	H.init(this).background(#DC5978).autoClear(true);
	colors = new HColorPool(#ECF0F1, #7877f9, #3498DB, #ffa446);
	
	// Circuits
	circuitPool = new HDrawablePool(40);
	circuitPool.autoAddToStage()
		.add (new HShape("svg1.svg"))
		.add (new HShape("svg2.svg"))
		.add (new HShape("svg3.svg"))
		.add (new HShape("svg4.svg"))
		.add (new HShape("svg5.svg"))
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d
						.anchorAt(H.CENTER)
						.noStroke()
						.loc( (int)random(width), (int)random(height))
						.size( (int)random(20, 400) )
						.rotation( 90 )
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