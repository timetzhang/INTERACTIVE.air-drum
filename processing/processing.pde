import java.util.Iterator;
import processing.serial.*;

ArrayList<Particle> plist = new ArrayList<Particle>();
Serial myPort;
Instrument curInstrument = Instrument.PIANO;

//sound vars
boolean playable = true; //when distance is 0mm, set to true

//draw
float t1=0;
float t2=10000;


void setup() {
  size(800, 600, P2D);
  background(0);
  smooth();

  //init serial port
  String portName = Serial.list()[1];
  println(portName);
  myPort = new Serial(this, portName, 9600);

  //init sound
  initSound();
}

void draw() {
  float n = noise(t1);
  float m = noise(t2);
  fill(0, 30);
  stroke(255);

  if (myPort.available()>0) {
    int v = int(myPort.readString().trim()); // distance from 0 - 550
    println("distance:" + v + "mm");

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
        fx.rewind();
        float rate = map(v, 30, 550, 1.0f, 3.f);
        rateControl.value.setLastValue(rate);
        fx.play();
      }
      break;

    case SCRATCH:
      if (v != 0) {
        int cuePoint = int(map(v, 30, 550, 0, scratch.length()));
        scratch.setLoopPoints(cuePoint, cuePoint + 400);
        scratch.loop(1);
      }
      break;

    case OSC:
      if (v != 0) {
        oscA.setAmplitude(0.3);
        oscB.setAmplitude(0.3);
        oscC.setAmplitude(0.33);

        float freqTime = map(v, 30, 550, 0.6, 1.3);
        oscA.unpatch(audioOut);
        oscB.unpatch(audioOut);
        oscC.unpatch(audioOut);
        oscA.setFrequency(440*freqTime);
        oscB.setFrequency(523.25*freqTime);
        oscC.setFrequency(659.25*freqTime);
        oscA.patch(audioOut);
        oscB.patch(audioOut);
        oscC.patch(audioOut);
      } else {
        oscA.setAmplitude(0);
        oscB.setAmplitude(0);
        oscC.setAmplitude(0);
      }
    }

    ellipse(n*width, m*height, v/2, v/2);
    t1+=map(v, 30, 550, 0.01, 0.003);
    t2+=map(v, 30, 550, 0.01, 0.003);
  } else {
    //ellipse(n*width, m*height, 30, 30);
    //t1+=0.007;
    //t2+=0.007;
  }
}
