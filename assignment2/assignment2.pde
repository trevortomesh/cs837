import controlP5.*;
import java.util.*;

ControlP5 control1, control2, slidex, slidey, scalex, scaley;
String ctrl1, ctrl2;
int c1, c2;
int v1, v2, sx, sy;

Table rawData;

int drawPointSize = 10;
int windowWidth = 800; 
int windowHeight = 600;
Cereal[] cereals;
int index;

int offsetx = 10; 
int offsety = 10; 

int[] scale = {50, 50};

void settings(){
  size(windowWidth,windowHeight); 

}

void setup(){
  rawData = loadTable("cereal.csv", "header");

  println(rawData.getRowCount() + " total rows in table"); 
  cereals = new Cereal[rawData.getRowCount()];
  int index = 0;

  for (TableRow row : rawData.rows()) {
    cereals[index] = new Cereal(
    row.getString("name"),
    row.getString("mfr"),
    row.getString("type"),
    float(row.getString("calories")),
    float(row.getString("protein")),
    float(row.getString("fat")),
    float(row.getString("sodium")),
    float(row.getString("fiber")),
    float(row.getString("carbo")),
    float(row.getString("sugars")),
    float(row.getString("shelf")),
    float(row.getString("potass")),
    float(row.getString("vitamins")),
    float(row.getString("weight")),
    float(row.getString("cups")));
    index++;
  }
  slidex = new ControlP5(this);
    slidex.addSlider("v1")
         .setPosition(40, 40)
         .setSize(200, 20)
         .setRange(100, 300)
         .setValue(250)
         .setColorCaptionLabel(color(20,20,20));
         
   slidey = new ControlP5(this);
    slidey.addSlider("v2")
         .setPosition(40, 40)
         .setSize(20, 200)
         .setRange(0, 300)
         .setValue(0)
         .setColorCaptionLabel(color(20,20,20)); 
         
  scalex = new ControlP5(this);
    scalex.addSlider("sx")
         .setPosition(windowWidth - 250, windowHeight - 20)
         .setSize(200, 20)
         .setRange(1, 10)
         .setValue(1)
         .setColorCaptionLabel(color(20,20,20));    
         
 scaley = new ControlP5(this);
    scaley.addSlider("sy")
         .setPosition(windowWidth - 50, windowHeight - 250)
         .setSize(20, 200)
         .setRange(1, 10)
         .setValue(1)
         .setColorCaptionLabel(color(20,20,20));        
                
         
   List l1 = Arrays.asList("calories","protein","fat","sodium","fiber","carbohydrates",
  "sugars","shelf","potassium","vitamins","weight","cups");
  
  control1 = new ControlP5(this);
  control1.addScrollableList("dropdown1")
     .setPosition(windowWidth-400, 100)
     .setSize(200, 100)
     .setBarHeight(20)
     .setItemHeight(20)
     .addItems(l1);
     
     
  control2 = new ControlP5(this);
  control2.addScrollableList("dropdown2")
     .setPosition(windowWidth-200, 100)
     .setSize(200, 100)
     .setBarHeight(20)
     .setItemHeight(20)
     .addItems(l1);  
         
      
}

void draw(){
  clear();
  update();  
  
  }
  
void update(){
  drawPoints();
 // scale[0] += v1;
 // drawHUD();
  //drawAxes(); 
}  

/*
void mouseWheel(MouseEvent event) {
  float e = event.getCount(); 
  scale[1] += e;  
  scale[0] += e;
} */
/*
void drawHUD(){  
}

void drawAxes(){ 
  
 stroke(255,255,255); 
 fill(#000000);
 strokeWeight(10);
 line(offsetx,windowHeight-offsety,windowWidth-offsetx, windowHeight-offsety); 
 line(offsetx, offsety, offsetx, windowHeight-offsety);  
 
 strokeWeight(1);
 for(float line = 0; line < 20; line+=0.1){
 line(float(offsetx-20), offsety+line, float(offsetx+20), offsety+line);
 }
 
 for(float line = 0; line < 20; line+=0.01){
   line(float(offsetx-10), offsety+line, float(offsetx+10), offsety+line);
 }
 
 for(float line = 0; line < 365; line+=30){
   line(offsetx+line, offsety-10, offsetx+line, offsety+10);
 } 
}

*/
//---------------------------------------------------------------------
void drawPoints(){
  //float maxx = 0;
  //float maxy = 0;
  for(int i = 0; i < cereals.length; i++){
      fill(#FFFFFF);
      //ellipse(100, 100, 10, 10);
     // ellipse(cereals[i].calories*2,cereals[i].fat*50, 10, 10); 
      //println(cereals[i].calories);
      //stroke(1);
      //float drawPointSize = 10;
      pushMatrix();
      translate(v1,v2);
      //scale(sx,sy);
      ellipse(cereals[i].properties[c1]*sx,cereals[i].properties[c2]*sy, drawPointSize, drawPointSize); 
      popMatrix();
      //println(cereals[i].properties[c1],cereals[i].properties[c2]);
      //fill(#FFFFAA);
      //drawPointSize = 20;
 }
    }

//----------------------------------------------------------------
void dropdown1(int n) {
  control1.get(ScrollableList.class, "dropdown1").getItem(n); 
   c1 = (int) control1.get(ScrollableList.class, "dropdown1").getItem(n).get("value"); 
//   println(c1,c2);
}

void dropdown2(int n){
control2.get(ScrollableList.class, "dropdown2").getItem(n); 
c2 = (int) control2.get(ScrollableList.class, "dropdown2").getItem(n).get("value");  
}
//----------------------------------------------------------------------
class Cereal { 
  String name, mfr,type;
  float calories,protein,fat,sodium,fiber,carbohydrates,sugars,shelf,potassium,vitamins,weight,cups;
  float[] properties = {0,0,0,0,0,0,0,0,0,0,0,0};

  // Here's a rediculously large constructor to accept all the properties of a cereal object.
  Cereal(String tmpname, String tmpmfr, String tmptype,
  float tmpcalories, float tmpprotein,float tmpfat,
  float tmpsodium,float tmpfiber,float tmpcarbo,float tmpsugars,
  float tmpshelf, float tmppotass, float tmpvitamins, float tmpweight, float tmpcups) { 
  
  name = tmpname;
  mfr = tmpmfr;
  type = tmptype;
  calories = tmpcalories;
  protein = tmpprotein;
  fat = tmpfat;
  sodium = tmpsodium;
  fiber = tmpfiber;
  carbohydrates = tmpcarbo;
  sugars = tmpsugars;
  shelf = tmpshelf;
  potassium = tmppotass;
  vitamins = tmpvitamins;
  weight = tmpweight;
  cups = tmpcups;
 
  
  properties[0] = calories;
  properties[1] = protein;
  properties[2] = fat;
  properties[3] = sodium;
  properties[4] = fiber;
  properties[5] = carbohydrates;
  properties[6] = sugars;
  properties[7] = shelf;
  properties[8] = potassium;
  properties[9] = vitamins;
  properties[10] = weight;
  properties[11] = cups;
  
  }
}