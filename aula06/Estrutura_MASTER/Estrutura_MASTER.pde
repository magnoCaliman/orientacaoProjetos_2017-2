Node[] node = new Node[400];
int cols = node.length;
int rows = node.length;
int [][] vertex = new int [cols][rows];
float [] degree = new float [node.length];
float vel = 2;
float thresh = 75;
float damp = 0.0003;

void setup(){
  //size(600,600);
  fullScreen();
  noCursor();
  for (int i = 0 ; i < node.length; i++){
    node[i] = new Node();
  }
  frameRate(30);
}

void draw(){
  background(0);
  for (int i = 0; i<node.length; i++){
    degree[i]=0;
    for (int j = 0; j<=i; j++){
      degree[i] = degree[i]+vertex[i][j];
      degree[j] = degree[j]+vertex[i][j];
    }
  }

  for (int i = 0; i < node.length; i++){
    node[i].drawNode(degree[i]);
    node[i].moveNode();
    
    for (int j = 0; j < i; j++){
      float d = dist(node[i].posX, node[i].posY, node[j].posX, node[j].posY);
      vertex[i][j] = 0;
      if (i != j && d < thresh){
        strokeWeight(0);
        stroke(255);
        vertex[i][j] = vertex[i][j]+1;
        vertex[j][i] = vertex[i][j];
        line(node[i].posX, node[i].posY, node[j].posX, node[j].posY);
        node[i].dampNode();
        node[j].dampNode();
      }
    }
  }
}