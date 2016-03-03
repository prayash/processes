// Processes - Day 50
// Prayash Thapa - February 19, 2016

import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;
import processing.pdf.*;
boolean record = false;

HDrawablePool pool;
HColorPool colors;
HShape s1;

// ************************************************************************************

void setup() {
	size(600, 400);
	H.init(this).background(#1C1C1C);

	HImage i1 = new HImage("map.png");
	H.add(i1).visibility(false);
	HShapeLayout s1 = new HShapeLayout().target(i1);

	colors = new HColorPool(#1a86c7, #b71c00, #f5f428, #af3b22, #cca292, #1a86c7, #8dcde8, #f8c023);

	pool = new HDrawablePool(2500);
	pool.autoAddToStage()
		.add(new HShape("components.svg"))
		.layout(s1)
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d
						.enableStyle(false)
						.strokeJoin(ROUND)
						.strokeCap(ROUND)
						.noStroke()
						.fill(colors.getColor(), 200)
						.anchorAt(H.CENTER)
						.size((int)random(2, 70))
					;
				}
			}
		).requestAll();

	H.drawStage();
}

// ************************************************************************************

void draw() {

}

// ************************************************************************************

void keyPressed() {
	if (key == 'r') {
		record = true;
		saveFrame("render_####.png");
		saveVector();
	}
}

void saveVector() {
	PGraphics tmp = null;
	tmp = beginRecord(PDF, "render_#####.pdf");
	if (tmp == null) H.drawStage(); else H.stage().paintAll(tmp, false, 1); // PGraphics, uses3D, alpha
	endRecord();
}
