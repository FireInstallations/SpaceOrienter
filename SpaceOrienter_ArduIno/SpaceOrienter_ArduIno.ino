// set Serial Monitor to 9600 Baud, insert values "<elevation>;<azimuth>;" and the Space Orienter will direct the beam
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
#define xp 730 // maximum value for x parallel
#define xm 690 // absolute minimum value for x antiparallel
#define yp 750 // same for y
#define ym 720 // same for y
#define cpemf 685 // counts per earth magnetic field according to data sheet and earth magnetic field of 0. G

float sx = 0, sy = 0;// scaled sensor values


/* ----------------- { general } ----------------- */

#define backlash_motor 10 // time for moving the motor in oppositee than desired direction to get it moving
#define elapse         80 // elapse time after each motor movement
#define minstep        20 // minimum stepwidth for regulator
#define multiplier     12 // multiplier between angular difference and on-time of motor
#define accuracy       1// postioning accuracy
#define cw   true // for moving the motor clockwise (increasing value)
#define ccw  false// for moving the motot counterclockwise (decrease value)

#define LaserWeak   12
#define LaserStrong 11

bool LaserIsOn = false;// is true as sonn as warning tone appears (one second before laser is switched on)
bool NewInput  = false;// is true as soon as a new valid input is got from Serial Port
bool PosReached = false;// is true as position reaches preset position and false after laser was activated

// We are working with raw values, which means if the azimuth goes over 180° the elevation will be flipped (> 90°)
// and the azimuth will deminished by 180° at the same time.
// the input values are comming from the serial port
float Raw_azimuth,   Raw_elevation;
float Raw_azimuthIn, Raw_elevationIn;

long oldtime = 0, elapsetime_a = 0, elapsetime_e = 0, lasertime = 0;

/* ----------------- { DemoMode } ----------------- */

#define DemoEleMin 10 //borders where the DemoMode was allowed
#define DemoEleMax 80
#define DemoAziMin 90
#define DemoAziMax 180

#define DemoElapse 3 //Time after last input from Pc or manuel control until DemoMode gets activated in minutes

long lastDemoTime = 0; //Time since DemoMode was deactive
// 0 means activ, 1 means waiting for 5 secounds, 2 means temporary off and 3 (+ everything else) means permanently off
// startvalue is 2 if you want to use DemoMode
byte DemoMode = 3; 

/* ----------------- { setup } ----------------- */
void setup() {
  oldtime = millis();
  elapsetime_a = millis();
  elapsetime_e = millis();
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
  // So it is attained for Berlin (earth magnetic field = 0.5 G) cpemf counts = 0.5 G/0.00073 G/count = 685 counts
  Wire.beginTransmission(HMC5883_ADDRESS_MAG);
  Wire.write((uint8_t) 0x01); //HMC5883_REGISTER Configuration Register B
  Wire.write((uint8_t)0x00);
  Wire.endTransmission();

  pinMode(0, INPUT_PULLUP);//Azimuth Control
  pinMode(1, INPUT_PULLUP);//Azimuth Control
  pinMode(4, INPUT_PULLUP);//Elevation Control
  pinMode(5, INPUT_PULLUP);//Elevation Control
  pinMode(6, INPUT);//Laser Control
  pinMode(7, OUTPUT);//Azimuth motor
  pinMode(8, OUTPUT);//Azimuth motor
  pinMode(9, OUTPUT);//Elevation motor
  pinMode(10, OUTPUT);//Elevation motor
  pinMode(11, OUTPUT);//Laser strong
  pinMode(12, OUTPUT);//Laser weak
  pinMode(13, OUTPUT);//Beep

  randomSeed(analogRead(0)); //get some random noise
}

/* ----------------- { loop } ----------------- */

void loop()
{
  float elevation, azimuth;

  MMAread ();// derives Raw_elevation from MMA

  elevation = Raw_elevation;
  // if Raw_elevation is greater than 90 degrees, flip it to the other side
  if (Raw_elevation >= 90) elevation = 180 - Raw_elevation;


  HMCread();//derives Raw_azimuth from HMC

  azimuth = Raw_azimuth;
  // restore azimuth with 0 to 360 degrees
  if (Raw_elevation > 90)
    azimuth += 180;
  if (azimuth < 0)
    azimuth += 360;
  if (azimuth > 360)
    azimuth -= 360;


  if ((millis() - oldtime) > 700 ) {
    Serial.println (String(elevation) + ";" + String(azimuth/* + 15*/) + ";");// + String(Raw_elevation) + ";" + String(Raw_azimuth));
    oldtime = millis();
  }

  Input ();//check input from the serial port, NewInput is set true, when something valid appears in Serial Monitor
  if (NewInput) {
    Regulator(); // move to position
  } else

    if (DemoMode < 3) { //if Demomode isn't permanently off
      if (millis() - lastDemoTime > 5000 && DemoMode == 0) { 
        FindRandomPoint(); //get a new random position
      } else

        if (millis() - lastDemoTime > DemoElapse * 60000 && DemoMode != 0 && DemoMode != 1) //if nothing happend for the last X Minutes
          DemoMode = 0; //enable DemoMode again
    }

  ManualCtrl();// manually controlling motors and laser
  if (PosReached)
    PutLaserOn(LaserStrong);
  if (PosReached && ((millis() - lasertime) > 4000) && digitalRead(6) == LOW)
    PutLaserOff(), PosReached = false;
}
//-------------------- Subroutines ----------------
//find a random point in the allowed borders and move to it
void FindRandomPoint() {
  // azimuthIn as float, 15.0 degrees is the misswise of magnetic field seen practically, theoretically it should be 4 degrees
  Raw_azimuthIn = random (DemoAziMin, DemoAziMax);// - 15.0L;
  Raw_elevationIn = random (DemoEleMin, DemoEleMax);

  if (Raw_azimuthIn >= 180) {
    Raw_elevationIn = 180 - Raw_elevationIn; //if the given azimuthIn is greater than 180 degrees, the elevation flips to the other side
    Raw_azimuthIn  -= 180;//the Raw_azimuth knows values between -20 up to 200 degrees only
  }

  NewInput = true;
  DemoMode = 1;
}

// Turn DemoMode off and set time when it got deactivaded
void TrunDemoModeOff () {
  if (DemoMode < 3) {
    DemoMode = 2;
    lastDemoTime = millis();
  }
}


//clockwise means increasing and counter clockwise means decreasing
void MoveAzimuth (byte stepsize, bool clockwise) {
  if ( (millis() - elapsetime_a) > 3 * elapse / 2) { // this differs from elevation to activate not both motors at the same time
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

      digitalWrite(backward, HIGH); //moves in opposite direction
      delay(backlash_motor);
      digitalWrite(backward, LOW); //the motor is stopped

      digitalWrite(forward, HIGH); //forward movement
      delay(stepsize);
      digitalWrite(forward, LOW); ////the motor is stopped
      //delay(elapse);

      tone(13, 600, 10);
    }
    elapsetime_a = millis();
  }
}

//clockwise means increasing and counter clockwise means decreasing
void MoveElevation (byte stepsize, bool clockwise)
{ if ( (millis() - elapsetime_e) > elapse) {
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

      digitalWrite(backward, HIGH); //moves in opposite direction
      delay(backlash_motor);
      digitalWrite(backward, LOW); //the motor is stopped

      digitalWrite(forward, HIGH); //forward movement
      delay(stepsize);
      digitalWrite(forward, LOW); ////the motor is stopped
      //delay(elapse);

      tone(13, 600, 10);
    }
    elapsetime_e = millis();
  }
}

void PutLaserOn(byte type)
{
  //Do a warning beep
  tone(13, 440);
  LaserIsOn = true;
  if ( millis() - lasertime > 1000)
    digitalWrite(type, HIGH);
}

void PutLaserOff ()
{
  if (LaserIsOn)
  {
    digitalWrite(LaserWeak, LOW);
    digitalWrite(LaserStrong, LOW);
    //stop warning beep
    noTone(13);

    LaserIsOn = false;

    if (DemoMode == 1) {
      lastDemoTime = millis();
      DemoMode = 0;
    }

  }
}

short Direction (float ToTest)
{
  if (ToTest >= 0)
    return (1);
  else
    return (0);
}

void Input ()// reads new input from Serial Monitor
{
  if (Serial.available())
  {
    String StrIn;
    byte Start, End;
    float elevationIn, azimuthIn;

    StrIn = Serial.readString();
    //Serial.println(StrIn);
    if ((StrIn != "")) {
      // get rid of NL if activated in Serial Monitor
      if (StrIn.endsWith("\n"))StrIn = StrIn.substring(0, StrIn.length() - 1);
      // get rid of CR if activated in Serial Monitor
      if (StrIn.endsWith("\r"))StrIn = StrIn.substring(0, StrIn.length() - 1);
      // the syntax of the input is: <elevationIn> ; <azimuthIn> ;
      if (StrIn.endsWith(";"))
      {
        Start = 0;
        End   = StrIn.indexOf(";", Start);
        // elevationIn as float
        elevationIn = (StrIn.substring(Start, End)).toFloat();

        //jump over ";"
        Start = End + 1;
        End   = StrIn.indexOf(";", Start);
        // azimuthIn as float, 15.0 degrees is the misswise of magnetic field seen practically, theoretically it should be 4 degrees
        azimuthIn   = (StrIn.substring(Start, End)).toFloat();// - 15.0L;

        Raw_elevationIn = elevationIn;
        Raw_azimuthIn = azimuthIn;

        if (azimuthIn >= 180)
        {
          Raw_elevationIn = 180 - elevationIn; //if the given azimuthIn is greater than 180 degrees, the elevation flips to the other side
          Raw_azimuthIn  -= 180;//the Raw_azimuth knows values between -20 up to 200 degrees only
        }
      }

      //We got a valid input
      NewInput = true;
      TrunDemoModeOff();
    }
    //Serial.println((String)elevationIn + "   " + (String)azimuthIn);
    //Serial.println((String)Raw_elevationIn + "   " + (String)Raw_azimuthIn);
  }// end of Serial available
}

void Regulator()// what follows is the position regulator
{

  float Movement;
  //for a stepsize of 120 the motor moves about 10 degrees
  byte  stepsize;
  bool mdirection;

  //----- { Azimuth } -----
  Movement = Raw_azimuthIn - Raw_azimuth;
  stepsize = RegulatorStep(abs(Movement));
  MoveAzimuth(stepsize, Direction(Movement));
  //Serial.println((String)RegulatorStep(abs(Movement)) + "    " + (String)Direction(Movement));
  //----- { Elevation } -----
  Movement = Raw_elevationIn - Raw_elevation;
  stepsize = RegulatorStep(abs(Movement));
  MoveElevation(stepsize, Direction(Movement));

  // test if finished and laser on for 3 seconds
  if (abs(Raw_azimuthIn - Raw_azimuth) <= accuracy && abs(Raw_elevationIn - Raw_elevation) <= accuracy)
  {
    NewInput = false;
    PosReached = true;
    lasertime = millis();
  }
}

int RegulatorStep (float movement)//input is the absolute value of position difference, returns the stepsize
{ int stepsize;
  if (movement <= 10)stepsize = movement * multiplier; //stepsize depending of difference
  else stepsize = 120;//do not too big steps
  if (movement < 1) stepsize = minstep;// to avoid too small steps
  return stepsize;
}

void ManualCtrl() {
  //manual control beginning
  if (digitalRead(0) == LOW & digitalRead(1) == HIGH  ) //decrease azimuth
  {
    MoveAzimuth (120, cw);
    TrunDemoModeOff();
    NewInput = false;
  }

  if (digitalRead(0) == HIGH & digitalRead(1) == LOW ) //increase azimuth
  {
    MoveAzimuth (120, ccw);
    TrunDemoModeOff();
    NewInput = false;
  }

  if (digitalRead(4) == LOW & digitalRead(5) == HIGH ) //increase elevation
  {
    MoveElevation (120, cw);
    TrunDemoModeOff();
    NewInput = false;
  }

  if (digitalRead(4) == HIGH & digitalRead(5) == LOW ) //decrease elevation
  {
    MoveElevation (120, ccw);
    TrunDemoModeOff();
    NewInput = false;
  }

  //Laser with warning tone
  if (digitalRead(6) == HIGH)
  {
    if (!LaserIsOn)lasertime = millis();
    PutLaserOn(LaserStrong);
  }
  else if (!PosReached)
    PutLaserOff ();
}// end of manual control


void MMAread () {
  int16_t helperx, helperz;

  // read x y z at once
  Wire.beginTransmission(MMA8451_ADDRESS);
  Wire.write((uint8_t)MMA8451_REG_OUT_X_MSB);
  Wire.endTransmission(false); // MMA8451 + friends uses repeated start!!

  Wire.requestFrom(MMA8451_ADDRESS, 6);

  // Shift values to create properly formed integer (MSB first)
  // Note MSB before LSB and 14 bit value
  helperx = Wire.read() << 8; helperx |= Wire.read(); helperx >>= 2;
  //Dismiss y
  Wire.read(); Wire.read();
  helperz = Wire.read() << 8; helperz |= Wire.read(); helperz >>= 2;

  //filtering values with gliding avarage
  mx = (float)helperx * 0.3 + mx * 0.7;
  mz = (float)helperz * 0.3 + mz * 0.7;

  Raw_elevation = (atan2(mz, -mx) * 180 / M_PI);
  // atan2 runs from -180 to 180 degrees, Raw_elevation theoretically from -90 to 270 degrees
  if (Raw_elevation < -90) Raw_elevation += 360;
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
  sx = (cpemf * (2 * ((float)rx + xm) / (xp + xm) - 1)) * 0.3 + sx * 0.7;
  sy = (cpemf * (2 * ((float)ry + ym) / (yp + ym) - 1)) * 0.3 + sy * 0.7;

  Raw_azimuth = atan2(-sx, sy) * 180 / M_PI;
  // atan2 runs from -180 to 180 degrees, Raw_azimuth theoretically from -90 to 270 degrees
  if (Raw_azimuth < -90) Raw_azimuth += 360;
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
