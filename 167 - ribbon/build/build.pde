boolean TESTING = false;
int ribbonAmount = 1;
int ribbonParticleAmount = 20;
float randomness = .2;
RibbonManager ribbonManager;

void setup() {
  size(900, 650);
  frameRate(30);
  background(0);
  ribbonManager = new RibbonManager(ribbonAmount, ribbonParticleAmount, randomness, "rothko_01.jpg");    // field, rothko_01-02, absImp_01-03 picasso_01
  ribbonManager.setRadiusMax(12);                 // default = 8
  ribbonManager.setRadiusDivide(10);              // default = 10
  ribbonManager.setGravity(.07);                   // default = .03
  ribbonManager.setFriction(1.1);                  // default = 1.1
  ribbonManager.setMaxDistance(40);               // default = 40
  ribbonManager.setDrag(2.5);                      // default = 2
  ribbonManager.setDragFlare(.015);                 // default = .008
}

void draw() {
  fill(0, 255);
  rect(0, 0, width, height);
  ribbonManager.update(mouseX, mouseY);
}
