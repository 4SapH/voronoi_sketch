class ColorPoint {
  color c;
  PVector pos;
  
  ColorPoint(color c_, PVector pos_) {
    c=c_;
    pos=pos_;
  }
  
  ColorPoint() {
    
  }
  
  void show() {
    stroke(c);
    point(pos.x,pos.y);
  }
  
  void save() {
    
  }
  
  void load() {
  }
}