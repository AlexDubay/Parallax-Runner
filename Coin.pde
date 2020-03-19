public class Coin extends Box {
  
  private int points;
  private boolean active;
  private Score1 s;
  
  public Coin(int x, int y, Score1 s) {
    super(x, y, 50, 50);
    this.points = 10;
    this.active = true;
    this.s = s;
  }
  
  @Override
  public boolean check(int y) {
    boolean b = false;
    if (this.active) {
      b = super.check(y);
      if (b) this.collect();
    }
    return b;
  }
  
  public void collect() {
    active = false;
    this.s.addP(this.points);
  }
  
  
  @Override
  public void show() {
    if (active) super.show();
  }
}
