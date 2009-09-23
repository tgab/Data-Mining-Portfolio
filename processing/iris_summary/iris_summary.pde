FloatTable data;
float dataMin, dataMax;

float[] sepal_length;
float[] sepal_width;
float[] petal_length;
float[] petal_width;

float sepal_l_min, sepal_l_max, sepal_w_min, sepal_w_max;
float petal_l_min, petal_l_max, petal_w_min, petal_w_max;

String[] classes;

float interval = .5;
int yearInterval = 10;
int volumeInterval = 10;
int volumeIntervalMinor = 5;

float plotX1, plotY1;
float plotX2, plotY2;
float labelX, labelY;
float xMin, xMax;
float yMin, yMax;

float[] means;
float[] medians;

float[] tabLeft, tabRight;
float tabTop, tabBottom;
float tabPad = 10;
PImage[] tabImageNormal;
PImage[] tabImageHighlight;

float barWidth = 30;
String[] uniqueNames;

int currentColumn1 = 0;
int currentColumn2 = 1;
int currentColumn = 0;
int columnCount;
int rowCount;
String currentStat;

PFont plotFont;

void setup( ) {
  size(720, 720);
  
  data = new FloatTable("iris.data");
  rowCount = data.getRowCount( );
  columnCount = data.getColumnCount();

  dataMin = data.getTableMin();
  dataMax = data.getTableMax( );
  
  sepal_length = new float[rowCount];
  sepal_width = new float[rowCount];
  petal_length = new float[rowCount];
  petal_width = new float[rowCount];
  
  classes = data.getRowNames();
  
  //Establish unique string array
  uniqueNames = getUnique(classes);
  
  xMin = 0;
  xMax = dataMax;
  yMin = 0;
  yMax = dataMax;
  
  // Corners of the plotted time series
  plotX1 = 120;
  plotX2 = width - 80;
  labelX = 50;
  plotY1 = 120;
  plotY2 = height - 60;
  labelY = height - 25;
  
  plotFont = createFont("SansSerif", 20);
  textFont(plotFont);
  
  smooth( );
}

void draw( ) {
  background(224);
  
  // Show the plot area as a white box.
  fill(255);
  rectMode(CORNERS);
  noStroke( );
  rect(plotX1, plotY1, plotX2, plotY2);
  
  // Draw the title of the current plot.
  //drawTitle( );
  drawAxisLabels( );
  drawXAxisLabels( );
  drawYAxisLabels( );
  
  drawTitleTabs( );
  
  drawDataBars(currentColumn);
  
  drawLegend();
}

void drawTitle( ) {
  fill(0);
  textSize(20);
  textAlign(LEFT);
  String title = data.getColumnName(currentColumn);
  text(title, plotX1, plotY1 - 10);
}

void drawDataBars(int col) {
  noStroke( );
  rectMode(CORNERS);
  
  for (int i = 0; i < uniqueNames.length; i++) {
      fill(#5679C1);
      float x = map(i, 0, uniqueNames.length, plotX1+100, plotX2);
      float y = map(calcMean(uniqueNames[i], col), yMin, ceil(yMax), plotY2, plotY1);
      rect(x-barWidth, y, x-2, plotY2);
      
      fill(#5600C1);
      float z = map(calcMedian(uniqueNames[i], col), yMin, ceil(yMax), plotY2, plotY1);
      rect(x+2, z, x+barWidth, plotY2);
  }
}

float calcMean(String name, int col) {
  float value = 0;
  int count = 0;
  for (int row = 0; row < rowCount; row++) {
    if (data.getRowName(row).equals(name)) {
      value += data.getFloat(row, col);
      count += 1;
    }
  }
  return value/count;
}

float calcMedian(String name, int col){
  float column[] = new float[1];
  column[0] = 0;
  
  for (int row=0; row < rowCount; row++){
    if (data.getRowName(row).equals(name)){
      column = append(column, data.getFloat(row, col));
    }
  }
  
  column = sort(column);
  int count = column.length;
  
  if ((count % 2) == 0){
    return (column[count/2] + column[count/2 + 1])/2;
  } else {
    return column[ceil(count/2)];
  }
}

void drawAxisLabels( ) {
  fill(0);
  textSize(13);
  textLeading(15);
  
  //Label X Axis
  textAlign(CENTER);
  text("Class of Iris", (plotX1+plotX2)/2, labelY+10);
  
  //Label Y Axis
  textAlign(CENTER, CENTER);
  text("Value of\n" + data.getColumnName(currentColumn), labelX, (plotY1+plotY2)/2);
  
}

void drawXAxisLabels( ) {
  fill(0);
  textSize(10);
  textAlign(CENTER, TOP);
  
  // Use thin, gray lines to draw the grid.
  stroke(255); //Or 224 for grey
  strokeWeight(1);
  
  for (int i = 0; i < uniqueNames.length; i++){
    float x = map(i, 0, uniqueNames.length, plotX1+100, plotX2);
    text(uniqueNames[i], x, plotY2 + 10);
    line(x, plotY1, x, plotY2);
  }
}

void drawYAxisLabels( ) {
  fill(0);
  textSize(10);
  
  stroke(128);
  strokeWeight(1);
  
  for (float v = yMin; v <= ceil(yMax); v += interval) {
    float y = map(v, yMin, ceil(yMax), plotY2, plotY1+20);
    if (v == yMin) {
      textAlign(RIGHT); // Align by the bottom
    } else if (v == yMax) {
      textAlign(RIGHT, TOP); // Align by the top
    } else {
      textAlign(RIGHT, CENTER); // Center vertically
    }
    text(nf(v,1,1), plotX1 - 10, y);
    line(plotX1 - 4, y, plotX1, y); // Draw major tick
  }
}

void drawLegend(){
  rectMode(CENTER);
  fill(255);
  rect(600, 60, 200, 100);
  
  fill(#5679C1);
  rect(520, 35, 25, 25);
  text("Mean", 550, 40);
  
  fill(#5600C1);
  rect(520, 75, 25, 25);
  text("Median", 550, 85);
}


void drawTitleTabs( ) {
  rectMode(CORNERS);
  noStroke( );
  textSize(20);
  textAlign(LEFT);
  
  // On first use of this method, allocate space for an array
  // to store the values for the left and right edges of the tabs.
  if (tabLeft == null) {
    tabLeft = new float[columnCount];
    tabRight = new float[columnCount];
  }
  
  float runningX = plotX1;
  tabTop = plotY1 - textAscent( ) - 15;
  tabBottom = plotY1;
  
  for (int col = 0; col < columnCount; col++) {
    String title = "Plot " + (col+1);
    tabLeft[col] = runningX;

    float titleWidth = textWidth(title);
    tabRight[col] = tabLeft[col] + tabPad + titleWidth + tabPad;
    
    // If the current tab, set its background white; otherwise use pale gray.
    fill(col == currentColumn ? 255 : 224);
    rect(tabLeft[col], tabTop, tabRight[col], tabBottom);
    
    // If the current tab, use black for the text; otherwise use dark gray.
    fill(col == currentColumn ? 0 : 64);
    text(title, runningX + tabPad, plotY1 - 10);
    
    runningX = tabRight[col];
  }
}

void mousePressed( ) {
  if (mouseY > tabTop && mouseY < tabBottom) {
    for (int col = 0; col < columnCount; col++) {
      if (mouseX > tabLeft[col] && mouseX < tabRight[col]) {
        setColumn1(col);
        setColumn2(col);
        setColumn(col);
      }
    }
  }
}

void setColumn(int col) {
  if (col != currentColumn) {
    currentColumn = col;
  }
}

void setColumn1(int col) {
  if (col != currentColumn) {
    if (col < 3){
      currentColumn1 = 0;
    } else if (col < 5){
      currentColumn1 = 1;
    } else {
      currentColumn1 = 2;
    }
  }
}

void setColumn2(int col) {
  if (col != currentColumn) {
    if (col == 0){
      currentColumn2 = 1;
    } else if (col == 1){
      currentColumn2 = 2;
    } else if (col == 3){
      currentColumn2 = 2;
    } else {
      currentColumn2 = 3;
    }
  }
}

String[] getUnique(String [] tracks){
  //Create a new string array to hold the names of all genres (including dupes)
  String allGenres[] = new String[tracks.length];
  for (int i = 0; i < tracks.length; i++) {
    allGenres[i] = tracks[i];
  }
  //Alphabetize the whole list
  allGenres = sort(allGenres);

  //Establish unique (non-dupe) genre array, and prepopulate it with the first genre
  String uniqueGenres[] = new String[1];
  uniqueGenres[0] = tracks[0];

  for (int i = 1; i < allGenres.length; i++) {
    if ((allGenres[i].equals(allGenres[i-1]))) {
    } 
    else {
	String tempNewGenre = allGenres[i];
	uniqueGenres = append(uniqueGenres, tempNewGenre);
    }
  }
  return uniqueGenres;
}
