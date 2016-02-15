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

// Processes - Day 43
// Prayash Thapa - February 12, 2016








boolean record = false;
boolean paused = true;
HDrawablePool pool;
HColorPool colors;

// ************************************************************************************

public void setup() {
	
	H.init(this).background(0xffFFFFFF);
	HImage hitObj = new HImage("P.png");
	H.add(hitObj).visibility(false);
	HShapeLayout shapeLayout = new HShapeLayout().target(hitObj);

	colors = new HColorPool(0xff1a86c7, 0xffb71c00, 0xfff5f428, 0xffaf3b22, 0xffcca292, 0xff1a86c7, 0xff8dcde8, 0xfff8c023);

	pool = new HDrawablePool(600);
	pool.autoAddToStage()
		.add(new HShape("smudge2.svg"))
		.add(new HShape("smudge5.svg"))
		.add(new HShape("smudge7.svg"))
		.colorist(new HColorPool(0xff1a86c7, 0xffb71c00, 0xfff5f428, 0xffaf3b22, 0xffcca292, 0xff1a86c7, 0xff8dcde8, 0xfff8c023).fillOnly())
		.layout(shapeLayout)
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d
						.enableStyle(false)
						.strokeJoin(ROUND)
						.strokeCap(ROUND)
						.noStroke()
						.size( (int)random(1, 55) )
						.anchorAt(H.CENTER)
						.rotation(180)
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
