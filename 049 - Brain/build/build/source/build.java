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

// Processes - Day 49
// Prayash Thapa - February 18, 2016







boolean record = false;

HDrawablePool pool;
HColorPool colors;
HShape s1;

// ************************************************************************************

public void setup() {
	
	H.init(this).background(0xffFFFFFF);

	HImage i1 = new HImage("brain.png");
	H.add(i1).visibility(false);
	HShapeLayout s1 = new HShapeLayout().target(i1);

	colors = new HColorPool(0xff482964,0xff563D66,0xff535E81,0xff495CC5,0xff4E72CA,0xff7A86AF,0xff7692D1,0xff8B9ECB,0xffA6B6D6);

	pool = new HDrawablePool(250);
	pool.autoAddToStage()
		.add(new HShape("circuit.svg"))
		.layout(s1)
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d
						.enableStyle(false)
						.strokeJoin(ROUND)
						.strokeCap(ROUND)
						.noStroke()
						.fill(colors.getColor(), 200)
						.anchorAt(H.CENTER)
						.rotate((int)random(0, 135))
						.size((int)random(5, 150))
					;
				}
			}
		).requestAll();

	pool = new HDrawablePool(30);
	pool.autoAddToStage()
		.add(new HShape("circuit.svg"))
		.layout(s1)
		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d
						.enableStyle(false)
						.strokeJoin(ROUND)
						.strokeCap(ROUND)
						.noStroke()
						.fill(colors.getColor(), 200)
						.anchorAt(H.CENTER)
						.rotate(45)
						.size( (int)random(5) * 100 )
					;
				}
			}
		).requestAll();

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
