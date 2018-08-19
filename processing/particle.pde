class Particle {
  PVector loc;
  PVector vel;
  PVector acc;
  float lifespan;
  color[] colors = new color[]{
    #f3b31e, 
    #80ccda, 
    #e84244, 
    #752f88, 
    #971f2b
  };
  color c;
  Particle(PVector l) {
    loc = l.get();
    acc = new PVector(0, 0.2);
    vel = new PVector(random(-4, 4), random(-6, 0));
    lifespan = 255;
    c = colors[int(random(colors.length))];
  }

  void update() {
    vel.add(acc);
    loc.add(vel);
    lifespan-=1;
  }

  void display() {
    stroke(c, lifespan);
    fill(c, lifespan);
    rectMode(RADIUS);
    rect(loc.x, loc.y, 6, 6);
  }

  void checkEdge() {
    if (loc.y > height) {
      loc.y = height;
      vel.y = -vel.y;
    }
  }

  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }

  void run() {
    update();
    checkEdge();
    display();
  }
}
