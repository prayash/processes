import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import treemap.*; 
import processing.pdf.*; 
import java.util.Calendar; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class build extends PApplet {

// Processes - Day 142
// Prayash Thapa - May 21, 2016





Treemap map;
MapLayout layoutAlgorithm = new PivotBySplitSize();

boolean savePDF = false;

int maxFontSize = 1000;
int minFontSize = 1;

PFont font;

// ************************************************************************************

public void setup() {
  
  font = createFont("miso-bold.ttf", 10);

  WordMap mapData = new WordMap();

  String[] lines = loadStrings("data.txt");
  String joinedText = join(lines, " ");
  joinedText = joinedText.replaceAll("_", "");
  String[] words = splitTokens(joinedText, " \u00ac\u00aa\u00ac\u00b4\u201a\u00c4\u00ec_-\u2013().,;:?!\u2014\"");

  for (int i = 0; i < words.length; i++) {
    String word = words[i].toLowerCase();
    mapData.addWord(word);
  }

  mapData.finishAdd();
  map = new Treemap(mapData, 0, 0, width, height);
}

// ************************************************************************************

public void draw() {
  if (savePDF) beginRecord(PDF, timestamp()+".pdf");

  background(255);
  map.setLayout(layoutAlgorithm);
  map.updateLayout();
  map.draw();

  if (savePDF) {
    savePDF = false;
    endRecord();
  }

  noLoop();
}

// ************************************************************************************

public void keyReleased() {
  if (key == 's' || key == 'S') saveFrame(timestamp()+"_##.png");
  if (key == 'p' || key == 'P') savePDF = true;

  // set layout algorithm
  if (key=='1') layoutAlgorithm = new SquarifiedLayout();
  if (key=='2') layoutAlgorithm = new PivotBySplitSize();
  if (key=='3') layoutAlgorithm = new SliceLayout();
  if (key=='4') layoutAlgorithm = new OrderedTreemap();
  if (key=='5') layoutAlgorithm = new StripTreemap();

  if (key=='1'||key=='2'||key=='3'||key=='4'||key=='5'||
    key=='s'||key=='S'||key=='p'||key=='P') loop();
}


// timestamp
public String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}

// ************************************************************************************

class WordMap extends SimpleMapModel {
  HashMap words;

  WordMap() {
    words = new HashMap();
  }

  public void addWord(String word) {
    WordItem item = (WordItem) words.get(word);
    if (item == null) {
      item = new WordItem(word);
      words.put(word, item);
    }
    item.incrementSize();
  }

  public void finishAdd() {
    items = new WordItem[words.size()];
    words.values().toArray(items);
  }
}

class WordItem extends SimpleMapItem {
  String word;
  int count;
  int margin = 3;

  WordItem(String word) {
    this.word = word;
  }

  public void draw() {
    // frames
    // inheritance: x, y, w, h
    noStroke();
    fill(w % 255, h % 255, y % 255);
    // rect(x, y, w, h);

    // maximize fontsize in frames
    for (int i = minFontSize; i <= maxFontSize; i++) {
      textFont(font, i);
      if (w < textWidth(word) + margin || h < (textAscent()+textDescent()) + margin) {
        textFont(font,i);
        break;
      }
    }

    textAlign(CENTER, CENTER);
    text(word, x + w/2, y + h/2);
  }
}
  public void settings() {  fullScreen(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "build" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
