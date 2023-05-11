//mouseX controls the scale of the second noise funtion

FlowField flowfield;

ArrayList<Vehicle> vehicles;

boolean save = false;
boolean fade = true;

void setup(){
  size(700,700,P3D);
  background(35);
  colorMode(HSB);
  flowfield = new FlowField(4);
  vehicles = new ArrayList<Vehicle>();
  // Make a whole bunch of vehicles with random maxspeed and maxforce values
  for (int i = 0; i < 40000; i++) {
    vehicles.add(new Vehicle(new PVector(random(width),random(width)), random(.5, 3), random(.1, 40)));
  }
}

void draw(){
  if(fade) fade();
  else background(35);
  
  flowfield.init();
  
  for (Vehicle v : vehicles){
    //v.separate(2,5);
    v.follow(flowfield);
    //v.pull();
    v.run();
  }
  
  if(frameCount%10 == 0)println(frameCount);
  if(save){
    saveFrame("noiseflow/nField_####.png"); 
  }
}
  
void keyPressed(){
  if(key == 'ö') fade = !fade;
  if(key == 'ó') save = !save;
}

void fade(){
  noStroke();
  fill(20,15);
  rect(0,0,width,height);
}



class FlowField{
  
  PVector[][] field;
  int cols, rows; 
  int resolution; 
  float time=0;
  float fScl=.1;
  float fSpd=.0015;
  float nScl=.03;
  float noise,noiseSm,theta,smlScl;
  float xoff,yoff;

  FlowField(int r){
    resolution = r;
    
    cols = width/resolution+1;
    rows = height/resolution+1;
    field = new PVector[cols][rows];
  }

  void init(){
    smlScl = map(mouseX,0,width,15,45);
    xoff = -8.7;
    for (int i = 0; i < cols; i++){
      yoff = -8.7;
      for (int j = 0; j < rows; j++){
        noise = map(noise(xoff*nScl,yoff*nScl,time),0,1,-TWO_PI,TWO_PI);
        noiseSm = map(noise(xoff*nScl*smlScl,yoff*nScl*smlScl,time+1000),0,1,-TWO_PI,TWO_PI);
        
        //theta = (xoff*sin(yoff) + yoff*sin(xoff)) + noise;
        //theta = (xoff*sin(yoff)%yoff*cos(xoff)) + (yoff*cos(xoff)%xoff*sin(yoff)) + time + noise;
        //theta = (noise + noiseSm)/2;
        //theta = (noise*sin(noiseSm) + noiseSm*cos(noise));
        theta = (noise*sin(noiseSm) % noiseSm*cos(noise));
      

        field[i][j] = new PVector(cos(theta),sin(theta));
        field[i][j].rotate(noise);
        
        yoff += fScl;
      }
      xoff += fScl;
    }
    time += fSpd;
  }

  PVector lookup(PVector lookup){
    int column = int(constrain(lookup.x/resolution,0,cols-1));
    int row = int(constrain(lookup.y/resolution,0,rows-1));
    return field[column][row];
  }
}



class Vehicle {

  PVector position;
  PVector velocity = new PVector(random(-5,5),random(-5,5));
  PVector acceleration = new PVector(0,0);;
  float maxforce;    
  float maxspeed;   
  float a=0;
  float str = 1;
  float clr;
    
    // constructor
    Vehicle(PVector l, float ms, float mf) {
    position = l;
    
    maxspeed = ms;
    maxforce = mf;
    a = velocity.mag()*5;
  }

  void run() {
    update();
    borders();
    display();
  }
  
  //separation method
  void separate(float l,float m){
    for(Vehicle other : vehicles){
    float d = PVector.dist(position,other.position);
    float lim = l;
    float mag = m;
      if(d < lim && d>0){
        PVector sep = PVector.sub(other.position,position);
        float sepMag = map(d,0,lim,mag,0);
        sep.setMag(sepMag);
        
        acceleration.sub(sep);
      }
    }
  }
  
  //follow vector field
  void follow(FlowField flow) {
    PVector desired = flow.lookup(position);
    desired.mult(maxspeed);
    
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce); 
    applyForce(steer);
  }
  
  // force pointing to the center
  void pull(){
    PVector cntr = new PVector(width/2,width/2);
    PVector pull = PVector.sub(cntr,position);
    float pMag = map(PVector.dist(position,cntr),0,350,0,5);
    pull.setMag(pMag);
    applyForce(pull);
  }
  
  void applyForce(PVector force) {
    acceleration.add(force);
  }

  // update position
  void update() {
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    position.add(velocity);
    
    acceleration.mult(0);
  }
  
  // draw
  void display() {
    if(str<2) str+=.02;
    clr = map(velocity.heading(),-PI,PI,0,255);
    strokeWeight(str);
    stroke(clr,140,255,a*2);
    point(position.x,position.y);
  }

  // Wraparound
  void borders() {
    if (position.x < 0) position.x = width; 
    if (position.y < 0) position.y = height; 
    if (position.x > width) position.x = 0; 
    if (position.y > height) position.y = 0;
  }
}