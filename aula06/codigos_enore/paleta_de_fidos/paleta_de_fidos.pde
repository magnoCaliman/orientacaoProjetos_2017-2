//fido 1 shades of blue, fido 2 shades of green, fido 3 shades of yellow, fido 4 etc

import TUIO.*;
PImage azul;
PImage amarelo;
PImage verde;
PImage vermelho;
int f;
TuioProcessing tuioClient;
float object_size = 45;
float scale_factor = 1;
float table_size = 760;
float obj_size = object_size*scale_factor; 
ArrayList<TuioObject> tuioObjectList;

void setup() {
  background(255);
  size(1200, 800);  
  //if (!callback) {
  //  frameRate(10);
  //  loop();
  //} else noLoop();

  scale_factor = height/table_size;

  tuioClient = new TuioProcessing(this);
  
  
  azul = loadImage("azul.JPG");
  amarelo = loadImage("amarelo.jpg");
  vermelho = loadImage("vermelho.jpg");
  verde = loadImage("verde.jpg");
  frameRate(10);
}

void draw() {
  

  tuioObjectList = tuioClient.getTuioObjectList();
  println(tuioObjectList);

  for (int i=0; i<tuioObjectList.size(); i++) {
    TuioObject tobj = tuioObjectList.get(i);
    //set(int(x),int(y),c);

    float x = tobj.getScreenX(width);
    float y = tobj.getScreenY(height);
    int e = tobj.getSymbolID();
    //for (int j = 0; j<width/2; j++) {
    //  for (int h = 0; h<height/2; h++) {
    //    set(int(j),int(h),int(j)*int(j)/(f+1));
    //  }
    //}
    if (e == 5) {
      color c = azul.get(int(x), int(y)); 
      println(c);
      pushMatrix();
      fill(c,40);
      noStroke();
      translate(tobj.getScreenX(width), tobj.getScreenY(height));
      rotate(tobj.getAngle());
      ellipse(-obj_size/2, -obj_size/2, obj_size, obj_size);
      popMatrix();
    } else if (e == 0) {
      color c = vermelho.get(int(x), int(y));
            println(c);

      pushMatrix();
      fill(c,50);
      noStroke();
      translate(tobj.getScreenX(width), tobj.getScreenY(height));
      rotate(tobj.getAngle());
      ellipse(-obj_size/2, -obj_size/2, obj_size, obj_size);
      popMatrix();
    } else if (e == 2) {
      color c = amarelo.get(int(x), int(y));
            println(c);

      pushMatrix();
      fill(c,50);
      noStroke();
      translate(tobj.getScreenX(width), tobj.getScreenY(height));
      rotate(tobj.getAngle());
      ellipse(-obj_size/2, -obj_size/2, obj_size, obj_size);
      popMatrix();
    } else if (e == 3) {
      color c = verde.get(int(x), int(y));
            println(c);
      pushMatrix();
      fill(c,50);
      noStroke();
      translate(tobj.getScreenX(width), tobj.getScreenY(height));
      rotate(tobj.getAngle());
      ellipse(-obj_size/2, -obj_size/2, obj_size, obj_size);
      popMatrix();
    } else {
      color c = color(255, 255, 255);
      pushMatrix();
      fill(c);
      noStroke();
      translate(tobj.getScreenX(width), tobj.getScreenY(height));
      rotate(tobj.getAngle());
      ellipse(-obj_size/2, -obj_size/2, obj_size, obj_size);
      popMatrix();
    }
  }
  f++;
}


void addTuioObject(TuioObject tobj) {
  println("add obj" +tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle());
}

void updateTuioObject (TuioObject tobj) {
  println("set obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle()
    +" "+tobj.getMotionSpeed()+" "+tobj.getRotationSpeed()+" "+tobj.getMotionAccel()+" "+tobj.getRotationAccel());
}

void removeTuioObject(TuioObject tobj) {
  println("del obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+")");
}

void refresh(TuioTime frameTime) {
  println("frame #"+frameTime.getFrameID()+" ("+frameTime.getTotalMilliseconds()+")");
  redraw();
}

void mousePressed() {
  saveFrame();
  exit();
}