import processing.video.*;

Capture cam;
PImage buf;

void setup(){
  background(255);
  size(480,640);
  cam = new Capture(this, 480,640);
  cam.start();
  frameRate(100);
}

void draw() {
  cam.read();
  for (int i = 0; i < 100; i++){
    float x = random(width);
    float y = random (height);
    color c = cam.get(int(x), int(y));
    fill(c,25);
    noStroke();
    tint(255,0,0);
    //ellipse(x,y,15,15);
    //rect(x,y,15,15);
    set(int(x),int(y),c);}
}