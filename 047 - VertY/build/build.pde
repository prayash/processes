// Processes - Day 47
// Prayash Thapa - February 16, 2016

// ************************************************************************************

import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;
import processing.pdf.*;

boolean paused = false, record = false;
HDrawablePool pool, pool2, pool3;
HShapeLayout hsl, hsl2, hsl3;

HColorPool colors, colors2;
HPixelColorist pcolors;

// ************************************************************************************

void setup() {
	size(800, 800);
	H.init(this).background(#192033 ).autoClear(true);

	HEllipse hitObj = new HEllipse(400);
	H.add(hitObj).anchorAt(H.CENTER).locAt(H.CENTER).visibility(false);
	hsl=new HShapeLayout().target(hitObj);

	HEllipse hitObj2 = new HEllipse(350);
	H.add(hitObj2).anchorAt(H.CENTER).locAt(H.CENTER).visibility(false);
	hsl2=new HShapeLayout().target(hitObj2);

	// HImage hitObj2 = new HImage("cloudy.png");
	// H.add(hitObj2).anchorAt(H.CENTER).locAt(H.CENTER).size(1800).visibility(false).rotate(90);
	// hsl2 = new HShapeLayout().target(hitObj2);

	HImage hitObj3 = new HImage("hairlayout.png");
	H.add(hitObj3).anchorAt(H.CENTER).locAt(H.CENTER).size(1100).visibility(false);
	hsl3 = new HShapeLayout().target(hitObj3);

	// HImage hitObj4 = new HImage("cloudy3.png");
	// H.add(hitObj4).anchorAt(H.CENTER).locAt(H.CENTER).size(1000).visibility(false).rotate(180);
	// hsl4 = new HShapeLayout().target(hitObj4);

 // 	pcolors= new HPixelColorist("indajungle.jpg")
	// .fillOnly()
	// .strokeOnly()
	// .fillAndStroke()
	;

	colors = new HColorPool()
		.add(#ffff29,2) //yellow
		.add(#ffc206,6) //light orange
		.add(#ff8708,4) // dark orange
 		.add(#333399,4) //purple
		.add(#8561ff,2) //light purp
		.add(#00cccc,6) //teal
		.add(#ff58e0,2) //pink
		.add(#9f368b) //d pink
		.add(#dee7ff,12)
		.add(#455787,4)
		.add(#2f3b5c,4)
		.fillOnly()
	;

	colors2 = new HColorPool()
		.add(#ffffff)
		.add(#e7e7e7) //lightest
		// .add(#0A5282) // blue
		.add(#B5C6D7) //v.light blue
		.add(#333333,2)
		.add(#666666)
		.add(#111111,3)
		.fillOnly()
	;

	drawThings();

}

// ************************************************************************************

void draw() {
	H.drawStage();
}

// ************************************************************************************

void drawThings() {
	H.clearStage();

	pool3 = new HDrawablePool(250); //BG
	pool3.autoAddToStage()

		.add (new HShape("Shape 1.svg").anchorAt(H.CENTER))
		.add (new HShape("Shape 2.svg").anchorAt(H.CENTER))
		.add (new HShape("Shape 3.svg").anchorAt(H.CENTER))
		.add (new HShape("Shape 4.svg").anchorAt(H.CENTER))
		.add (new HShape("Shape 5.svg").anchorAt(H.CENTER))
		.add (new HShape("Shape 6.svg").anchorAt(H.CENTER))
		.add (new HShape("Shape 7.svg").anchorAt(H.CENTER))

		.colorist(colors2)
		.layout(hsl3)

		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d
						.enableStyle(false)
						.fill(#2f3b5c)
						// .strokeWeight(0.3)
						// .stroke(#444444)
						.noStroke()
						// .loc((int)random(width), (int)random(height) )
						.size((int)random(5,200))
						.rotation((int)random(0,360))
					;
					// pcolors.applyColor(d);
				}
			}
		).requestAll();

	pool = new HDrawablePool(200); //top shapes
	pool.autoAddToStage()

		.add (new HShape("Shape 1.svg").anchorAt(H.CENTER))
		.add (new HShape("Shape 2.svg").anchorAt(H.CENTER))
		.add (new HShape("Shape 3.svg").anchorAt(H.CENTER))
		.add (new HShape("Shape 4.svg").anchorAt(H.CENTER))
		.add (new HShape("Shape 5.svg").anchorAt(H.CENTER))
		.add (new HShape("Shape 6.svg").anchorAt(H.CENTER))
		.add (new HShape("Shape 7.svg").anchorAt(H.CENTER))

		.layout(hsl3)

		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d
						.anchorAt(H.CENTER)
						.noStroke()
						// .loc((int)random(width), (int)random(height) )
						.size((int)random(30,200))
						.rotation((int)random(0,360))
					;
					 d.randomColors(colors.fillOnly());

				}
			}
		).requestAll();

	pool2 = new HDrawablePool(20); // top camo
	pool2.autoAddToStage()
		.add (new HShape("Shape 1.svg").anchorAt(H.CENTER))
		.add (new HShape("Shape 2.svg").anchorAt(H.CENTER))
		.add (new HShape("Shape 3.svg").anchorAt(H.CENTER))
		.add (new HShape("Shape 4.svg").anchorAt(H.CENTER))
		.add (new HShape("Shape 5.svg").anchorAt(H.CENTER))
		.add (new HShape("Shape 6.svg").anchorAt(H.CENTER))
		.add (new HShape("Shape 7.svg").anchorAt(H.CENTER))

		.layout(hsl3)

		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d
						.anchorAt(H.CENTER)
						// .strokeWeight(0.5)
						// .stroke(#444444)
						.noStroke()
						.rotation((int)random(360))
						.size((int)random(150,600))
						// .loc((int)random(width),height/2)
					;
					d.randomColors(colors.fillOnly());
				}
			}
		).requestAll();
	H.drawStage();
}

void keyPressed() {
	if (key == ']') drawThings();
	if (key == 'r') {
		record = true;
		saveFrame("png/render_####.png");
		saveVector();
	}
}

void saveVector() {
	PGraphics tmp = null;
	tmp = beginRecord(PDF, "pdf/render_#####.pdf");
	if (tmp == null) H.drawStage(); else H.stage().paintAll(tmp, false, 1); // PGraphics, uses3D, alpha
	endRecord();
}
