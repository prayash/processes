import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import hype.*; 
import hype.extended.behavior.*; 
import hype.extended.colorist.*; 
import hype.extended.layout.*; 
import hype.interfaces.*; 
import processing.pdf.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class build extends PApplet {

// Processes - Day 47
// Prayash Thapa - February 16, 2016

// ************************************************************************************








boolean paused = false;
boolean record = false;

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

// ************************************************************************************

public void setup() {
	
	H.init(this).background(0xff192033 ).autoClear(true);

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

		.add(0xffffff29,2) //yellow
		.add(0xffffc206,6) //light orange
		.add(0xffff8708,4) // dark orange
 		.add(0xff333399,4) //purple
		.add(0xff8561ff,2) //light purp
		.add(0xff00cccc,6) //teal
		.add(0xffff58e0,2) //pink
		.add(0xff9f368b) //d pink
		.add(0xffdee7ff,12)
		.add(0xff455787,4)
		.add(0xff2f3b5c,4)
		.fillOnly()
	;

	colors2 = new HColorPool()
		.add(0xffffffff)
		.add(0xffe7e7e7) //lightest
		// .add(#0A5282) // blue
		.add(0xffB5C6D7) //v.light blue
		.add(0xff333333,2)
		.add(0xff666666)
		.add(0xff111111,3)
		.fillOnly()
	;

	drawThings();

}

// ************************************************************************************

public void draw() {

}

// ************************************************************************************

public void drawThings() {
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
						.fill(0xff2f3b5c)
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
		)

	.requestAll();

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
						// .fill( colors2.getColor())
						// .fill(#05191e)
						// .strokeJoin(ROUND)
						// .strokeCap(ROUND)
						// .strokeWeight(0.5)
						// .stroke(#444444)
						.noStroke()
						// .loc((int)random(width), (int)random(height) )
						.size((int)random(30,200))
						.rotation((int)random(0,360))
					;
					 d.randomColors(colors.fillOnly());

				}
			}
		)
	.requestAll();

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
		)

	.requestAll();
	H.drawStage();

}


// +        = redraw() advances 1 iteration
// r        = render to PDF
// c        = recolor

public void keyPressed() {
	if (key == ']') drawThings();

	if (key == 'r') {
		record = true;
		saveFrame("png/render_####.png");
		saveVector();
		H.drawStage();
	}

	// H.drawStage();
}

public void saveVector() {
	PGraphics tmp = null;
	tmp = beginRecord(PDF, "pdf/render_#####.pdf");
	if (tmp == null) H.drawStage(); else H.stage().paintAll(tmp, false, 1); // PGraphics, uses3D, alpha
	endRecord();
}
  public void settings() { 	size(800, 800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "build" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
