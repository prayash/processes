// Processes - Day 1
// Prayash Thapa - January 1, 2016

import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;
import processing.pdf.*;

HShape d;
HColorPool colors;

// ************************************************************************************

void setup() {
	size(800, 800);
	H.init(this).background(#c7c6cb);
	colors = new HColorPool(#4473b9, #e79b43, #97ccda, #9a7b29, #27337f, #D44A4A);

	for (int i = 0; i < 19; i++){
		d = new HShape("uno.svg");
		d
			.strokeWeight(0)
			.rotation( (int)random(360) )
			.size( (int)random(500, 700) )
			.loc((int)random(width), (int)random(400, 600))
			.anchorAt(H.CENTER)
		;
		d.randomColors( colors.fillOnly() );
		H.add(d);
	}

	for (int i = 0; i < 15; i++){
		d = new HShape("dos.svg");
		d
			.strokeWeight(0)
			.rotation( (int)random(360) )
			.size( (int)random(200, 500) )
			.loc((int)random(width), (int)random(500, 700))
			.anchorAt(H.CENTER)
		;
		d.randomColors( colors.fillOnly() );
		H.add(d);
	}

	for (int i = 0; i < 18; i++){
		d = new HShape("tres.svg");
		d
			.strokeWeight(0)
			.rotation( (int)random(360) )
			.size( (int)random(400, 500) )
			.loc((int)random(width), (int)random(500, 700))
			.anchorAt(H.CENTER)
		;
		d.randomColors( colors.fillOnly() );
		H.add(d);
	}


	for (int i = 0; i < 18; i++){
		d = new HShape("cuatro.svg");
		d
			.strokeWeight(0)
			.rotation( (int)random(360) )
			.size( (int)random(200, 500) )
			.loc((int)random(width), (int)random(500, 700))
			.anchorAt(H.CENTER)
		;
		d.randomColors( colors.fillOnly() );
		H.add(d);
	}


	for (int i = 0; i < 18; i++){
		d = new HShape("cinco.svg");
		d
			.strokeWeight(0)
			.rotation( (int)random(360) )
			.size( (int)random(300, 500) )
			.loc((int)random(width), (int)random(500, 700))
			.anchorAt(H.CENTER)
		;
		d.randomColors( colors.fillOnly() );
		H.add(d);
	}


	for (int i = 0; i < 14; i++) {
		d = new HShape("seis.svg");
		d
			.strokeWeight(0)
			.rotation( random(360) )
			.size( random(400, 500) )
			.loc( random(width), random(500, 700) )
			.anchorAt(H.CENTER)
		;
		d.randomColors( colors.fillOnly() );
		H.add(d);
	}
}

// ************************************************************************************

void draw() {
	H.drawStage();
}

// ************************************************************************************

void keyPressed() {
	if (key == 's') {
		saveFrame();
	}
}
