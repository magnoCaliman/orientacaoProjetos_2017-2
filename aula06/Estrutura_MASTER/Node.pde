class Node{
  float cor,time,posX,posY,velX, velY,radius;
  
  Node(){
    cor = 170;
    posX = random(width-radius) + radius;
    posY = random(height-radius)+ radius;
    velX = random(-vel, vel);
    velY = random(-vel, vel);
    radius = 5;
  }
  
  void moveNode(){    
    posX = posX + velX;
    posY = posY + velY;
    
    if (posX>width+2*radius){
      if (velX > 0){
        posX = -2*radius;
      }
    }
    if (posX<-2*radius){
      if (velX <0){
        posX = width+2*radius;
      }
    }
    
    if (posY>height+2*radius){
      if (velY > 0){
        posY = -2*radius;
      }
    }
    if (posY<-2*radius){
      if (velY <0){
        posY = height+2*radius;
      }
    }
    //if (posX>(width-radius)){
    //  velX = velX*(-1);
    //}
    //if (posX<radius/2){
    //  velX = velX*(-1);
    //}
    //if (posY>(height-radius)){
    //  velY = velY*(-1);
    //}
    //if (posY<radius){
    //  velY = velY*(-1);
    //}
  }
  
  void drawNode(float tempRadius){
    radius = map(tempRadius,0,vertex.length,1,100);
    ellipse(posX,posY,2*radius,2*radius);
    fill(255,255,cor);
    noStroke();
  }
  
  
  void dampNode(){
    if (velX > 0){
      velX = velX - damp;
    }else{
      velX = velX + damp;
    }
    if (velY > 0){
      velY = velY - damp;
    }else{
      velY = velY + damp;
    }
  }
}