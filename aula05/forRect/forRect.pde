int tamRect, step;

void setup()
{
  size(400, 400);
  background(255);
  tamRect = 50;
  step = 100;
  noLoop();
}

void draw()
{
  for (int i = 0; i < width; i = i + step)
  {
    rect(i, height/2, tamRect, tamRect);
  }
}