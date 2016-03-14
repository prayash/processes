// Processes - Day 65
// Prayash Thapa - March 5, 2016

import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;
import processing.pdf.*;

HDrawablePool pool;
HColorPool colors;
HShape d;
boolean record = false;

// ************************************************************************************

void setup() {
	size(400, 500);
	H.init(this).background(#1E1E1E);
	H.clearStage();

	colors = new HColorPool(#003366,#663333,#663366,#993333,#006633,#006666,#336699,#666666,#CC6633,#CC6666,#339966,#009999,#669999,#6699CC,#FF6666,#999999,#CC9999,#FF9966,#FF9999,#99CC99,#99CCCC,#CCCCCC,#FFCC66,#FFCCCC,#FFFFCC,#FFFFFF);

	pool = new HDrawablePool(100);
	pool.autoAddToStage()
		.add(new HShape("lines.svg"))
		.add(new HShape("area.svg"))
		.layout(
			new HHexLayout()
			.spacing(100)
			.offsetX(0)
			.offsetY(0)
		)
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d
						.enableStyle(false)
						.noStroke()
						.anchorAt(H.CENTER)
						.alpha(50)
						.stroke(#ffffff)
						.size( (int)random(300,800) )
						//.rotate( (int)random(10,90) )
						.rotate(45)
					;
					d.randomColors(colors.fillOnly());
				}
			}
		).requestAll();

	H.drawStage();
}

// ************************************************************************************

void draw() {
	PGraphics tmp = null;

	if (record) {
		tmp = beginRecord(PDF, "render-2-######.pdf");
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
	if (key == 's') record = true;
	if (key == ']') setup();
}
