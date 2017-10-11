int num = 200;
float mx[] = new float[num];
float my[] = new float[num];

PImage img;

PImage peace;

color cinza, verm;

void setup () {
  size(640, 640);
  
  cinza = color(129);
  verm = color(224, 36, 36);
  
  img = loadImage("buda.png");
  
  peace = loadImage("peace.png");
  
  
}

void draw () {
  imageMode(CENTER);
  setGradient(0, 0, width, height, cinza, verm, 1);
  
    if (mousePressed == true) {
    image (peace, 320, 320);
  } else {
    fill(255, 0);
  }
  
  
  image (img, mouseX, mouseY);
  
  int which = frameCount % num;
  mx[which] = mouseX;
  my[which] = mouseY;
  
  stroke(255, 70);
  
  for (int i = 0; i < num; i++) {
    int index = (which+1 + i) % num;
    ellipse(mx[index], my[index], i, i);
  }
  

}
    

// Fundo
void setGradient(int x, int y, float w, float h, color cinza, color verm, int axis ) {

  noFill();

  if (axis == 1) {  // Top to bottom gradient
    for (int i = y; i <= y+h; i++) {
      float inter = map(i, y, y+h, 0, 1);
      color c = lerpColor(cinza, verm, inter);
      stroke(c);
      line(x, i, x+w, i);
    }
  }  
}