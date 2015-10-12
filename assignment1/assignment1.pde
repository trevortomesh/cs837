XML xml;
int myIndex;
boolean cnameRead;

int maxDate = 0;
int minDate = 100000;

int maxVal;
int minVal;

int offsetx = 20;
int offsety = 20;
int scale = 300;
int scalex = 1;
float scaley = 300;
float pointSize = 20;
int alpha = 1000;

int windowWidth = 500; 
int windowHeight = 650;

String drawName = " ";

boolean selectToggle = false;
int[] selectPoint = new int[2]; 

int[] origin = {0,0};

int[] pointsShown = {1,1,1,1,1};
int[] buttonColors = {#9A348E, #A4D4B4, #B96D40, #DA627D, #FCA17D};
float[] button1 = {windowWidth - 40, windowHeight/2+pointSize};
float[] button2 = {windowWidth - 40, windowHeight/2+(pointSize*2)+5};
float[] button3 = {windowWidth - 40, windowHeight/2+(pointSize*3)+10};
float[] button4 = {windowWidth - 40, windowHeight/2+(pointSize*4)+15};
float[] button5 = {windowWidth - 40, windowHeight/2+(pointSize*5)+20};
float[][] buttons = {button1, button2, button3, button4, button5};

boolean pause = false; //halts rendering for user input

void settings(){
  size(windowWidth,windowHeight); 
}

void setup(){
  xml = loadXML("exchange2014.xml");
  background(#1A1B25);
  update();
 
}

void draw(){
  clear();
  update();
}

void update(){
  drawPoints();
  drawHUD();
  drawAxes();
} 

void drawAxes(){
 stroke(255,255,255); 
 fill(#000000);
 strokeWeight(10);
 line(offsetx,offsety,windowWidth, offsety); 
 line(offsetx, offsety, offsetx, windowHeight);  
 
 strokeWeight(1);
 for(float line = 0; line < 20; line+=0.1){
 line(float(offsetx-20), offsety+line*scale, float(offsetx+20), offsety+line*scale);
 }
 
  for(float line = 0; line < 20; line+=0.01){
 line(float(offsetx-10), offsety+line*scale, float(offsetx+10), offsety+line*scale);
 }
 
 
  for(float line = 0; line < 365; line+=30){
 line(offsetx+line, offsety-10, offsetx+line, offsety+10);
 }
 
/*  for(float line = 0; line < 20; line+=0.01){
line(offsetx, offsety-10, offsetx+line, offsety+10);
}*/
 
 
}


void alertWindow(){ // Alert window -- implamentation incomplete as of now. 
  rect(windowWidth/2, windowHeight/2, 50, 20, 7); 
}

void drawHUD(){  
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
}
 
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
        fill(#9A348E, alpha); 
        
        renderPoint(Observation_date.getContent(), Observation_data.getContent(),Currency_name.getContent());  
        
        
  } 
      }
   
   if(pointsShown[1] ==1){   
    if(getCurrency(Currency_name.getContent()).equals("Australian dollar")){
        fill(#A4D4B4, alpha); 
        renderPoint(Observation_date.getContent(), Observation_data.getContent(),Currency_name.getContent());
      }
      }
     
      if(pointsShown[2] ==1){ 
      if(getCurrency(Currency_name.getContent()).equals("Hong Kong dollar")){ 
        fill(#B96D40, alpha); 
        renderPoint(Observation_date.getContent(), Observation_data.getContent(),Currency_name.getContent());
      }
       }
       
      
     if(pointsShown[3] ==1){
      if(getCurrency(Currency_name.getContent()).equals("Swiss franc")){
        fill(#DA627D, alpha); 
        renderPoint(Observation_date.getContent(), Observation_data.getContent(), Currency_name.getContent());
      }
      }
      
      if(pointsShown[4] ==1){
      if(getCurrency(Currency_name.getContent()).equals("U.K. pound sterling")){
        fill(#FCA17D, alpha); 
        renderPoint(Observation_date.getContent(), Observation_data.getContent(), Currency_name.getContent());
      }
      }
      
  
      }
}

}


void renderPoint(String date, String data, String name){
  float drawPointSize = pointSize;
  stroke(255,255,255,30);
  ellipse(origin[0] + offsetx+days(date), origin[1]+offsety+int(float(data)*scale), drawPointSize, drawPointSize);
  if(selectToggle == true){
    if(selectPoint[0] == offsetx+days(date) &&
      selectPoint[1] == offsety+int(float(data)*scale)){
        drawPointSize = pointSize*3;
        stroke(255);
        ellipse(origin[0]+offsetx+days(date), origin[1]+offsety+int(float(data)*scale), drawPointSize, drawPointSize);
      
    
  }}
    
  if(abs(mouseX - (offsetx+days(date)))<1 &&
    abs(mouseY - (offsety+int(float(data)*scale)))<=10){
      drawPointSize = pointSize*3;
      ellipse(origin[0]+offsetx+days(date),origin[1] + offsety+int(float(data)*scale), drawPointSize, drawPointSize);
      drawName = name;
      if(mousePressed == true && mouseButton == LEFT){
       selectToggle = true; 
        selectPoint[0] = int(offsetx+days(date));
        selectPoint[1] = offsety+int(float(data)*scale);
       
    // println(selectPoint);
         
   }
   
   if(mousePressed == true && mouseButton == RIGHT){
    selectToggle = false; 
    origin[0] = 0;
    origin[1] = 0;
     
   }
     
     
         }
         

         
  }

void mouseClicked(){
  //println("Clicked"); 
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
 
void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if(selectToggle == false){
  scale += e;
  }
  /*
  if(selectToggle == true){
    scale += e;
    
  }*/
} 
 
 
int days(String ymd){
    //println(ymd);
    String[] tmpDate = split(ymd,'-');
    //println(tmpDate[0]);
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