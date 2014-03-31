/* @pjs font="Frontage-Bold.otf"; 
 */

import java.text.SimpleDateFormat;
import java.util.*;

int timer;
int duree=30;
int value = 0;
boolean isMouseReleased;



Organe organe1 = new Organe(0, 0, "LAITAGES", 0);
Organe organe2 = new Organe(0, 0, "EPICERIE SALEE", 1);
Organe organe3 = new Organe(0, 0, "VIANDE", 2);
Organe organe4 = new Organe(0, 0, "EPICERIE SUCREE", 3); // CHARCUTERIE TRAITEUR
Organe organe5 = new Organe(0, 0, "BOULANGERIE", 4);
Organe organe6 = new Organe(0, 0, "FRUITS ET LEGUMES", 5);



String mode="menu";
// StringList familleLaitage;
//StringList dateLaitage;

void setup() {
  size(320, 480);
  //center shape in window
  //familleLaitage = new StringList();
  //  dateLaitage = new StringList();





  noStroke();
  frameRate(30);

  f = createFont("Frontage-Bold.otf", 16);
  //println(items);
}

void draw() {
  //fade background
  fill(0);
  rect(0, 0, width, height);




  organe1.draw();
  organe2.draw();
  organe3.draw();
  organe4.draw();
  organe5.draw();
  organe6.draw();

  //  println (organe1.poids);
  // println (familleLaitage.get(0));
  //  println (dateLaitage.get(0));

  /*
  
   for (int i=0; i<etiquette.length; i++) {
   
   // je crée un nouvel objet Etiquette et je lui attribue en argument le numéro de téléphone correspondant
   
   etiquette[i]= new Etiquette(items[i], items2[i], items3[i]);
   
   }
   
   */


  timer++;

  if (timer>duree) {
    //var param[]={"sine",0.0000,1.0000,0.0000,0.0580,0.0000,0.0340,random(10,60),220.0000,370.0000,-0.6620,-1.0000,0.0000,0.0100,0.1433,0.0000,0.316,0.1350,0.0000,0.0000,0.1472,0.0000,0.0000,1.0000,-1.0000,0.0000,0.0000,-1.0000};
    //var sound = jsfxlib.createWave(param);
    //sound.play();

    duree=30;
    timer=0;
  }
}





void keyPressed() { 
  if (value == 1) {
  } 
  else {
    value--;
  }
}


void mouseReleased() {

  isMouseReleased=true;
}








/*
class Etiquette {
 
 //var qui contiennent les infos
 String familyLabel;
 String timeStamp;
 String computedWeight;
 String [] laitage ={ "FROMAGE LS", "LAIT LS" };
 String [] sucre = {"SUCRES","CONFISERIE"}
 
 
 //setup de l'etiquette
 Etiquette(String FamilyLabel, String timeStamp, String computedWeight){
 
 this.familyLabel=familyLabel;
 this.timeStamp=timeStamp;
 this.computedWeight=computedWeight;
 
/*
 if (familyLabel.equals ("monString")){
 
 }
 
 */
/*
    for (int i=0; i< laitage.length(); i++){
 if (familyLabel.equals (laitage[i])){
 println ("ok");
 }
 
 }
 for (int i=0; i< sucre.length(); i++){
 if (familyLabel.equals (sucre[i])){
 println ("ok");
 }
 
 }
 
 
 }
 }
 */











class Organe {
  
  
  
  
  
  



  int x, y;
  int alpha; // transparenc
  boolean changeOpacity; // si true activer le changement d'opacite
  boolean noOpacity; //  si true reprend opacité de base
  boolean resetOpacity;

  int centerX = 0;
  int centerY = 1;

  float moveOrganX=10, moveOrganY=10;
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
  String []categories = {
    "LAITAGES", "EPICERIE SUCREE", 
    "VIANDE", "EPICERIE SALEE", "BOULANGERIE", "FRUITS & LÉGUMES"
  };


  int id; // numero pour identifier la categorie d'objet

  // categorie de produits a rechercher
  String [] laitage = { 
    "FROMAGE LS", "LAIT LS","ULTRA FRAIS", "OEUFS", "BEURRE"
  };
  String [] sale = {
    "CONSERVES POISSONS", "CONSERVES LEGUMES","FRUITS ET LEGUMES SECS","VINAIGRE","PRODUITS SALES APERITIFS","CHIPS","CONDIMENTS ET SAUCES","PLATS CUISINES ET A PREPARER"
  };
  
  String [] viandes = {
    "TRAITEUR LS", "CONSERVES VIANDES","CHARCUTERIE LS ET SALAISONS","VOLAILLES LS" 
  };
  String [] sucre = {
    "SUCRES", "CONFISERIE","CHOCOLATS TABLETTES","CONFITURES-FRUITS AU SIROP","BISCUITERIE"
  };
  String [] boulangerie = {
    "PAINS BLANCS", "BISCUITERIE","VIENNOISERIE TRAD","PATISSERIE LS INDUS","VIENNOISERIES LS INDUS"
  };
  String [] fruitsLegumes = {
    "LEGUMES FRAIS", "F/L RAYON REFRIGERE DLC COURTE","FRUITS FRAIS","F/L FRAIS EMBALLE","F/L LONGUE CONSERVATION"
  };
 
 
  
  float [] apportIdeal= {0.3, 0.8, 0.4,0.9,0.2,0.6};
int valeurApport; // minimum -100 // maximum 100  

  // tableau temporaire pour stocker les noms de produits 
  String [] familyLabelTemp=new String [items.length()];  

  // tableau definitif pour les noms de produits
  String [] listeDesProduits=new String [items.length()];

  // tableau temporaire pour stocker les dates
  String []  dateTemp=new String [items.length()];

  // tableau definitif pour les dates de produits
  String [] listeDesDates=new String [items.length()];

  // nombre d'element dans mon tableau qui m'interesse
  int nbElement;

  float poids;

  float []poidsDetail = new Float [items.length()];

  Organe (int x1, int y1, String nomObjet, int id) {


    alpha= int (random (40, 125));
    this.nomObjet=nomObjet;
    this.id=id;



    centerX = 320;
    centerY = 180;
    // initialize frequencies for corner nodes
    for (int i=0; i<nodes; i++) {
      frequency[i] = random(5, 12);
    }
    this.nomObjet= nomObjet;

    organicConstant= random(0, 8, 2);  
    radius = random(30, 55);
    nodes=int(random(5, 10));
    


changeOpacityDefault(){

if (resetOpacity){
      if (alpha <=initialOpacity) {
        alpha+=10;
      }
      else {
        resetOpacity =false;
      }

}
}




    ////////////////////////////////////////
    ////////////LAITAGE ////////////////////
    ////////////////////////////////////////

    // si mon objet represente le laitage
    if (id==0) { 

      // je vais dans la liste de tout les familyLabel
      for (int i; i<items.length(); i++) {

        // je vais dans la liste de toutes les catégories de laitage que je recherche
        for (int j; j<laitage.length(); j++) {

          // si mon familyLabel est similaire a la categore de laitage
          if (items[i].equals(laitage[j])) {




            // je stocke temporairement le nom de mon produit
            familyLabelTemp[nbElement]=items[i];
            // j'addition le poids
            poids=poids+ items3[i];
            println (poids);
            
            // je recupere le poids de l'objet
            poidsDetail[nbElement]= items3[i];

            //println(items2[i]);

            // je stocke temporairement la date
            dateTemp[nbElement]=items2[i];
            //println (familyLabelTemp[i]+" "+dateTemp[i]+ " "+i);

            // je rajoute 1 a ma variable nbElement 
            nbElement+=1;
          }
        }
      }
      
      // calcul du pourcentage de l'apport 
      
  valeurApport = int (map(poids, 0, apportIdeal[id],0,100 ));
println (poids+ " "+valeurApport);  
      
      
      /*
      // j'initialise mon tableau final pour stocker le nom et la date des produits
       listeDesProduits = new String [nbElement];
       listeDesDates = new String [nbElement]; 
       println  (listeDesProduits.length());
       // je fait une boucle pour transferer les donnees de ma variable temporaire vers ma variable finale
       for (int = 0; i< nbElement.length(); i++) {
       listeDesProduits[i]= familyLabelTemp[i];
       listeDesDates[i]=dateTemp[i];
       
       println (listeDesProduits[i]+ " "+listeDesDates[i]);
       }
       */
    }

    //////////////////////////////////////////
    ////////////////////////////////////////
    ////////////////////////////////////////

    
    
    //////////////////////////////////////////
    /////////////epicerie salee//////////////
    ////////////////////////////////////////

    
    if (id==1) { 

      // je vais dans la liste de tout les familyLabel
      for (int i; i<items.length(); i++) {

        // je vais dans la liste de toutes les catégories de laitage que je recherche
        for (int j; j<sale.length(); j++) {

          // si mon familyLabel est similaire a la categore de laitage
          if (items[i].equals(sale[j])) {




            // je stocke temporairement le nom de mon produit
            familyLabelTemp[nbElement]=items[i];
            // j'addition le poids
            poids=poids+ items3[i];
            println (poids);
            
            // je recupere le poids de l'objet
            poidsDetail[nbElement]= items3[i];

            println(items2[i]);

            // je stocke temporairement la date
            dateTemp[nbElement]=items2[i];
            println (familyLabelTemp[i]+" "+dateTemp[i]+ " "+i);

            // je rajoute 1 a ma variable nbElement 
            nbElement+=1;
          }
        }
      }
      
      // calcul du pourcentage de l'apport 
      
  valeurApport = int (map(poids, 0, apportIdeal[id],0,100 ));

      
      
      /*
      // j'initialise mon tableau final pour stocker le nom et la date des produits
       listeDesProduits = new String [nbElement];
       listeDesDates = new String [nbElement]; 
       println  (listeDesProduits.length());
       // je fait une boucle pour transferer les donnees de ma variable temporaire vers ma variable finale
       for (int = 0; i< nbElement.length(); i++) {
       listeDesProduits[i]= familyLabelTemp[i];
       listeDesDates[i]=dateTemp[i];
       
       println (listeDesProduits[i]+ " "+listeDesDates[i]);
       }
       */
    }
    
    
    
    
    
     //////////////////////////////////////////
    /////////////  viandes  //////////////
    ////////////////////////////////////////

    
    if (id==2) { 

      // je vais dans la liste de tout les familyLabel
      for (int i; i<items.length(); i++) {

        // je vais dans la liste de toutes les catégories de laitage que je recherche
        for (int j; j<viandes.length(); j++) {

          // si mon familyLabel est similaire a la categore de laitage
          if (items[i].equals(viandes[j])) {




            // je stocke temporairement le nom de mon produit
            familyLabelTemp[nbElement]=items[i];
            // j'addition le poids
            poids=poids+ items3[i];
            println (poids);
            
            // je recupere le poids de l'objet
            poidsDetail[nbElement]= items3[i];

            println(items2[i]);

            // je stocke temporairement la date
            dateTemp[nbElement]=items2[i];
            println (familyLabelTemp[i]+" "+dateTemp[i]+ " "+i);

            // je rajoute 1 a ma variable nbElement 
            nbElement+=1;
          }
        }
      }
      
      // calcul du pourcentage de l'apport 
      
  valeurApport = int (map(poids, 0, apportIdeal[id],0,100 ));

      
      
      /*
      // j'initialise mon tableau final pour stocker le nom et la date des produits
       listeDesProduits = new String [nbElement];
       listeDesDates = new String [nbElement]; 
       println  (listeDesProduits.length());
       // je fait une boucle pour transferer les donnees de ma variable temporaire vers ma variable finale
       for (int = 0; i< nbElement.length(); i++) {
       listeDesProduits[i]= familyLabelTemp[i];
       listeDesDates[i]=dateTemp[i];
       
       println (listeDesProduits[i]+ " "+listeDesDates[i]);
       }
       */
    }
    
     //////////////////////////////////////////
    /////////////epicerie sucree /////////////
    ////////////////////////////////////////

    
    if (id==3) { 

      // je vais dans la liste de tout les familyLabel
      for (int i; i<items.length(); i++) {

        // je vais dans la liste de toutes les catégories de laitage que je recherche
        for (int j; j<sucre.length(); j++) {

          // si mon familyLabel est similaire a la categore de laitage
          if (items[i].equals(sucre[j])) {




            // je stocke temporairement le nom de mon produit
            familyLabelTemp[nbElement]=items[i];
            // j'addition le poids
            poids=poids+ items3[i];
            println (poids);
            
            // je recupere le poids de l'objet
            poidsDetail[nbElement]= items3[i];

            println(items2[i]);

            // je stocke temporairement la date
            dateTemp[nbElement]=items2[i];
            println (familyLabelTemp[i]+" "+dateTemp[i]+ " "+i);

            // je rajoute 1 a ma variable nbElement 
            nbElement+=1;
          }
        }
      }
      
      // calcul du pourcentage de l'apport 
      
  valeurApport = int (map(poids, 0, apportIdeal[id],0,100 ));
 
      
      
      /*
      // j'initialise mon tableau final pour stocker le nom et la date des produits
       listeDesProduits = new String [nbElement];
       listeDesDates = new String [nbElement]; 
       println  (listeDesProduits.length());
       // je fait une boucle pour transferer les donnees de ma variable temporaire vers ma variable finale
       for (int = 0; i< nbElement.length(); i++) {
       listeDesProduits[i]= familyLabelTemp[i];
       listeDesDates[i]=dateTemp[i];
       
       println (listeDesProduits[i]+ " "+listeDesDates[i]);
       }
       */
    }
    
    
    
    
    
    
     //////////////////////////////////////////
    /////////////boulangerie//////////////
    ////////////////////////////////////////

    
    if (id==4) { 

      // je vais dans la liste de tout les familyLabel
      for (int i; i<items.length(); i++) {

        // je vais dans la liste de toutes les catégories de laitage que je recherche
        for (int j; j<boulangerie.length(); j++) {

          // si mon familyLabel est similaire a la categore de laitage
          if (items[i].equals(boulangerie[j])) {




            // je stocke temporairement le nom de mon produit
            familyLabelTemp[nbElement]=items[i];
            // j'addition le poids
            poids=poids+ items3[i];
            println (poids);
            
            // je recupere le poids de l'objet
            poidsDetail[nbElement]= items3[i];

            println(items2[i]);

            // je stocke temporairement la date
            dateTemp[nbElement]=items2[i];
            println (familyLabelTemp[i]+" "+dateTemp[i]+ " "+i);

            // je rajoute 1 a ma variable nbElement 
            nbElement+=1;
          }
        }
      }
      
      // calcul du pourcentage de l'apport 
      
  valeurApport = int (map(poids, 0, apportIdeal[id],0,100 ));

      
      
      /*
      // j'initialise mon tableau final pour stocker le nom et la date des produits
       listeDesProduits = new String [nbElement];
       listeDesDates = new String [nbElement]; 
       println  (listeDesProduits.length());
       // je fait une boucle pour transferer les donnees de ma variable temporaire vers ma variable finale
       for (int = 0; i< nbElement.length(); i++) {
       listeDesProduits[i]= familyLabelTemp[i];
       listeDesDates[i]=dateTemp[i];
       
       println (listeDesProduits[i]+ " "+listeDesDates[i]);
       }
       */
    }
    
    
    
    
     //////////////////////////////////////////
    /////////////fruits & légumes//////////////
    ////////////////////////////////////////

    
    if (id==5) { 

      // je vais dans la liste de tout les familyLabel
      for (int i; i<items.length(); i++) {

        // je vais dans la liste de toutes les catégories de laitage que je recherche
        for (int j; j<fruitsLegumes.length(); j++) {

          // si mon familyLabel est similaire a la categore de laitage
          if (items[i].equals(fruitsLegumes[j])) {




            // je stocke temporairement le nom de mon produit
            familyLabelTemp[nbElement]=items[i];
            // j'addition le poids
            poids=poids+ items3[i];
            println (poids);
            
            // je recupere le poids de l'objet
            poidsDetail[nbElement]= items3[i];

            println(items2[i]);

            // je stocke temporairement la date
            dateTemp[nbElement]=items2[i];
            println (familyLabelTemp[i]+" "+dateTemp[i]+ " "+i);

            // je rajoute 1 a ma variable nbElement 
            nbElement+=1;
          }
        }
      }
      
      // calcul du pourcentage de l'apport 
      
  valeurApport = int (map(poids, 0, apportIdeal[id],0,100 ));

      
      
      /*
      // j'initialise mon tableau final pour stocker le nom et la date des produits
       listeDesProduits = new String [nbElement];
       listeDesDates = new String [nbElement]; 
       println  (listeDesProduits.length());
       // je fait une boucle pour transferer les donnees de ma variable temporaire vers ma variable finale
       for (int = 0; i< nbElement.length(); i++) {
       listeDesProduits[i]= familyLabelTemp[i];
       listeDesDates[i]=dateTemp[i];
       
       println (listeDesProduits[i]+ " "+listeDesDates[i]);
       }
       */
    }
    
    
  } 
    
    
    
    
    
    
    
    



  void draw () {

    drawShape();
    moveShape();
    easeTarget();
    reduce();
    texte();
    mouseEvent();
    fadeToBlack();
    
 

  } 


   



  void drawShape() {
    //  calculate node  starting locations
    for (int i=0; i<nodes; i++) {
      nodeStartX[i] = centerX+cos(radians(rotAngle))*radius;
      nodeStartY[i] = centerY+sin(radians(rotAngle))*radius;
      rotAngle += 360.0/nodes;
    }

    // draw polygon
    curveTightness(organicConstant);
    fill(255, alpha);
    beginShape();
    for (int i=0; i<nodes; i++) {
      curveVertex(nodeX[i], nodeY[i]);
    }
    for (int i=0; i<nodes-1; i++) {
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
    for (int i=0; i<nodes; i++) {
      nodeX[i] = nodeStartX[i]+sin(radians(angle[i]))*(accelX);
      nodeY[i] = nodeStartY[i]+sin(radians(angle[i]))*(accelY);
      angle[i]+=frequency[i];
    }
  }


  void changeTarget(int x, int y) {

    cibleX=x;
    cibleY=y;
  }

  void easeTarget() {
    if (cibleX!=centerX || cibleY!=centerY) {

      centerX=centerX+int(0.001*(cibleX-centerX));
      centerY=centerY+int(0.001*(cibleY-centerY));
    }
  }


  void fadeToBlack() {
    if (changeOpacity) {
      if (alpha >=0) {
        alpha-=10;
      }
      else {
        changeOpacity=false;
      }
    }
  }
  
  


  void reduce() {
    if (cibleX!=centerX || cibleY!=centerY) {

      centerX=centerX+int(0.1*(cibleX-centerX));
      centerY=centerY+int(0.1*(cibleY-centerY));
    }
  }

  void texte() {


    if (mode.equals("menu")) {
      fill (200, alpha);
      textFont (f);
      text(day()+" / "+month()+" / "+year(), 80, 340);
    } 

    if (mode.equals ("detail")) {

      fill (200, alpha);
      textFont (f);
      text(nomObjet, centerX-(radius), (centerY));
    }

    if (mode.equals ("liste")) {

      fill (200, alpha);
      textFont (f);
      text( categories[id], centerX+radius+50, centerY);
      text(valeurApport[id], centerX+radius+50, centerY);

      for (int i=0; i<nbElement; i++) {

        text( nf (poidsDetail[i],1,3)+" kg  "+ familyLabelTemp[i], width/10,(height/3)+(i*30));
        // IMPRIMER LA VALEUR DE L'APPORT SUR L'ECRAN (EN %)
       text(valeurApport[id], centerX+radius+50, centerY+100);
      }

      //    text(day()+" / "+month(), 50, 170);
    }
  }


  void mouseEvent() {

    if (isMouseReleased && mousePressed && mouseX>=centerX-(radius/2) && mouseX <= centerX+(radius/2) && mouseY>=centerY-(radius/2) && mouseY <= centerY+(radius/2)) {

      if (mode.equals("menu")) {
        organe1.changeTarget(70, 80);
        organe2.changeTarget(70, 240);    //70, 240
        organe3.changeTarget(70, 380);    //70, 380
        organe4.changeTarget(240, 80);    //240, 80
        organe5.changeTarget(240, 240);    //240, 240
        organe6.changeTarget(240, 380);    //240, 380
        isMouseReleased=false;
        mode ="detail";
      }
    }
    
    
    if (isMouseReleased && mousePressed && mouseX>=centerX-(radius/2) && mouseX <= centerX+(radius/2) && mouseY>=centerY-(radius/2) && mouseY <= centerY+(radius/2)) {
      
      


      if (mode.equals("liste")) {
        println("ok");
        
        
        organe1.resetOpacity=true;
        organe2.resetOpacity=true;
        organe3.resetOpacity=true;
        organe4.resetOpacity=true;
        organe5.resetOpacity=true;
        organe6.resetOpacity=true;
        isMouseReleased=false;
        
        


mode="detail";
      }
    }
    
    
    if (isMouseReleased && mousePressed && mouseX>=centerX-(radius/2) && mouseX <= centerX+(radius/2) && mouseY>=centerY-(radius/2) && mouseY <= centerY+(radius/2)) {
      if (mode.equals("detail")) {

        switch (id) {
          
          //COLONNE GAUCHE
        case 0:
          organe1.changeTarget(70, 70);
          organe2.changeOpacity=true;
          organe3.changeOpacity=true;
          organe4.changeOpacity=true;
          organe5.changeOpacity=true;
          organe6.changeOpacity=true;

          break;

        case 1:
          organe1.changeOpacity=true;
          organe2.changeTarget(70, 70);
          organe3.changeOpacity=true;
          organe4.changeOpacity=true;
          organe5.changeOpacity=true;
          organe6.changeOpacity=true;

          break;

        case 2:
          
          organe1.changeOpacity=true;
          organe2.changeOpacity=true;
          organe3.changeTarget(70, 70);
          organe4.changeOpacity=true;
          organe5.changeOpacity=true;
          organe6.changeOpacity=true;

          break;


// Les cercles de droite ne bougent pas, ils restent à leur place alors qu'il devraient s'aligner en haut à gauche
        case 3:
          organe1.changeOpacity=true;
          organe2.changeOpacity=true;
          organe3.changeOpacity=true;
          organe4.changeTarget(70, 70);
          organe5.changeOpacity=true;
          organe6.changeOpacity=true;

          break;

        case 4:
          organe1.changeOpacity=true;
          organe2.changeOpacity=true;
          organe3.changeOpacity=true;
          organe4.changeOpacity=true;
          organe5.changeTarget=(70, 70);
          organe6.changeOpacity=true;

          break;

        case 5:
          organe1.changeOpacity=true;
          organe2.changeOpacity=true;
          organe3.changeOpacity=true;
          organe4.changeOpacity=true;
          organe5.changeOpacity=true;
          organe6.changeTarget=(70, 70);

          break;
         
        }





        isMouseReleased=false;

        mode ="liste";
      }
    }
    
    
    //retourner au mode detail // Faire que les cercles redeviennent opaques/visibles

    if (isMouseReleased && mousePressed && mouseX>=centerX-(radius/2) && mouseX <= centerX+(radius/2) && mouseY>=centerY-(radius/2) && mouseY <= centerY+(radius/2)) {
      
      
      //isMouseReleased && mousePressed && mouseX>=centerX-(radius/2) && mouseX <= centerX+(radius/2) && mouseY>=centerY-(radius/2) && mouseY <= centerY+(radius/2)

      if (mode.equals("liste")) {
        
       
        


mode="detail";
      }
    }
  }
}





