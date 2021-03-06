int NONE       = 0x00;
int SQHOLE     = 0x01;
int SQPIECE    = 0x02;
int CIRCHOLE   = 0x03;
int CIRCPIECE  = 0x04;
int SQPIECEROT = 0x05;

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

int[] gridSizes = {2, 3, 4};


void setup() {

    size(720, 720);
    rectMode(CORNER);
    noStroke();
    noLoop();
}


void generateElement() {

    //Get background and foreground colors
    int backColorPointer = (int)random(colorPalette.length);
    int foreColorPointer = backColorPointer;
    while (foreColorPointer == backColorPointer) {
        foreColorPointer = (int)random(colorPalette.length);
    }


    //Get valid grid size (for square boards / holes);
    int gridSize = gridSizes[(int)random(gridSizes.length)];
    int[][] board = new int[gridSize][gridSize];
    //int px, py;
    int pieceCase;
    boolean rotateElement = false, reflectElement = false;


    //Get hole and superposition cells
    switch(gridSize) {

    case 2:

        reflectElement = true;
        board[0][0] = SQHOLE;
        board[1][(int)random(0, 2)] = SQPIECE;
        break;

    case 3:

        pieceCase = (int)random(0, 4);

        switch (pieceCase) {

        case 0: //CENTER

            board[1][1] = SQHOLE;
            board[1][2] = SQPIECE;
            break;

        case 1: //BORDER

            board[1][0] = SQHOLE;
            switch ((int)random(3)) {
            case 0:
                board[1][1] = (random(1)<0.5) ? SQPIECE : SQPIECEROT;
                break;
            case 1:
                board[1][2] = (random(1)<0.5) ? SQPIECE : SQPIECEROT;
                break;
            case 2:
                board[0][0] = SQPIECE;
            }
            break;

        case 2: //CORNER

            int cornerCase = (int) random(0, 6);

            switch(cornerCase) {
            case 0:
                //TODO: diagonal simmetry
                board[0][0] = SQHOLE;
                board[1][0] = SQPIECE;
                break;
            case 1:
                board[0][0] = SQHOLE;
                board[2][0] = SQHOLE;
                board[0][1] = SQPIECE;
                board[2][1] = SQPIECE;
                break;
            case 2:
                board[0][0] = SQHOLE;
                board[2][2] = SQHOLE;
                board[2][0] = SQPIECE;
                board[0][2] = SQPIECE;                
                break;
            case 3:
                rotateElement = true;
                reflectElement = true;            
                board[0][0] = SQHOLE;
                board[2][2] = SQHOLE;
                board[2][1] = SQPIECE;
                board[0][1] = SQPIECE;                
                break;
            case 4:
                reflectElement = true;            
                board[0][0] = SQHOLE;
                board[0][1] = SQHOLE;
                board[2][1] = SQPIECE;
                board[2][2] = SQPIECE;                
                break;
            case 5:
                board[0][0] = SQHOLE;
                board[2][0] = SQPIECEROT;                
                break;
            }
            break;
        case 3:
            board[1][1] = CIRCHOLE;
            board[1][2] = CIRCPIECE;
            break;
        }

        break;

    case 4:

        pieceCase = (int)random(0, 8);

        switch (pieceCase) {

        case 0: //TWO CORNERS, SYM
            board[0][0] = SQHOLE;
            board[3][0] = SQHOLE;
            board[0][1] = SQPIECE;
            board[3][1] = SQPIECE;
            break;

        case 1: //TWO CORNERS, SYM
            board[0][0] = SQHOLE;
            board[3][0] = SQHOLE;
            board[0][2] = SQPIECE;
            board[3][2] = SQPIECE;
            break;

        case 2: //TWO CORNERS, SYM
            board[0][0] = SQHOLE;
            board[3][0] = SQHOLE;
            board[0][3] = SQPIECE;
            board[3][3] = SQPIECE;
            break;

        case 3: //TWO CORNERS, ASYM
            reflectElement = false;
            board[0][0] = SQHOLE;
            board[3][0] = SQHOLE;
            board[0][1] = SQPIECE;
            board[3][3] = SQPIECE;
            break;

        case 4: //TWO SIDES, SYM
            board[0][1] = SQHOLE;
            board[3][1] = SQHOLE;
            board[1][1] = SQPIECE;
            board[2][1] = SQPIECE;
            break;

        case 5: //TWO SIDES, SYM
            board[0][1] = SQHOLE;
            board[3][1] = SQHOLE;
            board[0][2] = SQPIECE;
            board[3][2] = SQPIECE;
            break;            

        case 6: //TWO SIDES, SYM
            board[0][1] = SQHOLE;
            board[3][1] = SQHOLE;
            board[0][3] = SQPIECE;
            board[3][3] = SQPIECE;
            break;

        case 7: //TWO SIDES, ASYM
            reflectElement = true;
            board[0][1] = SQHOLE;
            board[3][1] = SQHOLE;
            board[1][1] = SQPIECE;
            board[2][2] = SQPIECE;
            break;
        }

        break;
    }

    //int rotNum = (int)random(0, 4);
    //while (rotNum > 0) {
    //    board = rotateBoard(board);
    //    rotNum--;
    //}

    //if (random(1)>0.5) {
    //    board = reflectBoard(board);
    //}


    //Maybe move the painting code to another function.
    int pieceSize = elementSize / gridSize;


    //Start drawing

    //Change coordinates
    pushMatrix();
    translate(width/2, width/2);

    //Rotate canvas to avoid rotating the array
    if (rotateElement) {
        rotate (radians((int)random(0, 4)*90));
    }

    //Reflect the element
    if (reflectElement && random(1)>0.5) {
        scale(-1, 1);
    }

    //Recenter the element
    translate(-elementSize/2, -elementSize/2);

    //Main square
    fill (colorPalette[backColorPointer]);
    rect(0, 0, elementSize, elementSize);

    for (int y = 0; y<gridSize; y++) {
        for (int x = 0; x<gridSize; x++) {
            if (board[x][y] == SQHOLE) {
                fill(#ffffff);
                rect(x * pieceSize, y * pieceSize, pieceSize, pieceSize);
            } else if (board[x][y] == CIRCHOLE) {
                fill(#ffffff);
                ellipse(x * pieceSize + pieceSize/2, y * pieceSize + pieceSize/2, pieceSize * 0.8, pieceSize * 0.8);
            } else if (board[x][y] == SQPIECE) {
                fill(colorPalette[foreColorPointer]);
                rect(x * pieceSize, y * pieceSize, pieceSize, pieceSize);
            } else if (board[x][y] == CIRCPIECE) {
                fill(colorPalette[foreColorPointer]);
                ellipse(x * pieceSize + pieceSize/2, y * pieceSize + pieceSize/2, pieceSize * 0.8, pieceSize * 0.8);
            } else if (board[x][y] == SQPIECEROT) {
                fill(colorPalette[foreColorPointer]);
                rectMode(CENTER);
                pushMatrix();
                translate(x * pieceSize + pieceSize/2, y * pieceSize + pieceSize/2);
                rotate(radians(45));
                rect(0, 0, pieceSize * 0.7, pieceSize * 0.7);
                popMatrix();
                rectMode(CORNER);
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


boolean isCenter(int x, int y, int gs) {
    return (x == (gs-1)/2 && y==x);
}


//int[][] rotateBoard(int[][] oldBoard) {

//    int N = oldBoard.length;

//    int[][] newBoard = new int[N][N];
//    for (int r = 0; r < N; r++) {
//        for (int c = 0; c < N; c++) {
//            newBoard[c][N-1-r] = oldBoard[r][c];
//        }
//    }
//    return newBoard;
//}

//int[][] reflectBoard(int[][] oldBoard) {

//    int N = oldBoard.length;

//    int[][] newBoard = new int[N][N];
//    for (int r = 0; r < N; r++) {
//        for (int c = 0; c < N; c++) {
//            newBoard[N-1-c][r] = oldBoard[c][r];
//        }
//    }
//    return newBoard;
//}

void draw() {

    background(#ffffff);

    for (int x=0; x<7; x++) {
        for (int y=0; y<7; y++) {
            pushMatrix();
            translate(x*100+24, y*100+24);
            scale(0.1);
            generateElement();
            popMatrix();
        }
    }
}


void mousePressed() {

    redraw();
}