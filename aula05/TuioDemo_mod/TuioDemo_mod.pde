import TUIO.*; //<>//
// declare a TuioProcessing client
TuioProcessing tuioClient;

boolean verbose = true; // print console debug messages
boolean callback = true; // updates only after callbacks

void setup()
{
  // GUI setup
  size(500, 500);
  noStroke();
  fill(0);
  
  // periodic updates
  if (!callback) {
    frameRate(60);
    loop();
  } else noLoop(); // or callback updates 
  
  tuioClient  = new TuioProcessing(this);
}

// within the draw method we retrieve an ArrayList of type <TuioObject>, <TuioCursor> or <TuioBlob>
// from the TuioProcessing client and then loops over all lists to draw the graphical feedback.
void draw()
{
  background(255);
   
  ArrayList<TuioObject> tuioObjectList = tuioClient.getTuioObjectList();
  for (int i = 0; i < tuioObjectList.size(); i++) 
  {
     TuioObject tobj = tuioObjectList.get(i);
     fill(0);
     pushMatrix();
       translate(tobj.getScreenX(width),tobj.getScreenY(height));
       rotate(tobj.getAngle());
       rect(0, 0, 100, 100);
     popMatrix(); 
   }  
}

// --------------------------------------------------------------
// these callback methods are called whenever a TUIO event occurs
// there are three callbacks for add/set/del events for each object/cursor/blob type
// the final refresh callback marks the end of each TUIO frame

// called when an object is added to the scene
void addTuioObject(TuioObject tobj) {
  if (verbose) println(tobj.getSymbolID(), tobj.getSessionID(), tobj.getX(), tobj.getY(), tobj.getAngle());
}

 //called when an object is moved
void updateTuioObject (TuioObject tobj) {
  if (verbose) println(tobj.getSymbolID(), tobj.getSessionID(), tobj.getX(), tobj.getY(), tobj.getAngle(), tobj.getMotionSpeed(), tobj.getRotationSpeed(), tobj.getMotionAccel(), tobj.getRotationAccel());
}


// called when an object is removed from the scene
void removeTuioObject(TuioObject tobj) {
  if (verbose) println("del obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+")");
}

// --------------------------------------------------------------
// called at the end of each TUIO frame
void refresh(TuioTime frameTime) {
  if (verbose) println("frame #"+frameTime.getFrameID()+" ("+frameTime.getTotalMilliseconds()+")");
  if (callback) redraw();
}