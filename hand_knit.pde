/**
 
 Title: B1Tknit Generator V1
 Imagined, Designed, and Programmed by: Becca Rose 
 Date: November 20 2014
 
 Description:
 EXAMPLE: This app enables you to create your very own custom pompom makers and export them to make on a lasercutter! Use the sliders to change the size and inside-to-outside ratio of the pompom makers.
 Note: for straded knitting long sections of 1 colour cause tension issues in your knitted piece.
 
 Sources of ideas and inspiration and code:
 * EXAMPLE: Becca Rose Glowacki's pompom makers, which can be found at the following URL: www.URL.com
 * processing orange book -image chapter
 * natalies class / pom pomatic
 * Mirror 2 -Processing Example by Daniel Shiffman. 
 * 
 */

//to do:
//change cell size slider
//gray scale / color picker button
//2 color /3 color knit
// circle areas of color OR no more than 5 between one color
//make fairisle generator (usign photo uploads -reverse, change sze, outline
//and using shape generators
//print pdf of pattern only

PImage photo;
PImage destination;

// Size of each cell in the grid
int cellSize = 10;


// Number of columns and rows in our system, this is defined in the set-up
int cols, rows;

//colors 
float upthreshold = 200;

int lightColor = color(0, 0, 0);
int midColor = color(0, 0, 0);
int darkColor = color(0, 0, 0);

//greys
int lightGrey = color(255);
int midGrey = color(100);
int darkGrey = color(0);

//set color for knitting tones 
int light = 255;
int middle =150;
int dark = 0;

//testing for cellsize


//set brightness level
int brightLevel = 150;

import controlP5.*;

ControlP5 cp5;
Accordion accordion;

//set boolean for knitting in the round button
boolean knitRound = false;

//set booleans for knitting in color or greyscale
boolean knitGrey = true;


void setup() {

  photo = loadImage("cat.jpg");
  photo.resize(400, 0); 
  size(photo.width*2, photo.height+100); //get the pattern the size you want -variable for cols and rows needs to be set to suit your pattern 
  image(photo, 0, 0);
  filter(GRAY);
  background (200, 20, 150);
  rectMode(CENTER); //rectangles x,y coordinates are in the center 

  cols = photo.width/cellSize; //this is how many stiches wide the pattern will be -needs to be edited by user (slider?)
  rows = photo.height/cellSize;//this is how many stiches long the pattern will be -needs to be edited by user

  println(photo.pixels.length);

  addSliders();
}

void draw() { 
  knitPattern();
  rowNumbers();
  colsNumbers();
  grid ();
  if (knitRound==true) {
    intheRound();
  }
  
 
}

////C E L L   S I Z E //
//void cellSlider (int val){
//cellSize = val;
//}

// S L I D E R   L I G H T //
void lightslider(float thelightColor) {
  colorMode(HSB, 255);
  lightColor = color(thelightColor, thelightColor, thelightColor);
  println("a slider event. setting background to "+thelightColor);
}

// S L I D E R   M I D   //
void midslider(float themidColor) {
  colorMode(HSB, 255);
  midColor = color(themidColor, themidColor, themidColor);
  println("a slider event. setting background to "+themidColor);
}

// S L I D E R   D A R K  //
void darkslider(float thedarkColor) {
  colorMode(HSB, 255);
  darkColor = color(thedarkColor, thedarkColor, thedarkColor);
  println("a slider event. setting background to "+thedarkColor);
}

//B R I G H N E S S //
//void brightLevel() {
 
//}


//// S A T U A T I O N  //
//
//void sliderSAT (float thephotoSat) {
// }


//P I X A L A T E   F O R   K N I T// make the knitting pattern from your image
void knitPattern() {
  loadPixels(); //
  // Begin loop for columns
  for (int i = 0; i < cols; i++) {
    // Begin loop for rows
    for (int j = 0; j < rows; j++) {

      // Where are we, pixel-wise?
      int x = i * cellSize;
      int y = j * cellSize;
      int location = x+y*photo.width;

      // Each rect is colored white/black/grey determined by brightness
      color c = photo.pixels[location]; 
      float sz = (brightness(c));
      photo.updatePixels();


      if (knitGrey==true) {
        if (sz > upthreshold) {
          colorMode(RGB, 255);
          fill(lightGrey);
          noStroke();
          rect(x + cellSize/2, y + cellSize/2, cellSize, cellSize);
        } else if ((sz > upthreshold) || (sz > 100) ) {
          colorMode(RGB, 255);
          fill(midGrey);
          noStroke();
          rect(x + cellSize/2, y + cellSize/2, cellSize, cellSize);
        } else if (sz >= 0) {
          colorMode(RGB, 255);
          fill(darkGrey);
          noStroke();        
          rect(x + cellSize/2, y + cellSize/2, cellSize, cellSize);
        }
      } else if (knitGrey==false) {
        if (sz > upthreshold) {
          colorMode(HSB, 255);
          fill(lightColor);
          noStroke();
          rect(x + cellSize/2, y + cellSize/2, cellSize, cellSize);
        } else if ((sz > upthreshold) || (sz > 100) ) {
          colorMode(HSB, 255);
          fill(midColor);
          noStroke();
          rect(x + cellSize/2, y + cellSize/2, cellSize, cellSize);
        } else if (sz >= 0) {
          colorMode(HSB, 255);
          fill(darkColor);
          noStroke();        
          rect(x + cellSize/2, y + cellSize/2, cellSize, cellSize);
        }
      }
    }
  }
}
// G R I D // make a reather lovely shade of pink grid
void grid() {
  for (int i =0; i< photo.width; i++) {
    for (int j = 0; j < photo.height; j++) {
      int x = i * cellSize;
      int y = j * cellSize;
      colorMode(RGB, 255);
      noFill();
      strokeWeight(1);
      stroke (200, 20, 150);
      rect (x+ cellSize/2, y+ cellSize/2, cellSize, cellSize);
    }
  }
}


// K N I T T I N G   I N   T H E   R O U N D //
//dividing the image into 4 so you know when to change needle
void intheRound() {
  int divideFour = photo.width/4;
  for (int i = cellSize; i < photo.width; i=i+divideFour) {
    colorMode(RGB, 255);
    stroke(40, 180, 203);
    line (i, cellSize, i, photo.height);
  }
}


//C O L U M N   N U M B E R S // function to call the column number in blue
void colsNumbers() { //along the width i.e. x 
  fill(40, 180, 203);
  rect(cellSize/2, cellSize/2, photo.width*2-cellSize, cellSize);
  for (int i = 0; i < (photo.width - cellSize/2); i=i+cellSize) {
    colorMode(RGB, 255);
    fill(255);
    textAlign(CENTER, BOTTOM);
    textSize(cellSize*0.6);
    text(""+(i/cellSize), i+(cellSize/2), cellSize);
  }
}

//R O W   N U M B E R S // function to call the row number in blue
void rowNumbers() { //along the height i.e. y
  colorMode(RGB, 255);
  fill(40, 180, 203);
  rect(cellSize/2, cellSize/2, cellSize, photo.height*2-cellSize);
  for (int j = 0; j <photo.height - cellSize/2; j=j+cellSize) {
    colorMode(RGB, 255);
    fill(255);
    textAlign(CENTER, BOTTOM);
    textSize(cellSize*0.6);
    text(""+(j/cellSize), cellSize/2, j+cellSize);
  }
}

// A D D   S L I D E R S   A N D   B U T T O N S //
void addSliders() {
  cp5 = new ControlP5(this);
  
  // create a knit on the round toggle
  cp5.addToggle("knitRound")
    .setPosition(photo.width+20, 20)
      .setSize(50, 20)
        .setLabel("Knit in the Round")
          ;

  // create light slider to change hue
  cp5.addSlider("lightslider")
    .setPosition(photo.width+20, 300)
      .setSize(300, 20)
        .setRange(0, 255)
          .setValue(light)
            ;

  // create mid slider to change hue
  cp5.addSlider("midslider")
    .setPosition(photo.width+20, 330)
      .setSize(300, 20)
        .setRange(0, 255)
          .setValue(middle)
            ;

  // create dark slider to change hue
  cp5.addSlider("darkslider")
    .setPosition(photo.width+20, 360)
      .setSize(300, 20)
        .setRange(0, 255)
          .setValue(dark)
            ;

  // create a greyscale knit toggle
  cp5.addToggle("knitGrey")
    .setPosition(photo.width+20, 100)
      .setSize(50, 20)
        .setValue(true)
          .setMode(ControlP5.SWITCH)
            .setLabel("Knit in Greyscale or Color")
              ;


  // create light slider to change brightness thresholds
  cp5.addSlider("brightLevel")
    .setPosition(photo.width+20, 140)
      .setSize(300, 20)
        .setRange(0, 255)
          .setValue(light)
            ;

  // create mid slider to change brightness thresholds
  cp5.addSlider("satuationslider")
    .setPosition(photo.width+20, 170)
      .setSize(300, 20)
        .setRange(0, 255)
          .setValue(middle)
            ;
 
//   cp5.addSlider("cellSlider")
//     .setPosition(100,140)
//     .setSize(20,100)
//     .setRange(5,40)
//     .setValue(cellSize)
//     .setNumberOfTickMarks(10)
//     .setLabel("Resolution")
//     ;
}
