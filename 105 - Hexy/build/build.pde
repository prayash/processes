// Processes - Day 105
// Prayash Thapa - April 14, 2016

HDrawablePool hexPool;
HColorPool palette;
HHexLayout hexLayout;
int polyDeg = 3;

// ************************************************************************************

void setup() {
	size(640, 640, P3D);
	frameRate(30);
	H.init(this).background(#FFFFFF).use3D(true).autoClear(true);
	hexLayout = new HHexLayout()
		.spacing(20)
		.offsetX(25)
		.offsetY(0)
	;

	palette = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095A8, #00616f, #FF3300, #FF6600);

	hexPool = new HDrawablePool(255);
	hexPool.autoAddToStage()
		.add( new HPath() )
		.layout(hexLayout)
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					int i = hexPool.currentIndex();
					HPath d = (HPath) obj;
					d
						.polygon(polyDeg)
						.size(48, 24)
						.anchorAt(H.CENTER)
						.noStroke()
						.fill(palette.getColor(i * 120), 155)
					;

					new HOscillator()
						.target(d)
						.property(H.SIZE)
						.range(100 , -200)
						.waveform(H.SINE)
						.freq(1)
						.speed(1)
						.currentStep( i )
					;
				}
			}
		).requestAll();
}

// ************************************************************************************

void draw() {
	H.drawStage();
	// if (frameCount % 6 == 0 && frameCount < 181) saveFrame("_###.gif");
 }
