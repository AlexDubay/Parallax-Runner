public class Scroll {
  
  private PImage img;
  private int layer;  //0 means back
  private int playerX;
  public static final int IMGNUM = 11, FRAMESRIGHT = 5;
  
  public Scroll(PImage img, int layer) {
    this.img = img;
    this.layer = layer;
  }
  
  public void update(int x) {
    this.playerX = x;
  }
  
  
  public void show() {
    imageMode(CORNER);
    for (int i = 0; i <= FRAMESRIGHT * this.layer; i++) {
      image(this.img, i * width - this.playerX * this.layer, 0);
    }
  }
}
