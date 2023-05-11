// Processes - Day 150
// Prayash Thapa - March 28, 2016

PVector[] grid;
walker[] W;

int gSize = 50;
float  c = random(1.5, 3);

boolean play = true;


// ************************************************************************************


void setup()
{
  size(800, 600);
  background(255);


  // create grid
  int tx = width/gSize + 2;
  int ty = height/gSize + 2;
  grid = new PVector[tx*ty];

  for (int i = 0; i < tx ; i++)
    for (int j = 0; j < ty; j++)
      grid[i + j*tx] = new PVector(i*gSize - gSize/2 + random(-0.2*gSize, 0.2*gSize), j*gSize - gSize/2 + random(-0.2*gSize, 0.2*gSize));


 // create walkers
 W = new walker[10];
 for (int i = 0; i < W.length; i++)
   W[i] = new walker(i%2 == 0 ? true : false);
}


// ************************************************************************************


void draw()
{
  if (!play) noLoop();

  for (walker w : W)
  {
    if (random(1) > 0.96) w.setDir(random(-PI, PI));  // change direction sometimes
    w.update();
    w.checkEdges();
    w.display(grid);
  }

}


/*------------------------------*/


void mouseClicked()  //restart with new colors
{
  background(255);  // clear background
  c = random(1.5, 3);  // set new colors
}


/*------------------------------*/


void keyPressed()
{
  if (key == 's' || key == 'S') saveFrame();  // save the scren
  if (key == 'p' || key == 'P') play = !play;  // pause/resume

  if (play) loop();
}


/*------------------------------*/


class walker
{
  PVector position, velocity, acceleration;
  boolean clr;
  int cMin, cMax;


  walker(boolean clr_)
  {
    // define the color
    clr = clr_;
    cMin = 80;
    cMax = 200;

    // initialize the position
    position = new PVector(0, 0, 0);

    // initialize the velocity
    velocity = new PVector(0, 0, 0);

    // initialize the acceleration
    acceleration = new PVector(random(-1,1), random(-1,1), 0);
    acceleration.normalize();
    acceleration.mult(0.5);
  }


  void update()
  {
    velocity.add(acceleration);
    velocity.limit(5);
    position.add(velocity);
  }


  color chooseColor()
  {
    float a, b;

    if (position.x < width/2)  a = map(position.x, 0, width/2, cMax, cMin);
    else  a = map(position.x, width/2, width, cMin, cMax);

    if (position.y < height/2)  b = map(position.y, 0, height/2, cMax, cMin);
    else  b = map(position.y, height/2, height, cMin, cMax);

    return color(a, (a+b)/c, b);
  }


  void display(PVector[] g)
  {
    stroke((clr ? chooseColor() : 255), random(50, 100));

    for (int i = 0; i < g.length; i++)
      if (dist(position.x, position.y, g[i].x, g[i].y) < gSize)
        line(position.x, position.y, g[i].x, g[i].y);
  }


  void setDir(float angle)  //change the direction
  {
    // direction of the acceleration is defined by the new angle
    acceleration.set(cos(angle), sin(angle), 0);
    // magnitude of the acceleration is proportional to the angle between acceleration and velocity
    acceleration.normalize();
    float dif = PVector.angleBetween(acceleration, velocity);
    dif = map(dif, 0, PI, 0.1, 0.001);
    acceleration.mult(dif);
  }


  void checkEdges()  // if it's out of the screen come back on the opposite edge
  {
    if (position.x < 0)  position.x = width;
    if (position.x > width)  position.x = 0;
    if (position.y < 0)  position.y = height;
    if (position.y > height)  position.y = 0;
  }
}
