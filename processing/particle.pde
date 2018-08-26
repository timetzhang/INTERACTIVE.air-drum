class Particle {
  PVector pos1;
  PVector pos2;
  PVector pos3;
  float t1=1;
  float t2=200;
  PVector vel;
  color[] colors = new color[]{
    #f3b31e, 
    //#80ccda, 
    #e84244, 
    //#752f88, 
    #971f2b
  };
  color c;

  Particle() {
    pos1 = new PVector(random(width), random(height));
    pos2= new PVector(random(width), random(height));
    pos3 = new PVector(random(width), random(height));
    vel = new PVector(noise(t1), noise(t2));
    c = colors[int(random(colors.length))];
  }

  void update() {
    updateVel();
    pos1.add(vel);
    updateVel();
    pos2.add(vel);
    updateVel();
    pos3.add(vel);
  }

  void updateVel() {
    t1+=2;
    t2+=2;
    float p = random(1);
    if (p<0.25) {
      vel = new PVector(noise(t1), noise(t2));
    } else if (p<0.5) {
      vel = new PVector(-noise(t1), noise(t2));
    } else if (p<0.75) {
      vel = new PVector(noise(t1), -noise(t2));
    } else if (p<1) {
      vel = new PVector(-noise(t1), -noise(t2));
    }
  }

  void display() {
    ellipseMode(RADIUS);
    noStroke();
    fill(255);
    ellipse(pos1.x, pos1.y, 2, 2);
    ellipse(pos2.x, pos2.y, 2, 2);
    ellipse(pos3.x, pos3.y, 2, 2);
    stroke(255,90);
    fill(40,40);
    triangle(pos1.x, pos1.y, pos2.x, pos2.y, pos3.x, pos3.y);
  }

  void run() {
    update();
    display();
  }
}
