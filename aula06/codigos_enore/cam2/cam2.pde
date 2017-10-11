import processing.video.*;
import processing.pdf.*;
import processing.core.PApplet;

Capture cam;
PGraphicsPDF pdf;
PImage still;
PImage print = new PImage();
//PWindow win;

void setup() {
  //win = new PWindow();
  size(480, 640);
  background(255);
  pdf = (PGraphicsPDF)beginRecord(PDF, "euzinha.pdf");
  //beginRecord(pdf);
  still = new PImage();
  print = loadImage("print3.png");

  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    
    // The camera can be initialized directly using an 
    // element from the array returned by list():
    cam = new Capture(this, 480,640);
    frameRate(30);
    cam.start();  
  }      
}

void draw() {
  //tint(255);
  image(print,0,0, 480,640);

  if (cam.available() == true) {
    cam.read();
}
  image(cam, random(-15,15), random(-10,10));
  //image(cam, mouseX, mouseY);
  tint(130,130,103,20);
  still = get();

  image(still,0,0);
  

  loadPixels();
  
  for (int y = 0; y<height; y++){
    for (int x = 0; x<width; x++){
      if (get(x,y) == color(0,0,0)) {
        pixels[y*width+x] = color(255,255,255);

      }
    }

  }
  pdf.nextPage();
  updatePixels();

 
}

void mousePressed(){
  endRecord();
  exit();
}

//thanks github dude https://gist.github.com/atduskgreg/666e46c8408e2a33b09a
//class PWindow extends PApplet {
//  PWindow() {
//    super();
//    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
//  }

//  void settings() {
//    size(500, 200);
//  }

//  void setup() {
//    background(150);
//  }

//  void draw() {
//    ellipse(random(width), random(height), random(50), random(50));
//  }

//  void mousePressed() {
//    println("mousePressed in secondary window");
//  }
//}