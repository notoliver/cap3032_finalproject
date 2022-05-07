ArrayList<Obstacle> obstacles;
PImage dustimg, scratchimg;

//base class for obstacles
class Obstacle{
  int track;
  float x,y;
  boolean shown;
  boolean collided;
  //super constructor, only draws new obstacles off screen
  Obstacle(){
    shown = false;
    collided = false;
    track = int(random(1,4));
    float angle = random(0,359);
    if(track==1){
      x = cos(angle)*285;
      y = sin(angle)*285;
    }
    if(track==2){
      x = cos(angle)*370;
      y = sin(angle)*370;
    }
    if(track==3){
      x = cos(angle)*455;
      y = sin(angle)*455;
    }
    
    //while its onscreen, keep generating until its off screen
    while((screenX(x,y)>=0) && (screenY(x,y)<=1000)){
      angle = random(0,359);
      if(track==1){
        x = cos(angle)*285;
        y = sin(angle)*285;
      }
      if(track==2){
        x = cos(angle)*370;
        y = sin(angle)*370;
      }
      if(track==3){
        x = cos(angle)*455;
        y = sin(angle)*455;
      }
    }
    
  }
  void drawObstacle(){}; //override
  void hitObstacle(){}; //override
}

//a type of obstacle, scratches
class Scratch extends Obstacle{
  void drawObstacle(){
    //constructor, appears as a scratch
    if(screenX(x,y)<0){
      shown = true;
    }
    fill(110);
    //rect(x,y,20,10);
    image(scratchimg,x,y,30,30);
  }
  //on hit will play the scratch sound and update scores
  void hitObstacle(){
    if(!collided){
      scratch.play();
      collided = true;
      scratch.rewind();
      score -= 5;
      streak = 0;
      obstaclesHit++;
    }
  }
}

//a type of obstacle, dust
class Dust extends Obstacle{
  //constructor, appears as spec of dust
  void drawObstacle(){
    if(screenX(x,y)<0){
      shown = true;
    }
    fill(150,150);
    //ellipse(x,y,20,20);
    image(dustimg,x,y,30,30);
  }
  //on hit will play the dust sound and update scores
  void hitObstacle(){
    if(!collided){
      collided = true;
      dust.play();
      dust.rewind();
      score -= 5;
      if(streak>streakHigh){
        streakHigh = streak;
      }
      streak = 0;
      obstaclesHit++;
    }
  }
}

//draws and updates obstacles on the disc
void drawObstacles(){
  if(difficulty != "visualizer"){
    fill(255,0,0);

    //adds obstacles based on bass frequencies/beats
    if(difficulty == "hard"){
      if(fft.calcAvg(30,250)>50){
        if(int(random(1,3))==1){
          obstacles.add(new Dust());
        }
        else obstacles.add(new Scratch());
      }
    }
    if(difficulty == "normal"){
      if(fft.calcAvg(30,150)>80){
        if(int(random(1,3))==1){
          obstacles.add(new Dust());
        }
        else obstacles.add(new Scratch());
      }
    }
    

    //iterate through obstacles list
    for(int i=0;i<obstacles.size();i++){
      float tempx = obstacles.get(i).x;
      float tempy = obstacles.get(i).y;
      
      //print(screenX(tempx,tempy)+", "+screenY(tempx,tempy)+", "+nx+", "+ny+"\n");
      
      //draw obstacle, check for collsion with needly
      obstacles.get(i).drawObstacle();
      if(screenX(tempx,tempy)<nx+10 && screenY(tempx,tempy)<ny+10 && 
         screenX(tempx,tempy)>nx-10 && screenY(tempx,tempy)>ny-10){
        obstacles.get(i).hitObstacle();
      }
      
      //remove obstacle when passed to the left of screen and increment to dodged if not collided
      if(screenX(tempx,tempy)<0&&obstacles.get(i).shown){
        obstacles.remove(i);
      }
    }
  }
}
