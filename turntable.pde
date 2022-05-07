int cx = 0;
int cy = 0;
float rotFactor=0;
float needleRotate=14.4;
float nx, ny;
int track = 3;

//draws the turntable and record spinning
void drawTurntable(){
  //table
  fill(0,50);
  rect(500,550,1010,710);
  fill(70,50,30);
  rect(500,550,1000,700);
  
  //turntable base
  fill(0,50);
  rect(500,650,1210,710);
  fill(60,40,20);
  rect(500,650,1200,700);
  
  //plate
  fill(0,50);
  rect(800,680,810,690);
  fill(200);
  rect(800,680,800,680);
  fill(60,40,20);
  ellipse(150,900,1150,1150);

  //======== rotate =========
  pushMatrix();
    translate(150,900);
    //translate(500,500);
    
    //slipmat
    fill(0,50);
    ellipse(cx,cy,1110,1110);
    fill(200);
    ellipse(cx,cy,1100,1100);
    
    //record
    rotate(radians(rotFactor));
    fill(0);
    ellipse(cx,cy,1080,1080);
    
    //=== grooves ===
    drawGrooves();
    
    //=== LABEL ===
    fill(209,193,160);
    ellipse(cx,cy,340,340);
    fill(0);
    textSize(20);
    textAlign(CENTER,CENTER);
    text(songs[index],cx,40);
    textSize(14);
    text("Oliver Qiu",cx,70);
    rotate(radians(180));
    textSize(16);
    text("45RPM STEREO",cx,60);
    fill(0);
    ellipse(cx,cy,50,50);
    fill(200);
    ellipse(cx,cy,20,20);
  popMatrix();
  if(current == "game"){
    score += 0.05;
    streak += 0.05;
    rotFactor-=1;
  }
  
  //score, details
  drawDetails();
  //needle
  drawNeedle();
  
  
}

//draws the tracks on the record
void drawGrooves(){
  stroke(255);
  strokeWeight(1);
  ellipse(cx,cy,740+170,740+170);
  ellipse(cx,cy,740,740);
  ellipse(cx,cy,740-170,740-170);
  noStroke();
  
  //draw obstacles
  drawObstacles();
}

//handles key pressing during gameplay
void keyPressed() {
  if(current == "game"){
    if(keyCode == UP){
      trackChange(1);
    }
    if(keyCode == DOWN){
      trackChange(-1);
    }
  }
}

//draws the tone arm and needle
void drawNeedle(){
  fill(80);
  rect(850,600,50,50);
     
  pushMatrix();
    translate(850,600);
    
    trackRotate();
    rotate(radians(needleRotate));

    //front
    rectMode(CORNERS);
    fill(0,80);
    rect(0,-15,-552,15);
    fill(180);
    rect(0,-13,-550,13);
    
    //back
    fill(0,80);
    rect(-1,-15,182,15,0,10,10,0);
    fill(180);
    rect(-1,-13,180,13,0,10,10,0);
    
    //middle
    rectMode(CENTER);
    fill(0,80);
    rect(0,0,90,85,20);
    fill(50);  
    rect(0,0,90,80,20);
    
    //counterweight
    fill(0,80);
    rect(200,0,120,105,15);
    fill(160);
    rect(200,0,120,100,15);
    
    //needle
    fill(60);
    pushMatrix();
      translate(-570,10);
      rotate(radians(-20));
       nx = screenX(0,0);
       ny = screenY(0,0);
      rect(0,0,100,40,5);
      fill(180);
      ellipse(0,0,10,10);
    popMatrix();
    
  popMatrix();
}

//changes which track the tone arm will be on
void trackChange(int change){
  if(difficulty != "visualizer"){
    if(track==2){
      track+=change;
      return;
    }
    if(track==1){
      if(change==1){
        track+=change;
        return;
      }
    }
    if(track==3){
      if(change==-1){
        track+=change;
        return;
      }
    }
  }
  
}

//handles the rotating of the tone arm
void trackRotate(){
  if(difficulty != "visualizer"){
    if(track == 1){
      if(needleRotate>-3.6){
        needleRotate-=1;
      }
      else{
        needleRotate=-3.8;
      }
    }
    if(track == 2){   
      if(needleRotate<5.4){
        needleRotate+=1;
      }
      if(needleRotate>5.4){
        needleRotate-=1;
      }
      
    }
    if(track == 3){
      if(needleRotate<14.1){
        needleRotate+=1;
      }
      else{
        needleRotate=14.4;
      }
    }
  }
  else{
    if(current=="game"){
      needleRotate-=(18.2/(float(songLength)/16.67));
    }
    
  }
}

//draws extra details and text on the turntable
void drawDetails(){
  //buttons
  rectMode(CENTER);
  fill(50);
  rect(630,410,129,74);
  rect(840,410,169,74);
  rect(840,500,119,60);

  fill(10); 
  rect(630,410,120,64);
  rect(840,410,160,64);
  rect(840,500,110,50);

  //text/stats
  if(difficulty == "hard" || difficulty == "normal"){
    textAlign(CENTER,CENTER);
    fill(255);
    textSize(20);
    text("Score:",630,390);
    text(int(score),630,420);

    text("Clean Streak:",840,390);
    text(int(streak),840,420);

    textSize(16);
    fill(255,0,0);
    text("Obstacles hit:",840,485);
    text(obstaclesHit,840,505);
  }

  //faders
  fill(10);
  rect(820,850,10,250);
  rect(920,850,10,250);
  
  for(int i=-5;i<=5;i++){
    rect(820,850+i*25,25,4,5);
    rect(920,850+i*25,25,4,5);
  }
  rect(820,825,80,30,5);
  rect(920,900,80,30,5);
  fill(180);
  rect(820,825,60,5,5);
  rect(920,900,60,5,5);
  
}