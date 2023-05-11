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

float cos30 = cos(PI / 6);
float sin30 = sin(PI / 6);


public void setup() {
  
  background(0);
  noStroke();

  randomSeed(hour()+ minute()+second());

  float side = height / 24;
  float x0 = 0;
  float y0 = height + side;
  float v = 67 - 0; //72
  float luck_step = 0.01f;
  float maxcnt = 10;
  float dif2 = 1;

  float dif = 0;

  int c = 13 + 35;

  float num = width / cos30 / side;
  int n = ceil(num) + 2+30;
  float[][] values = new float[(int) c][n];

  for (int i = 0; i < c; i++) {
    for (int j = 0; j < n; j++){
      values[i][j] = v;
    }
  }

  for (int i = 0; i < 1; i++){

    float cnt_j = 0;
    float luck = luck_step;

    for (int j = 0; j < n; j++){
      if (random(1) < luck || cnt_j >= maxcnt){
        luck = luck_step;
        cnt_j = 0;
        float rnd = random(1);
        float drop = (int) (rnd * rnd * dif) + 1;
        for (int i_n = i; i_n < c; i_n++){
          for (int j_n = j; j_n < n; j_n++){
            values[i_n][j_n] -= drop;
          }
        }
      } else {
        luck += luck_step;
        cnt_j += 1;
      }

    }
  }


  for (int i = 1; i < c; i++){

    float cnt_j = 0;
    float luck = luck_step;

    for (int j = 1; j < n; j++){
      if (random(1) < luck || cnt_j >= maxcnt){
        luck = luck_step;
        cnt_j = 0;
        float drop = 0;
        if (values[i - 1][j] - values[i][j] > dif2 || values[i][j-1] - values[i][j] > dif2){

        } else {
          float rnd = random(1);
          drop = (int) (rnd * rnd * dif) + 1;
          float aux = values[i][j] - drop;
          for (int i_n = i; i_n < c; i_n++){
            for (int j_n = j; j_n < n; j_n++){
              values[i_n][j_n] = min(values[i_n][j_n], aux);

            }
          }
        }
        println(j, "-", drop, "-", values[i - 1][j], "-", values[i][j]);
      } else {
        luck += luck_step;
        cnt_j += 1;
        println(j, "-", 0, "-", values[i - 1][j], "-", values[i][j]);
      }

    }
  }

  for (int i = 0; i < c; i++){
    for (int j = 0; j < n; j++){
      make_column(x0 + j * side * cos30 - i * side * cos30, y0 + side * sin30 * i, side, values[i][j] * side - side * sin30 * j);
    }
  }




}

public void draw() {

}

//saves frame
public void mouseClicked() {
  saveFrame("iso.png");
}


public void make_column(float x0, float y0, float side, float hd0){
  float x_aux = (side + 1) * cos30;
  float y_aux = (side + 1) * sin30;
  float hd = hd0 +1;
  fill(9, 69, 106);
  quad(x0, y0 - hd, x0 + x_aux, y0 - y_aux - hd, x0 + x_aux, y0 - y_aux, x0, y0);
  fill(245, 109, 87);
  quad(x0, y0 - hd, x0 - x_aux, y0 - y_aux - hd, x0 - x_aux, y0 - y_aux, x0, y0);
  fill(241, 245, 212);
  quad(x0, y0 - hd, x0 + x_aux, y0 - y_aux - hd, x0, y0 - y_aux * 2  - hd, x0 - x_aux, y0 - y_aux - hd);
}
  public void settings() {  size(1280, 800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "build" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
