ArrayList<PVector> rawpoints; 
ArrayList<ColorPoint> points;
final int cnt=20;

void setup() {
  size(800, 800);
  rawpoints = new ArrayList<PVector>();
  points = new ArrayList<ColorPoint>();
  for (int i=0; i<cnt; i++) {
    rawpoints.add(new PVector(random(width),random(height)));
  }
  
  for (PVector p : rawpoints) {
    color c=color(int(random(255)),int(random(255)),int(random(255)));
    ColorPoint cp=new ColorPoint(c,new PVector(p.x,p.y));
    points.add(cp);
  }
  strokeWeight(4);
}

void savePoints(ArrayList<ColorPoint> points) {
  JSONObject idObj = new JSONObject();
  int id;
  // Delete id.json if you want to start over
  // (from 0)
  try {
    idObj = loadJSONObject("id.json");
    id = idObj.getInt("id") + 1;
  } catch(java.lang.Throwable err) {
    id = 0;
  }
  idObj.setInt("id", id);
  saveJSONObject(idObj, "id.json");
  JSONArray jsonArr = new JSONArray();
  JSONObject posObj, colorObj, pointObj;
  for (int i = 0; i < points.size(); i++) {
    posObj = new JSONObject();
    posObj.setFloat("x", points.get(i).pos.x);
    posObj.setFloat("y", points.get(i).pos.y);
    colorObj = new JSONObject();
    colorObj.setInt("r", int(red(points.get(i).c)));
    colorObj.setInt("g", int(green(points.get(i).c)));
    colorObj.setInt("b", int(blue(points.get(i).c)));
    pointObj = new JSONObject();
    pointObj.setJSONObject("pos", posObj);
    pointObj.setJSONObject("color", colorObj);
    jsonArr.setJSONObject(i, pointObj);
  }
  saveJSONArray(jsonArr, "exports/voronoi-"+id+".json");
}

void draw() {
  
  for (ColorPoint p : points) {
    p.show();
  }
  
  
  for (float x=0; x<=width; x+=1) {
    for (float y=0; y<=height; y+=1) {
      float mind=2e15;
      ColorPoint minp = new ColorPoint();
      for (ColorPoint p : points) {
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
  
  savePoints(points);
  noLoop();
}