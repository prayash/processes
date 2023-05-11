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

// Processes - Day 45
// Prayash Thapa - February 14, 2016

// ************************************************************************************







boolean record = false;
HShapeLayout shapeLayout;
HDrawablePool heartPool, flowerPool, particlePool;
HColorPool colors, colors2;

// ************************************************************************************

public void setup() {
	
	H.init(this).background(0xfffffee9).autoClear(true);

	HImage hitObj3 = new HImage("map.png");
	H.add(hitObj3).anchorAt(H.CENTER).locAt(H.CENTER).visibility(false);
	shapeLayout = new HShapeLayout().target(hitObj3);

  HImage hitObj5 = new HImage("Us.jpg");
	H.add(hitObj5).anchorAt(H.CENTER).locAt(H.CENTER).visibility(true);

	colors = new HColorPool()
		.add(0xffae2569, 8)
		.add(0xfff7bfdc, 9)
		.add(0xfffce8f3,2)
		.add(0xfff1cd81)
		.add(0xff91c5fb)
		.add(0xffe0e0e0, 3)
	;

	colors2 = new HColorPool()
		.add(0xfff1cd81)
		.add(0xffe0e0e0)
		.fillOnly()
	;

	H.clearStage();

	heartPool = new HDrawablePool(100); // Colorful flowers
	heartPool.autoAddToStage()
		.add (new HShape("svg1.svg"))
		.layout(shapeLayout)
		.colorist(colors)
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d
						.enableStyle(false).anchorAt(H.CENTER)
						.noStroke()
						.size((int)random(1, 10))
						.rotation(random(-90, 90))
					;
					d.randomColors(colors.fillOnly());
				}
			}
		).requestAll();

	particlePool = new HDrawablePool(50); // petals
	particlePool.autoAddToStage()
		.add (new HShape("Shape 6.svg").anchorAt(H.CENTER))
		.add (new HShape("Shape 7.svg").anchorAt(H.CENTER))
		.layout(shapeLayout)
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d
						.enableStyle(false)
						.noStroke()
						.size((int)random(10, 50))
						.rotation(random(360))
					;
					d.randomColors(colors.fillOnly());
				}
			}
		).requestAll();

	flowerPool = new HDrawablePool(50); // single petals
	flowerPool.autoAddToStage()
		.add (new HShape("Shape 6.svg").anchorAt(H.CENTER))
		.add (new HShape("flower4.svg").anchorAt(H.CENTER))
		.add (new HShape("flower2.svg").anchorAt(H.CENTER))
		.colorist(colors2)
		.layout(shapeLayout)
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d
						.noStroke()
						.rotation((int)random(360))
						.size((int)random(10, 75))
					;
					d.randomColors(colors.fillOnly());
				}
			}
		).requestAll();

  H.drawStage();
}

public void draw() { }

// ************************************************************************************

public void keyPressed() {
	if (key == 's' || key == 'S') {
		record = true;
		saveVector();
	}
}

public void saveVector() {
	PGraphics tmp = null;
	tmp = beginRecord(PDF, "render_#####.pdf");

	if (tmp == null) H.drawStage(); else H.stage().paintAll(tmp, false, 1); // PGraphics, uses3D, alpha

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
