// Student: Yeung Miu Wan 21000210A
// Class: 201D
// Assignment 2 SHDH2044 DIGITAL VISUALISATION IN NEW MEDIA

// import processing.svg.*; // used for A4 printing

int circleSize = 15; 
int virusNum = round(random(0, 20)); // 50 for A4 printing
int[] virusPositionX = new int[virusNum];
int[] virusPositionY = new int[virusNum];
int[] virusSize = new int[virusNum];
int virusSizeMax;
int virusSizeMin;
PImage covidImage;

void setup() {
  size(595,842);
  // size(1240,1754,SVG, "me.svg"); // used for A4 printing
  virusSizeMax = round(width/4);
  virusSizeMin = round(width/10);
  
  background(255);
  createGrid();
  createVirus();
  // exit(); // used for A4 printing
}

void createGrid(){
  // set the stroke and color 
  noFill();
  stroke(0);
  strokeWeight(0.5);
  
  //calculate grid of cicrle
  int numColumns = round(width/circleSize);
  int numRows = round(height/circleSize);
  
  for (int i = 0; i <= numColumns; i++) {
    for (int j = 0; j <= numRows; j++) {
      
      // 0.2% will choose black fill, 0.8% will choose white fill
      if (random(1) < 0.2)
        fill(0);
      else 
        fill(255);
      
      // Draw circle
      ellipse(i*circleSize, j*circleSize, circleSize, circleSize);
    }
  }
}

void createVirus() {
  covidImage = loadImage("covid-shape.png"); // Load COVID-19 shape image

  // Draw the first virus
  virusSize[0] = round(random(virusSizeMin, virusSizeMax));
  float x = random(width - virusSize[0]);
  float y = random(height - virusSize[0]);

  virusPositionX[0] = round(x);
  virusPositionY[0] = round(y);

  pushMatrix();
  translate(x, y);
  rotate(random(0, 6.283));
  image(covidImage, 0, 0, virusSize[0], virusSize[0]);
  popMatrix();

  // Draw the rest of the viruses
  for (int i = 1; i < virusNum; i++) {
    boolean virusPlaced = false;

    while (!virusPlaced) {
      virusSize[i] = round(random(virusSizeMin, virusSizeMax));
      float x2 = random(width - virusSize[i]);
      float y2 = random(height - virusSize[i]);

      boolean overlapping = false;
      for (int j = 0; j < i; j++) {
        //checks x2,y2 falling into the area of exisitng virus
        if (( x2 >= virusPositionX[j]  
            && x2 <= virusPositionX[j] +virusSize[j]) ||
            ( y2 <= virusPositionY[j]  
              && y2 >= virusPositionY[j] +virusSize[j])){
          overlapping = true;
          break;
        }
      }

      if (!overlapping) {
        virusPositionX[i] = round(x2);
        virusPositionY[i] = round(y2);

        pushMatrix();
        translate(x2, y2);
        rotate(random(0, 6.283));
        image(covidImage, 0, 0, virusSize[i], virusSize[i]);
        popMatrix();

        virusPlaced = true;
      }
    }
  }
}
