//Soundfiles
enum Instrument{
  DRUM,
  PIANO,
  FX,
  SCRATCH,
  SINE
}

SoundFile[] drum = new SoundFile[3]; //kick, snare and hihat
SoundFile[] piano = new SoundFile[8]; //c3, d3, e3 ... c4
SoundFile[] fx = new SoundFile[1]; //piano_loop
SoundFile[] scratch = new SoundFile[8];

SinOsc sine;
Boolean isSinePlay = false;

void initSound(){
  drum[0] = new SoundFile(this, "drum/kick.wav");
  drum[1] = new SoundFile(this, "drum/snare.wav");
  drum[2] = new SoundFile(this, "drum/hihat.wav");
  
  piano[0] = new SoundFile(this, "piano/c3.wav");
  piano[1] = new SoundFile(this, "piano/d3.wav");
  piano[2] = new SoundFile(this, "piano/e3.wav");
  piano[3] = new SoundFile(this, "piano/f3.wav");
  piano[4] = new SoundFile(this, "piano/g3.wav");
  piano[5] = new SoundFile(this, "piano/a3.wav");
  piano[6] = new SoundFile(this, "piano/b3.wav");
  piano[7] = new SoundFile(this, "piano/c4.wav");
  
  fx[0] = new SoundFile(this, "fx/1.wav");
  
  for(int i=0; i<8; i++){
    scratch[i] = new SoundFile(this, "scratch/" + (i+1) + ".wav");
  }
  
  sine = new SinOsc(this);
}
