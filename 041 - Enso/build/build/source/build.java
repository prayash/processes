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

// Processes - Day 34
// Prayash Thapa - February 3, 2016








boolean record = false;
boolean paused = true;
HDrawablePool pool;

// ************************************************************************************

public void setup() {
	
	H.init(this).background(0xff1C1C1C);
	HImage hitObj = new HImage("enso.png");
	H.add(hitObj).visibility(false);
	HShapeLayout shapeLayout = new HShapeLayout().target(hitObj);

	pool = new HDrawablePool(5200);
	pool.autoAddToStage()
		.add(new HShape("svg1.svg"))
		.colorist(new HColorPool(0xFF).fillOnly())
		.layout(shapeLayout)
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d
						.enableStyle(false)
						.noStroke()
						.strokeJoin(ROUND)
						.strokeCap(ROUND)
						.size( (int)random(1, 50) )
						.anchorAt(H.CENTER)
					;
				}
			}
		)
		.requestAll();

	H.drawStage();
}

// ************************************************************************************

public void draw() {
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

// ************************************************************************************

public void keyPressed() {
	if (key == 's') {
		record = true;
		draw();
	}
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
