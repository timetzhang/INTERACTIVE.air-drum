//Soundfiles
import ddf.minim.*;
import ddf.minim.ugens.*;

Minim minim;
AudioOutput    audioOut;

//drum
AudioPlayer[]  drum = new AudioPlayer[4];

//piano
AudioPlayer[]  piano = new AudioPlayer[8];

//scratch
AudioPlayer    scratch;

//fx
FilePlayer     fx;
TickRate       rateControl;

//sine osc generator

Oscil          oscA,oscB,oscC;
Frequency      currentFreq;


enum Instrument {
  DRUM, PIANO, FX, SCRATCH, OSC
}

void initSound() {
  minim = new Minim(this);

  switch(curInstrument) {
  case DRUM:
    drum[0] = minim.loadFile("drum/kick.wav");
    drum[1] = minim.loadFile("drum/snare.wav");
    drum[2] = minim.loadFile("drum/crash.wav");
    drum[3] = minim.loadFile("drum/hihat.wav");
    break;

  case PIANO:
    for (int i=1; i<=8; i++) {
      piano[i-1] = minim.loadFile("piano/"+i+".mp3");
    }
    break;

  case FX:
    audioOut = minim.getLineOut();
    fx = new FilePlayer( minim.loadFileStream("fx/1.wav") );
    rateControl = new TickRate(1.f);
    fx.patch(rateControl).patch(audioOut);
    break;
    
  case SCRATCH:
    scratch = minim.loadFile("scratch/1.wav");
    break;

  case OSC:
    audioOut = minim.getLineOut();
    oscA = new Oscil(440, 0.1f, Waves.SINE);
    oscB = new Oscil(523.25, 0.1f, Waves.SINE);
    oscC = new Oscil(659.25, 0.1f, Waves.SINE);
    break;
  }
}
