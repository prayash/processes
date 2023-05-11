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

// Processes - Day 51
// Prayash Thapa - February 20, 2016








boolean record = false;
HDrawablePool pool3, pool4;
HShapeLayout hsl2, hsl3;

HColorPool colors, colors2;
HPixelColorist pcolors;

// ************************************************************************************

public void setup() {
	
	H.init(this).background(0xff1E1E1E).autoClear(true);

	HImage hitObj = new HImage("usb.png");
	H.add(hitObj).anchorAt(H.CENTER).locAt(H.CENTER).size(700).visibility(false);
	hsl2 = new HShapeLayout().target(hitObj);

	HImage hitObj_2 = new HImage("usb.png");
	H.add(hitObj_2).anchorAt(H.CENTER).locAt(H.CENTER).size(700).visibility(false);
	hsl3 = new HShapeLayout().target(hitObj_2);

 	pcolors = new HPixelColorist("sunrise.jpg").fillOnly();

	colors = new HColorPool()

		.add(0xff98C32F) //yellowish
		.add(0xff0A5282,2) // blue
 		.add(0xff2EECCB,4) //light teal
		.add(0xff1DFDAC,2) //teal
		.add(0xff53B517,6) //green
		.add(0xff0AAE2A,4) //b green
		.add(0xff00C1BA,8) //light blue
		.add(0xff004D37,4) //d. green
		// .add(#ffffff)
		.fillOnly()
	;

	colors2 = new HColorPool()
		.add(0xffffffff,2)
		.add(0xffe7e7e7,3) //lightest
		.add(0xff0A5282) // blue
		.add(0xffB5C6D7,2) //v.light blue
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
	pool4 = new HDrawablePool(350);
	pool4.autoAddToStage()
		.add (new HShape("smudge1.svg").anchorAt(H.CENTER))
		.add (new HShape("smudge2.svg").anchorAt(H.CENTER))
		.add (new HShape("smudge3.svg").anchorAt(H.CENTER))
		.add (new HShape("smudge4.svg").anchorAt(H.CENTER))
		.add (new HShape("smudge5.svg").anchorAt(H.CENTER),3)
		.add (new HShape("smudge6.svg").anchorAt(H.CENTER),2)
		.add (new HShape("smudge7.svg").anchorAt(H.CENTER))
		.add (new HShape("smudge8.svg").anchorAt(H.CENTER))
		.layout(hsl3)
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d
						.enableStyle(false)
						.anchorAt(H.CENTER)
						.noStroke()
						.rotation((int)random(360))
						.size((int)random(15, 60))
					;
					pcolors.applyColor(d);

				}
			}
		).requestAll();

	pool3 = new HDrawablePool(650);
	pool3.autoAddToStage()
		.add (new HShape("smudge1.svg").anchorAt(H.CENTER))
		.add (new HShape("smudge2.svg").anchorAt(H.CENTER))
		.add (new HShape("smudge3.svg").anchorAt(H.CENTER),2)
		.add (new HShape("smudge4.svg").anchorAt(H.CENTER),2)
		.add (new HShape("smudge5.svg").anchorAt(H.CENTER),2)
		.add (new HShape("smudge6.svg").anchorAt(H.CENTER))
		.add (new HShape("smudge7.svg").anchorAt(H.CENTER))
		.add (new HShape("smudge8.svg").anchorAt(H.CENTER))
		.layout(hsl2)
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d
						.enableStyle(false)
						.anchorAt(H.CENTER)
						.noStroke()
						.rotation((int)random(360))
						.size((int)random(10, 20))
					;
					pcolors.applyColor(d);

				}
			}
		).requestAll();
	H.drawStage();
}

// ************************************************************************************

public void keyPressed() {
	if (key == ']') drawThings();
	if (key == 'r') {
		record = true;
		saveVector();
	}
}

public void saveVector() {
	PGraphics tmp = null;
	tmp = beginRecord(PDF, "render_#####.pdf");

	if (tmp == null) {
		H.drawStage();
	} else {
		H.stage().paintAll(tmp, false, 1); // PGraphics, uses3D, alpha
	}

	endRecord();
}
  public void settings() { 	size(700, 700); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "build" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
