walker[] w;
int mode = 2;

/*-----------------------*/


void setup() {
  size(1000, 1000);
  colorMode(HSB, 360, 100, 100);
  background(0);

  //create each walker;
  float newH = random(360);
  w = new walker[100];
  for (int i = 0; i < w.length; i++)  {   w[i] = new walker(newH);  }
}


/*-----------------------*/


void draw() {
  for (int i = 0; i < w.length; i++)
  {
    //move walkers
    if (random(1) > 0.96) w[i].setDir(random(-PI, PI));  //change direction sometimes
    w[i].update();
    w[i].checkEdges();

    //display according to the mode chosen
    if (mode == 1) w[i].display1();
    else for (int j = (i + 1); j < w.length; j++)  w[i].display2(w[j]);
  }

  //black circle
  noStroke();
  fill(0);
  ellipse(width/2, height/2, 200, 200);

  //stop after 500 frames
  if (frameCount % 500 == 0) noLoop();
}


/*-----------------------*/


void mousePressed()  //set a new hue and clean the background
{
  //choose mode
  if (mouseButton == LEFT) mode = 2;
  else if(mouseButton == RIGHT) mode = 1;

  //prepare to draw new image
  float newH = random(360);  //choose new color
  for (walker W : w)
  {
    W.h = newH;  //apply new color
    W.restart();  //restart positons
  }
  background(0);  //clean background

  //restart drawing
  frameCount = 0;
  loop();
}


/*-----------------------*/


class walker
{
  PVector oldP, newP; //old and new positions
  PVector velocity, acceleration;
  float h, s, b;  //components of the color


  walker(float h_)
  {
    //define the color
    h = h_;
    s = random(20, 100);
    b = random(20,100);

    //initialize the position
    oldP = newP = new PVector(width/2, height/2, 0);

    //initialize the velocity
    velocity = new PVector(0, 0, 0);

    //initialize the acceleration
    acceleration = new PVector(random(-1,1), random(-1,1), 0);
    acceleration.normalize();
    acceleration.mult(0.5);
  }


  void setDir(float angle)  //change direction
  {
    //direction of the acceleration is defined by the new angle
    acceleration.set(cos(angle), sin(angle), 0);

    //magnitude of the acceleration is proportional to the angle between acceleration and velocity
    acceleration.normalize();
    float dif = PVector.angleBetween(acceleration, velocity);
    dif = map(dif, 0, PI, 0.1, 0.001);
    acceleration.mult(dif);
  }


  void update()  //update position
  {
    oldP = newP;
    velocity.add(acceleration);
    velocity.limit(1.5);
    newP = PVector.add(oldP, velocity);
  }


  void configDisplay(int maxAlfa)  //set colors to display
  {
    float alfa = dist(newP.x, newP.y, width/2, height/2);
    alfa = map(alfa, 0, width/2, maxAlfa, 0);
    strokeWeight(1);
    stroke(h, s, b, alfa);
  }


  void display1()  //display as lines
  {
    configDisplay(127);
    line(oldP.x, oldP.y, newP.x, newP.y);
  }


  void display2(walker W)  //display as "flames"
  {
    configDisplay(25);
    if ( dist(newP.x, newP.y, W.newP.x, W.newP.y) < 25)
      line(newP.x, newP.y, W.newP.x, W.newP.y);
  }


  void checkEdges()  //if it's out of the circle restart positions
  {
    if (dist(width/2, height/2, newP.x, newP.y) > (width/2 + random(100)))  restart();
  }


  void restart()  //go back to the center of the image
  {
    newP.x = oldP.x = width/2;
    newP.y = oldP.y = height/2;
  }

}
