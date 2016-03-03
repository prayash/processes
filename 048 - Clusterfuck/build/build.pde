// Processes - Day 48
// Prayash Thapa - February 17, 2016

// ************************************************************************************

import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;
import processing.pdf.*;

boolean record = false;
boolean paused = false;

HDrawablePool rectPool;
HShapeLayout frame;
HColorPool colors, colors2;

// ************************************************************************************

void setup() {
	size(700, 700);
	H.init(this).background(#ffffff).autoClear(true);

	HImage hitObj3 = new HImage("wireframe.png");
	H.add(hitObj3).anchorAt(H.CENTER).locAt(H.CENTER).size(700).visibility(false);
	frame = new HShapeLayout().target(hitObj3);

	colors2 = new HColorPool()
		.add(#0b0c0c,2)
		.add(#0f1525,2)
		.add(#222232,2)
		.fillOnly()
	;
	drawThings();
}

// ************************************************************************************

void draw() {

}

void drawThings() {
	H.clearStage();

	rectPool = new HDrawablePool(10000);
	rectPool.autoAddToStage()
		.add (new HRect(300).anchorAt(H.CENTER).rotate(45))
		.layout(frame)
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d
						.fill( colors2.getColor())
						.noStroke()
						.loc( (int)random(100,width-100), (int)random(100,height-100) )
						.size((int)random(1, 5))
					;
				}
			}
		).requestAll();
	H.drawStage();
}

// ************************************************************************************

void keyPressed() {
	if (key == ']') drawThings();
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
