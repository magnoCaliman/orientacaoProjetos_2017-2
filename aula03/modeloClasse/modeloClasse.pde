Bola b1;
Bola b2;

void setup()
{
  size(500, 500);
  background(255);
  rectMode(CENTER);
  
  b1 = new Bola(100);
  b2 = new Bola(200);
}

void draw()
{
  background(255);
  
  b1.desenhaBola();
  b1.moveBola();
  
  b2.desenhaBola();
  b2.posX = mouseX;
  b2.posY = mouseY;
  b2.tam = 60;
}

class Bola
{
  float posX, posY, tam, cinza;
  
  Bola(float tempCinza)
  {
    posX = random(width);
    posY = random(height);
    tam  = 40;
    cinza = tempCinza;
  }
  
  void desenhaBola()
  {
    fill(cinza);
    ellipse(posX, posY, tam, tam);
    rect(posX + random(-5, 5), posY, tam/2, tam/2);
  }
  
  void moveBola()
  {
    posX = posX + random(-2, 2);
    posY = posY + random(-2, 2);
  }
}