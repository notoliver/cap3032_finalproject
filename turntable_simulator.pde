import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

String current;
PFont HelvetiHand;
Minim minim;
AudioPlayer player;
AudioPlayer dust;
AudioPlayer scratch;
AudioMetaData meta;
FFT fft;

//setup
void setup(){
  size(1000,1000);
  noStroke();
  frameRate(60);
  
  HelvetiHand = createFont("HelvetiHand.ttf",48);
  textFont(HelvetiHand);
  rectMode(CENTER);
  
  current = "menu";
  minim = new Minim(this);
  
  imageMode(CENTER);
  dustimg = loadImage("dust.png");
  scratchimg = loadImage("scratch.png");
}

//draws based on the state of the game
void draw(){
  if(current == "menu"){
    drawMenu();
  }
  if(current == "game"){
    drawGame();
  }
  if(current == "end"){
    drawEndScreen();
  }
}
