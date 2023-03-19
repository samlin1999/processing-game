import
ddf.minim.*;
Minim minim;
AudioPlayer player, player2, player3, player4, player5, player6, player7;


Ring[] bullet; // left bullet
Ring[] bullet2; // right bullet
Ring[] getskill; // special bullet
Ring[] boom;


int numbullet = 100 , numRock = 100, numboom = 3;
int currentRing = 0; // ring of bullet cnt
int currentboom = 0;
float timepass = 0, tmptime = 0, time = 0.0;
PImage img, img2, img3, img4, img5, img6, img7, img8, img9, img10, img11, img12, img13, img14, img15, img16, img17, img18, img19, img20, img21, img22;
int plane_x = 350, plane_y = 900, t = 10, s = 100, plive = 3, pcnt = plive-1, level = 0; // t = plane_speed s = plane_size plive = playerlive
int  x_enemy, y_enemy, cnt, k, startmenu = 1, changemenu = 0, pause = 0, pause_t = t;   //changemenu = 0 -> menu, 1 -> difficulty, 2 -> how to play
int E_best = 0, N_best = 0, H_best = 0; // best score, easy, normal, hard 
int  addx = 5, addy = 5;
int quantity = 3, quantitycnt = quantity - 1;
int[] xx = new int[numRock]; // rock_x
int[] yy = new int[numRock]; // rock_y
int[] live = new int[numRock]; // rock_live
int[] playerlive = new int[plive];
int[] background_y = new int[2];
int[] menu_y = new int[2];

int sk, x_skill, y_skill;
int[] x1 = new int[100];
int[] y1 = new int[100];
int[] skill = new int[100];

int[] boomquantity = new int[quantity];
int[] boomq = new int[quantity];


void setup() {
  frameRate(100);
  size(800, 1000);
  smooth();
  img = loadImage("plane.jpg");
  img2 = loadImage("bullet.jpg");
  img3 = loadImage("plane left.jpg");
  img4 = loadImage("plane right.jpg");
  img5 = loadImage("plane front.jpg");
  img6 = loadImage("plane back.jpg");
  img7 = loadImage("rock.jpg");
  img8 = loadImage("skill.jpg");
  img9 = loadImage("star.jpg");
  img10 = loadImage("menu.jpg");
  img11 = loadImage("mouse left.png");
  img12 = loadImage("mouse right.jpg");
  img13 = loadImage("plane die.jpg");
  img14 = loadImage("plane left die.jpg");
  img15 = loadImage("plane right die.jpg");
  img16 = loadImage("plane front die.jpg");
  img17 = loadImage("plane back die.jpg");
  img18 = loadImage("rock blue.jpg");
  img19 = loadImage("rock red.jpg");
  img20 = loadImage("star turn.jpg");
  img21 = loadImage("menu turn.jpg");
  img22 = loadImage("protect.jpg");
  //////music load
  minim = new Minim(this);
  player = minim.loadFile("Pacific Rim.mp3");
  player2 = minim.loadFile("boom.mp3");
  player3 = minim.loadFile("plane die.mp3");
  player4 = minim.loadFile("Yuuki Motetachimukau.mp3");
  player5 = minim.loadFile("laser.mp3");
  player6 = minim.loadFile("getskill.mp3");
  player7 = minim.loadFile("protect.mp3");

  
  cnt = 0; //score
  //set background_y
  background_y[0] = 0;
  background_y[1] = -1000;
  //set menu_y
  menu_y[0] = 0;
  menu_y[1] = -1000;
  
  
  
  //random rock x,y , set live = 1
  for(k = 0; k < numRock; k++){
    x_enemy = (int)random(0, 700);
    y_enemy = (int)random(-10000, -1000);
    xx[k] = x_enemy;
    yy[k] = y_enemy;
    live[k] = 1;
  }
  for(int i = 0;i < quantity;i++)
    boomquantity[i] = 1;
  
  
  //set playerlive
  for(int i = 0; i < plive; i++)
    playerlive[i] = 1;
  
  
  //set bullet
  bullet = new Ring[numbullet]; // Create the array
  bullet2 = new Ring[numbullet];
  getskill = new Ring[numbullet];
  boom = new Ring[numbullet];
  
  
  for (int i = 0; i < numbullet; i++) {
    bullet[i] = new Ring(); // Create each object
    bullet2[i] = new Ring();
    getskill[i] = new Ring();
    boom[i] = new Ring();
  }
  
  

  for(sk = 0;sk < 1;sk++){
    x_skill = (int)random(0, 700);
    y_skill = (int)random(0, 100);
    x1[sk] = x_skill;
    y1[sk] = y_skill;
    skill[sk] = 1;
    }
} // setup end

void draw() {
 //music menu & BGM
 if(startmenu == 1){
     player.play();
     player4.rewind();
   if ( player.position() >= 294000) {
     player.rewind();
   }
 }
 else{
 //menu
   player.pause();
   player.rewind();
  // BGM
   player4.play();
   if ( player4.position() >= 143000) {
     player4.rewind();
   }
 }
 //start menu
 if(startmenu == 1){
   //start menu
   image(img21, 0, menu_y[0] , 800, 1000);
   image(img10, 0, menu_y[1] , 800, 1000);
   
   //background_y move
   for(int i = 0; i < 2; i++){
     menu_y[i] += 2;
     if(menu_y[i] >= 1000)
       menu_y[i] = -1000;
   }
   if(changemenu == 0){
     int blue = 255 - (int)(((player.left.get(0))*1000000)%10000)/40;
     noStroke();
     //"MENU"
     fill(0, 0, blue);
     textSize(150);
     text("STRIKE", 170, 300);
     //"explain move"
     fill(255);
     textSize(50);
     text("front", 400, 400);
     text("back", 400, 460);
     text("left", 400, 520);
     text("right", 400, 580);
     text("shoot", 400, 640);
     text("Shield", 400, 690);
     text("pause", 400, 750);
     fill(205);
     rect(300, 350, 50, 50);
     rect(300, 410, 50, 50);
     rect(300, 470, 50, 50);
     rect(300, 530, 50, 50);
     rect(300, 710, 50, 50);
     
     tint(205);
     image(img11, 300, 590, 50, 50);
     image(img12, 300, 650, 50, 50);
     fill(0);
     text("w", 310, 400);
     text("s", 310, 460);
     text("a", 310, 520);
     text("d", 310, 580);
     text("p", 310, 750);
     
     //"THUNDER"
     fill(0, 0, blue);
     textSize(165);
     text("THUNDER", 10, 150);
      
     //"START"
     fill(0, 0, blue);
     rect(325, 850, 160, 50);
     fill(255);   
     textSize(50);
     text("START", 325, 900);
     if(mousePressed == true && mouseButton == LEFT && mouseX >= 325 && mouseX <= 475 && mouseY >= 850 && mouseY <= 900){
       startmenu = 0;
       currentboom = 0;
        //random rock x,y , set live = 1
        for(k = 0; k < numRock; k++){
            x_enemy = (int)random(0, 700);
            y_enemy = (int)random(-10000, -1000);
            xx[k] = x_enemy;
            yy[k] = y_enemy;
            live[k] = 1;
            cnt = 0;
        }
        pause = 0;
     }
     
     //"Difficulty"
     fill(0, 0, blue);
     rect(325, 775, 160, 50);
     fill(255);   
     textSize(35);
     text("Difficulty", 325, 825);
     if(mousePressed == true && mouseButton == LEFT && mouseX >= 325 && mouseX <= 475 && mouseY >= 775 && mouseY <= 825){
       changemenu = 1;
     }
     
     //"how to play"
     fill(200, 0, 0);
     rect(650, 970, 150, 30);
     fill(255);   
     textSize(25);
     text("How to play", 650, 995);
     if(mousePressed == true && mouseButton == LEFT && mouseX >= 650 && mouseX <= 800 && mouseY >= 970 && mouseY <= 1000){
       changemenu = 2;
     }
     
     //current difficulty
     //easy
     if(t < 15){
       fill(255);   
       textSize(40);
       text("Easy", 0, 950);
       //"best score"
       textSize(35);
       text("Best score: " + E_best, 0, 995);
     }
     //normal
     if(t >= 15 && t < 20){
       fill(255);   
       textSize(40);
       text("Normal", 0, 950);
       //"best score"
       textSize(35);
       text("Best score: " + N_best, 0, 995);
     }
     //hard
     if(t >= 20){
       fill(255);   
       textSize(40);
       text("Hard", 0, 950);
       //"best score"
       textSize(35);
       text("Best score: " + H_best, 0, 995);
     }
     
   }
   //difficulty menu
   if(changemenu == 1){
      fill(0, 0, 205);
      rect(325, 300, 160, 50);
      rect(325, 450, 160, 50);
      rect(325, 600, 160, 50);
      fill(255);
      textSize(50);
      text("Easy", 325, 350);
      textSize(45);
      text("Normal", 325, 500);
      textSize(50);
      text("Hard", 325, 650);
      if(mousePressed == true && mouseButton == LEFT && mouseX >= 325 && mouseX <= 475 && mouseY >= 300 && mouseY <= 350){
        t = 10;
        pause_t = t;
        changemenu = 0;
      }
      if(mousePressed == true && mouseButton == LEFT && mouseX >= 325 && mouseX <= 475 && mouseY >= 450 && mouseY <= 500){
        t = 15; 
        pause_t = t;
        changemenu = 0;
      }
      if(mousePressed == true && mouseButton == LEFT && mouseX >= 325 && mouseX <= 475 && mouseY >= 600 && mouseY <= 650){
        t = 20;
        pause_t = t;
        changemenu = 0;
      }
   }
   
   //how to play menu
   if(changemenu == 2){
     fill(0, 0, 205);
     rect(325, 700, 160, 50);
     fill(255);
     textSize(50);
     text("Back", 350, 750);
     text("#Kill enemy ->", 100, 250);
     image(img7, 470, 210, 50, 50);
     text("#With level getting higher", 100, 305);
     text("enemy->     ->     ->", 130, 360);
     image(img7, 365, 320, 50, 50);
     image(img18, 515, 320, 50, 50);
     image(img19, 665, 320, 50, 50);
     text("#Upgrade your weapon", 100, 415);
     text("with -> ", 130, 470);
     image(img8, 330, 425, 50, 50);
     text("#You must get 50 score in", 100, 525);
     text("each level to go to", 130, 580);
     text("the next level.", 130, 635);
     if(mousePressed == true && mouseButton == LEFT && mouseX >= 325 && mouseX <= 475 && mouseY >= 700 && mouseY <= 750){ 
        changemenu = 0;
      }
   }
 }
 else{ ///startmanu == 0////////////////////////////////////////////////////////
   image(img20, 0, background_y[0] , 800, 1000);
   image(img9, 0, background_y[1] , 800, 1000);
   
   //background_y move
   for(int i = 0; i < 2; i++){
     background_y[i] += 2;
     if(background_y[i] >= 1000)
       background_y[i] = -1000;
   }
   
    //plane move
   if(playerlive[0] != 0){ //if player alive can move
   //player die twinkling
    if(timepass != 0 && timepass + 5000 > millis()){
      if(timepass + 500> millis())
        image(img13, plane_x, plane_y, s, s);
      else if(timepass + 1000 > millis())
        image(img, plane_x, plane_y, s, s);
      else if(timepass + 1500 > millis())
        image(img13, plane_x, plane_y, s, s);
      else if(timepass + 2000 > millis())
        image(img, plane_x, plane_y, s, s);
      else if(timepass + 2500 > millis())
        image(img13, plane_x, plane_y, s, s);
      else if(timepass + 3000 > millis())
        image(img, plane_x, plane_y, s, s);
      else if(timepass + 3500 > millis())
        image(img13, plane_x, plane_y, s, s);
      else if(timepass + 4000 > millis())
        image(img, plane_x, plane_y, s, s);
      else if(timepass + 4500 > millis())
        image(img13, plane_x, plane_y, s, s);
      else
        image(img, plane_x, plane_y, s, s);
    } 
    else {
      tint(255);
      image(img, plane_x, plane_y, s, s);
    }
    tint(255);
    if(plane_x <= 0 )
      plane_x = 0;
    if(plane_x >= 700 )
      plane_x = 700;
    if(plane_y <= 0)
      plane_y = 0;
    if(plane_y >= 900)
      plane_y = 900;
    
    if(keyPressed == true){
      if(key == 's'){
          plane_y+=t;
          //player die twinkling
          if(timepass != 0 && timepass + 6000 > millis()){
            if(timepass + 500> millis())
              image(img17, plane_x, plane_y, s, s);
            else if(timepass + 1000 > millis())
              image(img6, plane_x, plane_y, s, s);
            else if(timepass + 1500 > millis())
              image(img17, plane_x, plane_y, s, s);
            else if(timepass + 2000 > millis())
              image(img6, plane_x, plane_y, s, s);
            else if(timepass + 2500 > millis())
              image(img17, plane_x, plane_y, s, s);
            else if(timepass + 3000 > millis())
              image(img6, plane_x, plane_y, s, s);
            else if(timepass + 3500 > millis())
              image(img17, plane_x, plane_y, s, s);
            else if(timepass + 4000 > millis())
              image(img6, plane_x, plane_y, s, s);
            else if(timepass + 4500 > millis())
              image(img17, plane_x, plane_y, s, s);
            else
              image(img6, plane_x, plane_y, s, s);
          } 
          else {
            tint(255);
            image(img6, plane_x, plane_y, s, s);
          }
        }
      if(key == 'w'){
          plane_y-=t;
          //player die twinkling
          if(timepass != 0 && timepass + 6000 > millis()){
            if(timepass + 500> millis())
              image(img16, plane_x, plane_y, s, s);
            else if(timepass + 1000 > millis())
              image(img5, plane_x, plane_y, s, s);
            else if(timepass + 1500 > millis())
              image(img16, plane_x, plane_y, s, s);
            else if(timepass + 2000 > millis())
              image(img5, plane_x, plane_y, s, s);
            else if(timepass + 2500 > millis())
              image(img16, plane_x, plane_y, s, s);
            else if(timepass + 3000 > millis())
              image(img5, plane_x, plane_y, s, s);
            else if(timepass + 3500 > millis())
              image(img16, plane_x, plane_y, s, s);
            else if(timepass + 4000 > millis())
              image(img5, plane_x, plane_y, s, s);
            else if(timepass + 4500 > millis())
              image(img16, plane_x, plane_y, s, s);
            else
              image(img5, plane_x, plane_y, s, s); 
          } 
          else {
            tint(255);
            image(img5, plane_x, plane_y, s, s);
          }
        }
      if(key == 'd'){
          plane_x+=t;
          //player die twinkling
          if(timepass != 0 && timepass + 6000 > millis()){
            if(timepass + 500> millis())
              image(img15, plane_x, plane_y, s, s);
            else if(timepass + 1000 > millis())
              image(img4, plane_x, plane_y, s, s);
            else if(timepass + 1500 > millis())
              image(img15, plane_x, plane_y, s, s);
            else if(timepass + 2000 > millis())
              image(img4, plane_x, plane_y, s, s);
            else if(timepass + 2500 > millis())
              image(img15, plane_x, plane_y, s, s);
            else if(timepass + 3000 > millis())
              image(img4, plane_x, plane_y, s, s);
            else if(timepass + 3500 > millis())
              image(img15, plane_x, plane_y, s, s);
            else if(timepass + 4000 > millis())
              image(img4, plane_x, plane_y, s, s);
            else if(timepass + 4500 > millis())
              image(img15, plane_x, plane_y, s, s);
            else
              image(img4, plane_x, plane_y, s, s);
          } 
          else {
            tint(255);
            image(img4, plane_x, plane_y, s, s);
          }
        }
      if(key == 'a'){
          plane_x-=t;
          //player die twinkling
          if(timepass != 0 && timepass + 6000 > millis()){
            if(timepass + 500> millis())
              image(img14, plane_x, plane_y, s, s);
            else if(timepass + 1000 > millis())
              image(img3, plane_x, plane_y, s, s);
            else if(timepass + 1500 > millis())
              image(img14, plane_x, plane_y, s, s);
            else if(timepass + 2000 > millis())
              image(img3, plane_x, plane_y, s, s);
            else if(timepass + 2500 > millis())
              image(img14, plane_x, plane_y, s, s);
            else if(timepass + 3000 > millis())
              image(img3, plane_x, plane_y, s, s);
            else if(timepass + 3500 > millis())
              image(img14, plane_x, plane_y, s, s);
            else if(timepass + 4000 > millis())
              image(img3, plane_x, plane_y, s, s);
            else if(timepass + 4500 > millis())
              image(img14, plane_x, plane_y, s, s);
            else
              image(img3, plane_x, plane_y, s, s);  
          } 
          else {
            tint(255);
            image(img3, plane_x, plane_y, s, s);
          }
      }
      tint(255);
      if(key == 'q')
          t++;
      if(key == 'e')
          t--;
    }
   }
   
  //weapon
  /////////////////////////////////////////////////////////////////////////////////////////////////////////  
    
    //bullet
    for (int i = 0; i < numbullet; i++) {
      if(bullet[i].y < 0)
          bullet[i].on = false;
      if(bullet[i].on == true)
        bullet[i].grow();
      bullet[i].display();
      if(bullet2[i].on == true)
        bullet2[i].grow();
      bullet2[i].display();
      if(getskill[i].on == true){
        getskill[i].grow();
        getskill[i].display(); 
      }
    }
    
    for(int i = 0;i < numboom;i++){
      if(boom[i].boomshoot == true)
        boom[i].range();
      boom[i].boomdisplay();
    }
   ////////////////bullet shoot rate/////////////////////////////////////
    for(int i = 0; i < numbullet; i++) {
        if(bullet[i].on == true){
           bullet[i].on = false;
           if(i % 10 == 0){
             bullet[i].on = true;
          }
        }
        if(bullet2[i].on == true){
          bullet2[i].on = false;
          if(i % 10 == 0){
             bullet2[i].on = true;
          }
        }
        if(getskill[i].on == true){
           getskill[i].on = false;
           if(i % 10 == 0){
             getskill[i].on = true;
          }  
        }
    }
    

 //////////special bullet//////////////////////////////   
    for(sk = 0;sk < 10;sk++){
      if(skill[sk] == 1)
      image(img8, x1[sk], y1[sk], 50, 50); 
    }
    for(sk = 0;sk < 10;sk++)
    {
     if(skill[sk] == 1)
     {
      x1[sk] += addx; 
      y1[sk] += addy;
      if(y1[sk] > 950)
        addy *= -1;
      if(y1[sk] < 0)
        addy *= -1;
      if(x1[sk] > 750)
        addx *= -1;
      if(x1[sk] < 0)
        addx *= -1;
     }
    }
    
    
    //getskill
    for(int a = 0;a < 99;a++){
     for(int sk = 0;sk < 1;sk++){
     if(skill[sk] == 1){
       player6.rewind();
      if((plane_x >= x1[sk] - 75 && plane_x <= x1[sk] + 75) && (plane_y <= y1[sk] + 75 && plane_y >= y1[sk] - 75) && (playerlive[pcnt] == 1 && pause == 0)){
       skill[sk] = 0;
      }
     }
     if(skill[sk] == 0){
       player6.play();
      getskill[a].change = true; 
     } 
    }
    }
 //////weapon end/////////////////////////////////////   
    //mouse shoot
    if(playerlive[pcnt] == 1 && pause == 0)
    if(mousePressed == true && mouseButton == LEFT){
          // laser sound
        if(currentRing % 10 ==0){
            player5.rewind();
            player5.play();
        }
        bullet[currentRing].start(plane_x + 5, plane_y + 55);
        bullet2[currentRing].start(plane_x + 80, plane_y + 55);
        if(getskill[currentRing].change == true)
          getskill[currentRing].start(plane_x + 43, plane_y + 55);
        currentRing++;
        if (currentRing >= numbullet) { // reset bullet
          currentRing = 0;
        }
     }
     
    //shoot boom
    if(currentboom < 3)
    if(playerlive[pcnt] == 1 && pause == 0)
    if(boomquantity[quantitycnt] == 1)
    if(mousePressed == true && mouseButton == RIGHT){
      boom[currentRing].start(plane_x + 43, plane_y + 55);
      currentRing++;
      if (currentRing >= numbullet) {
        currentRing = 0;
      }
    }
  //enemy
  //////////////////////////////////////////////////////////////////////////////////////////////////////////  
    //rock
    for(k = 0; k < numRock; k++){
     if(live[k] >= 1){
        if(live[k] == 2)
          image(img18, xx[k], yy[k], 50, 50);
        else if(live[k] >= 3)
          image(img19, xx[k], yy[k], 50, 50);
        else
          image(img7, xx[k], yy[k], 50, 50);
        yy[k] += t-5;  //rock_y speed
        if( yy[k] > 1000)
          live[k] = 0;
      }
    }
    
    // kill rock
    for(int i = 0; i < numbullet - 1; i++){
        for(int k = 0; k < numRock; k++){
          if(live[k] >= 1){
            if(bullet[i].on)
            if((bullet[i].x >= xx[k] && bullet[i].x <= xx[k] + 50) && (yy[k] <= bullet[i].y - bullet[i].speed && yy[k] + 50 >= bullet[i].y - bullet[i].speed )&& yy[k] >= 0){
              live[k] -= 1;
              bullet[i].on = false;
              cnt++;
              player2.rewind();
              player2.play();
            } 
            if(bullet2[i].on)
            if((bullet2[i].x >= xx[k]&& bullet2[i].x<= xx[k] + 50) && (yy[k] <= bullet2[i].y - bullet2[i].speed && yy[k] + 50 >= bullet2[i].y - bullet[i].speed)&& yy[k] >= 0){
              live[k] -= 1;
              bullet2[i].on = false;
              cnt++;
              player2.rewind();
              player2.play();
            }
            /*if(getskill[i].on == true)
            if(getskill[i].change == true)
            if((getskill[i].x >= xx[k]&& getskill[i].x<= xx[k] + 50) && (yy[k] <= getskill[i].y - getskill[i].speed && yy[k] + 50 >= getskill[i].y - getskill[i].speed)){
              live[k] -= 1;
              getskill[i].on = false;
              cnt++;
              player2.rewind();
              player2.play();
            }*/
            if(getskill[i].on == true)
            if(getskill[i].change == true)
            if((getskill[i].x - getskill[i].speed >= xx[k]&& getskill[i].x - getskill[i].speed <= xx[k] + 50) && (yy[k] <= getskill[i].y - getskill[i].speed && yy[k] + 50 >= getskill[i].y - getskill[i].speed)&& yy[k] >= 0){
              live[k] -= 1;
              getskill[i].on = false;
              cnt++;
              player2.rewind();
              player2.play();
            }
            if(getskill[i].on == true)
            if(getskill[i].change == true)
            if((getskill[i].x + getskill[i].speed >= xx[k]&& getskill[i].x + getskill[i].speed <= xx[k] + 50) && (yy[k] <= getskill[i].y - getskill[i].speed && yy[k] + 50 >= getskill[i].y - getskill[i].speed)&& yy[k] >= 0){
              live[k] -= 1;
              getskill[i].on = false;
              cnt++;
              player2.rewind();
              player2.play();
            }
          }
        }
    
    }
    //use boom kill rock///////////////////////////////////////////////////////////////////////////////////
    for(int i = 0;i < numboom;i++)
    {
      for(int k = 0;k < 100;k++)
      {
        if(live[k] >= 1 && boom[i].boomshoot == true)
        {
            if((plane_x <= xx[k] + 200 && plane_x >= xx[k] - 200) && (plane_y <= yy[k] + 200 && plane_y >= yy[k] - 100))
            {
              live[k] = 0; 
              cnt++;
            }
        }
      }
    }
    //boom Quantity and use boom
    if(currentboom < 3)
    for(int i = 0;i < numboom;i++){
    if(playerlive[pcnt] == 1 && pause == 0)
    if(time == 0 || time + 5000 < millis())
    if(mousePressed == true && mouseButton == RIGHT)
    {
      player7.play();
      time = millis();
      currentboom++;
      boom[i].boomshoot = true;
      boomquantity[quantitycnt] = 0;
      quantitycnt--;
      if(quantitycnt < 0)
        quantitycnt = 0;
      player7.rewind();
    }
    }
    for(int i = 0;i < numboom;i++)
    {
     if(boomquantity[i] == 1)
     image(img22, 750-i*50, 950, 50, 50);
    }
    for(int i = 0;i < numboom;i++)
    {
      if(boom[i].x > 400 && boom[i].y > 400)
      boom[i].boomshoot = false;
    } 
    
    //rockreset // level up rock live++
    if(cnt%50 == 0){
      //random rock x,y , set live = 1
      for(k = 0; k < numRock; k++){
        if(live[k] <= 0){
          x_enemy = (int)random(0, 700);
          y_enemy = (int)random(-10000, -1000);
          xx[k] = x_enemy;
          yy[k] = y_enemy;
          live[k] = cnt/50 + 1;
        }
      }
    }
    for(int i = 0; i < numbullet - 1; i++){
      if((bullet[i].y + bullet[i].speed) < 0)
          bullet[i].on = false;
      if((bullet2[i].y + bullet2[i].speed) < 0)
          bullet2[i].on = false;
      if((getskill[i].y + getskill[i].speed) < 0)
          getskill[i].on = false;
    }
    
  //playerlive
  ////////////////////////////////////////////////////////////////////////////////////////////
  
    for(int k = 0; k < numRock - 1; k++){
      if(timepass == 0|| timepass + 5000 < millis())
        if(live[k] >= 1)
           if((plane_x >= xx[k] - 50 && plane_x<= xx[k] + 50)&&(plane_y >= yy[k] - 50 && plane_y <= yy[k] +50)){
            timepass = millis();
            playerlive[pcnt] = 0;
            pcnt--;
            player3.rewind();
            player3.play();
            if(pcnt < 0)
              pcnt = 0;
          }
    }
  
  
  for(int i = 0; i < plive; i++){
    if(playerlive[i] == 1){
       image(img, 750-i*50, 0, 50, 50); // plane
    }
  }
  
  
  //check if all the rock die
  int checkrock = 0;
  for(int i = 0; i < numRock; i++){
    if(live[i] >= 1)
      checkrock = 1;
  }
  if(checkrock == 0)
    playerlive[0] = 0;
  
  
   // set best score
      if(t < 15)
         if(cnt > E_best)
           E_best = cnt;
       if(t >= 15 && t < 20)
         if(cnt > N_best)
           N_best = cnt;
       if(t >= 20)
         if(cnt > H_best)
           H_best = cnt; 
  ///////////////////////////////////////////////////////////////////////////////////////////////////
  //pause == 'p'
  if(keyPressed == true && key == 'p')
    pause = 1;
    
  //pause
  if(pause == 1){
     playerlive[0] = 0;
     t = 5;
     tint(100);
     image(img, plane_x, plane_y, s, s);
     fill(255);
     textSize(150);
     text("PAUSE", 190, 400);
    //"resume"
     fill(255);
     rect(350, 500, 150, 60);
     fill(0);
     textSize(40);
     text("Resume", 350, 550);
     if(mousePressed == true && mouseX >= 350 && mouseX <= 500 && mouseY >= 500 && mouseY <= 560){
       //reset rock
       t = pause_t;
       playerlive[0] = 1;
       pause = 0;
     }
     fill(255);
     rect(350, 600, 150, 60);
     fill(0);
     textSize(50);
     text("MENU", 350, 660);
     //////reset//////////////////////////////////////////////////////////////
     if(mousePressed == true && mouseX >= 350 && mouseX <= 500 && mouseY >= 600 && mouseY <= 660){
         startmenu = 1;
         pause = 0;
         t = pause_t;
         cnt = 0;
         currentboom = 0;
         for(int i = 0; i < plive; i++)
           playerlive[i] = 1;
         for(k = 0; k < numRock; k++){
          x_enemy = (int)random(0, 700);
          y_enemy = (int)random(-1000, -200);
          xx[k] = x_enemy;
          yy[k] = y_enemy;
          live[k] = 1;
          plane_x = 350; plane_y = 900;
          for(int i = 0;i < numboom;i++)
            boomquantity[i] = 1;
          for(sk = 0;sk < 1;sk++)
          {
            x_skill = (int)random(0, 700);
            y_skill = (int)random(0, 100);
            x1[sk] = x_skill;
            y1[sk] = y_skill;
            skill[sk] = 1;
          }
          for(int i = 0;i < numbullet;i++)
          {
            getskill[i].change = false;  
          }
        }
     }
  }
  
  
  
///////playerlive = 0 gameovrer/////////////////////////////////////////////
   if(playerlive[0] != 1 && pause != 1){
     tint(100);
     image(img, plane_x, plane_y, s, s);
     //"game over"
     fill(255);
     textSize(100);
     text("GAME OVER", 140, 400);
     //"resume"
     fill(255);
     rect(350, 500, 150, 60);
     fill(0);
     textSize(40);
     text("Resume", 350, 550);
     if(mousePressed == true && mouseX >= 350 && mouseX <= 500 && mouseY >= 500 && mouseY <= 560){
       for(int i = 0; i < plive; i++)
         playerlive[i] = 1;
       currentboom = 0;
       for(int i = 0;i < quantity;i++)
          boomquantity[i] = 1;
       //reset rock
       for(k = 0; k < numRock; k++){
        if(live[k] <= 0){
          x_enemy = (int)random(0, 700);
          y_enemy = (int)random(-10000, -1000);
          xx[k] = x_enemy;
          yy[k] = y_enemy;
          live[k] = cnt/50 + 1;
        }
      }
     }
     pcnt = plive-1; // reset pcnt
     quantitycnt = quantity - 1;
     fill(255);
     rect(350, 600, 150, 60);
     fill(0);
     textSize(50);
     text("MENU", 350, 660);
     //////reset//////////////////////////////////////////////////////////////
     if(mousePressed == true && mouseX >= 350 && mouseX <= 500 && mouseY >= 600 && mouseY <= 660){
         startmenu = 1;
         cnt = 0;
         currentboom = 0;
         for(int i = 0; i < plive; i++)
           playerlive[i] = 1;
         for(k = 0; k < numRock; k++){
          x_enemy = (int)random(0, 700);
          y_enemy = (int)random(-1000, -200);
          xx[k] = x_enemy;
          yy[k] = y_enemy;
          live[k] = 1;
          plane_x = 350; plane_y = 900;
          for(int i = 0;i < quantity;i++)
            boomquantity[i] = 1;
            quantitycnt = quantity - 1;
          for(sk = 0;sk < 1;sk++)
          {
            x_skill = (int)random(0, 700);
            y_skill = (int)random(0, 100);
            x1[sk] = x_skill;
            y1[sk] = y_skill;
            skill[sk] = 1;
          }
          for(int i = 0;i < numbullet;i++)
          {
            getskill[i].change = false;  
          }
        }
     }
   }
  
  
  
    
  //score
  //////////////////////////////////////////////////////////////////////////////////////////
    // score
    fill(255);
    textSize(50);
    text("score = " + cnt, 0, 50);
    text("Level  " + cnt/50, 0, 100);
    if(cnt != 0 && cnt%50 == 0){
      fill(255);
      textSize(50);
      text("Level " + cnt/50, 300, 450);
    }
    fill(255);
    textSize(50);
    text(millis() / 1000 + "s", 650, 950);
    //best score
    //easy
     if(t < 15){
       textSize(35);
       text("Best score: " + E_best, 0, 995);
     }
     //normal
     if(t >= 15 && t < 20){
       textSize(35);
       text("Best score: " + N_best, 0, 995);
     }
     //hard
     if(t >= 20){
       textSize(35);
       text("Best score: " + H_best, 0, 995);
     }
 } // startmanu end
} //draw end


class Ring {
  float x, y; // X-coordinate, y-coordinate
  float speed; // speed of the ring
  float diameter;
  boolean on = false; // Turns the display on and off
  boolean change = false;
  boolean boomshoot = false;
  void start(float xpos, float ypos) {
    x = xpos;
    y = ypos;
    on = true;
    speed = 1;
    diameter = 1;
  }

  void grow() {
    if (on == true) {
      speed += 15; // speed of bullet
      if (speed > 1000) {
        on = false;
      }
    }
    if (on == false) {
      speed = 1;
      x = 0;
      y = 0;
    }
  }

  void display() {
    if (on == true) {
    if(change == true){
    image(img2, x-speed, y-speed, 15, 15);
    image(img2, x+speed, y-speed, 15, 15);
    //image(img2, x, y-speed, 15, 30);
     }else
    image(img2, x, y-speed, 15, 30);
    }
  }
  void range(){
    if(boomshoot == true)
    {
      diameter += 20; 
    }
    if(diameter > 400)
    {
     boomshoot = false; 
    }
    if(boomshoot == false)
    {
      diameter = 1;
      x = 0;
      y = 0;
    }
  }
  void boomdisplay(){
    if(boomshoot == true){
    stroke(100, 255, 255);
    strokeWeight(5);
    noFill();
    ellipse(plane_x + 43, plane_y + 55, diameter, diameter);
    }
  }
}
