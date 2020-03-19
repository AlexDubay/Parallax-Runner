public enum State {
  IDLE, RUNNING, JUMP, MIDAIR, LAND
}

public class Player {
  
  private PImage[] idle, run, air;
  private PImage jump, land;
  private State state;
  public int t, x, y, vy, playerX;
  private static final int ACC = 1;
  public static final int FLOOR = 700, ANIRATE = 5; // 1 / ANIRATE
  
  private Box[] hitbox;
  
  public Player(int x, int y, PImage[] idle, PImage[] run, PImage[] midair, PImage jump, PImage land) {
    this.idle = idle;
    this.run = run;
    this.air = midair;
    this.jump = jump;
    this.land = land;
    
    this.state = State.IDLE;
    t = 0;
    this.x = x;
    this.y = y;
  }
  
  public void registerHitbox(Box[] h) {
    this.hitbox = h;
  }
  
  
  public boolean isLanded() {
    if (this.y >= FLOOR) {
      this.y = FLOOR;
      return true;
    }
    
    for (Box b: this.hitbox) {
      if (this.vy >= 0 && b.check(this.y)) {
        this.y = b.getY() - 60 / 2;
        return true;
      }
    }
    return false;
  }
  
  public State getState() {
    return this.state;
  }
  
  public void changeState(State s) {
    this.state = s;
    this.t = 0;
  }
  
  public void bounce() {
    this.vy = -20;
    this.y -= 1;
  }
  
  public void update(int playerX) {
    this.playerX = playerX;
    if (!this.isLanded()) {
      this.vy += ACC;
      this.y += this.vy;
      if (this.isLanded()) {
        this.vy = 0;
        this.state = State.LAND;
      }
    }
  }
  
  public void show(int keyValue) {
    imageMode(CENTER);
    switch (this.state) {
      case IDLE:
        image(this.idle[t / ANIRATE], this.x, this.y, 40, 60);
        t++;
        if (this.t >= this.idle.length * ANIRATE) t = 0;
        break;
      case RUNNING:
        image(this.run[t / ANIRATE], this.x, this.y, 40, 60);
        t++;
        if (this.t >= this.run.length * ANIRATE) t = 0;
        break;
      case JUMP:
        image(this.jump, this.x, this.y, 40, 60);
        this.state = State.MIDAIR;
        break;
      case MIDAIR:
        image(this.air[t / ANIRATE], this.x, this.y, 40, 60);
        t++;
        if (t >= this.air.length * ANIRATE) t = 0;
        break;
      case LAND:
        image(this.land, this.x, this.y, 40, 60);
        if (keyValue == 0) this.state = State.IDLE;
        else this.state = State.RUNNING;
        break;
    }
  }
  
}
