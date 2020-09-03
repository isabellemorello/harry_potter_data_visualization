// Iniziato: 8/07/2020

import http.requests.*;

// https://www.potterapi.com/v1/characters?key=$2a$10$VVv//TXBcNwwhSLFKb8UoeUmHjZxK1/aeH9OcChCnU3CE3p9aW3W2
String APIKEY = "$2a$10$VVv//TXBcNwwhSLFKb8UoeUmHjZxK1/aeH9OcChCnU3CE3p9aW3W2";
String URLc = "https://www.potterapi.com/v1/characters?key=";
String URLh = "https://www.potterapi.com/v1/houses?key=";

JSONArray json, characters, houses;

String role, house, blood;//, bloodStatus, species;
// String name, patronus, species, bloodStatus, role, school, alias, wand, boggart, animagus;
boolean deathEater, dumbledoresArmy, orderOfThePhoenix, ministryOfMagic;

int memberGryff, memberSlyth, memberHuff, memberRaven, level;
JSONObject jsonGryff, jsonSlyth, jsonHuff, jsonRaven, jsonCharacter;
JSONArray memberG, memberS, memberH, memberR;

PImage gryffindor, slytherin, hufflepuff, ravenclaw;

PFont font;
PFont font2;

color red = color(163, 35, 35);
color green = color(50, 113, 30);
color yellow = color(226, 205, 69);
color blue = color(7, 119, 173);

// Variabili per il bottone di comparazione dei radar
int textCompareX = 0;
int textCompareY = 310;
int mouseX1 = textCompareX - 230;
int mouseX2 = textCompareX + 230;
int mouseY1 = textCompareY - 25;
int mouseY2 = textCompareY + 30;
boolean compareRadars = false;
String clickButton = "Click here to compare the radar charts between houses";
boolean changeHouseName = false;


void setup() {
  pixelDensity(2);
  fullScreen();
  background(0);
  surface.setTitle("Harry Potter World"); 
  getData();
  dataCall();
}

void draw() {
  background(0);
  PImage hogwarts = loadImage("hogwarts.png");
  pushMatrix();
  scale(1.5);
  if (level == 1) {
    tint(red, 120);
  } else if (level == 2) {
    tint(green, 120);
  } else if (level == 3) {
    tint(yellow, 75);
  } else if (level == 4) {
    tint(blue, 90);
  } else {
    tint(255, 60);
  }
  image(hogwarts, 0, 0);
  noTint();
  popMatrix();

  switch(level) {
  case 0:
    strokeWeight(1);
    drawHousesRect();
    drawBarChart();
    drawGui();
    break;

  case 1:
    gryfInformation();
    drawRadarChart("Gryffindor");
    if (compareRadars) {
      changeHouseName = true;
      pushMatrix();
      float newOriginX1 = width / 2 + width / 5;
      float newOriginY1 = 70 + height / 2;
      translate(newOriginX1, newOriginY1);
      drawRadarCharts("Gryffindor");
      drawRadarCharts("Slytherin");
      drawRadarCharts("Hufflepuff");
      drawRadarCharts("Ravenclaw");
      popMatrix();
    }
    break;

  case 2:
    slythInformation();
    drawRadarChart("Slytherin");
    if (compareRadars) {
      changeHouseName = true;
      pushMatrix();
      float newOriginX1 = width / 2 + width / 5;
      float newOriginY1 = 70 + height / 2;
      translate(newOriginX1, newOriginY1);
      drawRadarCharts("Gryffindor");
      drawRadarCharts("Slytherin");
      drawRadarCharts("Hufflepuff");
      drawRadarCharts("Ravenclaw");
      popMatrix();
    }
    break;

  case 3:
    huffleInformation();
    drawRadarChart("Hufflepuff");
    if (compareRadars) {
      changeHouseName = true;
      pushMatrix();
      float newOriginX1 = width / 2 + width / 5;
      float newOriginY1 = 70 + height / 2;
      translate(newOriginX1, newOriginY1);
      drawRadarCharts("Gryffindor");
      drawRadarCharts("Slytherin");
      drawRadarCharts("Hufflepuff");
      drawRadarCharts("Ravenclaw");
      popMatrix();
    }
    break;

  case 4:
    ravenInformation();
    drawRadarChart("Ravenclaw");
    if (compareRadars) {
      changeHouseName = true;
      pushMatrix();
      float newOriginX1 = width / 2 + width / 5;
      float newOriginY1 = 70 + height / 2;
      translate(newOriginX1, newOriginY1);
      drawRadarCharts("Gryffindor");
      drawRadarCharts("Slytherin");
      drawRadarCharts("Hufflepuff");
      drawRadarCharts("Ravenclaw");
      popMatrix();
    }
    break;
  };
}


void getData() {
  // OTTENGO DATI RELATIVI AI PERSONAGGI
  /*  GetRequest get = new GetRequest(URLc+APIKEY);
   get.send();
   println("prova: " + get.getContent());  
   json = parseJSONArray(get.getContent());
   println(json);
   saveJSONArray(json, "data/characters.json");
   println(get.getHeader("Content-Length"));
   */

  // OTTENGO DATI RELATIVI ALLE CASATE E AI PERSONAGGI
  characters = loadJSONArray("characters.json");
  houses = loadJSONArray("houses.json");

  /* for(int i = 0; i < json.size(); i++) {
   JSONObject content = json.getJSONObject(i);
   id = content.getString("_id");
   name = content.getString("name");
   role = content.getString("role");
   house = content.getString("house");
   bloodStatus = content.getString("bloodStatus");
   ministryOfMagic = content.getBoolean("ministryOfMagic");
   
   println(id + " " + house + " " + ministryOfMagic);
   }
   */
}

// RICHIAMO I DATI
void dataCall() {
  // Gryffindor
  jsonGryff = houses.getJSONObject(0);
  memberG = jsonGryff.getJSONArray("members");
  memberGryff = memberG.size();

  // Slytherin
  jsonSlyth = houses.getJSONObject(2);
  memberS = jsonSlyth.getJSONArray("members");
  memberSlyth = memberS.size();

  // Hufflepuff
  jsonHuff = houses.getJSONObject(3);
  memberH = jsonHuff.getJSONArray("members");
  memberHuff = memberH.size();

  // Ravenclaw
  jsonRaven = houses.getJSONObject(1);
  memberR = jsonRaven.getJSONArray("members");
  memberRaven = memberR.size();
}


void keyPressed() {
  if (key == '0') {
    level = 0;
  }
  if (key == '1') {
    level = 1;
  }
  if (key == '2') {
    level = 2;
  }
  if (key == '3') {
    level = 3;
  }
  if (key == '4') {
    level = 4;
  }
}


// DISEGNO LIVELLO 0 HOGWARTS
void drawHousesRect() {
  //noStroke();
  int marginTop = 200;
  int marginLeft = 100;
  int sizeRect = 300;
  int marginTop2 = marginTop + sizeRect;
  int marginRight = width - (marginLeft + (sizeRect * 2));
  int marginLeft2 = marginLeft + sizeRect;
  int marginBottom = height - (marginTop + (sizeRect * 2));
  int marginBottom2 = height - (marginBottom + sizeRect);
  int marginTop3 = marginTop + (sizeRect * 2);
  int imageX1 = (marginLeft *2) - 20;
  int imageY1 = ((marginTop + sizeRect) / 2) + 55;
  int imageX2 = marginLeft + sizeRect + 235;
  int imageX3 = marginLeft + sizeRect + 220;
  int imageY2 = marginTop + sizeRect + 235;
  int imageY3 = ((marginTop + sizeRect) / 2) + 65;
  int textY = marginTop - 20;
  int textX1 = marginLeft2 + 155;
  int textY2 = marginBottom2 + 330;
  int textX2 = textX1 - 10;
  int textX3 = ((marginTop + sizeRect) / 2);

  int barX = 975;
  int barY = height - 70;
  int spaceBar = 25;
  int bar = 50;

  PImage gryffindor = loadImage("gryffindor.png");
  PImage slytherin = loadImage("slytherin.png");
  PImage hufflepuff = loadImage("hufflepuff.png");
  PImage ravenclaw = loadImage("ravenclaw.png");

  font = createFont("harryPotterFont.TTF", 30);
  font2 = loadFont("HanziPen2.vlw");

  fill(224);
  textFont(font);
  text("Welcome to the Hogwarts School of Witchcraft and Wizardry", width/2, 100);

  textSize(22);
  text("Pass over the coat of the arms of the house \nto visualize the number of students for each house", width/2 + 350, 250);
  noStroke();
  
  // RETTANGOLO ROSSO
  if (mouseX >= marginLeft && mouseX <= marginLeft2 && mouseY >= marginTop && mouseY <= marginBottom2) {
    fill(255, 0, 0);
    textFont(font2);
    text(memberGryff, barX, barY);
    if (mousePressed == true) {
      level = 1;
    }
  } else {
    fill(red);
  }
  rect(marginLeft, marginTop, sizeRect, sizeRect, 30, 0, 0, 0);
  pushMatrix();
  scale(0.7);
  image(gryffindor, imageX1, imageY1);
  popMatrix();
  textFont(font);
  text("Gryffindor", textX3, textY);

  // RETTANGOLO VERDE
  if (mouseX >= marginLeft2 && mouseX <= marginRight && mouseY >= marginTop && mouseY <= marginBottom2) {
    fill(0, 255, 0);
    textFont(font2);
    text(memberS.size(), barX + spaceBar + bar, barY);
    if (mousePressed == true) {
      level = 2;
    }
  } else {
    fill(green);
  }
  rect(marginLeft2, marginTop, sizeRect, sizeRect, 0, 30, 0, 0);
  pushMatrix();
  scale(0.68);
  image(slytherin, imageX2, imageY3);
  popMatrix();
  textFont(font);
  text("Slytherin", textX1, textY);

  // RETTANGOLO GIALLO
  if (mouseX >= marginLeft && mouseX <= marginLeft2 && mouseY >= marginTop2 && mouseY <= marginTop3) {
    fill(255, 255, 0);
    textFont(font2);
    text(memberH.size(), barX + (spaceBar * 2) + (bar * 2), barY);
    if (mousePressed == true) {
      level = 3;
    }
  } else {
    fill(yellow);
  }
  rect(marginLeft, marginTop2, sizeRect, sizeRect, 0, 0, 0, 30);
  pushMatrix();
  scale(0.7);
  image(hufflepuff, imageX1, imageY2);
  popMatrix();
  textFont(font);
  text("Hufflepuff", textX3, textY2);

  // RETTANGOLO BLU
  if (mouseX >= marginLeft2 && mouseX <= marginRight && mouseY >= marginTop2 && mouseY <= marginTop3) {
    fill(0, 232, 255);
    textFont(font2);
    text(memberR.size(), barX + (spaceBar * 3) + (bar * 3), barY);
    if (mousePressed == true) {
      level = 4;
    }
  } else {
    fill(blue);
  }
  rect(marginLeft2, marginTop2, sizeRect, sizeRect, 0, 0, 30, 0);
  pushMatrix();
  scale(0.7);
  image(ravenclaw, imageX3, imageY2);
  popMatrix();
  textFont(font);
  text("Ravenclaw", textX2, textY2);
}


// DISEGNO IL GRAFICO A BARRE
void drawBarChart() {
  int barX = 950;
  int barY = height - 100;
  int spaceBar = 25;
  int bar = 50;

  fill(red);
  rect(barX, barY, bar, memberGryff * -10);

  fill(green);
  rect(barX + bar + spaceBar, barY, bar, memberSlyth * -10);

  fill(yellow);
  rect(barX + (bar * 2) + (spaceBar * 2), barY, bar, memberHuff * -10);

  fill(blue);
  rect(barX + (bar * 3) + (spaceBar * 3), barY, bar, memberRaven * -10);
}

// DISEGNO LA GUI
void drawGui() {
  font2 = loadFont("HanziPen.vlw");
  int lineX = 900;
  pushMatrix();
  translate(0, - 100);
  for (int i = 0; i < 450; i += 10) {
    if (i % 50 == 0) {
      stroke(255, 85);
      textAlign(CENTER);
      textFont(font2);
      fill(255, 100);
      text(i / 10, lineX - 20, 900 + (i * -1));
    } else {
      stroke(255, 40);
    }
    line(lineX, height - i, lineX + 375, height - i);
  }
  popMatrix();
}


// DISEGNO LIVELLO 1 GRIFONDORO
void gryfInformation() {
  int rectX = 60;
  int rectX1 = 520;
  int rectX2 = 70;
  int rectX3 = 500;
  int rectY = 115;
  int rectY1 = 720;
  int rectY2 = 125;
  int rectY3 = 700;
  int imageX = (rectX1 / 2) + rectX - 35;
  int imageY = 220;
  PImage gryffindor = loadImage("gryffindor.png");
  String mascot, headOfHouse, houseGhost, founder;
  int numberMembers;
  int textX = 105;
  int textX1 = 530;
  int textY = 575;
  int padding = 10;
  int buttonX = 50;
  int buttonX1 = 150;
  int buttonY = 25;
  int buttonY1 = 75;

  font = createFont("harryPotterFont.TTF", 22);
  font2 = loadFont("Hannotate.vlw");

  jsonGryff = houses.getJSONObject(0);
  memberG = jsonGryff.getJSONArray("members");
  numberMembers = memberG.size();
  mascot = jsonGryff.getString("mascot");
  headOfHouse = jsonGryff.getString("headOfHouse");
  houseGhost = jsonGryff.getString("houseGhost");
  founder = jsonGryff.getString("founder");

  noStroke();
  fill(red);
  rect(rectX, rectY, rectX1, rectY1, 20); 
  fill(255);
  textFont(font);
  textSize(40);
  textAlign(CENTER);
  text("Gryffindor", width/5 + 40, 480);
  pushMatrix();
  scale(0.7);
  image(gryffindor, imageX, imageY);
  popMatrix();

  fill(255);
  textAlign(LEFT);
  textFont(font);
  text("Mascot", textX, textY);
  text("Head of House", textX, textY + 50);
  text("Founder", textX, textY + 100);
  text("House Ghost", textX, textY + 150);
  text("Number of Members", textX, textY + 200);

  textAlign(RIGHT);
  text(mascot, textX1, textY);  
  text(headOfHouse, textX1, textY + 50); 
  text(founder, textX1, textY + 100);
  text(houseGhost, textX1, textY + 150);
  textFont(font2);
  textSize(24);
  text(numberMembers, textX1, textY + 200);

  noFill();
  strokeWeight(4);
  stroke(255);
  rect(rectX2 + padding, rectY2 + padding, rectX3 - padding * 2, rectY3 - 20, 12);

  // Bottone "BACK"
  if (mouseX >= buttonX && mouseX <= buttonX1 && mouseY >= buttonY && mouseY <= buttonY1) {
    fill(255, 0, 0);
    if (mousePressed == true) {
      level = 0;
    }
  } else {
    fill(red);
  }
  noStroke();
  rect(buttonX, buttonY, 75, 35, 30);
  fill(255);
  textFont(font);
  textSize(20);
  textAlign(CENTER, CENTER);
  text("Back", 88, 40);
}


// DISEGNO LIVELLO 2 SERPEVERDE
void slythInformation() {
  int rectX = 60;
  int rectX1 = 520;
  int rectX2 = 70;
  int rectX3 = 500;
  int rectY = 115;
  int rectY1 = 720;
  int rectY2 = 125;
  int rectY3 = 700;
  int imageX = (rectX1 / 2) + rectX - 35;
  int imageY = 220;
  PImage slytherin = loadImage("slytherin.png");
  String mascot, headOfHouse, houseGhost, founder;
  int numberMembers;
  int textX = 105;
  int textX1 = 530;
  int textY = 575;
  int padding = 10;
  int buttonX = 50;
  int buttonX1 = 150;
  int buttonY = 25;
  int buttonY1 = 75;

  font = createFont("harryPotterFont.TTF", 22);
  font2 = loadFont("Hannotate.vlw");

  jsonGryff = houses.getJSONObject(2);
  memberG = jsonGryff.getJSONArray("members");
  numberMembers = memberG.size();
  mascot = jsonGryff.getString("mascot");
  headOfHouse = jsonGryff.getString("headOfHouse");
  houseGhost = jsonGryff.getString("houseGhost");
  founder = jsonGryff.getString("founder");

  fill(green);
  noStroke();
  rect(rectX, rectY, rectX1, rectY1, 20);
  fill(255);
  textFont(font);
  textSize(40);
  textAlign(CENTER);
  text("Slytherin", width/5 + 40, 480);  
  pushMatrix();
  scale(0.7);
  image(slytherin, imageX, imageY);
  popMatrix();

  fill(255);
  textAlign(LEFT);
  textFont(font);
  text("Mascot", textX, textY);
  text("Head of House", textX, textY + 50);
  text("Founder", textX, textY + 100);
  text("House Ghost", textX, textY + 150);
  text("Number of Members", textX, textY + 200);

  textAlign(RIGHT);
  text(mascot, textX1, textY);  
  text(headOfHouse, textX1, textY + 50); 
  text(founder, textX1, textY + 100);
  text(houseGhost, textX1, textY + 150);
  textFont(font2);
  textSize(24);
  text(numberMembers, textX1, textY + 200);

  noFill();
  strokeWeight(4);
  stroke(255);
  rect(rectX2 + padding, rectY2 + padding, rectX3 - padding * 2, rectY3 - 20, 12);

  // Bottone "BACK"
  if (mouseX >= buttonX && mouseX <= buttonX1 && mouseY >= buttonY && mouseY <= buttonY1) {
    fill(0, 255, 0);
    if (mousePressed == true) {
      level = 0;
    }
  } else {
    fill(green);
  }
  noStroke();
  rect(buttonX, buttonY, 75, 35, 30);
  fill(255);
  textFont(font);
  textSize(20);
  textAlign(CENTER, CENTER);
  text("Back", 88, 40);
}


// DISEGNO LIVELLO 3 TASSOROSSO
void huffleInformation() {
  int rectX = 60;
  int rectX1 = 520;
  int rectX2 = 70;
  int rectX3 = 500;
  int rectY = 115;
  int rectY1 = 720;
  int rectY2 = 125;
  int rectY3 = 700;
  int imageX = (rectX1 / 2) + rectX - 35;
  int imageY = 220;
  PImage slytherin = loadImage("hufflepuff.png");
  String mascot, headOfHouse, houseGhost, founder;
  int numberMembers;
  int textX = 105;
  int textX1 = 530;
  int textY = 575;
  int padding = 10;
  int buttonX = 50;
  int buttonX1 = 150;
  int buttonY = 25;
  int buttonY1 = 75;

  font = createFont("harryPotterFont.TTF", 22);
  font2 = loadFont("Hannotate.vlw");

  jsonGryff = houses.getJSONObject(3);
  memberG = jsonGryff.getJSONArray("members");
  numberMembers = memberG.size();
  mascot = jsonGryff.getString("mascot");
  headOfHouse = jsonGryff.getString("headOfHouse");
  houseGhost = jsonGryff.getString("houseGhost");
  founder = jsonGryff.getString("founder");

  fill(yellow);
  noStroke();
  rect(rectX, rectY, rectX1, rectY1, 20);
  fill(0);
  textFont(font);
  textSize(40);
  textAlign(CENTER);
  text("Hufflepuff", width/5 + 40, 480);
  pushMatrix();
  scale(0.7);
  image(slytherin, imageX, imageY);
  popMatrix();

  fill(0);
  textAlign(LEFT);
  textFont(font);
  text("Mascot", textX, textY);
  text("Head of House", textX, textY + 50);
  text("Founder", textX, textY + 100);
  text("House Ghost", textX, textY + 150);
  text("Number of Members", textX, textY + 200);

  textAlign(RIGHT);
  text(mascot, textX1, textY);  
  text(headOfHouse, textX1, textY + 50); 
  text(founder, textX1, textY + 100);
  text(houseGhost, textX1, textY + 150);
  textFont(font2);
  textSize(24);
  text(numberMembers, textX1, textY + 200);

  noFill();
  strokeWeight(4);
  stroke(0);
  rect(rectX2 + padding, rectY2 + padding, rectX3 - padding * 2, rectY3 - 20, 12);

  // Bottone "BACK"
  if (mouseX >= buttonX && mouseX <= buttonX1 && mouseY >= buttonY && mouseY <= buttonY1) {
    fill(255, 255, 0);
    if (mousePressed == true) {
      level = 0;
    }
  } else {
    fill(yellow);
  }
  noStroke();
  rect(buttonX, buttonY, 75, 35, 30);
  fill(0);
  textFont(font);
  textSize(20);
  textAlign(CENTER, CENTER);
  text("Back", 88, 40);
}


// DISEGNO LIVELLO 4 CORVONERO
void ravenInformation() {
  int rectX = 60;
  int rectX1 = 520;
  int rectX2 = 70;
  int rectX3 = 500;
  int rectY = 115;
  int rectY1 = 720;
  int rectY2 = 125;
  int rectY3 = 700;
  int imageX = (rectX1 / 2) + rectX - 35;
  int imageY = 220;
  PImage slytherin = loadImage("ravenclaw.png");
  String mascot, headOfHouse, houseGhost, founder;
  int numberMembers;
  int textX = 105;
  int textX1 = 530;
  int textY = 575;
  int padding = 10;
  int buttonX = 50;
  int buttonX1 = 150;
  int buttonY = 25;
  int buttonY1 = 75;

  font = createFont("harryPotterFont.TTF", 22);
  font2 = loadFont("Hannotate.vlw");

  jsonGryff = houses.getJSONObject(1);
  memberG = jsonGryff.getJSONArray("members");
  numberMembers = memberG.size();
  mascot = jsonGryff.getString("mascot");
  headOfHouse = jsonGryff.getString("headOfHouse");
  houseGhost = jsonGryff.getString("houseGhost");
  founder = jsonGryff.getString("founder");
  
  fill(blue);
  noStroke();
  rect(rectX, rectY, rectX1, rectY1, 20);
  fill(255);
  textFont(font);
  textSize(40);
  textAlign(CENTER);
  text("Ravenclaw", width/5 + 40, 480);
  pushMatrix();
  scale(0.7);
  image(slytherin, imageX, imageY);
  popMatrix();

  fill(255);
  textAlign(LEFT);
  textFont(font);
  text("Mascot", textX, textY);
  text("Head of House", textX, textY + 50);
  text("Founder", textX, textY + 100);
  text("House Ghost", textX, textY + 150);
  text("Number of Members", textX, textY + 200);

  textAlign(RIGHT);
  text(mascot, textX1, textY);  
  text(headOfHouse, textX1, textY + 50); 
  text(founder, textX1, textY + 100);
  text(houseGhost, textX1, textY + 150);
  textFont(font2);
  textSize(24);
  text(numberMembers, textX1, textY + 200);

  noFill();
  strokeWeight(4);
  stroke(255);
  rect(rectX2 + padding, rectY2 + padding, rectX3 - padding * 2, rectY3 - 20, 12);

  // Bottone "BACK"
  if (mouseX >= buttonX && mouseX <= buttonX1 && mouseY >= buttonY && mouseY <= buttonY1) {
    fill(0, 232, 255);
    if (mousePressed == true) {
      level = 0;
    }
  } else {
    fill(blue);
  }
  noStroke();
  rect(buttonX, buttonY, 75, 35, 30);
  fill(255);
  textFont(font);
  textSize(20);
  textAlign(CENTER, CENTER);
  text("Back", 88, 40);
}


// DISEGNO GRAFICO RADAR
void drawRadarChart(String house) {
  int xEll1 = -250 + (18 * 5) + (12 * 5) + 75;
  int xEll2 = -100 + (18 * 5) + (12 * 5) + (4 * 5) + 75;
  int xEll3 = 50 + (18 * 5) + (12 * 5) + (4 * 5) + 75;
  int yText = -460;
  int yEll = -355;
  font = createFont("harryPotterFont.TTF", 18);
  font2 = loadFont("Hannotate.vlw");  

  pushMatrix();
  strokeWeight(1);
  float newOriginX = width/2 + width/5;
  float newOriginY = 70 + height / 2;
  translate(newOriginX, newOriginY);

  // DISEGNO LE LINEE
  String[] vertexNames = new String[] {"Death Eater", "Dumbledore Army", "Order of Phoenix", "Ministry of Magic", "Auror"};
  int numLine = vertexNames.length;
  float insideAngle = 360 / numLine;

  // Setto il colore
  color drawColor;
  color pressedColor;
  switch(house) {
  case "Gryffindor":
    drawColor = red;
    pressedColor = color(255, 0, 0);
    break;
  case "Slytherin":
    drawColor = green;
    pressedColor = color(0, 255, 0);
    break;
  case "Hufflepuff":
    drawColor = yellow;
    pressedColor = color(255, 255, 0);
    break;
  case "Ravenclaw":
    drawColor = blue;
    pressedColor = color(0, 232, 255);
    break;
  default:
    drawColor = color(255);
    pressedColor = color(200);
  }

  // Richiamo i dati
  String currentHouse, role, blood;
  boolean deathEater, dumbledoresArmy, orderOfThePhoenix, ministryOfMagic;

  int countPure = 0, countUnknown = 0, countMuggle = 0, countHalf = 0;
  int countDeath = 0, countRole = 0, countDumbledore = 0, countOrder = 0, countMinistry = 0;
  int countDeathG = 0, countRoleG = 0, countDumbledoreG = 0, countOrderG = 0, countMinistryG = 0;
  int countDeathS = 0, countRoleS = 0, countDumbledoreS = 0, countOrderS = 0, countMinistryS = 0;
  int countDeathH = 0, countRoleH = 0, countDumbledoreH = 0, countOrderH = 0, countMinistryH = 0;
  int countDeathR = 0, countRoleR = 0, countDumbledoreR = 0, countOrderR = 0, countMinistryR = 0;
  int[] countAll = {0};
  IntDict invBlood = new IntDict();
  IntDict invRole = new IntDict();
  IntDict invDeath = new IntDict();
  IntDict invDumbledore = new IntDict();
  IntDict invOrder = new IntDict();
  IntDict invMinistry = new IntDict();

  int countG = 0, countS = 0, countH = 0, countR = 0;

  for (int i = 0; i < characters.size(); i++) {
    jsonCharacter = characters.getJSONObject(i);
    currentHouse = jsonCharacter.getString("house");
    role = jsonCharacter.getString("role");
    blood = jsonCharacter.getString("bloodStatus");
    deathEater = jsonCharacter.getBoolean("deathEater");
    dumbledoresArmy = jsonCharacter.getBoolean("dumbledoresArmy");
    orderOfThePhoenix = jsonCharacter.getBoolean("orderOfThePhoenix");
    ministryOfMagic = jsonCharacter.getBoolean("ministryOfMagic");

    if (currentHouse != null && currentHouse.equals(house)) {
      //level = 1;
      invBlood.increment(blood);
      invRole.increment(role);
      invDeath.increment(str(deathEater));
      invDumbledore.increment(str(dumbledoresArmy));
      invOrder.increment(str(orderOfThePhoenix));
      invMinistry.increment(str(ministryOfMagic));

      switch(house) {
      case "Gryffindor":
        countG++;
        break;
      case "Slytherin":
        countS++;
        break;
      case "Hufflepuff":
        countH++;
        break;
      case "Ravenclaw":
        countR++;
        break;
      }

      // Disegno gli ellissi riferiti al "Blood-Status"
      ellipseMode(CENTER);
      switch(blood) {
      case "pure-blood":
        if (!house.equals("Ravenclaw")) {
          countPure++;
          stroke(drawColor, countPure * 10);
          fill(drawColor, countUnknown * 10);
          ellipse(-250, yEll, countPure * 10, countPure * 10);
        }
        break;
      case "unknown":
        countUnknown++;
        stroke(drawColor, countUnknown * 10);
        fill(drawColor, countUnknown * 10);
        ellipse(xEll1, yEll, countUnknown * 10, countUnknown * 10);
        break;
      case "muggle-born":
        if (house.equals("Gryffindor") || house.equals("Ravenclaw")) {
          countMuggle++;
          stroke(drawColor, countMuggle * 10);
          fill(drawColor, countMuggle * 10);
          ellipse(xEll2, yEll, countMuggle * 10, countMuggle * 10);
        }
        break;
      case "half-blood":
        countHalf++;
        stroke(drawColor, countHalf * 10);
        fill(drawColor, countHalf * 10);
        ellipse(xEll3, yEll, countHalf * 10, countHalf * 10);
        break;
      }

      // Dati per il grafico a radar
      if (deathEater == true) {
        countDeath++;
        if (house.equals("Gryffindor")) {
          countDeathG++;
        } else if (house.equals("Slytherin")) {
          countDeathS++;
        } else if (house.equals("Hufflepuff")) {
          countDeathH++;
        } else if (house.equals("Ravenclaw")) {
          countDeathR++;
        }
      }

      if (dumbledoresArmy == true) {
        countDumbledore++;
        if (house.equals("Gryffindor")) {
          countDumbledoreG++;
        } else if (house.equals("Slytherin")) {
          countDumbledoreS++;
        } else if (house.equals("Hufflepuff")) {
          countDumbledoreH++;
        } else if (house.equals("Ravenclaw")) {
          countDumbledoreR++;
        }
      }

      if (orderOfThePhoenix == true) {
        countOrder++;
        if (house.equals("Gryffindor")) {
          countOrderG++;
        } else if (house.equals("Slytherin")) {
          countOrderS++;
        } else if (house.equals("Hufflepuff")) {
          countOrderH++;
        } else if (house.equals("Ravenclaw")) {
          countOrderR++;
        }
      }

      if (ministryOfMagic == true) {
        countMinistry++;
        if (house.equals("Gryffindor")) {
          countMinistryG++;
        } else if (house.equals("Slytherin")) {
          countMinistryS++;
        } else if (house.equals("Hufflepuff")) {
          countMinistryH++;
        } else if (house.equals("Ravenclaw")) {
          countMinistryR++;
        }
      }

      if (role != null) {
        switch(role) {
        case "Auror":
        case "Auror (formerly)":
          countRole++;
          if (house.equals("Gryffindor")) {
            countRoleG++;
          } else if (house.equals("Slytherin")) {
            countRoleS = 0;
          } else if (house.equals("Hufflepuff")) {
            countRoleH++;
          } else if (house.equals("Ravenclaw")) {
            countRoleR = 0;
          }
          break;
        }
      }
    }
  }

  // Testi riferiti al "Blood-Status" (diversi per casata)
  fill(255);
  textFont(font);
  textSize(20);
  textAlign(CENTER);

  if (!house.equals("Ravenclaw")) {
    text("Pure blood", -250, yText);
  }
  text("Unknown", -250 +  (18 * 5) + (12 * 5) + 75, yText);

  if (house.equals("Gryffindor") || house.equals("Ravenclaw")) {
    text("Muggle born", -100 + (18 * 5) + (12 * 5) + (4 * 5) + 75, yText);
  }
  text("Half blood", 50 + (18 * 5) + (12 * 5) + (4 * 5) + 75, yText);

  textFont(font2);
  textSize(18);
  if (!house.equals("Ravenclaw")) {
    text(countPure, -250, yEll + 5);
  }
  text(countUnknown, -250 +  (18 * 5) + (12 * 5) + 75, yEll + 5);

  if (house.equals("Gryffindor") || house.equals("Ravenclaw")) {
    text(countMuggle, -100 + (18 * 5) + (12 * 5) + (4 * 5) + 75, yEll + 5);
  }
  text(countHalf, 50 + (18 * 5) + (12 * 5) + (4 * 5) + 75, yEll + 5);


  // Disegno il grafico a radar
  int[] countAllG, countAllS, countAllH, countAllR = {0};
  countAll = new int[] {countDeath, countDumbledore, countOrder, countMinistry, countRole};
  countAllG = new int[] {countDeathG, countDumbledoreG, countOrderG, countMinistryG, countRoleG};
  countAllS = new int[] {countDeathS, countDumbledoreS, countOrderS, countMinistryS, countRoleS};
  countAllH = new int[] {countDeathH, countDumbledoreH, countOrderH, countMinistryH, countRoleH};
  countAllR = new int[] {countDeathR, countDumbledoreR, countOrderR, countMinistryR, countRoleR};

  Radar radar = new Radar(vertexNames, 25, 250, drawColor, countAll);
  radar.drawRadar();

  if (mouseX >= newOriginX + mouseX1 && mouseX <= newOriginX + mouseX2 && mouseY >= newOriginY + mouseY1 && mouseY <= mouseY2 + newOriginY) {
    fill(pressedColor);
    stroke(pressedColor);
  } else {
    fill(drawColor);
    stroke(drawColor);
  }
  textFont(font);
  textAlign(CENTER);
  textSize(18);
  text(clickButton, textCompareX, textCompareY);
  noFill();
  strokeWeight(1);
  rect(mouseX1, mouseY1, 460, 40, 30);

  if (changeHouseName) {
    clickButton = "Click here to see " + house + " radar chart";
  } else {
    clickButton = "Click here to compare the radar charts between houses";
  }
  popMatrix();
}


void mouseClicked() {
  float newOriginX = width / 2 + width / 5;
  float newOriginY = 70 + height / 2;

  if (mouseX >= newOriginX + mouseX1 && mouseX <= newOriginX + mouseX2 && 
    mouseY >= newOriginY + mouseY1 && mouseY <= mouseY2 + newOriginY) {
    compareRadars = !compareRadars;
    changeHouseName = !changeHouseName;
  }
}


void drawRadarCharts(String house) {
  // Dati
  String currentHouse, role;
  boolean deathEater, dumbledoresArmy, orderOfThePhoenix, ministryOfMagic;

  int countDeath = 0, countRole = 0, countDumbledore = 0, countOrder = 0, countMinistry = 0;
  int[] countAll = {0};
  IntDict invRole = new IntDict();
  IntDict invDeath = new IntDict();
  IntDict invDumbledore = new IntDict();
  IntDict invOrder = new IntDict();
  IntDict invMinistry = new IntDict();
  int countG = 0, countS = 0, countH = 0, countR = 0;
  String[] vertexNames = new String[] {"Death Eater", "Dumbledore Army", "Order of Phoenix", "Ministry of Magic", "Auror"};

  for (int i = 0; i < characters.size(); i++) {
    jsonCharacter = characters.getJSONObject(i);
    currentHouse = jsonCharacter.getString("house");
    role = jsonCharacter.getString("role");
    deathEater = jsonCharacter.getBoolean("deathEater");
    dumbledoresArmy = jsonCharacter.getBoolean("dumbledoresArmy");
    orderOfThePhoenix = jsonCharacter.getBoolean("orderOfThePhoenix");
    ministryOfMagic = jsonCharacter.getBoolean("ministryOfMagic");

    if (currentHouse != null && currentHouse.equals(house)) {
      invRole.increment(role);
      invDeath.increment(str(deathEater));
      invDumbledore.increment(str(dumbledoresArmy));
      invOrder.increment(str(orderOfThePhoenix));
      invMinistry.increment(str(ministryOfMagic));

      switch(house) {
      case "Gryffindor":
        countG++;
        break;
      case "Slytherin":
        countS++;
        break;
      case "Hufflepuff":
        countH++;
        break;
      case "Ravenclaw":
        countR++;
        break;
      }

      // Dati per il grafico a radar
      if (deathEater == true) {
        countDeath++;
      }

      if (dumbledoresArmy == true) {
        countDumbledore++;
      }

      if (orderOfThePhoenix == true) {
        countOrder++;
      }

      if (ministryOfMagic == true) {
        countMinistry++;
      }

      if (role != null) {
        switch(role) {
        case "Auror":
        case "Auror (formerly)":
          countRole++;
          break;
        }
      }
    }
  }

  color drawColor;
  switch(house) {
  case "Gryffindor":
    drawColor = red;
    break;
  case "Slytherin":
    drawColor = green;
    break;
  case "Hufflepuff":
    drawColor = yellow;
    break;
  case "Ravenclaw":
    drawColor = blue;
    break;
  default:
    drawColor = color(255);
  }

  countAll = new int[] {countDeath, countDumbledore, countOrder, countMinistry, countRole};
  Radar radar = new Radar(vertexNames, 25, 250, drawColor, countAll);
  radar.drawRadarChart();
}
