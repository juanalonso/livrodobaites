int HOLE  = 0x01;
int PIECE = 0x02;

int elementSize = 600;

//Livro do tempo palette
color[] colorPalette = {
    color (230, 230, 230), //Light grey
    color ( 20, 20, 20), //Dark grey
    color (240, 220, 50), //Yellow
    color (230, 180, 40), //Ochre
    color ( 30, 30, 130), //Dark blue
    color ( 70, 100, 170), //Light blue
    color (213, 0, 0), //Light red
    color (125, 15, 15)  //Dark red
};

int[] gridSizes = {3};


void setup() {

    size(720, 720);
    rectMode(CORNER);
    noStroke();
    //noLoop();
}


void generateElement() {

    //Get background and foreground colors
    int backColorPointer = (int)random(colorPalette.length);
    int foreColorPointer = backColorPointer;
    while (foreColorPointer == backColorPointer) {
        foreColorPointer = (int)random(colorPalette.length);
    }


    //Get grid size (for square boards / holes);
    int gridSize = gridSizes[(int)random(gridSizes.length)];
    int[][] board = new int[gridSize][gridSize];
    //int boardSize = gridSize * gridSize;


    //Get hole and superposition cells
    int px = (int)random(gridSize);
    int py = (int)random(gridSize);
    board[px][py] = HOLE;

    if (isCorner(px, py, gridSize) && gridSize > 2) {
        board[gridSize-1-px][py] = HOLE;
    }

    while (board[px][py] == HOLE) {
        px = (int)random(gridSize);
        py = (int)random(gridSize);
    }
    board[px][py] = PIECE;

    int pieceSize = elementSize / gridSize;


    //Start drawing

    //Change coordinates
    pushMatrix();
    translate((width-elementSize)/2, (width-elementSize)/2);

    //Main square
    fill (colorPalette[backColorPointer]);
    rect(0, 0, elementSize, elementSize);

    for (int y = 0; y<gridSize; y++) {
        for (int x = 0; x<gridSize; x++) {
            if (board[x][y] == HOLE) {
                fill(#ffffff);
                rect(x * pieceSize, y * pieceSize, pieceSize, pieceSize);
            } else if (board[x][y] == PIECE) {
                fill(colorPalette[foreColorPointer]);
                rect(x * pieceSize, y * pieceSize, pieceSize, pieceSize);
            }
        }
    }    

    popMatrix();
}


boolean isCorner(int x, int y, int gs) {

    return (x==0 && y==x) ||
        (x==0 && y==gs-1) ||
        (x==gs-1 && y==x) ||
        (x==gs-1 && y==0);
}

void draw() {

    //White background
    background(#ffffff);

    
    for (int x=0; x<7; x++) {
        for (int y=0; y<7; y++) {
            pushMatrix();
            translate(x*100+22, y*100+22);
            scale(0.1);
            generateElement();
            popMatrix();        
        }
    }
    noLoop();

}


void mousePressed() {

    redraw();
}