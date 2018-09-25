#include <Wire.h> //I2C Arduino Library
#include <string.h>
#include <Adafruit_Sensor.h>
#include <Adafruit_MMA8451.h>
#include <Adafruit_HMC5883_U.h>

Adafruit_MMA8451 mma = Adafruit_MMA8451();
Adafruit_HMC5883_Unified mag = Adafruit_HMC5883_Unified(12345);

float elevation, azimut, Roh_elevation, Roh_azimut;
float elevationIn,azimutIn,Roh_azimutIn,Roh_elevationIn;

String stringin,Test_In;

int signum;
int stepsize = 120;
int backlash_elevation=10;
int backlash_azimut=10;
int elapse=60;
int Zaehler = 1;

bool Weiter=false;

void Regler ()
  { 
    if (Serial.available())
       Test_In= Serial.readString();

      if (!(Test_In == ""))
      {
       if (!( Test_In == stringin))
          {
            stringin = Test_In;
            Weiter=true;
          }
        if (Weiter)
          {
            elevationIn=(stringin.substring(0, stringin.indexOf(";",0))).toFloat();
            azimutIn   =(stringin.substring(stringin.indexOf(";",0)+1,(stringin.length()))).toFloat();
            Roh_elevationIn = elevationIn;
            Roh_azimutIn = azimutIn;
            
            if (azimutIn >= 180)
             {
                Roh_elevationIn=180-elevationIn; //if the given azimutIn is greater than 180 degrees, the elevation flips to the other side
                Roh_azimutIn  -= 180;//the Roh_azimut knows values between -10 up to 190 degrees only
             }   
    
            //for a step width of 120 the motor moves about 10 degrees
               
            float Bewegung = Roh_azimutIn-Roh_azimut;
            if (Bewegung >0) signum=1; else signum=-1;//signum determines the direction of movement
            if (abs(Bewegung)<=10)Bewegung=Bewegung*20; else Bewegung=signum*120;//the maximum step width is limited to 120
            if (abs(Bewegung)<1)Bewegung=signum*20;//the minimum step width is limited to 20
            //Serial.println("Azimut: "+String(Bewegung)+"  "+String(Roh_azimutIn));
            stepsize=(int)abs(Bewegung);
            //movement of the motor to compensate the azimut difference
            if (signum >0)AzimutG();else AzimutK();
        
         
             
        
            Bewegung=Roh_elevationIn-Roh_elevation;
             
        
            if (Bewegung >0)signum=1; else signum=-1;
            if (abs(Bewegung)<=10)Bewegung=Bewegung*20; else Bewegung=signum*120;
            if (abs(Bewegung)<1)Bewegung=signum*20;
            //Serial.println("Elevation: "+String(Bewegung)+"  "+String(Roh_elevationIn));
            stepsize=(int)abs(Bewegung);
            //movement of the motor to compensate the elevation difference
            if (signum > 0) ElevationG(); else ElevationK();

            if (Bewegung <=2 && Bewegung >=-2 &&  Roh_azimutIn-Roh_azimut<=2 &&  Roh_azimutIn-Roh_azimut >=-2)
              {
                Weiter=false;
                LaserOn_Schwach();
                delay(3000);
                LaserOff_Schwach();
              }  
            
            stepsize =120;
    
          }
        }
     }

void AzimutK ()

  {
    if (Roh_azimut >= -10)
     {
      digitalWrite(8,LOW); //remove backlash
      digitalWrite(7,HIGH);//moves in opposit direction
      delay(backlash_azimut);
      digitalWrite(7,LOW);//the motor is stopped
      digitalWrite(8,HIGH);//counter clockwise movement
      delay(stepsize);
      digitalWrite(8,LOW);////the motor is stopped
      delay(elapse);
      tone(13,600,10);
     }  
  }


void AzimutG ()
  {
    if (Roh_azimut <= 190)
     {
      digitalWrite(7,LOW);  //remove backlash
      digitalWrite(8,HIGH);//moves in opposit direction
      delay(backlash_azimut);
      digitalWrite(8,LOW);//the motor is stopped
      digitalWrite(7,HIGH);//clockwise movement
      delay(stepsize);
      digitalWrite(7,LOW);//the motor is stopped
      delay(elapse);
      tone(13,600,10);
    }
  }

void ElevationG ()

  {
    if (Roh_elevation <= 190)
     {
      digitalWrite(10,LOW);  //remove backlash
      digitalWrite(9,HIGH);//moves in opposit direction
      delay(backlash_elevation);
      digitalWrite(9,LOW);//the motor is stopped
      digitalWrite(10,HIGH);//clockwise movement
      delay(stepsize);
      digitalWrite(10,LOW);//the motor is stopped
      delay(elapse);
      tone(13,600,10);
     }
  }

void ElevationK ()
  {
    if (Roh_elevation >= -10)
     {
      digitalWrite(9,LOW);  //remove backlash
      digitalWrite(10,HIGH);//moves in opposit direction
      delay(backlash_elevation);
      digitalWrite(10,LOW);//the motor is stopped
      digitalWrite(9,HIGH);//clockwise movement
      delay(stepsize);
      digitalWrite(9,LOW);//the motor is stopped
      delay(elapse);
      tone(13,600,10);
     }
  }

void LaserOn_Stark()
  {
    tone(13,440);
    delay(1000);
    digitalWrite(11,HIGH);
  }

void LaserOff_Stark ()
  {
    digitalWrite(11,LOW);
    noTone(13);
  }

void LaserOn_Schwach()
  {
    tone(13,440);
    delay(1000);
    digitalWrite(12,HIGH);
  }

void LaserOff_Schwach ()
  {
    digitalWrite(12,LOW);
    noTone(13);
  }

void setup(){
  
  Serial.begin(9600);
  if (! mma.begin()) {
    Serial.println("Fehler, konnte nicht starten!");
    Serial.println("Details: Fehler im Beschleunigungssensor");
    while (1);
  }

  if(!mag.begin())
  {
    Serial.println("Fehler, konnte nicht starten!");
    Serial.println("Details: Fehler im Mangetsensor.");
    while(1);
  }
  mma.setRange(MMA8451_RANGE_2_G);  
 
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

void loop() { //digitalWrite(12,HIGH);
  sensors_event_t event; 
    mma.getEvent(&event);
   float za = za*0.5 + (event.acceleration.z)*0.5;
   float xa = xa*0.5 - (event.acceleration.x)*0.5;
   Roh_elevation = (atan2(za,xa)*180/M_PI);
    
   if (Roh_elevation < -90) {
     Roh_elevation += 360;   }
     elevation=Roh_elevation;
   
   
   if (Roh_elevation>=90)  
     elevation=180-Roh_elevation;

   mag.getEvent(&event);
   float xm = xm*0.5 - (event.magnetic.x)*0.5;
   float ym = ym*0.5 + (event.magnetic.y)*0.5;
      
   Roh_azimut = atan2(xm,ym)*180/M_PI;
   if(Roh_azimut < -90) 
     Roh_azimut += 360;

   //float Roh_2 = Roh_azimut;
       
   Roh_azimut = Roh_azimut*1800/1833 + 10,5;   //NEUAUFGESTELLT
       
   azimut = Roh_azimut;
   if(Roh_elevation>90) 
     azimut += 180;
   if(azimut < 0) 
     azimut += 360;
   if(azimut > 360) 
     azimut -= 360;
      
   if (Zaehler==100 || Weiter){
      Serial.println (String((int) (elevation+0.5))+";"+String((int) (azimut+0.5))+";");
      Zaehler = 1;
    } 
   else
      Zaehler++;
       
    if (digitalRead(0)==LOW & digitalRead(1)==HIGH  )  //kleiner
      AzimutK ();

    if (digitalRead(0)==HIGH & digitalRead(1)==LOW )  //größer
      AzimutG ();

    if (digitalRead(4)==LOW & digitalRead(5)==HIGH )  //vergrößern
      ElevationG ();

    if (digitalRead(4)==HIGH & digitalRead(5)==LOW ) //kleiner
      ElevationK ();
        
    //Laser with warning tone
    if (digitalRead(6)==HIGH)
      LaserOn_Stark();
    else
      LaserOff_Stark ();
      
    Regler ();
}
