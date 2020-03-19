public class Score1 {
  
  private int num;
  
  public Score1() {
    this.num = 0;
  }
  
  public void addP(int x) {
    this.num += x;
  }
  
  public void show() {
    fill(255);
    textSize(32);
    text("Score: " + Integer.toString(this.num), width - 200, 50);
  }
  
}
