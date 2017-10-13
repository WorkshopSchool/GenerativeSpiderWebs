import processing.pdf.*;
int batch;

Webs[][] webz;
int saves = 0;
int cols = 5;
int rows = 3;

int depth = 2;

void setup() {
  size(1000, 1200);
  webz = new Webs[cols][rows];
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      // Initialize each object
      webz[i][j] = new Webs(i, j);
    }
  }
}

void draw() {
}

class Webs {
  float x, y;
  int size = 100;
  final int NBRANCHES = 6;
  final int CIRCLE = 360;
  float[] fractions = new float[depth];
  int[] angles = new int[depth];
  Webs(float tempX, float tempY) {
    x= tempX;
    y= tempY;
  }
  void web() {
   // translate(500/2, 500/2);
    //rotate the canvas so the zero-direction is up
    rotate(radians(-CIRCLE/4));
    noFill();
    strokeWeight(6);
    ellipse(85, 0, 0.25*75, 0.25*75);
    for (int i = 0; i<6; i++) {
      strokeWeight(5);
      line(0, 0, 77, 0);
      strokeWeight(8);
      webber();
      rotate(radians(CIRCLE/NBRANCHES));
    }
  }

  void webber() {
    for (float i=0; i<1; i= i + .25) {
      pushMatrix();
      translate((size*i), 0);
      rotate(radians(120));
      scale(i);
      curve(random(-200), random(-200), 0, 0, size, 0, size+random(200), random(-200));
      popMatrix();
    }
  }
}

void mouseClicked() {
  background(255);
  if (mouseButton == LEFT) {
    batch++;
    String bN= "webBatch"+ batch + ".pdf";
    //println(bN);
  beginRecord(PDF, bN);
    translate(100, 125);
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        //display each object

        pushMatrix();
        translate((i*1)*175, (j*1)*210);
        webz[i][j].web();
        popMatrix();
      }
    }
   endRecord();
  }
}