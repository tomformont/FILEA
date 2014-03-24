/* @pjs font="Frontage-Bold.ttf"; 
 */
 
import java.text.SimpleDateFormat;
import java.util.*;

int timer;
int duree=30;
int value = 0;
boolean isMouseReleased;


String mode="menu";

void setup() {
  size(320, 480);
  //center shape in window

  noStroke();
  frameRate(30);
  
  f = createFont("Frontage-Bold.ttf",16);
     println(items);
     //println(data);
     //println(poids);
     //println(voulume);
}

void draw() {
  //fade background
  fill(0);
  rect(0,0,width, height);


  
  organe1.draw();
  organe2.draw();
  organe3.draw();
  organe4.draw();
  organe5.draw();
  organe6.draw();
  
  
  
timer++;
  
  if (timer>duree){
    //var param[]={"sine",0.0000,1.0000,0.0000,0.0580,0.0000,0.0340,random(10,60),220.0000,370.0000,-0.6620,-1.0000,0.0000,0.0100,0.1433,0.0000,0.316,0.1350,0.0000,0.0000,0.1472,0.0000,0.0000,1.0000,-1.0000,0.0000,0.0000,-1.0000};
    //var sound = jsfxlib.createWave(param);
    //sound.play();
    
    duree=30;
    timer=0;
    
  }
  

}
 



 void mouseReleased(){
   window.navigator.vibrate(2000);
 if( value == 0){
   value++;
   
/*
organe1.changeTarget(70,80);
organe2.changeTarget(70,240);
organe3.changeTarget(70,380);
organe4.changeTarget(240,80);
organe5.changeTarget(240,240);
organe6.changeTarget(240,380);
*/
 }
 }

void keyPressed() { 
  if(value == 1){


} else {
  value--;
 
}
}


void mouseReleased(){
  
  isMouseReleased=true;
}
 


  



Organe organe1 = new Organe(0,0,"glucide");
Organe organe2 = new Organe(0,0,"lipide");
Organe organe3 = new Organe(0,0,"vitamine");
Organe organe4 = new Organe(0,0,"protide");
Organe organe5 = new Organe(0,0,"fibre");
Organe organe6 = new Organe(0,0,"fer");



class Organe {
  
  
  
int x,y;
int alpha; // transparence
int centerX = 0;
int centerY = 1;
  
float moveOrganX=10,moveOrganY=10;
int cibleX=160, cibleY=240;
  
  // center point
//int centerX, centerY;

float radius = 90, rotAngle = -90;
float accelX, accelY;
float springing = .0008, damping = .98;

//corner nodes
int nodes = 10;
float nodeStartX[] = new float[nodes];
float nodeStartY[] = new float[nodes];
float[]nodeX = new float[nodes];
float[]nodeY = new float[nodes];
float[]angle = new float[nodes];
float[]frequency = new float[nodes];
// soft-body dynamics
float organicConstant = 0.2;
String nomObjet;



 Organe (int x1, int y1 ,String nomObjet){

   alpha= int (random (40,125));
   this.nomObjet=nomObjet;
     centerX = 320;
  centerY = 180;
  // initialize frequencies for corner nodes
  for (int i=0; i<nodes; i++){
    frequency[i] = random(5, 12);
  }
   

 organicConstant= random(0,8,2);  
   radius = random(30,55);
   nodes=int(random(5,10));
 }
 
 
 
 void draw (){

     drawShape();
  moveShape();
  easeTarget();
  reduce();
  texte();
  mouseEvent();

    

 } 
  
  
 
 void drawShape() {
  //  calculate node  starting locations
  for (int i=0; i<nodes; i++){
    nodeStartX[i] = centerX+cos(radians(rotAngle))*radius;
    nodeStartY[i] = centerY+sin(radians(rotAngle))*radius;
    rotAngle += 360.0/nodes;
  }

  // draw polygon
  curveTightness(organicConstant);
  fill(255,alpha);
  beginShape();
  for (int i=0; i<nodes; i++){
    curveVertex(nodeX[i], nodeY[i]);
  }
  for (int i=0; i<nodes-1; i++){
    curveVertex(nodeX[i], nodeY[i]);
  }
  endShape(CLOSE);

  /*// draw polygon
  curveTightness(organicConstant);
  fill(255,alpha);
  beginShape();
  for (int i=0; i<nodes; i++){
    curveVertex(nodeX[i]+random(-3,3), nodeY[i]+random(-3,3));
  }
  for (int i=0; i<nodes-1; i++){
    curveVertex(nodeX[i]+random(-3,3), nodeY[i]+random(-3,3));
  }
  endShape(CLOSE);

  curveTightness(organicConstant);
  fill(255,alpha);
  beginShape();
  for (int i=0; i<nodes; i++){
    curveVertex(nodeX[i]+random(-3,3), nodeY[i]+random(-3,3));
  }
  for (int i=0; i<nodes-1; i++){
    curveVertex(nodeX[i]+random(-3,3), nodeY[i]+random(-3,3));

  }
curveTightness(organicConstant);
  fill(255,alpha);
  beginShape();
  for (int i=0; i<nodes; i++){
    curveVertex(nodeX[i], nodeY[i]+);
  }
  for (int i=0; i<nodes-1; i++){
    curveVertex(nodeX[i]+random(-3,3), nodeY[i]+random(-3,3));

  }  
  
*/
}



void moveShape() {
  //move center point
  float deltaX = mouseX-centerX;
  float deltaY = mouseY-centerY;

  // create springing effect
  deltaX *= springing;
  deltaY *= springing;
  accelX += deltaX;
  accelY += deltaY;

  // move predator's center
  //centerX += accelX;
  //centerY += accelY;

  // slow down springing
  accelX *= damping;
  accelY *= damping;

  // change curve tightness
  organicConstant = 1-((abs(accelX)+abs(accelY))*0.15);

  //move nodes
  for (int i=0; i<nodes; i++){
    nodeX[i] = nodeStartX[i]+sin(radians(angle[i]))*(accelX);
    nodeY[i] = nodeStartY[i]+sin(radians(angle[i]))*(accelY);
    angle[i]+=frequency[i];
  }
  

}


void changeTarget(int x, int y){
  
cibleX=x;
cibleY=y; 
  

}

void easeTarget(){
  if(cibleX!=centerX || cibleY!=centerY){
    
  centerX=centerX+int(0.001*(cibleX-centerX));
  centerY=centerY+int(0.001*(cibleY-centerY));

  }
}

void reduce(){
  if(cibleX!=centerX || cibleY!=centerY){
    
  centerX=centerX+int(0.1*(cibleX-centerX));
  centerY=centerY+int(0.1*(cibleY-centerY));
  
  
  }
}

void texte(){
  
  
  if (mode.equals("menu")){
   fill (200,alpha);
   textFont (f);
   text(day()+" / "+month()+" / "+year(), 80, 340); 
   
    
  } 
  
  if (mode.equals ("detail")){
    
       fill (200,alpha);
   textFont (f);
 text(nomObjet,centerX-(radius),(centerY)); 
  }
  
  if (mode.equals ("month")){
    
       fill (200,alpha);
   textFont (f);
 text(day()+" / "+month(), 50, 170); 
  }
  
  
}


void mouseEvent(){
  
  if (isMouseReleased && mousePressed && mouseX>=centerX-(radius/2) && mouseX <= centerX+(radius/2) && mouseY>=centerY-(radius/2) && mouseY <= centerY+(radius/2)){
  
    if (mode.equals("menu")){
organe1.changeTarget(70,80);
organe2.changeTarget(70,240);
organe3.changeTarget(70,380);
organe4.changeTarget(240,80);
organe5.changeTarget(240,240);
organe6.changeTarget(240,380);
isMouseReleased=false;
      mode ="detail";
    }
  }
  if (isMouseReleased && mousePressed && mouseX>=centerX-(radius/2) && mouseX <= centerX+(radius/2) && mouseY>=centerY-(radius/2) && mouseY <= centerY+(radius/2)){
      if (mode.equals("detail")){
organe1.changeTarget(70,70);
organe2.changeTarget(70,70);
organe3.changeTarget(70,70);
organe4.changeTarget(70,70);
organe5.changeTarget(70,70);
organe6.changeTarget(70,70);
isMouseReleased=false;

mode ="month";


    }
      
 }
 
 if (isMouseReleased && mousePressed && mouseX>=centerX-(radius/2) && mouseX <= centerX+(radius/2) && mouseY>=centerY-(radius/2) && mouseY <= centerY+(radius/2)){
  
    if (mode.equals("month")){
organe1.changeTarget(160,240);
organe2.changeTarget(160,240);
organe3.changeTarget(160,240);
organe4.changeTarget(160,240);
organe5.changeTarget(160,240);
organe6.changeTarget(160,240); 
isMouseReleased=false;

      mode ="menu";
    }
  }
  
  
}

}




