/* This example shows how to use continuous mode to take
  range measurements with the VL53L0X. It is based on
  vl53l0x_ContinuousRanging_Example.c from the VL53L0X API.

  The range readings are in units of mm. */

#include <Wire.h>
#include <VL53L0X.h>
#include "MIDIUSB.h"

VL53L0X sensor;

int lastDistance = 0;
int curDistance = 0;

void noteOn(byte channel, byte pitch, byte velocity) {
  midiEventPacket_t noteOn = {0x09, 0x90 | channel, pitch, velocity};
  MidiUSB.sendMIDI(noteOn);
}

void noteOff(byte channel, byte pitch, byte velocity) {
  midiEventPacket_t noteOff = {0x08, 0x80 | channel, pitch, velocity};
  MidiUSB.sendMIDI(noteOff);
}

void controlChange(byte channel, byte control, byte value) {
  midiEventPacket_t event = {0x0B, 0xB0 | channel, control, value};
  MidiUSB.sendMIDI(event);
}

void setup()
{
  Serial.begin(9600);
  Wire.begin();

  sensor.setAddress(0x52);
  sensor.init();
  sensor.setTimeout(500);

  // Start continuous back-to-back mode (take readings as
  // fast as possible).  To use continuous timed mode
  // instead, provide a desired inter-measurement period in
  // ms (e.g. sensor.startContinuous(100)).
  sensor.setMeasurementTimingBudget(2000);
}

void loop()
{
  int curDistance = sensor.readRangeSingleMillimeters();
  if (curDistance < 100) {
    controlChange(0, 10, 0); 
  } else if (curDistance < 500) {
    for (int i = 0; i < 20; i++) {
      //controlChange(0, 10, map(curDistance, 100, 500, 1, 127)); //
      noteOn(0, map(curDistance, 100, 500, 48, 68), 120);
      delay(1);
    }
  }


  //  int curDistance = sensor.readRangeContinuousMillimeters();
  //  if (curDistance < 500) {
  //    Serial.println(curDistance);
  //
  //  }
  //  if (sensor.timeoutOccurred()) {
  //    Serial.println(" TIMEOUT");
  //  }
}
