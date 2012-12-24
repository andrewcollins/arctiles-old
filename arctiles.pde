int cols = 8;
int rows = 5;
int cellSize = 150;
float innerRadDiv = 1.5;
int[][] directions;
int radius1, radius2 = cellSize/2;
color c1 = randColor();
color c2 = randColor();
color c3 = randColor();
int filecounter = 0;

void setup() {
  size(cols*cellSize, rows*cellSize);
  background(255);
  noStroke();
  smooth();
  directions = new int[cols][rows];
  for (int x=0; x < cols; x++) {
    for (int y=0; y < rows; y++) {
      directions[x][y] = int(random(4));
    }
  }
  filecounter = 0;
//  noLoop();
}

color randColor() {
  int r = int(random(255));
  int g = int(random(255));
  int b = int(random(255));
  color xx = color(r,g,b);
  return xx;
}

void drawCell(int posX, int posY, int radius, int direction) {
  switch(direction % 4) {
    case 0:
      //orgin lower-right
      arc(posX, posY, radius, radius, 0, PI/2);
      break;
    case 1:
      // orgin lower-left
      arc(posX + cellSize, posY, radius, radius, PI/2, PI);
      break;
    case 2:
      // orgin upper-left
      arc(posX + cellSize, posY + cellSize, radius, radius, PI, TWO_PI-PI/2);
      break;
    case 3:
      // orgin upper-right
      arc(posX, posY + cellSize, radius, radius, TWO_PI-PI/2, TWO_PI);
      break;
  }
}

void update(int rad1, int rad2, int[][] directions) {
//  innerRadDiv = 1 + float(mouseX)/400;
  background(255);
  //loop for columns
  for (int i = 0; i < cols; i++) {
    //loop for rows
    for (int j = 0; j < rows; j++) {
      fill(c1);
      drawCell(i*cellSize, j*cellSize, cellSize*2, directions[i][j]);
      fill(c2);
      drawCell(i*cellSize, j*cellSize, rad1*2, directions[i][j]);
      fill(c3);
      drawCell(i*cellSize, j*cellSize, rad2*2, directions[i][j]);
    }
  }
}

void mouseClicked() {
  int tlX, trX, llX, lrX, tlY, trY, llY, lrY = 0; // corner coords
  float tlD, trD, llD, lrD = cellSize; // corner distances
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      tlX = llX = cellSize*(i);
      trX = lrX = cellSize*(i+1) - 1;
      tlY = trY = cellSize*(j);
      llY = lrY = cellSize*(j+1) - 1;
      tlD = dist(tlX, tlY, mouseX, mouseY);
      trD = dist(trX, trY, mouseX, mouseY);
      llD = dist(llX, llY, mouseX, mouseY);
      lrD = dist(lrX, lrY, mouseX, mouseY);
      c1 = randColor();
      c2 = randColor();
      c3 = randColor();
      if ((tlD > trD) && (tlD > llD) && (tlD > lrD)) {
        directions[i][j] = 2;
      } else if ((trD > tlD) && (trD > llD) && (trD > lrD)) {
        directions[i][j] = 3;
      } else if ((llD > trD) && (llD > tlD) && (llD > lrD)) {
        directions[i][j] = 1;
      } else if ((lrD > trD) && (lrD > llD) && (lrD > tlD)) {
        directions[i][j] = 0;
      } else {
        directions[i][j] = int(random(4));
      }
    }
  }
}

void keyReleased() {
  String filename = "file01.png";
  if ((key == 'r') || (key == 'R')) {
      c1 = randColor();
      c2 = randColor();
      c3 = randColor();
      for (int x=0; x < cols; x++) {
        for (int y=0; y < rows; y++) {
          directions[x][y] = int(random(4));
        }
      }
  } else if ((key == 'w') || (key == 'W')) {
    filename = "arc-save" + filecounter + ".png";
    //save(filename);
    filecounter++;
  }
}

void draw() {
  radius1 = cellSize - int(cellSize*(mouseX)/width);
  radius2 = cellSize - int(cellSize*(mouseY)/height);
  update(radius1, radius2, directions);
}
