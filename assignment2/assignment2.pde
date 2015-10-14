Table rawData;

int windowWidth = 500; 
int windowHeight = 650;
Cereal[] cereals;
int index;

void settings(){
  size(windowWidth,windowHeight); 
}

void setup(){
  background(#1A1B25); 
  
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
}


void update(){
  
  
}  

class Cereal { 
  String name, mfr,type;
  float calories,protein,fat,sodium,fiber,carbo,sugars,shelf,potass,vitamins,weight,cups;

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
  carbo = tmpcarbo;
  sugars = tmpsugars;
  shelf = tmpshelf;
  potass = tmppotass;
  vitamins = tmpvitamins;
  weight = tmpweight;
  cups = tmpcups;
  }
}