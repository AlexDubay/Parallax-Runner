Scroll[] bg; //0-10: back to front
Box[] box;

Score1 s;

int pos, keyValue;
int IMGNUM = 11;
int RUNSPEED = 1;

Player player;

void setup() {
  size(928, 793, P2D);
  
  
  //~~~~~~~~~~~~Load Assets~~~~~~~~~~~~~~~
  bg = new Scroll[IMGNUM];
  PImage p;
  for (int i = 0; i < bg.length; i++) {
    p = loadImage("data\\BGLayers\\Layer" + (bg.length - i - 1) + ".png");
    bg[i] = new Scroll(p, i + 1);
  }
  
  PImage[] idle = new PImage[12];
  for (int i = 0; i < idle.length - 2; i++) {
    idle[i] = loadImage("data\\sprites\\idle\\frame_0" + i + "_delay-0.1s.png");
  }
  idle[10] = loadImage("data\\sprites\\idle\\frame_10_delay-0.1s.png");
  idle[11] = loadImage("data\\sprites\\idle\\frame_11_delay-0.1s.png");
  
  PImage[] run = new PImage[8];
  for (int i = 0; i < run.length; i++) {
    run[i] = loadImage("data\\sprites\\run\\frame_" + i + "_delay-0.1s.gif");
  }
  
  PImage[] midAir = new PImage[2];
  midAir[0] = loadImage("data\\sprites\\midAir\\frame_0_delay-0.1s.gif");
  midAir[1] = loadImage("data\\sprites\\midAir\\frame_1_delay-0.1s.gif");
  
  PImage land = loadImage("data\\sprites\\land\\frame_apngframe0.png");
  PImage jump = loadImage("data\\sprites\\jump\\frame_apngframe0.png");
  
  player = new Player(120, Player.FLOOR, idle, run, midAir, jump, land);
  
  //~~~~~~~~~~~~~~~~End Load Assets~~~~~~~~~~~~~~~~~~~~~~~~~
  
  pos = 0;
  keyValue = 0;
  
  //Scoreboard
  s = new Score1();
  
  
  //hitboxing
  box = new Box[5];
  box[0] = new Box(500, 100, 200, 50);
  box[1] = new Box(700, 250, 200, 50);
  box[2] = new Coin(800, 350, s);
  box[3] = new Box(1000, 150, 200, 50);
  box[4] = new Coin(1000, 250, s);
  
  player.registerHitbox(box);
  
  frameRate(60);
}


void draw() {
  background(0);
  //~~~~~~~~debug~~~~~~~~~~~
  //println(mouseX + " " + mouseY);
  //println(pos + " " + box[0].getX() + " " + box[0].getR());
  
  pos += keyValue * RUNSPEED;
  if (pos < 0) pos = 0;
  
  for (Scroll s: bg) {
    s.update(pos);
    s.show();
  }
  
  for(Box b:box) {
    b.check(player.y);
    b.update(pos);
    b.show();
  }
  
  player.update(pos);
  player.show(keyValue);
  
  s.show();
}


void keyPressed() {
  if (keyCode == RIGHT) {
    if (player.getState() == State.IDLE) player.changeState(State.RUNNING);
    keyValue = 1;
  } else if (keyCode == LEFT) {
    if (player.getState() == State.IDLE) player.changeState(State.RUNNING);
    keyValue = -1;
  } else if (keyCode == UP && player.isLanded()) {
    player.changeState(State.JUMP);
    player.bounce();
  }
    
}

void keyReleased() {
  if ((keyCode == RIGHT && keyValue == 1) || (keyCode == LEFT && keyValue == -1)) {
    player.changeState(State.IDLE);
    keyValue = 0;
  }
}
