/* This example shows how to use continuous mode to take
  range measurements with the VL53L0X. It is based on
  vl53l0x_ContinuousRanging_Example.c from the VL53L0X API.

  The range readings are in units of mm. */

#include <Wire.h>
#include <VL53L0X.h>

VL53L0X sensor;
int lastDistance = 0;
int curDistance = 0;

void setup()
{
  Serial.begin(9600);
  Wire.begin();

  sensor.init();
  sensor.setTimeout(500);

  // Start continuous back-to-back mode (take readings as
  // fast as possible).  To use continuous timed mode
  // instead, provide a desired inter-measurement period in
  // ms (e.g. sensor.startContinuous(100)).
  sensor.startContinuous(100);
}

void loop()
{
  int curDistance = sensor.readRangeContinuousMillimeters();
  if (curDistance != lastDistance && curDistance <= 1000) {
    Serial.println(curDistance);
  }
  if (curDistance != lastDistance && curDistance > 1000) {
    Serial.println(0);
  }
  lastDistance = curDistance;
  
  if (sensor.timeoutOccurred()) {
    Serial.println(" TIMEOUT");
  }
}
