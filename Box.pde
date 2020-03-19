public class Box {
  
  private int x, y, w, h;
  public int playerX = 0;
  
  public Box(int x, int y, int w, int h) {
    this.x = x;
    this.y = Player.FLOOR - y;
    this.w = w;
    this.h = h;
  }
  
  public boolean check(int y) {
    return 120 >= this.getX() && 120 <= this.getR() && y < this.getB() && y + 60 / 2 >= this.getY();
    //return playerX + 100 >= this.getX() && playerX + 20 <= this.getR() && y < this.getB() && y + 60 / 2 >= this.getY();
  }
  
  public void update(int x) {
    this.playerX = x;
  }
  
  public void show() {
    rectMode(CORNER);
    fill(255, 0, 0);
    rect(this.x - this.playerX * Scroll.IMGNUM, this.y, this.w, this.h);
  }
  
  public int getX() {
    return this.x - this.playerX * Scroll.IMGNUM;
  }
  
  public int getY() {
    return this.y;
  }
  
  //returns bottom edge
  public int getB() {
    return this.y + this.h;
  }
  
  //returns right side
  public int getR() {
    return this.getX() + this.w;
  }
  
}
