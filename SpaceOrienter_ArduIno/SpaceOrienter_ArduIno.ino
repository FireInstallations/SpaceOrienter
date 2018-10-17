// set Serial Monitor to 9600 Baud, insert values <elevation> ; <azimuth> and the Space Orienter will direct the beam
#include <Wire.h> //I2C Arduino Library
#include "Print.h"


#define MMA8451_REG_OUT_X_MSB     0x01
#define MMA8451_REG_WHOAMI        0x0D

#define MMA8451_REG_CTRL_REG1     0x2A
#define MMA8451_REG_CTRL_REG2     0x2B


#define MMA8451_ADDRESS                (0x3A >> 1)    // this is  0x1D and means SA0 = 1
#define HMC5883_ADDRESS_MAG            (0x3C >> 1)    // this is  0x1E

float elevation, azimut, Roh_elevation, Roh_azimut;
float elevationIn, azimutIn, Roh_azimutIn, Roh_elevationIn;

String stringin, Test_In;

int signum;
int stepsize = 120;
int backlash_elevation = 10;
int backlash_azimut = 10;
int elapse = 60;
int Zaehler = 1;
long oldtime = 0;

int cpemf = 543;
//int cpemf = 685; //Earthmagnetic field should be 685 counts (here in Berlin).
float rx = 0, ry = 0;// raw values directly red from the sensor and avaraged
float sx = 0, sy = 0;// scaled sensor values
//float xp = cpemf, xm = cpemf;// scaling constants
//float yp = cpemf, ym = cpemf;

//MMA
float mx, my, mz;

float xp = 730, xm = 690;// scaling constants
float yp = 750, ym = 720;

bool Weiter = true;

void Regler ()
{
  if (Serial.available())
    Test_In = Serial.readString();

  if (!(Test_In == ""))
  {
    if (!( Test_In == stringin))
    {
      stringin = Test_In;
      Weiter = true;
    }

    if (Weiter)
    {
      elevationIn = (stringin.substring(0, stringin.indexOf(";", 0))).toFloat();
      azimutIn   = (stringin.substring(stringin.indexOf(";", 0) + 1, (stringin.length()))).toFloat(); azimutIn -= 15;
      Roh_elevationIn = elevationIn;
      Roh_azimutIn = azimutIn;

      if (azimutIn >= 180)
      {
        Roh_elevationIn = 180 - elevationIn; //if the given azimutIn is greater than 180 degrees, the elevation flips to the other side
        Roh_azimutIn  -= 180;//the Roh_azimut knows values between -10 up to 190 degrees only
      }

      //for a step width of 120 the motor moves about 10 degrees

      float Bewegung = Roh_azimutIn - Roh_azimut;
      if (Bewegung > 0) signum = 1; else signum = -1; //signum determines the direction of movement
      if (abs(Bewegung) <= 10)Bewegung = Bewegung * 20; else Bewegung = signum * 120; //the maximum step width is limited to 120
      if (abs(Bewegung) < 1)Bewegung = signum * 20; //the minimum step width is limited to 20
      //Serial.println("Azimut: "+String(Bewegung)+"  "+String(Roh_azimutIn));
      stepsize = (int)abs(Bewegung);
      //movement of the motor to compensate the azimut difference
      if (signum > 0)AzimutG(); else AzimutK();



      Bewegung = Roh_elevationIn - Roh_elevation;


      if (Bewegung > 0)signum = 1; else signum = -1;
      if (abs(Bewegung) <= 10)Bewegung = Bewegung * 20; else Bewegung = signum * 120;
      if (abs(Bewegung) < 1)Bewegung = signum * 20;
      //Serial.println("Elevation: "+String(Bewegung)+"  "+String(Roh_elevationIn));
      stepsize = (int)abs(Bewegung);
      //movement of the motor to compensate the elevation difference
      if (signum > 0) ElevationG(); else ElevationK();

      if (Bewegung <= 2 && Bewegung >= -2 &&  Roh_azimutIn - Roh_azimut <= 2 &&  Roh_azimutIn - Roh_azimut >= -2)
      {
        Weiter = false;
        LaserOn_Schwach();
        delay(3000);
        LaserOff_Schwach();
      }

      stepsize = 120;

    }
  }
}

void AzimutK ()

{
  if (Roh_azimut >= -20)
  {
    digitalWrite(8, LOW); //remove backlash
    digitalWrite(7, HIGH); //moves in opposit direction
    delay(backlash_azimut);
    digitalWrite(7, LOW); //the motor is stopped
    digitalWrite(8, HIGH); //counter clockwise movement
    delay(stepsize);
    digitalWrite(8, LOW); ////the motor is stopped
    delay(elapse);
    tone(13, 600, 10);
  }
}


void AzimutG ()
{
  if (Roh_azimut <= 200)
  {
    digitalWrite(7, LOW); //remove backlash
    digitalWrite(8, HIGH); //moves in opposit direction
    delay(backlash_azimut);
    digitalWrite(8, LOW); //the motor is stopped
    digitalWrite(7, HIGH); //clockwise movement
    delay(stepsize);
    digitalWrite(7, LOW); //the motor is stopped
    delay(elapse);
    tone(13, 600, 10);
  }
}

void ElevationG ()

{
  if (Roh_elevation <= 190)
  {
    digitalWrite(10, LOW); //remove backlash
    digitalWrite(9, HIGH); //moves in opposit direction
    delay(backlash_elevation);
    digitalWrite(9, LOW); //the motor is stopped
    digitalWrite(10, HIGH); //clockwise movement
    delay(stepsize);
    digitalWrite(10, LOW); //the motor is stopped
    delay(elapse);
    tone(13, 600, 10);
  }
}

void ElevationK ()
{
  if (Roh_elevation >= -10)
  {
    digitalWrite(9, LOW); //remove backlash
    digitalWrite(10, HIGH); //moves in opposit direction
    delay(backlash_elevation);
    digitalWrite(10, LOW); //the motor is stopped
    digitalWrite(9, HIGH); //clockwise movement
    delay(stepsize);
    digitalWrite(9, LOW); //the motor is stopped
    delay(elapse);
    tone(13, 600, 10);
  }
}

void LaserOn_Stark()
{
  tone(13, 440);
  delay(1000);
  digitalWrite(11, HIGH);
}

void LaserOff_Stark ()
{
  digitalWrite(11, LOW);
  noTone(13);
}

void LaserOn_Schwach()
{
  tone(13, 440);
  delay(1000);
  digitalWrite(12, HIGH);
}

void LaserOff_Schwach ()
{
  digitalWrite(12, LOW);
  noTone(13);
}

void HMCread()
{
  int16_t helperx = 0, helpery = 0;
  uint8_t zvoid;

  // Read the magnetometer
  Wire.beginTransmission((byte)HMC5883_ADDRESS_MAG);
  Wire.write(0x03); //HMC5883_REGISTER
  Wire.endTransmission();
  // 6 Bytes are requested, the addresses are counted firther automatically
  Wire.requestFrom((byte)HMC5883_ADDRESS_MAG, (byte)6);

  // Wait around until enough data are available
  while (Wire.available() < 6);

  // Note high before low (different than accelerometer)
  // Shift values to create properly formed integer (low byte first)
  helperx = Wire.read(); helperx <<= 8; helperx |= Wire.read();
  //Dismiss z
  Wire.read();                          Wire.read();
  helpery = Wire.read(); helpery <<= 8; helpery |= Wire.read();

  //filStering values with gliding avarage
  rx = rx * 0.90 + (float)helperx * 0.10;
  ry = ry * 0.90 + (float)helpery * 0.10;

  // correct the values to gauging values xp ... ym, see document Magnetometer Extreme Calibration.doc
  sx = cpemf * (2 * (rx + xm) / (xp + xm) - 1);
  sy = cpemf * (2 * (ry + ym) / (yp + ym) - 1);
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

void MMAread () {
  int16_t helperx, helperz;

  // read x y z at once
  Wire.beginTransmission(MMA8451_ADDRESS);
  Wire.write((uint8_t)MMA8451_REG_OUT_X_MSB);
  Wire.endTransmission(false); // MMA8451 + friends uses repeated start!!

  Wire.requestFrom(MMA8451_ADDRESS, 6);

  // Note high before low (different than accelerometer)
  helperx = Wire.read(); helperx <<= 8; helperx |= Wire.read(); helperx >>= 2;
  //Dismiss y
  Wire.read();              Wire.read();
  helperz = Wire.read(); helperz <<= 8; helperz |= Wire.read(); helperz >>= 2;

  // Shift values to create properly formed integer (MSB first)
  mx = (float)helperx;
  mz = (float)helperz;

  //Serial.println(("Roh" + (String)mx) + " " + (String)mz);
}

void setup() {
  oldtime = millis();

  Serial.begin(9600);

  // Enable I2C
  Wire.begin();

  // Check if MMA sensor was found
  if (readRegister8(MMA8451_REG_WHOAMI) != 0x1A)
  {
    /* No MMA8451 detected ... */
    Serial.println("MMA not found");
    delay(1000);
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



void loop()
{ //digitalWrite(12,HIGH);

  MMAread ();
  float za = za * 0.5 + mz * 0.5;
  float xa = xa * 0.5 + mx * 0.5;
  Roh_elevation = (atan2(za, -xa) * 180 / M_PI);

  if (Roh_elevation < -90) Roh_elevation += 360;
  elevation = Roh_elevation;

  if (Roh_elevation >= 90) elevation = 180 - Roh_elevation;

  HMCread();
  Roh_azimut = atan2(-sx, sy) * 180 / M_PI;
  if (Roh_azimut < -90) Roh_azimut += 360;

  // Roh_azimut = Roh_azimut*1800/2025 + 4,5;   //NEUAUFGESTELLT
  azimut = Roh_azimut + 15;
  if (Roh_elevation > 90) azimut += 180;
  if (azimut < 0) azimut += 360;
  if (azimut > 360) azimut -= 360;

  if (((millis() - oldtime) > 700) || Weiter){ 
    Serial.println (String((int) (elevation + 0.5)) + ";" + String((int) (azimut + 0.5)) + ";");// + String((int)( Roh_elevation + 0.5)) + ";" + String((int) (Roh_azimut + 0.5)));

    if (!(Weiter))
      oldtime = millis();
  }


  if ((millis() - oldtime) > 30) {
    if (digitalRead(0) == LOW & digitalRead(1) == HIGH  ) //kleiner
      AzimutK ();

    if (digitalRead(0) == HIGH & digitalRead(1) == LOW ) //größer
      AzimutG ();

    if (digitalRead(4) == LOW & digitalRead(5) == HIGH ) //vergrößern
      ElevationG ();

    if (digitalRead(4) == HIGH & digitalRead(5) == LOW ) //kleiner
      ElevationK ();

    Regler ();

    if (Weiter)
      oldtime = millis();
  }

  //Laser with warning tone
  if (digitalRead(6) == HIGH)
    LaserOn_Stark();
  else
    LaserOff_Stark ();

  //delay(100);
}

