int baseSize = 600;
color[] colorPalette = new color[8];

void setup() {

    size(800,800);
    rectMode(CORNER);
    noStroke();
    noLoop();

    //Livro do tempo palette
    colorPalette[0] = color (230,230,230); //Light grey
    colorPalette[1] = color ( 20, 20, 20); //Dark grey
    colorPalette[2] = color (240,220, 50); //Yellow
    colorPalette[3] = color (230,180, 40); //Ochre
    colorPalette[4] = color ( 30, 30,130); //Dark blue
    colorPalette[5] = color ( 70,100,170); //Light blue
    colorPalette[6] = color (213,  0,  0); //Light red
    colorPalette[7] = color (125, 15, 15); //Dark red
    
}


void generateItem() {
    
    //Get background and foreground colors
    int backColorPointer = (int)random(colorPalette.length);
    int foreColorPointer = backColorPointer;
    while (foreColorPointer == backColorPointer) {
        foreColorPointer = (int)random(colorPalette.length);
    }
    
    //Get grid size (for square holes right now);
    int gridSize = 2 + (int) random(2);
    int cellNumber = gridSize * gridSize;
    int holeSize = baseSize / gridSize;
        
    //Get hole and superposition cells
    int holePosition = (int)random(cellNumber);
    int superposPosition = holePosition;
    while (superposPosition == holePosition) {
        superposPosition = (int)random(cellNumber);
    }
    
    //Start drawing

    //White background
    background(#ffffff);

    //Change coordinates
    pushMatrix();
    translate((width-baseSize)/2,(width-baseSize)/2);
    
    //Main square
    fill (colorPalette[backColorPointer]);
    rect(0,0,baseSize, baseSize);
    
    //Draw hole
    fill(#ffffff);
    rectMode(CORNER);
    rect((holePosition % gridSize)*holeSize,
         (holePosition / gridSize)*holeSize,
         holeSize,
         holeSize);

    //Draw superposition
    fill(colorPalette[foreColorPointer]);
    rectMode(CORNER);
    rect((superposPosition % gridSize)*holeSize,
         (superposPosition / gridSize)*holeSize,
         holeSize,
         holeSize);
   
    popMatrix();
    
}


void draw() {
    
    generateItem();

}


void mousePressed() {
   
  redraw();

}