import TUIO.*;             // import the TUIO library

TuioProcessing tuioClient; // declare a TuioProcessing client
TuioObject ameba3;

void setup()
{
  size(500, 500);
  
  tuioClient = new TuioProcessing(this); 
}

void draw()
{
  background(255);
  
  if (ameba3.getSymbolID() == 3)
  {
    println("FOI!");
  }
}

 //called when an object is added to the scene
void addTuioObject(TuioObject tobj) {
  //println("add obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle());
  println(tobj.getSymbolID(), tobj.getX());
}

// called when an object is moved
//void updateTuioObject (TuioObject tobj) {
//  println("set obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle()
//          +" "+tobj.getMotionSpeed()+" "+tobj.getRotationSpeed()+" "+tobj.getMotionAccel()+" "+tobj.getRotationAccel());
//}

// called when an object is removed from the scene
//void removeTuioObject(TuioObject tobj) {
//  println("del obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+")");
//}

// --------------------------------------------------------------
// called when a cursor is added to the scene
//void addTuioCursor(TuioCursor tcur) {
//  println("add cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY());
//}

//// called when a cursor is moved
//void updateTuioCursor (TuioCursor tcur) {
//  println("set cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY()
//          +" "+tcur.getMotionSpeed()+" "+tcur.getMotionAccel());
//}

//// called when a cursor is removed from the scene
//void removeTuioCursor(TuioCursor tcur) {
//  println("del cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+")");
//}

// --------------------------------------------------------------
// called when a blob is added to the scene
//void addTuioBlob(TuioBlob tblb) {
//  println("add blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+") "+tblb.getX()+" "+tblb.getY()+" "+tblb.getAngle()+" "+tblb.getWidth()+" "+tblb.getHeight()+" "+tblb.getArea());
//}

//// called when a blob is moved
//void updateTuioBlob (TuioBlob tblb) {
//  println("set blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+") "+tblb.getX()+" "+tblb.getY()+" "+tblb.getAngle()+" "+tblb.getWidth()+" "+tblb.getHeight()+" "+tblb.getArea()
//          +" "+tblb.getMotionSpeed()+" "+tblb.getRotationSpeed()+" "+tblb.getMotionAccel()+" "+tblb.getRotationAccel());
//}

//// called when a blob is removed from the scene
//void removeTuioBlob(TuioBlob tblb) {
//  println("del blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+")");
//}

// --------------------------------------------------------------
// called at the end of each TUIO frame
//void refresh(TuioTime frameTime) { 
//  println("frame #"+frameTime.getFrameID()+" ("+frameTime.getTotalMilliseconds()+")");
//}