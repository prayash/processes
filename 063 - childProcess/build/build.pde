// Processes - Day 63
// Prayash Thapa - March 3, 2016

import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;
import processing.pdf.*;

HDrawablePool assetPool, assetPool_2;
HColorPool colors;
boolean record = false;

// ************************************************************************************

void setup() {
	size(700, 350);
	H.init(this).background(#FDFDFD).autoClear(true);
	colors = new HColorPool(#ECF0F1, #DC5978, #3498DB, #ffa446);

	// Circuits
	assetPool = new HDrawablePool(50);
	assetPool.autoAddToStage()
		.add (new HShape("shape.svg"))
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d
						.anchorAt(H.CENTER)
						.noStroke()
						.loc( (int)random(width), (int)random(height))
						.size( (int)random(20, 700) )
						.rotation( 0 )
					;
					d.randomColors(colors.fillOnly());
				}
			}
		).requestAll();

	// Circuits
	assetPool_2 = new HDrawablePool(30);
	assetPool_2.autoAddToStage()
		.add (new HShape("shape.svg"))
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d
						.anchorAt(H.CENTER)
						.noFill()
						.loc( (int)random(width), (int)random(height))
						.size( (int)random(20, 800) )
						.rotation( 180 )
					;
					d.randomColors(colors.strokeOnly());
				}
			}
		).requestAll();

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
