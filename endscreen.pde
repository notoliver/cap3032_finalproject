//draws the end screen menu
void drawEndScreen(){
  drawTurntable();

  //end screen popup background
  stroke(0,180);
  noFill();
  strokeWeight(5);
  rect(500,500,600,600);
  noStroke();

  fill(255,240);
  rect(500,500,600,600);

  //text, buttons
  if(difficulty != "visualizer"){
    fill(20);
    textSize(24);
    text("Final Score:",500,250);
    text("Longest Clean Streak:",500,350);
    text("Obstacles Hit:",500,450);

    textSize(38);
    text(int(score),500,290);
    text(int(streakHigh),500,390);
    text(obstaclesHit,500,490);
  }
  else{
    fill(20);
    textSize(38);
    text("Thanks for listening",500,450);
  }
  

  rect(500,650,120,40,5);
  rect(500,750,100,40,5);
  fill(255);
  textSize(18);
  text("Play Again",500,647);
  text("Quit",500,747);
}

//manages button clicks in the menu
void handleEndClick(){
  if(rectRange(500,650,120,40)){
    init = true;
    
    current = "menu";
    
  }
  if(rectRange(500,750,100,40)){
    exit();
  }
}
