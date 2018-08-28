ArrayList<PVector> rawpoints; 
ArrayList<colorPoint> points;
final int cnt=20;

void setup() {
  size(800, 800);
  rawpoints = new ArrayList<PVector>();
  points = new ArrayList<colorPoint>();
  for (int i=0; i<cnt; i++) {
  rawpoints.add(new PVector(random(width),random(height)));
  }
  
  
  for (PVector p : rawpoints) {
    color c=color(int(random(255)),int(random(255)),int(random(255)));
    colorPoint cp=new colorPoint(c,new PVector(p.x,p.y));
    points.add(cp);
  }
  strokeWeight(4);
}

void draw() {
  
  for (colorPoint p : points) {
    p.show();
  }
  
  
      for (float x=0; x<=width; x+=1) {
        for (float y=0; y<=height; y+=1) {
          float mind=2e15;
          colorPoint minp = new colorPoint();
          for (colorPoint p : points) {
            float d=dist(x,y,p.pos.x,p.pos.y);
           if (d<mind) {
             mind=d;
             minp=p;
           } 
          }
          stroke(minp.c);
          point(x,y);
      }
  }
  
  noLoop();
}