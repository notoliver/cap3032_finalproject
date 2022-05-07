String[] songs = {"Welcome Back", "On Break","Printer Paper"};
int index = 1;
String difficulty;

//draws the main menu
void drawMenu(){
  background(loadImage("menu.png"));
  
  rectMode(CENTER);
  fill(255,255,255,100);
  rect(200,180,150,50,10);
  rect(500,180,150,50,10);
  rect(800,180,150,50,10);
  rect(500,740,250,50,10);
  rect(500,930,150,50,10);
  
  rect(500,800,120,50,10);
  rect(400,800,50,50,10);
  rect(600,800,50,50,10);
  
  textAlign(CENTER,CENTER);
  textSize(24);
  fill(255,255,255);
  text("Visualizer",200,177);
  text("Normal",500,177);
  text("Hard",800,177);
  text(songs[index],500,737);
  text("<",400,800);text(">",600,797);
  text("Song",500,797);
  text("Quit",500,927);
}

//manages button clicks in the menu
void handleMenuClick(){
  if(rectRange(200,180,150,50)){ //visualizer
      current="game";
      difficulty="visualizer";
    }
    if(rectRange(500,180,150,50)){ //normal
      current="game";
      difficulty="normal";
    }
    if(rectRange(800,180,150,50)){ //hard
      current="game";
      difficulty="hard";
    }
    
    if(rectRange(400,800,50,50)){ //prev track
      if(index==0){
        index=2;
      }
      else{
        index--;
      }
    }
    if(rectRange(600,800,50,50)){ //next track
      if(index==2){
        index=0;
      }
      else{
        index++;
      }
    }
    if(rectRange(500,930,150,50)){
      exit();
    }
}
