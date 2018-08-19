import java.util.Iterator;
import processing.serial.*;
import processing.sound.*;

ArrayList<Particle> plist = new ArrayList<Particle>();
Serial myPort;
Instrument curInstrument = Instrument.DRUM;

void setup() {
  size(800, 600);
  String portName = Serial.list()[1];
  println(portName);
  myPort = new Serial(this, portName, 9600);

  //Sound init
  initSound();
}

void draw() {
  background(30);

  if (myPort.available()>0) {
    PVector startPos = new PVector(width/2, height/2);
    int v = int(myPort.readString().trim()); // distance from 0 - 550
    switch(curInstrument) {
    case DRUM:
      drum[int(map(v, 30, 550, 0, drum.length-1))].play();
      break;
    case PIANO:
      piano[int(map(v, 30, 550, 0, piano.length-1))].play();
      break;
    case FX:
      fx[int(map(v, 30, 550, 0, fx.length-1))].rate(map(v, 30, 550, 0.25, 4.0)); 
      fx[int(map(v, 30, 550, 0, fx.length-1))].play();
      break;
    case SCRATCH:
      scratch[int(map(v, 30, 550, 0, scratch.length-1))].play();
      break;
    case SINE:
      if (!isSinePlay) {
        sine.play();
      }
      isSinePlay = true;
      sine.freq(map(v, 30, 550, 20.0, 1000.0));
    }
    ellipseMode(RADIUS);
    fill(255, 30);
    for (int i=0; i<v/2; i++) {
      plist.add(new Particle(startPos));
    }
  }

  Iterator<Particle> it = plist.iterator();

  while (it.hasNext()) {
    Particle p = it.next();
    p.run();
    if (p.isDead()) {
      it.remove();
    }
  }
}
