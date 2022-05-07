boolean init = true;
int songLength;
float score, streak, streakHigh;
int obstaclesHit;

//main game function loop, draws and updates for menu, game and end
void drawGame(){

  if(init){
    //choose song
    print(difficulty+" "+songs[index]+"\n");
    String filename = "";
    if(index==0){
      filename="welcomeback.mp3";
    }
    if(index==1){
      filename="onbreak.mp3";
    }
    if(index==2){
      filename="printerpaper.mp3";
    }
    
    //init score and streak
    score = 0;
    streak = 0;
    obstaclesHit = 0;
    streakHigh = 0;
    obstacles = new ArrayList<Obstacle>();
    needleRotate = 14.4;
    track = 3;

    //init minim stuff
    player = minim.loadFile(filename);
    scratch = minim.loadFile("scratch.mp3");
    dust = minim.loadFile("dust.mp3");
    meta = player.getMetaData();
    songLength= meta.length();
    player.play();
    fft = new FFT( player.bufferSize(), player.sampleRate() );

    //run once bool
    init = false;
  }
  
  //end when song ends
  if(!player.isPlaying()){
    current = "end";
  }
  
  background(50,30,20);
  rectMode(CENTER);
  fft.forward( player.mix );
  
  drawTurntable();
}

//handles mouse click in menus and end screen
void mouseClicked(){
  if(current == "menu"){
    handleMenuClick();
  }
  if(current == "end"){
    handleEndClick();
  }
}

//helper function to detect click location
boolean rectRange(float x, float y, float w, float h){
  return( mouseX>(x-w/2) && mouseX<(x+w/2) && mouseY>(y-h/2) && mouseY<(y+h/2));
}
