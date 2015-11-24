

/* @pjs preload = "quarter.png", "dime.png", "nickel.png", "penny.png", "twentydollarbill.png", "tendollarbill.png", "fivedollarbill.png", "onedollarbill.png", "imgBackground.png", "receiptImg.png"; */

PFont fontBody, fontReceipt;
PImage imgQuart, imgDime, imgNickel, imgPenny, imgTwenty, imgTen, imgFive, imgOne, imgBackground, imgReceipt;
int numTwenty, numTen, numFive, numOne, numPenny, numNickel, numDime, numQuart, eTotal, intEndTotal, eBills, eCoins;
int aPenny, aNickel, aDime, aQuart, aOne, aFive, aTen, aTwenty, totalBills, changeTotal;
int quartX, quartY, dimeX, dimeY, nickelX, nickelY, pennyX, pennyY;
int  billX, twentyY, tenY, fiveY, oneY;
float billXButton, billHtButton, billWdButton, twentyYButton, tenYButton, fiveYButton, oneYButton;
float coinXButton, coinWdButton, coinHtButton, quartYButton, dimeYButton, nickelYButton, pennyYButton;
float numGum, numChips, numIceCream, priceGum, priceChips, priceIceCream, priceTotal, couponVal, priceTax, endTotal, changeLeft; 
String gumPacks, chipBags, pintsIceCream, gum, chips, iceCream, coupon, tax, totalNoTax, total;
String gumPrice="", iceCreamPrice="", chipsPrice="", totalWOutTax= "", couponValue="", taxValue="", purchaseTotal="", allTextBoxes="";
boolean checkTotal = false, showTotals = true, initial = true, showInstructions=false;

void setup() {
  size(850, 675);
  imgBackground = loadImage("imgBackground.png");
  background(imgBackground);
  smooth();
  fontBody = loadFont("Georgia-25.vlw");
  fontReceipt = loadFont("PTSans-Narrow-20.vlw");
  imgQuart = loadImage("quarter.png");
  imgDime = loadImage("dime.png");
  imgNickel = loadImage("nickel.png");
  imgPenny = loadImage("penny.png");
  imgTwenty = loadImage("twentydollarbill.png");
  imgTen = loadImage("tendollarbill.png");
  imgFive = loadImage("fivedollarbill.png");
  imgOne = loadImage("onedollarbill.png");
  imgReceipt = loadImage("receiptImg.png");
  billXButton = 585; //coordinates & height & width to make the money images into buttons
  billHtButton=55.5; 
  billWdButton=108; 
  twentyYButton = 381; 
  tenYButton=450; 
  fiveYButton=520; 
  oneYButton=592;
  coinWdButton =58;
  coinHtButton= 55; 
  coinXButton = 722; 
  quartYButton = 383;
  dimeYButton = 450; 
  nickelYButton = 519;  
  pennyYButton= 586;
    var BGsound = new Audio("bitBG.mp3"); // buffers automatically when created
  BGsound.play();
}

void draw(){

  if (initial) { //initial screen
    initialize();
    drawBackground();
    textSize(18);
    initial = false;
  }

  if (showInstructions) {
    noStroke();
    fill(0);
    rect(0, 0, 850, 117);
    fill(255);
    textFont(fontBody);
    textSize(20);
    String h="Calculate the cost of all items on the receipt. Then subtract a 15% coupon, and add 8% sales tax from the items' total cost. Once you have calculated the purchase total, click on the money buttons to represent the value in dollars & cents. (to remove a coin/bill right click)";
    text(h, 50, 20, 800, 800);
  }

  if (showTotals) { // displays current total of selected coins
    fill(255);
    textFont(fontBody);
    textSize(14);
    text("current total= $" + eBills + "." + eCoins, 670, 110);
  }
  if (checkTotal) {//checks to see if the selected coin values is equal to to the random number & not the correct answer will display

    if ((eTotal == intEndTotal)) { //checks to see if the total is correct
       // println(eTotal + "=" + intEndTotal);
      fill(0);
      noStroke();
      rect(0, 0, 850, 115);
      fill(232, 12, 19);
      textFont(fontBody);  
      textSize(40);
      text("CONGRATULATIONS! YOU WIN!!", 110, 60, 800, 100);
      fill(255);
      text("CONGRATULATIONS! YOU WIN!!", 109, 59, 800, 100);
    } else {
     // println(eTotal + "!=" + intEndTotal);
      background(imgBackground);
      textFont(fontBody);
      textSize(20);
      fill(255);
      textSize(24);
      text("PRESS 's' TO START A NEW GAME", 200, 70);
      fill(232, 12, 19);
      text("SORRY, THE CORRECT ANSWER IS:", 200, 50); 
      checkAnswer();
    }

    fill(255);
    showTotals = false;
    checkTotal = !checkTotal;
  }
}



void keyPressed() {
  if (key=='s') { // press 's' to start new game
    initialize();
  } 

  if ((key==RETURN||key==ENTER)&&(checkTotal==false)) {//draws text on the receipt image from the textbox when enter is pressed
    fill(255, 0, 0);
    textSize(18);
    textFont(fontReceipt);
//    text(cp5.get(Textfield.class, "gumPrice").getText(), 500, 206);
//    text(cp5.get(Textfield.class, "iceCreamPrice").getText(), 500, 267);
//    text(cp5.get(Textfield.class, "chipsPrice").getText(), 500, 336);
//    text(cp5.get(Textfield.class, "totalWOutTax").getText(), 500, 401);
//    text(cp5.get(Textfield.class, "couponValue").getText(), 500, 468);
//    text(cp5.get(Textfield.class, "taxValue").getText(), 500, 540);
//    text(cp5.get(Textfield.class, "purchaseTotal").getText(), 500, 632);
  }
  if (key=='h') {// press 'h' for instructions
    if (showInstructions) {
      stroke(255);
      fill(76, 144, 80);
      rect(0, 0, 849, 115);
      textSize(20);
      fill(255);
      text("1. press the clear button to clear the text boxes", 30, 10, 400, 30);  
      text("2. press 't' to see the current total of your money", 30, 35, 400, 30); 
      text("3. press 'c' to check your answer", 30, 65, 400, 30);
      text("4. press 's' to start a new game", 30, 90, 400, 30);
      noStroke();
    } 
    showInstructions=!showInstructions;
  }

  if (key=='t') {
    if (showTotals) { //press 't' for to display total amount of current coins, 
      fill(0);
      noStroke();
      rect(640, 95, 220, 25);
    } 
    showTotals=!showTotals;
  } 
  if (key=='c') { // press 'c' to check if the number of selected coins is equal to the random the number
    checkTotal = !checkTotal;
  }
}


void mousePressed() {
  
  var change1 = new Audio("change1.mp3");
  var change2 = new Audio("change2.mp3");
  var change3 = new Audio("change3.mp3");

  if ((mouseX>billXButton && mouseX <billXButton+billWdButton && mouseY>twentyYButton && mouseY <twentyYButton+billHtButton)&&(mouseButton==LEFT)) {// tests if mouse is pressed over $20 button
    numTwenty++;
    change1.play();
  }
  if ((mouseX>billXButton && mouseX <billXButton+billWdButton && mouseY>twentyYButton && mouseY <twentyYButton+billHtButton)&&(mouseButton==RIGHT)) {// right click to remove $20 
    numTwenty--;
    change3.play();
  }
  if ((mouseX>billXButton && mouseX <billXButton+billWdButton && mouseY>tenYButton && mouseY <tenYButton+billHtButton)&&(mouseButton==LEFT)) {// tests if mouse is pressed over $10 button
    numTen++;
    change2.play();
  } 
  if ((mouseX>billXButton && mouseX <billXButton+billWdButton && mouseY>tenYButton && mouseY <tenYButton+billHtButton)&&(mouseButton==RIGHT)) {// right click to remove $10 
    numTen--;
    change1.play();
  } 
  if ((mouseX>billXButton && mouseX <billXButton+billWdButton && mouseY>fiveYButton && mouseY <fiveYButton+billHtButton)&&(mouseButton==LEFT)) {// tests if mouse is pressed over $5 button
    numFive++;
    change3.play();
  }  
  if ((mouseX>billXButton && mouseX <billXButton+billWdButton && mouseY>fiveYButton && mouseY <fiveYButton+billHtButton)&&(mouseButton==RIGHT)) {// right click to remove $5
    numFive--;
    change2.play();
  } 
  if ((mouseX>billXButton && mouseX <billXButton+billWdButton && mouseY>oneYButton && mouseY <oneYButton+billHtButton)&&(mouseButton==LEFT)) { //tests if mouse is pressed over $1 button
    numOne++;
    change1.play();
  }  
  if ((mouseX>billXButton && mouseX <billXButton+billWdButton && mouseY>oneYButton && mouseY <oneYButton+billHtButton)&&(mouseButton==RIGHT)) { //right click to remove $1 
    numOne--;
    change3.play();
  } 
  if ((mouseX>coinXButton && mouseX <coinXButton+coinWdButton && mouseY>quartYButton && mouseY <quartYButton+coinHtButton)&&(mouseButton==LEFT)) {// tests if mouse is pressed over quarter button
    numQuart++;
    change2.play();
  } 
  if ((mouseX>coinXButton && mouseX <coinXButton+coinWdButton && mouseY>quartYButton && mouseY <quartYButton+coinHtButton)&&(mouseButton==RIGHT)) {// right click to remove quarter 
    numQuart--;
    change1.play();
  }  
  if ((mouseX>coinXButton && mouseX <coinXButton+coinWdButton && mouseY>dimeYButton && mouseY <dimeYButton+coinHtButton)&&(mouseButton==LEFT)) {// tests if mouse is pressed over dime button
    numDime++;
    change3.play();
  }  
  if ((mouseX>coinXButton && mouseX <coinXButton+coinWdButton && mouseY>dimeYButton && mouseY <dimeYButton+coinHtButton)&&(mouseButton==RIGHT)) {//right click to remove dime 
    numDime--;
    change2.play();
  }  
  if ((mouseX>coinXButton && mouseX <coinXButton+coinWdButton && mouseY>nickelYButton && mouseY <nickelYButton+coinHtButton)&&(mouseButton==LEFT)) { //tests if mouse is pressed over nickel button
    numNickel++;
    change1.play();
  } 
  if ((mouseX>coinXButton && mouseX <coinXButton+coinWdButton && mouseY>nickelYButton && mouseY <nickelYButton+coinHtButton)&&(mouseButton==RIGHT)) {//right click to remove nickel 
    numNickel--;
    change3.play();
  } 
  if ((mouseX>coinXButton && mouseX <coinXButton+coinWdButton && mouseY>pennyYButton && mouseY <pennyYButton+coinHtButton)&&(mouseButton==LEFT)) { //tests if mouse is pressed over penny button
    numPenny++;
    change2.play();
  } 
  if ((mouseX>coinXButton && mouseX <coinXButton+coinWdButton && mouseY>pennyYButton && mouseY <pennyYButton+coinHtButton)&&(mouseButton==RIGHT)) {// right click to remove penny
    numPenny--;
    change1.play();
  }

  redrawMoney();
  eTotal = numTwenty*20 + 10*numTen + 5*numFive + numOne +((25*numQuart + 10*numDime + 5*numNickel + numPenny)/100);//every time a button is clicked the total is updated 
  eBills= numTwenty*20 + 10*numTen + 5*numFive+numOne;
  eCoins=25*numQuart + 10*numDime + 5*numNickel + numPenny;
  //println(eBills + "." + eCoins);
}

void redrawMoney() {///function redraws the coins based on the amount of times the coin buttons are clicked to add a coin or right clicked to remove a coin

  drawBackground();
  billX= 600;//resets bill & coin x & y position each times the game is played
  twentyY= 140;
  tenY= 200;
  fiveY= 260;
  oneY=  320;
  quartX= 720;
  quartY= 210;
  dimeX= 785;
  dimeY = 219;
  nickelX = 720;
  nickelY = 320;
  pennyX= 785;
  pennyY= 320;


  for (int t=0, deltaX=0, deltaY=0; t<numTwenty; t++) { //draws coins each time one is added or removed
    image(imgTwenty, billX+deltaX, twentyY+deltaY);
    deltaX+=5;
    deltaY+= -15;
  }

  for (int e=0, deltaX=0, deltaY=0; e<numTen; e++) { 
    image(imgTen, billX+deltaX, tenY+deltaY);
    deltaX+=5;
    deltaY+= -15;
  }

  for (int f=0, deltaX=0, deltaY=0; f<numFive; f++) { 
    image(imgFive, billX+deltaX, fiveY+deltaY);
    deltaX+=5;
    deltaY+= -15;
  }

  for (int o=0, deltaX=0, deltaY=0; o<numOne; o++) { 
    image(imgOne, billX+deltaX, oneY+deltaY);
    deltaX+=5;
    deltaY+= -15;
  }

  for (int q=0, deltaX=0, deltaY=0; q<numQuart; q++) { 
    image(imgQuart, quartX+deltaX, quartY+deltaY);
    deltaX+=3;
    deltaY+= -15;
  }


  for (int d=0, deltaX=0, deltaY=0; d<numDime; d++) {
    image(imgDime, dimeX+deltaX, dimeY+deltaY);
    deltaX+=3;
    deltaY+=-15;
  }

  for (int n=0, deltaX=0, deltaY=0; n<numNickel; n++) {
    image(imgNickel, nickelX+deltaX, nickelY+deltaY);
    deltaX+=3;
    deltaY+=-15;
  }


  for (int p=0, deltaX=0, deltaY=0; p<numPenny; p++) {
    image(imgPenny, pennyX+deltaX, pennyY+deltaY);
    deltaX+=3;
    deltaY+=-15;
  }
}

void initialize() {
  eTotal= numQuart = numDime = numNickel = numPenny = numTwenty = numTen = numFive = numOne = 0;
  numGum=(int)random(1, 10);//intializes the random number of items and calculates totals
  gumPacks=nf(numGum, 1, 0);//string that displays only the first value of the random generated float
  numChips=(int)random(1, 10);
  chipBags=nf(numChips, 1, 0);
  numIceCream=(int)random(1, 10);
  pintsIceCream=nf(numIceCream, 1, 0);
  priceGum= (1.15)*numGum;
  gum= nf(priceGum, 2, 2); //string that only shows the first 2 numbers before & after the decimal point to show as a price
  priceChips= (1.65)*numChips;
  chips= nf(priceChips, 2, 2);
  priceIceCream= (5.45)*numIceCream;
  iceCream= nf(priceIceCream, 2, 2);
  priceTotal= priceGum + priceChips + priceIceCream;
  totalNoTax= nf(priceTotal, 2, 2);
  couponVal=  .15*priceTotal;
  coupon= nf(couponVal, 2, 2);
  priceTax= (priceTotal-couponVal)*.08;
  tax= nf(priceTax, 2, 2);
  endTotal= (priceTotal-couponVal)+priceTax;
  total=nf(endTotal, 2, 2);
  totalBills= floor(endTotal);
  aTwenty=(totalBills/20);
  aTen=(totalBills%20)/10;
  aFive=(totalBills-(aTwenty*20)-(aTen*10))/5;
  aOne=(totalBills-(aTwenty*20)-(aTen*10))%5;
  changeLeft=endTotal-floor(endTotal);
  changeTotal=(int)(changeLeft*100);
  aQuart=changeTotal/25;
  aDime= (changeTotal%25)/10;
  aNickel=(changeTotal-(aQuart*25)-(aDime*10))/5;
  aPenny=ceil(changeTotal-(aQuart*25)-(aDime*10)-(aNickel*5))/1;
  intEndTotal=(int)(endTotal);//converts endTotal into an integer so that it can be checked with user answer

  //these are helpful to  make sure everything in the game is still working properly
//  println(chipBags + " " + "bags of chips"+ " " + "and it will cost you" + " " + "$" + chips);
//  println(numIceCream + " " + "candy bars" + " " + "and it will cost you" + " " + "$" + iceCream);
//  println("The total cost of the purchase" + " " + "$" + totalNoTax);
//  println("You saved $" + " " + coupon);
//  println("Tax =" + " " + tax);
//  println("Total purchase cost is" + " " + total);
//  println(" ");
//  println(" ");
//  println("The total number of bills you need is:");
//  if (aTwenty!=1) {
//    println(aTwenty + " " + "twenty dollar bills");
//  } else {
//    println(aTwenty + " " + "twenty dollar bill");
//  }
//  if (aTen!=1) {
//    println(aTen + " " + "ten dollar bills");
//  } else {
//    println(aTen + " " + "ten dollars bill");
//  }
//  if (aFive!=1) {
//    println(aFive + " " + "five dollar bills");
//  } else {
//    println(aFive + " " + "five dollars bill");
//  }
//  if (aOne!=1) {
//    println(aOne + " " + "one dollar bills");
//  } else {
//    println(aOne + " " + "one dollar bill");
//  }
//
//  println("The total number of coins you need is:"); 
//
//  if (aQuart!=1) {
//    println(aQuart + " " + "quarters");
//  } else {
//    println(aQuart + " " + "quarter");
//  }
//  if (aDime!=1) {
//    println(aDime + " " + "dimes");
//  } else {
//    println(aDime + " " + "dime");
//  }
//  if (aNickel!=1) {
//    println(aNickel + " " + "nickels");
//  } else {
//    println(aNickel + " " + "nickel");
//  }
//  if (aPenny!=1) {
//    println(aPenny + " " + "pennies");
//  } else {
//  println(aPenny + " " + "penny");
//  }

  initial = !initial;
  showTotals = false;
}

void drawBackground() {//draws the background and text
  background(imgBackground);
  fill(66, 120, 160);
  rect(567, 135, 276, 230);
  fill(255);
  textFont(fontBody);
  textSize(20);
  String q="Calculate the cost of all items on the receipt. Then subtract a 15% coupon, and add 8% sales tax from the items' total cost. Once you have calculated the purchase total, click on the money buttons to represent the value in dollars & cents. (~press enter to submit the value in the text box, ~to remove a coin/bill right click)";
  text(q, 50, 20, 800, 800);
  fill(100);
  stroke(255);
  rect(50, 645, 150, 22);
  textSize(18);
  fill(80, 144, 80);
  text("press 'h' for help", 59, 649, 200, 21);
  fill(255);
  text("press 'h' for help", 58.25, 648.25, 200, 21);
  textFont(fontReceipt);
  textSize(18);
  fill(0);
  stroke(2);
  text(gumPacks + " " + "packs of gum", 335, 200);
  text(pintsIceCream + " " + "pints of ice cream", 335, 258);
  text(chipBags + " " + "bags of chips", 335, 325);
  text("Total w/out Tax", 335, 395);
  text("15% off Coupon", 335, 460);
  text("8% Sales Tax", 335, 535); 
  textSize(20);
  strokeWeight(3);
  text("TOTAL", 335, 615);
  strokeWeight(2);
  textSize(16);
  fill(255, 0, 0);
  text("(coupon value)", 335, 475);//hint: coupon 
  text("(total * .08)", 335, 550); // hint: sales tax
  text("(total - coupon + tax)", 335, 630); //hint:final total
  text("@ $1.15", 335, 215); //gum price
  text("@ $5.45", 335, 272); //ice cream price
  text("@ $1.65", 335, 340); //chips price
  stroke(255);
}

void checkAnswer() { ///displays the correct amount of coins if the user answer is incorrect, accompanied by the text answer
  billX= 600;//resets bill & coin x & y position each times the game is played
  twentyY= 140;
  tenY= 200;
  fiveY= 260;
  oneY=  320;
  quartX= 720;
  quartY= 210;
  dimeX= 785;
  dimeY = 219;
  nickelX = 720;
  nickelY = 320;
  pennyX= 785;
  pennyY= 320;
  fill(66, 120, 160);
  rect(567, 135, 276, 230);
  fill(255);
  textSize(18);

  for (int t=0, deltaX=0, deltaY=0; t<aTwenty; t++) { //draws coins for the right answer
    image(imgTwenty, billX+deltaX, twentyY+deltaY);
    deltaX+=5;
    deltaY+= -15;
  }

  for (int e=0, deltaX=0, deltaY=0; e<aTen; e++) { 
    image(imgTen, billX+deltaX, tenY+deltaY);
    deltaX+=5;
    deltaY+= -15;
  }

  for (int f=0, deltaX=0, deltaY=0; f<aFive; f++) { 
    image(imgFive, billX+deltaX, fiveY+deltaY);
    deltaX+=5;
    deltaY+= -15;
  }

  for (int o=0, deltaX=0, deltaY=0; o<aOne; o++) { 
    image(imgOne, billX+deltaX, oneY+deltaY);
    deltaX+=5;
    deltaY+= -15;
  }

  for (int q=1; q<=aQuart; q++) { 
    image(imgQuart, quartX, quartY);
    quartX+= 5;
    quartY+= -15;
  }


  for (int d=1; d<=aDime; d++) {
    image(imgDime, dimeX, dimeY);
    dimeX+=5;
    dimeY+=-15;
  }

  for (int n=1; n<=aNickel; n++) {
    image(imgNickel, nickelX, nickelY);
    nickelX+=5;
    nickelY+=-15;
  }


  for (int p=1; p<=aPenny; p++) {
    image(imgPenny, pennyX, pennyY);
    pennyX+=5;
    pennyY+=-15;
  }
  textFont(fontReceipt);
  textSize(16);
  fill(0);
  stroke(2);
  text(gumPacks + " " + "packs of gum", 335, 200);
  text(pintsIceCream + " " + "pints of ice cream", 335, 258);
  text(chipBags + " " + "bags of chips", 335, 325);
  text("Total w/out Tax", 335, 395);
  text("15% off Coupon", 335, 460);
  text("8% Sales Tax", 335, 535); 
  textSize(16);
  strokeWeight(3);
  text("TOTAL", 335, 615);
  strokeWeight(2);
  textSize(16);
  fill(0);
  text("(coupon value)", 335, 475);//hint: coupon 
  text("(total * .08)", 335, 550); // hint: sales tax
  text("(total - coupon + tax)", 335, 630); //hint:final total
  text("@ $1.15", 335, 215); //gum price
  text("@ $5.45", 335, 272); //ice cream price
  text("@ $1.65", 335, 340); //chips price
  fill(255, 0, 0);
  textSize(16);
  text(gum, 500, 206);
  text(iceCream, 500, 267);
  text(chips, 500, 336);
  text(totalNoTax, 500, 401);
  text(coupon, 500, 468);
  text(tax, 500, 541);
  text(total, 500, 632);
}







