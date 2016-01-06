import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;
import processing.pdf.*;

boolean record = false;
boolean paused = true;
HDrawablePool pool;

void setup() {
	size(700, 700);
	H.init(this).background(#202020);

	HImage hitObj = new HImage("text.png");
	H.add(hitObj).visibility(false);

	HShapeLayout shapeLayout = new HShapeLayout().target(hitObj);
	
	pool = new HDrawablePool(4000);
	pool.autoAddToStage()
		.add (new HRect())
		.colorist(new HColorPool(#2A77E8, #495DFF, #3BC4FF, #2AE8E8).fillOnly())
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
		.requestAll()
	;

	H.drawStage();
}

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

void keyPressed() {
	if (key == 's') {
		record = true;
		draw();
	}
}