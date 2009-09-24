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

float[] tabLeft, tabRight;
float tabTop, tabBottom;
float tabPad = 10;
PImage[] tabImageNormal;
PImage[] tabImageHighlight;


int currentColumn1 = 0;
int currentColumn2 = 1;
int currentColumn = 0;
int columnCount;
int rowCount;

PFont plotFont;

void setup( ) {
  size(720, 720);
  
  data = new FloatTable("iris.data");
  rowCount = data.getRowCount( );
  columnCount = 6;

  dataMin = data.getTableMin();
  dataMax = data.getTableMax( );
  
  sepal_length = new float[rowCount];
  sepal_width = new float[rowCount];
  petal_length = new float[rowCount];
  petal_width = new float[rowCount];
  
  classes = data.getRowNames();
  for (int row = 0; row < rowCount; row++){
    sepal_length[row] = data.getFloat(row, 0);
    sepal_width[row] = data.getFloat(row, 1);
    petal_length[row] = data.getFloat(row, 2);
    petal_width[row] = data.getFloat(row, 3);
  }
   
  sepal_l_min = data.getColumnMin(0);
  sepal_l_max = data.getColumnMax(0);
  sepal_w_min = data.getColumnMin(1);
  sepal_w_max = data.getColumnMax(1);
  petal_l_min = data.getColumnMin(2);
  petal_l_max = data.getColumnMax(2);
  petal_w_min = data.getColumnMin(3);
  petal_w_max = data.getColumnMax(3);
  
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
  
  // Draw the data for each column combination
  drawDataPoints(currentColumn1, currentColumn2);
  
  drawLegend();
}

// Draw the data as a series of points.
void drawDataPoints(int col1, int col2) {
  strokeWeight(5);
  for (int row = 0; row < rowCount; row++) {
    if (data.getRowName(row).equals("Iris-virginica")) {
      stroke(#990000);
    } else if (data.getRowName(row).equals("Iris-versicolor")) {
      stroke(#006600);
    } else if (data.getRowName(row).equals("Iris-setosa")) {
      stroke(#000066);
    } else {
      stroke(#5679C1);
    }
    if (data.isValid(row, col1) && data.isValid(row, col2)) {
      float value1 = data.getFloat(row, col1);
      float value2 = data.getFloat(row, col2);
      float x = map(value1, xMin, ceil(xMax), plotX1, plotX2);
      float y = map(value2, yMin, ceil(yMax), plotY2, plotY1);
      point(x, y);
    }
  }
}

void drawAxisLabels( ) {
  fill(0);
  textSize(13);
  textLeading(15);
  
  //Label X Axis
  textAlign(CENTER);
  text(data.getColumnName(currentColumn1) + "\n in cm", (plotX1+plotX2)/2, labelY);
  
  //Label Y Axis
  textAlign(CENTER, CENTER);
  text(data.getColumnName(currentColumn2) + "\n in cm", labelX, (plotY1+plotY2)/2);
  
}

void drawXAxisLabels( ) {
  fill(0);
  textSize(10);
  textAlign(CENTER, TOP);
  
  // Use thin, gray lines to draw the grid.
  stroke(255); //Or 224 for grey
  strokeWeight(1);
  
  for (float i = xMin; i <= ceil(xMax); i+=interval){
    float x = map(i, xMin, ceil(xMax), plotX1, plotX2);
    text(nf(i, 1, 1), x, plotY2 + 10);
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

void drawLegend(){
  stroke(0);
  strokeWeight(2);
  rectMode(CORNER);
  fill(255);
  rect(plotX1+10, plotY1+10, 100, 70);
  
  textAlign(LEFT, CENTER);
  strokeWeight(5);
  fill(0);
  textSize(12);
  textLeading(5);
  
  stroke(#990000);
  point(plotX1+20, plotY1+20);
  text("Iris-virginica", plotX1+30, plotY1+20);
  
  stroke(#006600);
  point(plotX1+20, plotY1+40);
  text("Iris-versicolor", plotX1+30, plotY1+40);
  
  stroke(#000066);
  point(plotX1+20, plotY1+60);
  text("Iris-setosa", plotX1+30, plotY1+60);
  /*
  noStroke();
  fill(#5679C1);
  rect(520, 35, 25, 25);
  text("Mean", 550, 40);
  
  fill(#5600C1);
  rect(520, 75, 25, 25);
  text("Median", 550, 85);
  */
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
