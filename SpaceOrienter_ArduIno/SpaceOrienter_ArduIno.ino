// set Serial Monitor to 9600 Baud, insert values <elevation> ; <azimuth> and the Space Orienter will direct the beam
#include <Wire.h> //I2C Arduino Library
#include "Print.h"

/* ----------------- { MMA } ----------------- */
#define MMA8451_ADDRESS                (0x3A >> 1)    // this is  0x1D and means SA0 = 1

// register keys
#define MMA8451_REG_OUT_X_MSB     0x01
#define MMA8451_REG_WHOAMI        0x0D

#define MMA8451_REG_CTRL_REG1     0x2A
#define MMA8451_REG_CTRL_REG2     0x2B

// sensor values
float mx = 0, mz = 0;


/* ----------------- { HMC } ----------------- */
#define HMC5883_ADDRESS_MAG            (0x3C >> 1)    // this is  0x1E

// scaling constants
#define xp 730
#define xm 690
#define yp 750
#define ym 720
#define cpemf 543 //Earthmagnetic field in counts (vaulue here in Berlin).

float sx = 0, sy = 0;// scaled sensor values


/* ----------------- { general } ----------------- */

#define backlash_motor 8
#define elapse         60

#define LaserWeak   12
#define LaserStrong 11

bool LaserIsRunning = false;
bool NewInput       = false;

// We are working with raw values, which means if the azimuth goes over 180° the elevation will be flipped (> 90°)
// and the azimuth will decreased by 180°.
// the INput values are comming from the serial port
float Raw_azimuth,   Raw_elevation;
float Raw_azimuthIn, Raw_elevationIn;

long oldtime = 0;

//If you want to run whith Twedge decomment this and in ProgressInput too!
//String LastStrIn;


/* ----------------- { setup } ----------------- */

void setup() {
  oldtime = millis();

  Serial.begin(9600);

  // Enable I2C
  Wire.begin();

  // Check if MMA sensor was found
  if (readRegister8(MMA8451_REG_WHOAMI) != 0x1A)
  {
    /* No MMA8451 detected don't do anything */
    Serial.println("MMA not found");
    while (true);
  }

  //Reset MMA
  writeRegister8(MMA8451_REG_CTRL_REG2, 0x40);
  while (readRegister8(MMA8451_REG_CTRL_REG2) & 0x40);
  //  set data rate 12.5 Hz(0x28), low noise mode (0x04), activate operation(0x01)
  writeRegister8(MMA8451_REG_CTRL_REG1, 0x28 | 0x04 | 0x01);

  // Set magnetometer to continuous operation, since default is single measurement
  Wire.beginTransmission(HMC5883_ADDRESS_MAG);
  Wire.write((uint8_t) 0x02); //HMC5883_REGISTER Mode Register
  Wire.write((uint8_t)0x00);
  Wire.endTransmission();
  // Set gain to maximum (0.73 mG per count)
  // So it is attained for Berlin (earth magnetic field = 0.5 G) cpemf counts = 0.5 G/0.00073 G = 685 counts
  Wire.beginTransmission(HMC5883_ADDRESS_MAG);
  Wire.write((uint8_t) 0x01); //HMC5883_REGISTER Configuration Register B
  Wire.write((uint8_t)0x00);
  Wire.endTransmission();

  pinMode(0, INPUT_PULLUP);//Azimut Control
  pinMode(1, INPUT_PULLUP);//Azimut Control
  pinMode(4, INPUT_PULLUP);//Elevation Control
  pinMode(5, INPUT_PULLUP);//Elevation Control
  pinMode(6, INPUT);//Laser Control
  pinMode(7, OUTPUT);//Azimut motor
  pinMode(8, OUTPUT);//Azimut motor
  pinMode(9, OUTPUT);//Elevation motor
  pinMode(10, OUTPUT);//Elevation motor
  pinMode(11, OUTPUT);//Laser strong
  pinMode(12, OUTPUT);//Laser weak
  pinMode(13, OUTPUT);//Beep

}


/* ----------------- { loop } ----------------- */

void loop()
{
  float elevation, azimuth;

  //Get value from MMA
  MMAread ();
  Raw_elevation = (atan2(mz, -mx) * 180 / M_PI);
  // atan2 runs from -180 to 180 degrees, Raw_elevation theoretically from -90 to 270 degrees
  if (Raw_elevation < -90) Raw_elevation += 360;
  elevation = Raw_elevation;

  if (Raw_elevation >= 90) elevation = 180 - Raw_elevation;


  //Get values from HMC
  HMCread();
  Raw_azimuth = atan2(-sx, sy) * 180 / M_PI;
  // atan2 runs from -180 to 180 degrees, Raw_azimuth theoretically from -90 to 270 degrees
  if (Raw_azimuth < -90) Raw_azimuth += 360;

  azimuth = Raw_azimuth;
  // restore azimuth with 0 to 360 degrees
  if (Raw_elevation > 90) azimuth += 180;
  if (azimuth < 0) azimuth += 360;
  if (azimuth > 360) azimuth -= 360;


  if (((millis() - oldtime) > 700) || NewInput) {
    Serial.println (String(elevation) + ";" + String(azimuth/* + 15*/) + ";");// + String(Raw_elevation) + ";" + String(Raw_azimuth));
    oldtime = millis();
  }


  //progress input from the manual control
  if (digitalRead(0) == LOW & digitalRead(1) == HIGH  ) //decrease azimuth
  {
    MoveAzimuth (120, true);
    NewInput = false;
  }

  if (digitalRead(0) == HIGH & digitalRead(1) == LOW ) //increase azimuth
  {
    MoveAzimuth (120, false);
    NewInput = false;
  }

  if (digitalRead(4) == LOW & digitalRead(5) == HIGH ) //increase elevation
  {
    MoveElevation (120, true);
    NewInput = false;
  }

  if (digitalRead(4) == HIGH & digitalRead(5) == LOW ) //decrease elevation
  {
    MoveElevation (120, false);
    NewInput = false;
  }

  //Laser with warning tone
  if (digitalRead(6) == HIGH)
    PutLaserOn(LaserStrong);
  else
    PutLaserOff (LaserStrong);// end of manual control

  //progress input from the serial port
  ProgressInput ();


}
//-------------------- Subroutines ----------------
//clockwise means increasing and counter clockwise means decreasing
void MoveAzimuth (byte stepsize, bool clockwise)

{
  byte backward = 7;
  byte forward = 8;

  //counter clockwise is default
  if (clockwise)
  {
    backward = 8;
    forward = 7;
  }

  if ((Raw_azimuth >= -20 || clockwise) && (Raw_azimuth <= 200 || !clockwise))
  {
    digitalWrite(forward, LOW); //remove backlash

    digitalWrite(backward, HIGH); //moves in opposit direction
    delay(backlash_motor);
    digitalWrite(backward, LOW); //the motor is stopped

    digitalWrite(forward, HIGH); //forward movement
    delay(stepsize);
    digitalWrite(forward, LOW); ////the motor is stopped
    delay(elapse);

    tone(13, 600, 10);
  }
}

//clockwise means increasing and counter clockwise means decreasing
void MoveElevation (byte stepsize, bool clockwise)
{
  byte backward = 10;
  byte forward = 9;

  //counter clockwise is default
  if (clockwise)
  {
    backward = 9;
    forward  = 10;
  }

  if ((Raw_elevation >= -10 || clockwise) && (Raw_elevation <= 190 || !clockwise))
  {
    digitalWrite(forward, LOW); //remove backlash

    digitalWrite(backward, HIGH); //moves in opposit direction
    delay(backlash_motor);
    digitalWrite(backward, LOW); //the motor is stopped

    digitalWrite(forward, HIGH); //forwad movement
    delay(stepsize);
    digitalWrite(forward, LOW); ////the motor is stopped
    delay(elapse);

    tone(13, 600, 10);
  }
}

void PutLaserOn(byte type)
{
  if (!(LaserIsRunning))
  {
    //Do a warning beep
    tone(13, 440);
    delay(1000);

    digitalWrite(type, HIGH);

    LaserIsRunning = true;
  }
}

void PutLaserOff (byte type)
{
  if (LaserIsRunning)
  {
    digitalWrite(type, LOW);
    //stop warning beep
    noTone(13);

    LaserIsRunning = false;
  }
}

short sign (float ToTest)
{
  if (ToTest >= 0)
    return (1);
  else
    return (-1);
}

void ProgressInput ()// reads new input from Serial Monitor and regulates on this position
{
  if (Serial.available())
  {
    String StrIn;
    byte Start, End;
    float elevationIn, azimuthIn;

    StrIn = Serial.readString();

    //LastStrIn is needed for working with Twedge
    if ((StrIn != "") /* && (StrIn != LastStrIn)*/) {

      // the syntax of the input is: <elevationIn> ; <azimuthIn>
      // try to find elevation
      // please note: the implementation of .toFloat allows to get all digets until somthing non numerical appears
      Start = 0;
      while (!(isDigit(StrIn[Start])) && (Start < StrIn.length())) // skip all non digit chars
        Start++;        
      End = StrIn.indexOf(";", Start);
      // elevationIn as float
      elevationIn = (StrIn.substring(Start, End)).toFloat();

      //ensure at least one diget of elevation was given
      NewInput = (End - Start >= 1);

      // try to find azimuth
      Start = End;
      while (!(isDigit(StrIn[Start])) && (Start < StrIn.length())) // skip all non digit chars (jumps over the semicolon)
        Start++;
      End = StrIn.length() - 1;
      // azimuthIn as float, 15.0 degrees is the misswise of magnetic field seen practically, theoretically it should be ~ 4 degrees
      azimuthIn   = (StrIn.substring(Start, End)).toFloat();// - 15.0L;

      //ensure correct ranges
      Raw_elevationIn = fmod(elevationIn, 180);
      Raw_azimuthIn   = abs(fmod(azimuthIn, 360));

      while (azimuthIn >= 180)
      {
        Raw_elevationIn = 180 - elevationIn; //if the given azimuthIn is greater than 180 degrees, the elevation flips to the other side
        Raw_azimuthIn  -= 180;//the Raw_azimuth knows values between -20 up to 200 degrees only
      }

      // Did we got valid input?
      // It's true, if we got at least 1 digit of azimuth and elevation (testet above)
      NewInput &= (End - Start >= 1);
    }
  }// end of Serial available


  // what follows is the position regulator
  if (NewInput)
  {
    float Movement;
    //for a stepsize of 120 the motor moves about 10 degrees
    byte  stepsize;

    //----- { Azimuth } -----
    Movement = Raw_azimuthIn - Raw_azimuth;

    //the maximum step width is limited to 120
    if (Movement >= 6)
      Movement = 120 * sign(Movement);
    else
    {
      //the minimum step width is limited to 20
      if (abs(Movement) < 1)
        Movement = sign(Movement) * 20.0;
      else
        Movement *= 20.0;
    }

    stepsize = round(abs(Movement));
    //movement of the motor to compensate the azimuth difference
    if (Movement > 0)
      MoveAzimuth(stepsize, true); //Inc
    else if (Movement < 0)
      MoveAzimuth(stepsize, false); //Dec

    //----- { Elevation } -----
    Movement = Raw_elevationIn - Raw_elevation;

    //the maximum step width is limited to 120
    if (Movement >= 6)
      Movement = 120 * sign(Movement);
    else
    {
      //the minimum step width is limited to 20
      if (abs(Movement) < 1)
        Movement = sign(Movement) * 20.0;
      else
        Movement *= 20.0;
    }

    stepsize = round(abs(Movement));
    //movement of the motor to compensate the elevation difference
    if (Movement > 0)
      MoveElevation(stepsize, true); //Inc
    else if (Movement < 0)
      MoveElevation(stepsize, false); //Dec
    delay(elapse);

    if (abs(Raw_azimuthIn - Raw_azimuth) <= 2 && abs(Raw_elevationIn - Raw_elevation) <= 2)
    {
      NewInput = false;

      PutLaserOn(LaserWeak);
      delay(3000);
      PutLaserOff(LaserWeak);
    }
  }
}

void MMAread () {
  int16_t helperx, helperz;

  // read x y z at once
  Wire.beginTransmission(MMA8451_ADDRESS);
  Wire.write((uint8_t)MMA8451_REG_OUT_X_MSB);
  Wire.endTransmission(false); // MMA8451 + friends uses repeated start!!

  Wire.requestFrom(MMA8451_ADDRESS, 6);

  // Shift values to create properly formed integer (MSB first)
  // Note high before low (different than accelerometer)
  helperx = Wire.read() << 8; helperx |= Wire.read(); helperx >>= 2;
  //Dismiss y
  Wire.read(); Wire.read();
  helperz = Wire.read() << 8; helperz |= Wire.read(); helperz >>= 2;

  //filtering values with gliding avarage
  mx = (float)helperx * 0.9 + mx * 0.1;
  mz = (float)helperz * 0.9 + mz * 0.1;
}

void HMCread()
{
  // raw values directly read from the sensor and avaraged
  int16_t rx, ry;

  // Read the magnetometer
  Wire.beginTransmission((byte)HMC5883_ADDRESS_MAG);
  Wire.write(0x03); //HMC5883_REGISTER
  Wire.endTransmission();
  // 6 Bytes are requested, the addresses are counted further automatically
  Wire.requestFrom((byte)HMC5883_ADDRESS_MAG, (byte)6);

  // Wait around until enough data are available
  while (Wire.available() < 6);

  // Note high before low
  // Shift values to create properly formed integer (high byte first)
  rx = Wire.read() << 8; rx |= Wire.read();
  //Dismiss z
  Wire.read(); Wire.read();
  ry = Wire.read() << 8; ry |= Wire.read();

  //filtering values with gliding avarage
  //correct the values to gauging values xp ... ym
  sx = (cpemf * (2 * ((float)rx + xm) / (xp + xm) - 1)) * 0.9 + sx * 0.1;
  sy = (cpemf * (2 * ((float)ry + ym) / (yp + ym) - 1)) * 0.9 + sy * 0.1;
}
//Reads 8-bits from MMA
uint8_t readRegister8(uint8_t reg) {
  Wire.beginTransmission(MMA8451_ADDRESS);
  Wire.write(reg);
  Wire.endTransmission(false); // MMA8451 + friends uses repeated start!!

  Wire.requestFrom(MMA8451_ADDRESS, 1);
  if (! Wire.available()) return -1;
  return ((uint8_t)Wire.read());
}

//Writes 8-bits to MMA
void writeRegister8(uint8_t reg, uint8_t value) {
  Wire.beginTransmission(MMA8451_ADDRESS);
  Wire.write(reg);
  Wire.write(value);
  Wire.endTransmission();
}
