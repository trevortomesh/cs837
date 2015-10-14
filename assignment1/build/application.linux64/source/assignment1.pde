XML xml; 
int myIndex;
boolean cnameRead;

float scaleFactor, translateX, translateY;

String selectName = " ";

int maxDate = 0;
int minDate = 100000;

int maxVal;
int minVal;

boolean xPressed = false;
float[] defaultScale = {1,300};
float[] scale = defaultScale;
int offsetx = 30;
int offsety = 30;
float pointSize = 20;
int alpha = 1000;

int windowWidth = 500; 
int windowHeight = 650;

String drawName = " ";

boolean selectToggle = false;
float[] selectPoint = new float[2]; 

float[] origin = {0,0};

int[] pointsShown = {1,1,1,1,1};
int[] buttonColors = {#9A348E, #A4D4B4, #B96D40, #DA627D, #FCA17D};
float[] button1 = {windowWidth - 40, windowHeight/2+pointSize};
float[] button2 = {windowWidth - 40, windowHeight/2+(pointSize*2)+5};
float[] button3 = {windowWidth - 40, windowHeight/2+(pointSize*3)+10};
float[] button4 = {windowWidth - 40, windowHeight/2+(pointSize*4)+15};
float[] button5 = {windowWidth - 40, windowHeight/2+(pointSize*5)+20};
float[][] buttons = {button1, button2, button3, button4, button5};

boolean pause = false; //halts rendering for user input

//--------------------------------------------------------------------
//Remove for processing 2 compatability
void settings(){
  size(windowWidth,windowHeight); 
}

//---------------------------------------------------------------------
void setup(){
  xml = loadXML("exchange2014.xml");
  background(#1A1B25);
  //size(windowWidth,windowHeight); //enable for processing 2 compatability 
  scaleFactor = 1;
  translateX = 0;
  translateY = 0;
  
}

//----------------------------------------------------------------------
void draw(){
  clear();
  update();
}

//----------------------------------------------------------------------
void update(){
  drawPoints();
  drawHUD();
  drawAxes();
} 

//----------------------------------------------------------------------
void drawAxes(){
 stroke(255,255,255); 
 fill(#000000);
 strokeWeight(10);
 line(offsetx,offsety,windowWidth, offsety); 
 line(offsetx, offsety, offsetx, windowHeight);  
 
 strokeWeight(1);
 for(float line = 0; line < 20; line+=0.1){
 line(float(offsetx-20), offsety+line*scale[1], float(offsetx+20), offsety+line*scale[1]);
 }
 
 for(float line = 0; line < 20; line+=0.01){
   line(float(offsetx-10), offsety+line*scale[1], float(offsetx+10), offsety+line*scale[1]);
 }
 
 for(float line = 0; line < 365; line+=30){
   line(offsetx+line*scale[0], offsety-10, offsetx+line*scale[0], offsety+10);
 }
}

void alertWindow(){ // Alert window -- implamentation incomplete as of now. 
  rect(windowWidth/2, windowHeight/2, 50, 20, 7); 
}

//-----------------------------------------------------------------------------
void drawHUD(){  
 PFont drawFont;
 strokeWeight(1);
 fill(#63372C); 
 rect(windowWidth - 60, windowHeight/2, pointSize+20, 6*pointSize+20, 7);
 for(int btn = 0; btn < 5; btn++){
   if(abs(mouseX - (buttons[btn][0]))<10 &&
      abs(mouseY - (buttons[btn][1]))<10){
      stroke(225);
      fill(buttonColors[btn]);
      ellipse(buttons[btn][0], buttons[btn][1], pointSize, pointSize);      
   }
         
 else{
   if(pointsShown[btn] == 1){
 stroke(0);
 fill(buttonColors[btn], alpha);
 ellipse(buttons[btn][0], buttons[btn][1], pointSize, pointSize); 
   } 
   
 if(pointsShown[btn] == 0){
 noStroke();
 fill(buttonColors[btn], 50);
 ellipse(buttons[btn][0], buttons[btn][1], pointSize, pointSize); 
      }
    }
  }
  
      fill(#82846D);
      text(drawName, 250, 100);
      
      drawFont = loadFont("Arial-Black-12.vlw");
      textFont(drawFont);
      text("Zoom:Scroll-wheel +/-   RMB:Select Series   LMB:Deselect Series", offsetx + 30, windowHeight);
    }

//---------------------------------------------------------------------
void drawPoints(){
  PFont drawFont;
  strokeWeight(1);
  drawFont = loadFont("Carlito-Bold-30.vlw");
  textFont(drawFont);
  
  XML[] observation = xml.getChildren("Observation");

  for(int i = 0; i < observation.length; i++){
    cnameRead = false;
      float drawPointSize;
      XML Currency_name = observation[i].getChild("Currency_name"); 
      XML Observation_date = Currency_name.getChild("Observation_date");
      XML Observation_data = Currency_name.getChild("Observation_data");
  
      if(Observation_data.getContent().equals("Bank holiday") == false){   
        if(pointsShown[0] == 1){
        if(getCurrency(Currency_name.getContent()).equals("U.S. dollar (close)")){   
          if(selectName.equals("U.S. dollar (close)")){
            
           fill(#FF4413, alpha); 
          }
          else{
        fill(#9A348E, alpha);} 
        renderPoint(Observation_date.getContent(), Observation_data.getContent(),Currency_name.getContent());  
  } 
      }
   
   if(pointsShown[1] ==1){   
    if(getCurrency(Currency_name.getContent()).equals("Australian dollar")){
       if(selectName.equals("Australian dollar")){
           fill(#FF4413, alpha); 
          }
          else{
        fill(#A4D4B4, alpha); }
        renderPoint(Observation_date.getContent(), Observation_data.getContent(),Currency_name.getContent());
      }
      }
     
      if(pointsShown[2] ==1){ 
      if(getCurrency(Currency_name.getContent()).equals("Hong Kong dollar")){ 
        if(selectName.equals("Hong Kong dollar")){
           fill(#FF4413, alpha); 
          }
        else{  
        fill(#B96D40, alpha); }
        
        renderPoint(Observation_date.getContent(), Observation_data.getContent(),Currency_name.getContent());
      }
       }
       
      
     if(pointsShown[3] ==1){
      if(getCurrency(Currency_name.getContent()).equals("Swiss franc")){
        if(selectName.equals("Swiss franc")){
           fill(#FF4413, alpha); 
          }
        else{  
        fill(#DA627D, alpha); }
        renderPoint(Observation_date.getContent(), Observation_data.getContent(), Currency_name.getContent());
      }
      }
      
      if(pointsShown[4] ==1){
      if(getCurrency(Currency_name.getContent()).equals("U.K. pound sterling")){
        if(selectName.equals("U.K. pound sterling")){
           fill(#FF4413, alpha); 
          }
        else{  
        fill(#FCA17D, alpha); }
        renderPoint(Observation_date.getContent(), Observation_data.getContent(), Currency_name.getContent());
      }}}}}
//----------------------------------------------------------------
void renderPoint(String date, String data, String name){
  float drawPointSize = pointSize;
  stroke(255,255,255,30);
  
  //if a point is selected, highlight it and increase size
  if(selectToggle == true){  
    if(selectPoint[0] == offsetx+days(date)*scale[0] &&
      selectPoint[1] == offsety+float(data)*scale[1]){
        //drawPointSize = pointSize*3;
        //stroke(255);
  }
}

  //check if hovering over a point, highlight it and get the name for rendering.    
  if(abs(mouseX - (offsetx+days(date)*scale[0]))<1 &&
    abs(mouseY - (offsety+float(data)*scale[1]))<=10 &&
    selectToggle == false){
      stroke(255);
      drawPointSize = pointSize*3;
      drawName = name;
      
      //if the point is clicked on with LMB, lock it 
      if(mousePressed == true && mouseButton == LEFT){
        selectToggle = true; 
        selectName = getCurrency(name);
        
        
        selectPoint[0] = offsetx+days(date)*scale[0]; 
        selectPoint[1] = offsety+float(data)*scale[1];  
        
        //origin[0] = selectPoint[0];
        //origin[1] = selectPoint[1];
   }
  } 

   //if the point is clicked on with RMB, unlock it.
   if(mousePressed == true && mouseButton == RIGHT){
    selectToggle = false; 
    selectName = " ";
    origin[0] = 0;
    origin[1] = 0;
    
   // scale = defaultScale; 
   }
  
  //DRAW THE POINT
  //pushMatrix();
  //translate(translateX, translateY);
  //scale(scaleFactor);
  ellipse(origin[0]+offsetx+days(date)*scale[0], origin[1]+offsety+float(data)*scale[1], 
  drawPointSize, drawPointSize);
  //popMatrix();
  }

//------------------------------------------------------------
void mouseClicked(){
  for(int btn = 0; btn < 5; btn++){
     if(abs(mouseX - (buttons[btn][0]))<10 &&
        abs(mouseY - (buttons[btn][1]))<10){
            if(pointsShown[btn] == 1){  
                pointsShown[btn] = 0;
               }
    else{
        pointsShown[btn] = 1;
      }

 }
 }
  
}
 
//----------------------------------------------------------- 
void mouseWheel(MouseEvent event) {
  float e = event.getCount(); 
  /*scaleFactor += event.getAmount() / 100;
  translateX -= event.getAmount() * mouseX / 100;
  translateY -= event.getAmount() * mouseY / 100;
  */
  scale[1] += e;  
  scale[0] += e;
} 


//-------------------------------------------------------------------------------
void keyPressed() {
  
  /*if(key == 'x'){
    xPressed = true;
    selectToggle = false;
  }
  
}

void keyReleased(){
  if(key == 'x'){
   xPressed = false; 
  }*/
}

 
//---------------------------------------------------------- 
int days(String ymd){
    String[] tmpDate = split(ymd,'-');
    int year = int(tmpDate[0]);
    int month = int(tmpDate[1]);
    int day = int(tmpDate[2]);
    int elapsed = 0;
    

    
    switch(month){
      case 1:
        elapsed = day;  
        break;
        
      case 2:
        elapsed = 31 + day;
        break;
        
      case 3:
        elapsed = 59 + day;
        break;
        
      case 4:
        elapsed = 90 + day;
        break;
        
      case 5:
        elapsed = 120 + day;
        break;
        
      case 6: 
        elapsed = 151 + day; 
        break;
        
      case 7:
        elapsed = 181 + day;
        break;
        
      case 8:
        elapsed = 212 + day;
        break;
        
      case 9:
        elapsed = 243 + day;
        break;
        
      case 10:
        elapsed = 273 + day;
        break;
        
      case 11:
        elapsed = 304 + day;
        break;
        
      case 12:
        elapsed = 334 + day;
        break;   
    }   
    
    if(elapsed >= maxDate){
     maxDate = elapsed;  
    }
    if(elapsed <= minDate){
     minDate = elapsed;  
    }
    
    return elapsed; 
}

//-------------------------------------------------------------------------------
String getCurrency(String content){
/*This ugly little hack takes the first line of the "Currency_name" tag and 
 converts it to a string and returns that string -- to make up for the missing 
 function in the XML library. 
 */
    for(int j = 0; j < content.length(); j++){
    if(content.charAt(j) == '\n'){
      if(cnameRead == false){
      myIndex = j;
      cnameRead = true;
      }
    }
  }
            return(content.substring(0,myIndex));
}