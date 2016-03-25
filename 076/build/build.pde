// Processes - Day 76
// Prayash Thapa - March 16, 2016

import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;


HDrawablePool pool;
HDrawablePool pool2;
HDrawablePool pool3;
HDrawablePool pool4;
HDrawablePool pool5;

HShapeLayout hsl;
HShapeLayout hsl2;
HShapeLayout hsl3;
HShapeLayout hsl4;

HTimer timer;
HColorPool colors;
HColorPool colors2;

HPixelColorist pcolors;

void setup() {
	size(800, 800);
	H.init(this).background(#FFFFFF).autoClear(true);

	HEllipse hitObj = new HEllipse(400);
	H.add(hitObj).anchorAt(H.CENTER).locAt(H.CENTER).visibility(false);
	hsl=new HShapeLayout().target(hitObj);

	HEllipse hitObj2 = new HEllipse(350);
	H.add(hitObj2).anchorAt(H.CENTER).locAt(H.CENTER).visibility(false);
	hsl2=new HShapeLayout().target(hitObj2);

	HImage hitObj3 = new HImage("wavy.png");
	H.add(hitObj3).anchorAt(H.CENTER).locAt(H.CENTER).size(1100).visibility(false);
	hsl3 = new HShapeLayout().target(hitObj3);

	HImage hitObj4 = new HImage("jellies.png");
	H.add(hitObj4).anchorAt(H.CENTER).locAt(H.CENTER).size(1000).visibility(false).rotate(180);
	hsl4 = new HShapeLayout().target(hitObj4);
	colors = new HColorPool()

		.add(#e4ffb2,5) //yellow
		.add(#ff9000,5) //light orange
		.add(#ff5800,2) // dark orange
 		.add(#1c0d68,3) //purple
		.add(#5001be,2) //light purp
		.add(#02fcfa,7) //teal
		.add(#fe39a2,6) //pink
		.add(#7bfc88,7) //green
		// .add(#dee7ff,12)
		.add(#c7f6fe,2)
		.add(#2f3b5c,2)
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

void draw() {

}

void drawThings() {

	H.clearStage();

	pool3 = new HDrawablePool(40); //BG
	pool3.autoAddToStage()
		.add (new HShape("grid1.svg").anchorAt(H.CENTER),3)
		.add (new HShape("grid1.svg").anchorAt(H.CENTER),2)
		.add (new HShape("grid2.svg").anchorAt(H.CENTER))
		.add (new HShape("grid1.svg").anchorAt(H.CENTER),3)
		.add (new HShape("grid2.svg").anchorAt(H.CENTER),2)

		.colorist(colors2)
		.layout(hsl)

		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d

						// .fill( colors2.getColor())
						.enableStyle(false)
						.fill(#0b052b, 25)
						// .strokeWeight(0.3)
						// .stroke(#444444)
						.noStroke()
						// .loc((int)random(width), (int)random(height) )
						.size((int)random(200,500))
						// .rotation((int)random(0,360))
					;
					// pcolors.applyColor(d);

				}
			}
		)

	.requestAll()
	;

	pool2 = new HDrawablePool(4); // top camo
	pool2.autoAddToStage()

		.add (new HShape("grid2.svg").anchorAt(H.CENTER))


		.layout(hsl2)

		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d
						.anchorAt(H.CENTER)
						.strokeWeight(0.3)
						.stroke(#010103)
						// .noStroke()
						.rotation((int)random(360))
						.size((int)random(300,600))
						// .loc((int)random(width),height/2)
					;
					d.randomColors(colors.fillOnly());

				}
			}
		)

	.requestAll()
	;

	pool = new HDrawablePool(70); //top shapes
	pool.autoAddToStage()

		.add (new HShape("grid2.svg").anchorAt(H.CENTER),3)
		.add (new HShape("grid1.svg").anchorAt(H.CENTER),4)
		.add (new HShape("grid2.svg").anchorAt(H.CENTER),2)
		.add (new HShape("grid1.svg").anchorAt(H.CENTER))
		.add (new HShape("grid2.svg").anchorAt(H.CENTER),3)
		.add (new HShape("grid1.svg").anchorAt(H.CENTER),2)

		.layout(hsl3)

		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d


						.anchorAt(H.CENTER)
						// .fill( colors2.getColor())
						// .fill(#05191e)
						.strokeJoin(ROUND)
						.strokeCap(ROUND)
						.strokeWeight(0.5)
						.stroke(#010103)
						// .noStroke()
						// .loc((int)random(width), (int)random(height) )
						.size((int)random(100,250))
						.rotation((int)random(0,360))
					;
					 d.randomColors(colors.fillOnly());

				}
			}
		).requestAll();

	H.drawStage();
}


void keyPressed() {
	if (key == '+') drawThings();
	if (key == 'r') saveFrame("render_####.png");

	if (key == 'b') filter(BLUR, 1);
  if (key == 'e') filter(ERODE);
  if (key == 'd') filter(DILATE);
}
