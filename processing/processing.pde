import java.util.Iterator;
import processing.serial.*;


ArrayList<Particle> plist = new ArrayList<Particle>();
Serial myPort;
Instrument curInstrument = Instrument.SINE;

//sound vars
boolean playable = true; //when distance is 0mm, set to true

void setup() {
  size(800, 600, P2D);
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
    //println("distance:" + v + "mm");
    switch(curInstrument) {
    case DRUM:
      if (v != 0 ) {
        drum[int(map(v, 1, 550, 0, drum.length))].play();
        drum[int(map(v, 1, 550, 0, drum.length))].rewind();
        playable = false;
      }
      if ( v == 0) {
        playable = true;
      }
      break;

    case PIANO:
      if (v != 0) {
        println(int(map(v, 30, 550, 0, piano.length)));
        piano[int(map(v, 30, 550, 0, piano.length))].play();
        piano[int(map(v, 30, 550, 0, piano.length))].rewind();
        playable = false;
      }
      if (v == 0) {
        playable = true;
      }
      break;

    case FX:
      if (v != 0) {
        int cuePoint = int(map(v, 30, 550, 0, fx.length()));
        //fx.
        fx.loop(1);
      }
      break;

    case SCRATCH:
      if (v != 0) {
        int cuePoint = int(map(v, 30, 550, 0, scratch.length()));
        scratch.setLoopPoints(cuePoint, cuePoint + 400);
        scratch.loop(1);
      }
      break;

    case SINE:
      if (v != 0) {
        oscA.setAmplitude(0.4);
        oscB.setAmplitude(0.3);
        oscC.setAmplitude(0.3);
        
        float freqTime = map(v, 30, 550, 0.6, 1.3);
        oscA.unpatch(oscOut);
        oscB.unpatch(oscOut);
        oscC.unpatch(oscOut);
        oscA.setFrequency(440*freqTime);
        oscB.setFrequency(523.25*freqTime);
        oscC.setFrequency(659.25*freqTime);
        oscA.patch(oscOut);
        oscB.patch(oscOut);
        oscC.patch(oscOut);
      } else {
        oscA.setAmplitude(0);
        oscB.setAmplitude(0);
        oscC.setAmplitude(0);
      }
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
