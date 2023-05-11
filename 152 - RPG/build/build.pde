Gui gui;  // interaction
Example ex;  //display
int[] lim = {0, 255, 0, 255, 0, 255};  //color limits


/*===========================*/


void setup() {
  size(800, 600);

  //create elements
  gui = new Gui(width - 370, height - 150);
  ex = new Example(25, 15, 744, 434);
}


/*===========================*/


void draw() {
  background(255);

  gui.update(mouseX, mouseY);

  gui.display();
  ex.display();
  displayTitle();

  ex.dropper(mouseX, mouseY);
}


/*===========================*/


void mousePressed() {
  gui.interact(mouseX, mouseY);
  ex.reload(mouseX, mouseY, lim);
}


/*===========================*/


void mouseReleased() {
  gui.stopInteraction();
}


/*===========================*/


void displayTitle() {
  textAlign(LEFT);
  fill(140);

  textSize(30);
  text("RPG", 25, 540);

  textSize(12);
  String txt = "color(random(" + lim[0] + ", " +lim[1] + "),  random(" + lim[2] + ", " + lim[3] + "), random(" + lim[4] + ", " + lim[5] + "));";
  text(txt, 25, 565);
}


/*===========================*/


class Button {

  String label;  // text written in the button
  int x, y;  // position
  int w, h;  // dimension
  int rad;  // corner radius
  boolean clicked, rolled;  // booleans used to verify if the mouse is over the button and if it's clicked

  /*----------*/

  Button(String label_, int x_, int y_, int w_, int h_) {
    label = label_;

    x = x_;
    y = y_;

    w = w_;
    h = h_;

    rad = 10;

    clicked = false;
    rolled = false;
  }

  /*----------*/

  void click(int mx, int my) {
    if(mx > x &&  my > y && mx < x + w && my < y + h)  clicked = true;
  }

  /*----------*/

  void rollover(int mx, int my) {
    if (mx > x &&  my > y && mx < x + w && my < y + h)  rolled = true;
    else rolled = false;
  }

  /*----------*/

  void release(Slider[] s, Example ex, int[] l) {
    if (clicked) act(s, ex, l);
    clicked = false;
  }

  /*----------*/

  void act(Slider[] s, Example ex, int[] l) {
    if (label == "Random") {
      for (int i = 0; i < l.length; i += 2) {
        float a = 0, b = 0;
         while (abs(a-b) < 20) {  //limit mininum range
           a = random(255);
           b = random(255);
         }

        l[i] = (int)min(a, b);
        l[i+1] = (int)max(a, b);
        s[i/2].updateButton(l[i], l[i+1]);
      }
    } else if (label == "Run") {
      for (int i = 0; i < l.length; i += 2) {
        l[i] = s[i/2].min;
        l[i+1] = s[i/2].max;
      }
    }

    ex.update(l);
  }

  /*----------*/

  void display() {
    noStroke();

    if (clicked)  fill(200);
    else if (rolled)  fill(165);
    else  fill(150);
    rect(x, y, w, h, rad);

    fill(255);
    textAlign(CENTER, CENTER);
    text(label, x, y - 2, w, h);
  }

}


/*===========================*/


class Example {
  PGraphics pg;
  int x, y;
  Truchet t;

  /*----------*/

  Example(int x_, int y_, int w, int h) {
    pg = createGraphics(w, h);

    x = x_;
    y = y_;

    t = new Truchet(31, w, h);

    update(lim);
  }

  /*----------*/

  void reload(int mx, int my, int[]l) {
    boolean testX = mx >= x && mx < pg.width + x;
    boolean testY = my >= y && my < pg.height + y;

    if (testX && testY) {
      update(l);
    }
  }

  /*----------*/

  void update(int[] l) {
    t.configTile(l);
    t.drawTruchet(pg);
  }

  /*----------*/

  void display() {
    image(pg, x, y);
  }

  /*----------*/

  void dropper(int mx, int my) {  //show the color when the mouse is over it
    boolean testX = mx >= x && mx < pg.width + x;
    boolean testY = my >= y && my < pg.height + y;

    if(testX && testY) {
      color c = get(mx, my);
      fill(c);

      if (c != -1)  {  // show the color only if it's not white
        String txt = "  color(" + nfc(c >> 16 & 0xFF) + ", " + nfc(c >> 8 & 0xFF) + ", " + nfc(c & 0xFF) + ")  ";

        int tx = mx;
        if (mx + textWidth(txt) > width) tx = mx - (int)textWidth(txt);

        stroke(140);
        fill(255, 220);
        rect(tx, my - 14, textWidth(txt), 20);

        fill(140);
        text(txt, tx, my);
      }

    }
  }

}


/*===========================*/


class Gui {

  Slider[] sColor;  // sliders
  Button[] btn;  // buttons

  /*----------*/

  Gui(int x, int y) {

    sColor = new Slider[3];
    sColor[0] = new Slider(x + 50, y + 25, 0, 255, color(196, 38, 38), color(219, 60, 60));  // red slider
    sColor[1] = new Slider(x + 50, y + 50, 0, 255, color(137, 206, 10), color(153, 216, 28));  // green slider
    sColor[2] = new Slider(x + 50, y + 75, 0, 255, color(39, 137, 255), color(52, 165, 255));  // blue slider

    btn = new Button[2];
    btn[0] = new Button("Random", x + 115, y + 100, 90, 20);  // random button
    btn[1] = new Button("Run", x + 215, y + 100, 90, 20);  // run button

  }

  /*----------*/

  void display() {
    for (int i = 0; i < sColor.length; i++)  sColor[i].display();
    for (int i = 0; i < btn.length; i++)  btn[i].display();
  }

  /*----------*/

  void update(int mx, int my) {
    for (int i = 0; i < sColor.length; i++)  {
      sColor[i].drag(mx);
      sColor[i].rollover(mx, my);
    }
    for (int i = 0; i < btn.length; i++)  btn[i].rollover(mx, my);
  }

  /*----------*/

  void interact(int mx, int my) {
    for (int i = 0; i < sColor.length; i++)  sColor[i].click(mx, my);
    for (int i = 0; i < btn.length; i++) btn[i].click(mx, my);

  }

  /*----------*/

  void stopInteraction() {
    for (int i = 0; i < sColor.length; i++)  sColor[i].release();
    for (int i = 0; i < btn.length; i++)  btn[i].release(sColor, ex, lim);
  }

}


/*===========================*/


class Slider {

  int x, y;  // position of the upper-left corner of the slider
  int w, h;  // width and height fo the slider
  int min, max;  // position of the buttons
  color c1, c2;  // color of the colored part (between min and max)
  SButton[] limit;  // buttons usd to ajust min and max
  boolean rolled, clicked;  // booleans used to verify if the mouse is over the button and if it's clicked
  int px;  // variable that saves the position of the mouse when clicked, used to drag the bar

  /*----------*/

  Slider(int x_, int y_,  int min_, int max_, color c1_, color c2_) {
    x = x_;
    y = y_;

    px = 0;

    w = 255;
    h = 10;

    max = max_;
    min = min_;

    c1 = c1_;
    c2 = c2_;

    limit = new SButton[2];
    limit[0] = new SButton(min, h/2);
    limit[1] = new SButton(max, h/2);

    rolled = false;
    clicked = false;
  }

  /*----------*/

  void rollover(int mx, int my) {
    boolean testX = mx > x + min + h && mx < x + max - h;
    boolean testY = my > y && my < y + h;
    if (testX && testY) rolled = true;
    else rolled = false;
  }

  /*----------*/

  void click(int mx, int my) {
    //click on the buttons of the bar
    for (int i = 0; i < limit.length; i++) limit[i].click(mx - x, my - y);

    //click on the colored part of the bar
    boolean testX = mx > x + min + h && mx < x + max - h;
    boolean testY = my > y && my < y + h;
    if (testX && testY) {
      clicked = true;
      px = mx;
    }
  }

  /*----------*/

  void drag(int mx) {
    if (clicked) {  //drag buttons together
        int nMin = (min + mx - px);
        int nMax = (max + mx - px);
        if (nMin >= 0 && nMax <= 255) updateButton(nMin, nMax);
        px = mx;
    } else {  //drag buttons separately
      min = limit[0].drag(mx - x, max);
      max = limit[1].drag(mx - x, min);
    }
  }

  /*----------*/

  void release() {
    for (int i = 0; i < limit.length; i++) limit[i].release();
    clicked = false;
  }

  /*----------*/

  void updateButton(int nMin, int nMax) {
    min = nMin;
    limit[0].change(min);

    max = nMax;
    limit[1].change(max);
  }

  /*----------*/

  void display() {
    pushMatrix();
    translate(x, y);

    // draw bar
    noStroke();
    fill(130);
    rect(0, 0, w, h);

    // draw colored bar between min and max:
    pushStyle();
    if (rolled || clicked) fill(c2);
    else fill(c1);
    rect(min, 0, max - min, h);
    popStyle();

    // draw buttons
    for (int i = 0; i < limit.length; i++) limit[i].display();

    //write values
    fill(c1);
    textAlign(CENTER, CENTER);
    text(min, -3*h, 2);
    text(max, w + 3*h, 2);

    popMatrix();
  }

}


/*===========================*/


class SButton {

  int x, y;  // center of the button
  int dx;  //displacement used when dragging the button
  boolean clicked;  //boolean used to verify if the mouse is clicked when dragging the button

  /*----------*/

  SButton(int x_, int y_) {
    x = x_;
    y = y_;

    dx = 0;
    clicked = false;
  }

  /*----------*/

  void display() {
    //semi-transparent circle around the button
    fill(0, 20);
    ellipse(x, y, 4*y, 4*y);

    //button
    if (clicked) fill(250);  //button becomes lighter when dragged
    else fill(240);
    ellipse(x, y, 2*y, 2*y);
  }

  /*----------*/

  void click(int mx, int my) {  //verify if the mouse is inside the button when the mouse is clicked
    if(dist(mx, my, x, y) < 2*y) {
      clicked = true;
      dx = (mx - x);
    }
  }

  /*----------*/

  int drag(int mx, int other) {
    // set limits (border and the other button)
    int l0 = 0, l1= 255;
    if (x >= other + 4*y) {  l0 = other + 4*y;   l1 = 255;  }
    else if (x <= other - 4*y)  {  l0 = 0;  l1 = other - 4*y;  }

    if (clicked)  x = mx + dx;  // update position
    x = constrain(x, l0, l1);  // constrain position to the limits

    return x;
  }

  /*----------*/

  void release() {
    clicked = false;
  }

  /*----------*/

  void change(int value) {  // change x value when random buttom is used
    x = value;
  }

}


/*===========================*/


class Truchet {

  int tsize;  // tile size
  int[][] c, r;  // matrices of information for circles and rectangles
  color[] col;  // list of colors
  int k;  //index of the tile on the list of colors

  /*----------*/

  Truchet(int tsize_, int w, int h) {
    tsize = tsize_;

    c = new int[w/tsize][h/tsize];
    r = new int[w/tsize][h/tsize];

    col = new color[100];
    k = 0;
  }

  /*----------*/

  void configTile(int[] lim) {
    //create information matrices
    for (int i = 0; i < r.length; i++) {
      for (int j = 0; j < r[0].length; j++) {

        //create rectangles
        if (random(1) > 0.65)  r[i][j] = -1;
        else r[i][j] = 0;

        //create circles
        if ((i+j)%2 == 0)  c[i][j] = -1;
        else c[i][j] = 0;
      }
    }

    /*----------*/

    //clean edges (male the rectangles on the edges white)
    for (int i = 0; i < r.length; i++) r[i][0] = 0;
    for (int j = 0; j < r[0].length; j++) r[0][j] = 0;

    //choose colors
    for (int i = 0; i < c.length; i++) {
      for (int j = 0; j < c[0].length; j++) {
        chooseColor(i, j, true, lim);
      }
    }
  }

  /*----------*/

  void chooseColor(int x, int y, boolean first, int[] lim) {

    //if the ellipse is not colored yet
    if (c[(x + c.length)%c.length][(y + c[0].length)%c[0].length] == -1) {

      //choose color if it's the first ellipse of this contour
      if (first) {
        k++;
        col[k] = color(random(lim[0], lim[1]), random(lim[2], lim[3]), random(lim[4], lim[5]));
      }

      //set color of this ellipse
      c[(x + c.length)%c.length][(y + c[0].length)%c[0].length] = k;


      //test neighbors:

      // bottom-right
      if (r[(x + 1 + c.length)%c.length][(y + 1 + c[0].length)%c[0].length] == -1) {
        r[(x + 1 + c.length)%c.length][(y + 1 + c[0].length)%c[0].length] = k;                       // r[x+1][y+1]
        chooseColor((x + 1 + c.length)%c.length, (y + 1 + c[0].length)%c[0].length, false, lim);  // test(x+1, y+1, k)
      }

      // bottom-left
      if (r[(x + c.length)%c.length][(y + 1 + c[0].length)%c[0].length] == -1) {
        r[(x + c.length)%c.length][(y + 1 + c[0].length)%c[0].length] = k;                   // r[x][y+1]
        chooseColor((x - 1 + c.length)%c.length, (y + 1 + c[0].length)%c[0].length, false, lim);  // test(x-1, y+1)
      }

      // upper-right
      if (r[(x + 1 + c.length)%c.length][(y + c[0].length)%c[0].length] == -1) {
        r[(x + 1 + c.length)%c.length][(y + c[0].length)%c[0].length] = k;                   // r[x+1][y]
        chooseColor((x + 1 + c.length)%c.length, (y - 1 + c[0].length)%c[0].length, false, lim);  // test(x+1, y-1)
      }

      // upper-left
      if (r[(x + c.length)%c.length][(y + c[0].length)%c[0].length] == -1) {
        r[(x + c.length)%c.length][(y + c[0].length)%c[0].length] = k;                // r[x][y]
        chooseColor((x - 1 + c.length)%c.length, (y - 1 + c[0].length)%c[0].length, false, lim);  // test(x-1, y-1)
      }

    }

  }

  /*----------*/

  void drawTruchet(PGraphics pg) {
    pg.beginDraw();
    pg.noStroke();

    //draw rectangles
    for (int i = 0; i < r.length + 1; i++) {
      for (int j = 0; j < r[0].length + 1; j++) {
        if (r[i%c.length][j%c[0].length] == 0)  pg.fill(255);
        else pg.fill(col[r[i%c.length][j%c[0].length]]);

        pg.rect(i*tsize - tsize/2, j*tsize - tsize/2, tsize, tsize);
      }
    }

    //draw ellipses
    for (int i = 0; i < c.length; i++) {
      for (int j = 0; j < c[0].length; j++) {
        if (c[i][j] == 0)  pg.fill(255);
        else  pg.fill(col[c[i][j]]);

        pg.ellipse(i*tsize + tsize/2, j*tsize + tsize/2, tsize, tsize);
      }
    }

    pg.endDraw();

    k = 0;  // reset the index
  }

}
