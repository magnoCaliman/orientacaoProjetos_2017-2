import processing.video.*;

Movie videoGato;

void setup()
{
  size(500, 500);
  background(255);

  videoGato = new Movie(this, "cat.mov");
  videoGato.loop();
  videoGato.speed(0.5);
  
  //imageMode(CENTER);
}

void draw()
{
  //background(255);
  
  //if (videoGato.available() == true)
  //{
  //  videoGato.read();
  //}
  
  float filtroPB = map(mouseY, 0, 500, 0, 1);
  videoGato.filter(THRESHOLD, filtroPB);
  
  float filtroVerm = map(mouseX, 0, 500, 0, 255);
  tint(filtroVerm, 0, 0);

  image(videoGato, 0, 0);
}


void mousePressed()
{
  videoGato.jump(2.5);
}

void movieEvent(Movie videoGato)
{
  videoGato.read();
}