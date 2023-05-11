import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class build extends PApplet {

int[][] result;
float t, c;

public float ease(float p) {
  return 3*p*p - 2*p*p*p;
}

public float ease(float p, float g) {
  if (p < 0.5f)
    return 0.5f * pow(2*p, g);
  else
    return 1 - 0.5f * pow(2*(1 - p), g);
}

float mn = .5f*sqrt(3), ia = atan(sqrt(.5f));

public void push() {
  pushMatrix();
  pushStyle();
}

public void pop() {
  popStyle();
  popMatrix();
}

public void draw() {

  if (!recording) {
    t = mouseX*1.0f/width;
    c = mouseY*1.0f/height;
    if (mousePressed)
      println(c);
    draw_();
  } else {
    for (int i=0; i<width*height; i++)
      for (int a=0; a<3; a++)
        result[i][a] = 0;

    c = 0;
    for (int sa=0; sa<samplesPerFrame; sa++) {
      t = map(frameCount-1 + sa*shutterAngle/samplesPerFrame, 0, numFrames, 0, 1);
      draw_();
      loadPixels();
      for (int i=0; i<pixels.length; i++) {
        result[i][0] += pixels[i] >> 16 & 0xff;
        result[i][1] += pixels[i] >> 8 & 0xff;
        result[i][2] += pixels[i] & 0xff;
      }
    }

    loadPixels();
    for (int i=0; i<pixels.length; i++)
      pixels[i] = 0xff << 24 |
        PApplet.parseInt(result[i][0]*1.0f/samplesPerFrame) << 16 |
        PApplet.parseInt(result[i][1]*1.0f/samplesPerFrame) << 8 |
        PApplet.parseInt(result[i][2]*1.0f/samplesPerFrame);
    updatePixels();

    saveFrame("fr###.gif");
    println(frameCount,"/",numFrames);
    if (frameCount==numFrames)
      exit();
  }
}

//////////////////////////////////////////////////////////////////////////////

int samplesPerFrame = 4;
int numFrames = 300;
float shutterAngle = 1.2f;

boolean recording = true;

OpenSimplexNoise noise;



int n = 9;

float EASE = 1.8f;

int m = 1500;

float R = 150;

public float r(float theta,int k){
  if(k==3){
    theta += PI/6;
  }
  return 1.1f*R*cos(PI/k)/cos(theta - TWO_PI/k * floor((k*theta + PI)/TWO_PI));
}

float RAD = 1.8f;

float MR = 0.8f;

float L = 30;

float SEED = 321;

float f = 1.0f;

float SW = 1.0f;

float alph = 40;

class Thing{
  float offset;
  int ind;

  Thing(int i){
    ind = i;
    offset = 0.01f*i/n;
  }

  public void show(){
    float tt = (100+t-offset)%1;

    stroke(255,alph);
    strokeWeight(SW);

    float x1,y1,x2,y2,p;

    float phi = 2*TWO_PI*t;

    for(int i=0;i<m;i++){
      float theta = TWO_PI*i/m;

      if(tt<1.0f/3){
        p = 3*tt;
        p = ease(p,EASE);

        x1 = r(theta,3)*cos(theta);
        y1 = r(theta,3)*sin(theta);
        x2 = r(theta,4)*cos(theta);
        y2 = r(theta,4)*sin(theta);
      } else if(tt<2.0f/3){
        p = 3*tt-1;
        p = ease(p,EASE);

        x1 = r(theta,4)*cos(theta);
        y1 = r(theta,4)*sin(theta);
        x2 = R*cos(theta);
        y2 = R*sin(theta);
      } else {
        p = 3*tt-2;
        p = ease(p,EASE);

        x1 = R*cos(theta);
        y1 = R*sin(theta);
        x2 = r(theta,3)*cos(theta);
        y2 = r(theta,3)*sin(theta);
      }

      float dx = L*(float)noise.eval(SEED+f*ind/n+RAD*cos(theta+phi),RAD*sin(theta+phi),MR*cos(TWO_PI*t),MR*sin(TWO_PI*t));
      float dy = L*(float)noise.eval(2*SEED+f*ind/n+RAD*cos(theta+phi),RAD*sin(theta+phi),MR*cos(TWO_PI*t),MR*sin(TWO_PI*t));

      float xx = lerp(x1,x2,p) + dx*(0.25f+sin(PI*p));
      float yy = lerp(y1,y2,p) + dy*(0.25f+sin(PI*p));

      point(xx,yy);
    }
  }
}

Thing[] array = new Thing[n];

public void setup(){
  
  result = new int[width*height][3];

  noise = new OpenSimplexNoise();

  for(int i=0;i<n;i++){
    array[i] = new Thing(i);
  }
}

public void draw_(){
  background(0);
  push();
  translate(width/2,height/2);

  for(int i=0;i<n;i++){
    array[i].show();
  }

  pop();
}
  public void settings() {  size(600,600,P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "build" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
