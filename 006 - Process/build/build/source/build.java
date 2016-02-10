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

// Processes - Day 6
// Prayash Thapa - January 6, 2016








HDrawablePool circuitPool;
HColorPool colors;
boolean record = false;

// ************************************************************************************

public void setup() {
	
	H.init(this).background(0xffDC5978).autoClear(true);
	colors = new HColorPool(0xffECF0F1, 0xff7877f9, 0xff3498DB, 0xffffa446);

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

public void draw() {
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

public void keyPressed() {
	if (key == 's') {
		record = true;
		draw();
	}
}
  public void settings() { 	size(700, 350); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "build" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
