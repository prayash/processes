Table stats;
int visibleRows = 25;

int chartTop, chartBottom;
int chartLeft, chartRight;
int currentRow;


void setup() {
  size(600, 600);
  pixelDensity(displayDensity());

  // Do not call loadTable() from draw(). You'll be re-loading 
  // the table 60 times every *second*, and making our server slow.
  stats = loadTable("http://download.processing.org/stats/libraries", "tsv");
  textFont(createFont("Roboto Mono", 14));

  // add some margin
  chartTop = 20;
  chartBottom = height-chartTop;
  chartLeft = 20;
  chartRight = width - 80;
}


void draw() {
  background(255);
  cursor(HAND);

  // get the highest number from the first line, second column
  int highest = stats.getInt(0, 1);

  textAlign(LEFT, CENTER);
  strokeCap(SQUARE);
  strokeWeight(10);
  stroke(192);

  currentRow = -1;
  for (int row = 0; row < visibleRows; row++) {
    String title = stats.getString(row, 0);
    int count = stats.getInt(row, 1);
    //String url = stats.getString(row, 2);

    float x = map(count, 0, highest, chartLeft, chartRight);
    float y = map(row, 0, visibleRows-1, chartTop, chartBottom);
    line(chartLeft, y, x, y);

    fill(96);
    // if the mouse is nearby, select this row
    if (abs(y - mouseY) < 8) {
      currentRow = row;
      fill(0);
    }
    text(title, x + 8, y);
  }
}


void mousePressed() {
  if (currentRow != -1) {
    // open the url in a browser
    link(stats.getString(currentRow, 2));
  }
}