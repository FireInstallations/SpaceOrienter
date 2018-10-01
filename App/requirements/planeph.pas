unit PlanEph;

{$IfDef FPC}
  {$mode objfpc}
  {$inline on}

  {$WARN 5057 off : Local variable "$1" does not seem to be initialized}
{$EndIf}


{$H+}
interface

uses
  Classes, SysUtils, Math,
  Data, iausofa, utils, wmm, VSOP87;

var
  JPLDE_BinDirectory: string = 'C:\Astro\Ephemerides\bin';

type
  TRealMatrix13_6 = Array [0..12] of Array [0..5] of Real;
  TRealVektor6 = Array [0..5] of Real;
  TRealVektor4 = Array [0..3] of Real;
  TRealVektor2 = Array [0..1] of Real;
  TIntVektor14 = Array [0..13] of integer;

const

  //Error Values
    PLERR_NOFILE = -10000;
    PLERR_OUTOFRANGE = -10001;
    PLERR_UNKNOWNSOLUTION = -10002;
    PLERR_WRONGFRAME = -10003;
    PLERR_WRONGOBJECT = -10004;
    PLERR_WRONGCENTER = -10005;
    PLERR_WRONGVALUE = -10006;
    PLERR_NONUTATIONS = -10007;
    PLERR_NOLIBRATIONS = -10008;
    PLERR_NOLUNARANGLES = -10009;
    PLERR_NOTTMTDB = -10010;
    PLERR_WRONGDATE = -10011;
    PLERR_WRONGMODEL = -10012;
    PLERR_GENERALERROR = -10013;
    PLERR_ATAN2ERROR = -10100;

  //Cord To UTM Values
    ZV_North = 1;  //Northing
    ZV_East  = 2;  //Easting
    ZV_ZoneH = 3;
    ZV_ZoneV = 4;

  //Coordinate Values
    CV_LAT = 1;
    CV_LON = 2;
    CV_ASC = 1;
    CV_HOR = 2;
    CV_DEC = 3;
    CV_ALT = 1;
    CV_AZI = 2;

  //Frame Kind
    FK_CEP = 1;
    FK_EQX = 2;

  //Planets94 Ephem Version Number
    VN_PLAN94 = 7;

  //CEP Frames
    FR_ICRS =  1; // Defined by Proper Motion, Stellar Parallax and Radial Velocity of a set of Stars in the Hipparcos Catalog. Fixed J2000. It differs by about 50 mas in pole position and 80 mas in right ascension from J2000 (2451545.0 TT)
    FR_BCRS =  2; // Barycentric Position of the Object, evaluated at TDB. Same as ICRS. ICRS is a barycentric reference system unless otherwise, and also BCRS is.
    FR_GCRS =  3; // Geocentric BCRS plus Annual Parallax, Light Deflection and Annual Aberration. Same as BCRS unless it is explictly referred to ICRS.
    FR_CIRS =  4; // B x P x N x GCRS. Same as TOD but referred to ICRS (CIP and CIO) and not J2000
    FR_TIRS =  5; // ERA/GAST x CIRS
    FR_ITRS =  6; // PolarMotion x TIRS
    FR_TOPO =  7; // LocalMeridian+DiurnalParallax+DiurnalAberration+ITRS. Topocentric.
    FR_OBSD =  8; // Same as TOPO but expressed in Horizontal Coordinates plus Refraction(Pressure, Temperature, Relative Humidity, Model Atmosphere and Frequency). Observed.

  //Equinox Frames
    FR_J2000 = 11; // = B x GCRS   B = Bias (ICRS analogy)
    FR_FMOD  = 12; // = P x J2000  P = Precession
    FR_TOD   = 13; // = N x MOD    N = Nutation     (It is the 1994 analogy of CIRS)
    FR_UOD   = 14; // = Q x TOD    Q = Equation of the Equinox
    FR_ECI   = 14; // = Q x TOD    Q = Equation of the Equinox (A very used alias for UOD)
    FR_TEME  = 14; // = Q x TOD    Q = Equation of the Equinox (A very used alias for UOD)
    FR_PEF   = 15; // = R x UOD    R = Greenwich Mean SideReal Time (TIRS analogy)
    FR_TEF   = 16; // = W x PEF    W = Polar Motion (ROT2(-xp) ROT1(-yp)) (ITRS analogy)
    FR_TOP   = 17; // Same as TOPO but for J2000
    FR_OBS   = 18; // Same as OBSD but for J2000

  //IAU Models
    IAU_MODEL_1900 = 1900;
    IAU_MODEL_2000 = 2000;
    IAU_MODEL_2006 = 2006;

  //Adjustment
    AD_NONE          = 0;
    AD_LIGHTTIME     = 1;
    AD_CIO_BASED     = 2;
    AD_GEOCENTRIC    = 4;
    AD_PERTURBATIONS = 8;

  //Bodies
    BN_MERCURY    =  1;
    BN_VENUS      =  2;
    BN_EARTH      =  3;
    BN_MARS       =  4;
    BN_JUPITER    =  5;
    BN_SATURN     =  6;
    BN_URANUS     =  7;
    BN_NEPTUNE    =  8;
    BN_PLUTO      =  9;
    BN_MOON       = 10;
    BN_SUN        = 11;
    BN_SSB        = 12;
    BN_EMB        = 13;
    BN_NUTATIONS  = 14;
    BN_LIBRATIONS = 15;
    BN_TDB        = 16;
    BN_TCB        = 17;

  //Coordinates
    COR_ECLIPTICS = 1;
    COR_HORIZONTALS = 2;
    COR_EQUATORIALS = 3;

  //Orbital Elements
    OE_MEANLONGITUDE = 1;
    OE_SEMIMAJORAXIS = 2;
    OE_ECCENTRICITY = 3;
    OE_INCLINATION = 4;
    OE_ASCENDINGNODE = 5;
    OE_PERIHELIUM = 6;

  //Arguments
    ARG_MEANELONGATION = 2;
    ARG_SOLARANOMALY = 3;
    ARG_LUNARANOMALY = 4;
    ARG_MOONNODELONGITUDE = 5;
    ARG_LONGITUDEPERIGEO = 6;
    ARG_ARGUMENTLATITUDE = 7;


  //VSOP870 Rectangular Values
    VSOP870_POS_X = 11;
    VSOP870_POS_Y = 12;
    VSOP870_POS_Z = 13;

  //VSOP87 Orbital Elements Values
    MEANLONGITUDE = 1;
    SEMIMAJORAXIS = 2;
    E_COS_P = 3;
    E_SIN_P = 4;
    SIN_g_COS_G = 5;
    SIN_g_SIN_G = 6;

  //General Values
    GV_POS_X          =  1;
    GV_POS_Y          =  2;
    GV_POS_Z          =  3;
    GV_VEL_X          =  4;
    GV_VEL_Y          =  5;
    GV_VEL_Z          =  6;
    GV_LONGITUDE      =  7;
    GV_LATITUDE       =  8;
    GV_RADIUS         =  9;
    GV_EARTHLONGITUDE = 10;
    GV_EARTHLATITUDE  = 11;
    GV_EARTHRADIUS    = 12;
    GV_RIGHTASCENSION = 13;
    GV_HOURANGLE      = 14;
    GV_DECLINATION    = 15;
    GV_ELONGATION     = 16;
    GV_ELEVATION      = 17;
    GV_AZIMUTH        = 18;
    GV_PASSAGE        = 19; //Culminaci¢n
    GV_RISING         = 20;
    GV_SETTING        = 21;

  //Geomag Values
    Mag_AngleNE           = 1;    //  1. Angle between the magnetic field vector and true north, + east
    Mag_AnglePD           = 2;    //  2. Angle between the magnetic field vector and the horizontal plane, + down
    Mag_Strength          = 3;    //  3. Magnetic Field Strength
    Mag_HorizStrength     = 4;    //  4. Horizontal Magnetic Field Strength
    Mag_North             = 5;    //  5. Northern component of the magnetic field vector
    Mag_East              = 6;    //  6. Eastern component of the magnetic field vector
    Mag_Down              = 7;    //  7. Downward component of the magnetic field vector
    Mag_GridVar           = 8;    //  8. The Grid Variation
    Mag_ChDec             = 9;    //  9. Yearly Rate of change in declination
    Mag_ChInc             = 10;   // 10. Yearly Rate of change in inclination
    Mag_ChStrengh         = 11;   // 11. Yearly rate of change in Magnetc fielid strength
    Mag_ChHorizStrength   = 12;   // 12. Yearly rate of change in horizontal field strength
    Mag_ChNorth           = 13;   // 13. Yearly rate of change in the northern component
    Mag_ChEast            = 14;   // 14. Yearly rate of change in the eastern component
    Mag_ChDown            = 15;   // 15. Yearly rate of change in the downward component
    Mag_ChGridVar         = 16;   // 16. Yearly rate of change in grid variation

    Mag_AngleNE_Err       = 17;   //  1. Angle between the magnetic field vector and true north, + east
    Mag_AnglePD_Err       = 18;   //  2. Angle between the magnetic field vector and the horizontal plane, + down
    Mag_Strength_Err      = 19;   //  3. Magnetic Field Strength
    Mag_HorizStrength_Err = 20;   //  4. Horizontal Magnetic Field Strength
    Mag_North_Err         = 21;   //  5. Northern component of the magnetic field vector
    Mag_East_Err          = 22;   //  6. Eastern component of the magnetic field vector
    Mag_Down_Err          = 23;   //  7. Downward component of the magnetic field vector
    Mag_GridVar_Err       = 24;   //  8. The Grid Variation

  //GeoMagErrors
    _DEGREE_NOT_FOUND = -2;

  // These error values are the NGDC error model
    WMM_UNCERTAINTY_F =         152;
    WMM_UNCERTAINTY_H =         133;
    WMM_UNCERTAINTY_X =         138;
    WMM_UNCERTAINTY_Y =          89;
    WMM_UNCERTAINTY_Z =         165;
    WMM_UNCERTAINTY_I =        0.22;
    WMM_UNCERTAINTY_D_OFFSET = 0.24;
    WMM_UNCERTAINTY_D_COEF   = 5432;

{=======================}
{ Function Declarations }
{=======================}

function nDaysMonth (const Year, Month: integer): integer; inline;

{ Ephemerides }
{=============}
//function Asteroids(Version, Frame, Value, Adjust: Integer; a, e, i, w, N, M, Epo, utc1, utc2, Lon, Lat, xp, yp, dut1, hm, ra, rb: Double): Real;
//function Comets(Version, Frame, Value, Adjust: Integer; q,  e, i, w, N, TP, utc1, utc2, Lon, Lat, xp, yp, dut1, hm, ra, rb: Double): Real;
function  Ephem(const Version, Frame, Body, Value: integer; Adjust: integer; const utc1: Real; utc2, Lon, Lat: Real; const TZ: Real; xp, yp, dut1: Real; const hm, ra, rb: Real): Real;
function  Houses(const Value: Integer; const TZ, Lon, Lat, Jul: Real): Real;
function  LightTime(const r: Real):Real;
function  Passage(const Version: integer; Frame: integer; const Body, Value: integer; const utc1: Real; utc2: Real; const Lon, Lat, TZ, Elevation, Height: Real): Real;

{ Astrometry }
{============}
//procedure RefractionAB(pm, tc, rh, wl: Double; var RefA, RefB: Double); stdcall;

{ Calendars }
{===========}
function  Julian (const Year, Month, Day, Hour, Minute, Second: Integer): Real;

{ World Magnetic Model }
{======================}
function wmmGeomag (const Value, Year, Month, Day: integer; const Lon, Lat, Height: Real): Real;
//DEFAULT FILE location: Default file ist noch nicht richtig

implementation

const
  kAberracion      = 0.0056932;

{  AU               = DAU / 1000.0;
  LightSpeed       = CMPS / 1000.0;
  JulianYear       = DJY;
  JulianCentury    = DJC;
  JulianMillennium = DJM;
  TropicalYear     = DTY;   }

  nLONGITUDE = 1;
  nOBLIQUITY = 2;

  //SGP4 General Values
{  SGP4POS_X          =  1;
  SGP4POS_Y          =  2;
  SGP4POS_Z          =  3;
  SGP4VEL_X          =  4;
  SGP4VEL_Y          =  5;
  SGP4VEL_Z          =  6;
  SGP4SEMILATUS      =  7;
  SGP4SEMIMAJORAXIS  =  8;
  SGP4ECCENTRICITY   =  9;
  SGP4LONGITUDE      = 10;
  SGP4LATITUDE       = 11;
  SGP4RADIUS         = 12;
  SGP4RIGHTASCENCION = 13;
  SGP4HOURANGLE      = 14;
  SGP4DECLINATION    = 15;
  SGP4TRUELONGITUDE  = 16;
  SGP4ELEVATION      = 17;
  SGP4AZIMUTH        = 18;
  SGP4INCLINATION    = 19;
  SGP4ASCENDINGNODE  = 20;
  SGP4PERIGEE        = 21;
  SGP4TRUEANOMALY    = 22;
  SGP4MEANANOMALY    = 23;
  SGP4LATARGUMENT    = 24;
  SGP4LONPERIAPSIS   = 25;

  //IAU Fundamental Arguments
  FA_MER_MEANLONGITUDE  =  1;  //FAME03 mean longitude of Mercury                    d = iauFame03( t );
  FA_VEN_MEANLONGITUDE  =  2;  //FAVE03 mean longitude of Venus                      d = iauFave03( t );
  FA_EAR_MEANLONGITUDE  =  3;  //FAE03  mean longitude of Earth                      d = iauFae03 ( t );
  FA_MAR_MEANLONGITUDE  =  4;  //FAMA03 mean longitude of Mars                       d = iauFama03( t );
  FA_JUP_MEANLONGITUDE  =  5;  //FAJU03 mean longitude of Jupiter                    d = iauFaju03( t );
  FA_SAT_MEANLONGITUDE  =  6;  //FASA03 mean longitude of Saturn                     d = iauFasa03( t );
  FA_URA_MEANLONGITUDE  =  7;  //FAUR03 mean longitude of Uranus                     d = iauFaur03( t );
  FA_NEP_MEANLONGITUDE  =  8;  //FANE03 mean longitude of Neptune                    d = iauFane03( t );
  FA_SUN_MEANANOMALY    =  9;  //FALP03 mean anomaly of the Sun                      d = iauFalp03( t );
  FA_MOO_MEANANOMALY    = 10;  //FAL03  mean anomaly of the Moon                     d = iauFal03 ( t );
  FA_MOO_MEANELONGATION = 11;  //FAD03  mean elongation of the Moon from the Sun     d = iauFad03 ( t );
  FA_MOO_MEANARGUMENT   = 12;  //FAF03  mean argument of the latitude of the Moon    d = iauFaf03 ( t );
  FA_MOO_MEANASCNODE    = 13;  //FAOM03 mean longitude of the Moons ascending node d = iauFaom03( t );
  FA_GEN_PRECESSION     = 14;  //FAPA03 general accumulated precession in longitude  d = iauFapa03( t );

  //Multi Calendar number. These values are different that those in www.projectpluto.com
  CALENDAR_GREGORIAN        = 1;
  CALENDAR_JULIAN           = 2;
  CALENDAR_HEBREW           = 3;
  CALENDAR_ISLAMIC          = 4;
  CALENDAR_REVOLUTIONARY    = 5;
  CALENDAR_PERSIAN          = 6;
  CALENDAR_CHINESE          = 7;
  CALENDAR_MODERN_PERSIAN   = 8;
  CALENDAR_JULIAN_GREGORIAN = 9; // The "Julian/Gregorian" calendar uses the Julian system before mid-October 1582,  and Gregorian after that.   }

var //global Variables uses by Eph
  ddPsi: Real = 0.0;
  ddEps: Real = 0.0;

  Data_inited: boolean = false;

  fileYear: integer;
  NRFILE: file of byte;
  NRASSIGNED: Boolean = false;
  isFilesDir: boolean = false;
  SOLUTION: integer = 0;
  IRECSZ, NCOEFFS: integer;
  NSOL, NRECL, KSIZE: integer;
  NAMFIL, filesDir: String;
  //DefaultDir: String;

  {IYMIN: integer = -4799; }
  TTL: Array [0..2, 0..83] of Byte; //[3][84]
  CNAM: Array [0..999, 0..5] of Byte;   //[1000][6]
  plAU, EMRAT: Double;
  SS: Array [0..2] of Double;
  CVAL: Array [0..999] of Double;
  {PNUT: Array [0..3] of Double;}
  PVSUN: Array [0..5] of Real;
  BARY: boolean;
  KM{, DENUM}: boolean;
  NCON, NUMDE{, CENTER}: integer;
  IPT: Array [0..14, 0..2] of integer;
  dummy: array[0..8191] of Byte; // *** !!! It MUST BE 8192 bytes, because it is the size of a chunk !!! *** //
                                 // *** !!! otherwise you will have to read 8192 bytes one by one    !!! *** //

  plET1: Real = 0.0;
  plET2: Real = 0.0;
  plSOL: integer = 0;
  plARG: integer = 0;
  plCEN: integer = 0;
  plResult: TRealVektor6 = (0.0, 0.0, 0.0, 0.0, 0.0, 0.0);

//Check function headers
// should have a testrun with Data_

procedure InitData_ ();
  var
    i, j: byte;
  begin
   if not Data_inited then
     begin
       {$IfDef FPC}
       i := length(Mercury);
       setlength(Data_[0], i);
       for j := 0 to pred(i) do
         Data_[0, j] := Mercury[j];

       i := length(Venus);
       setlength(Data_[1], i);
       for j := 0 to pred(i) do
         Data_[1, j] := Venus[j];

       i := length(Earth);
       setlength(Data_[2], i);
       for j := 0 to pred(i) do
         Data_[2, j] := Earth[j];

       i := length(Mars);
       setlength(Data_[3], i);
       for j := 0 to pred(i) do
         Data_[3, j] := Mars[j];

       i := length(Jupiter);
       setlength(Data_[4], i);
       for j := 0 to i-1 do
         Data_[4, j] := Jupiter[j];

       i := length(Saturn);
       setlength(Data_[5], i);
       for j := 0 to i-1 do
         Data_[5, j] := Saturn[j];

       i := length(Uranus);
       setlength(Data_[6], i);
       for j := 0 to i-1 do
         Data_[6, j] := Uranus[j];

       i := length(Neptune);
       setlength(Data_[7], i);
       for j := 0 to i-1 do
         Data_[7, j] := Neptune[j];

       {$Else}
       i := length(Mercury);
       setlength(Data_[0], i);
       for j := 0 to pred(i) do
         Data_[0, j] := @Mercury[j];

       i := length(Venus);
       setlength(Data_[1], i);
       for j := 0 to pred(i) do
         Data_[1, j] := @Venus[j];

       i := length(Earth);
       setlength(Data_[2], i);
       for j := 0 to pred(i) do
         Data_[2, j] := @Earth[j];

       i := length(Mars);
       setlength(Data_[3], i);
       for j := 0 to pred(i) do
         Data_[3, j] := @Mars[j];

       i := length(Jupiter);
       setlength(Data_[4], i);
       for j := 0 to i-1 do
         Data_[4, j] := @Jupiter[j];

       i := length(Saturn);
       setlength(Data_[5], i);
       for j := 0 to i-1 do
         Data_[5, j] := @Saturn[j];

       i := length(Uranus);
       setlength(Data_[6], i);
       for j := 0 to i-1 do
         Data_[6, j] := @Uranus[j];

       i := length(Neptune);
       setlength(Data_[7], i);
       for j := 0 to i-1 do
         Data_[7, j] := @Neptune[j];
       {$EndIf}

       Data_inited := true;
     end;
  end;

function  round_(const InReal: Real): Real; inline;
  var
    f: Real;
    n: integer;
  begin
    f := ModF (InReal, n);

    if (n < 0) then
      if (f < -0.5) then
        Result := n-1
      else
        Result := n
    else
      if (f > 0.5) then
        Result :=  n + 1
    else
      Result := n;
  end;

{function  strtrim(const str: String): String; inline;
  begin
    Result := Trim (Str);
  end; }

procedure strrmeol(var str: String); inline;
  var
    i : integer;
  begin
    for i := 1 to length(str) do
      begin
        if (str[i] = #13) then
            Delete(str, i, 1)
        else
          if (str[i] = #10) then
            Delete(str, i, 1)
        {$IfDef FPC}
        else
            if (str[i] = LineEnding) then
              Delete(str, i, length(LineEnding))
       {$EndIf}
       ;
      end;
  end;

//----------------------------------------------------------------------------\\

function wmmGeoMag (const Value, Year, Month, Day: integer; const Lon, Lat, Height: Real): Real; //Wrapper for the wmmGeoMag function
  begin
    Result := wmm_Geomag (Value, Year, Month, Day, Lon, Lat, Height);
  end;

function  atang2(const y, x: Real): Real; inline;
  begin
    if  (y = 0) and (x = 0) then
      Result := (PLERR_ATAN2ERROR)
    else
      if (y < 0) and (x = 0) then
        Result := (3 * Pi / 2)
    else
      if (y > 0) and (x = 0) then
        Result := Pi / 2
    else
      if (y = 0) and (x > 0) then
        Result := 0.0
    else
      if (y = 0) and (x < 0) then
        Result := Pi
    else
      Result := arctan2(y, x);
  end;

procedure RotVX(const angle: Real; var p: TRealVektor3); inline;
  var
    r: TRealMatrix3_3;
  begin
    iauIr(r);
    iauRx(angle, r);
    iauRxp(r, p, p);
  end;

procedure RotVY(const angle: Real; var p: TRealVektor3); inline;
  var
    r:TRealMatrix3_3;
  begin
    iauIr(r);
    iauRy(angle, r);
    iauRxp(r, p, p);
  end;

procedure RotVZ(const angle: Real; var p: TRealVektor3); inline;
  var
    r: TRealMatrix3_3;
  begin
    iauIr(r);
    iauRz(angle, r);
    iauRxp(r, p, p);
  end;

function  PowerTo(const x, y: Real): Real; inline;
  begin
    if (x = 0) and (y = 0) then
      Result := 1.0
    else
      Result := Power(x, y);
  end;

function  RangeTo(x: Real; const bound: Real): Real;
  begin
    if (bound <= 0.0) then
      exit(0.0);

    {$IfDef FPC}
    while (x > bound) do
      x -= bound;
    while(x < 0.0) do
      x += bound;
    {$Else}
    while (x > bound) do
      x := x - bound;
    while(x < 0.0) do
      x := x + bound;
    {$EndIf}

    Result := x;
  end;

function  Centuries(const jd1, jd2: Real): Real;
  begin
    Result := (((jd1 - DJ00) + jd2) / 36525.0);
  end;

function  nDaysMonth (const Year, Month: integer): integer; inline;
  var
    Day: integer;
  begin
    if (Month = 2) then
      begin
        if (Year > 1582) then
          if (((Year mod 4) = 0) and ((Year mod 100) <> 0) or ((Year mod 400) = 0)) then
            Day := 29
          else
            Day := 28
        else
          if ((Year mod 4) = 0) then
            Day := 29
          else
            Day := 28;
      end
    else
      Day := ((Month + (Month div 8)) mod 2) + 30;

    Result := Day;
  end;

function  DeltaT(const jd1, jd2: Real): Real;
 var
   e: Extended;
   d,t,Jul: Real;
   a,a1,a2,d1,d2,i: integer;

  const
    dFac18: Array [0..10] of Real = (-0.000009,  0.003844,  0.083563,  0.865736,  4.867575,
                       15.845535, 31.332267, 38.291999, 28.316289, 11.636204, 2.043794);
    dFac19: Array [0..7] of Real =  (-0.000020, 0.000297,  0.025184, -0.181133, 0.553040, -0.861938, 0.677066, -0.212591);

  begin
    d := 0.0;
    Jul := jd1 + jd2;

    d1 := 124;
    d2 := 115;

    a1 := 1620;
    a2 := 1622;

    if (Jul < 2067315.5) then // ~~~~ - 948
      begin
        t := (Jul - FR_J2000) / 36525.0;
        d := 2715.6 + 573.36 * t + 46.5 * (t * t);
      end
    else
      if (Jul >= 2067315.5) and (Jul<2312752.5)then //  948 - 1600
        begin
          t := (Jul - FR_J2000) / 36525.0;
          d := 50.6 + 67.5 * t + 22.5 * (t * t);
        end
    else
      if(Jul >= 2312752.5) and (Jul < 2378496.5) then // 1620 - 1799
        begin
          e := Jul + 10;
          a := trunc(e / 365.25 - 4712.0);

          {$IfDef FPC}
          e += (abs(a/100)-(abs(a/400)-4))-16;
          {$Else}
          e := e + (abs(a/100)-(abs(a/400)-4))-16;
          {$EndIf}
          a := trunc(e / 365.25 - 4712.0);

          if(a < 1620) then
            a := 1620;

          for i := 0 to 90 do
            begin
              if (tabDelta[i][0] <= a) then
                begin
                  a1 := tabDelta[i][0];
                  d1 := tabDelta[i][1];
                end
              else
                if (tabDelta[i][0] > a) then
                  begin
                    a2 := tabDelta[i][0];
                    d2 := tabDelta[i][1];

                    break;
                  end;
            end;

          t := (Jul - Julian(a1,1,1,0,0,0)) / 365.25;
          d := t * ((d2 - d1) / (a2 - a1)) + d1;
        end
    else
      if (Jul >= 2378496.5) and (Jul<2415020.5) then // 1800 - 1899
        begin
          t := (Jul - 2415020.5) / 36525.0;

          for i :=0 to 10 do
            {$IfDef FPC}
            d += (dFac18[i]*PowerTo(t,i));

          d *= 86400.0;
            {$Else}
            d := d + (dFac18[i]*PowerTo(t,i));

          d := d * 86400.0;
            {$EndIf}
        end
    else
      if (Jul >= 2415020.5) and (Jul<2447161.5) then // 1900 - 1987
        begin
          t := (Jul - 2415020.5) / 36525.0;

          for i :=0 to 7 do
            {$IfDef FPC}
            d += (dFac19[i]*PowerTo(t,i));

          d *= 86400.0;
            {$Else}
            d := d + (dFac19[i]*PowerTo(t,i));

          d := d * 86400.0;
            {$EndIf}
        end
    else
      d := -15.0 + PowerTo(Jul - 2382148.0,2) / 41048480.0;

    Result := d;
  end;

function  ephNutation(const Value: integer; const utc1, utc2: Real): Real;
  var
    dpsi, deps: Real;
  begin
    iauNut80(utc1, utc2, dpsi, deps);

    if (Value = nLONGITUDE) then
      Result := dpsi
    else
      if (Value = nOBLIQUITY) then
        Result := deps
    else
      Result := 0.0;
  end;

procedure Tt2Tdb(const tt1, tt2: Real; var tdb1, tdb2: Real);
  var
    g, LLj: Real;
  begin
    tdb1 := tt1;
    tdb2 := tt2;

    g := (357.53 + 0.98560028 * ((tt1 - DJ00) + tt2)) * DD2R;
    LLj := (246.11 + 0.90251792 * ((tt1 - DJ00) + tt2)) * DD2R;
    {$IfDef FPC}
    tdb2 += ((0.001657 * sin(g) + 0.000022 * sin(LLj)) / 86400.0);
    {$Else}
    tdb2 := tdb2 + ((0.001657 * sin(g) + 0.000022 * sin(LLj)) / 86400.0);
    {$Endif}
  end;

function  OrbitalElements(const Body, Value: integer; const jd1, jd2: Real): Real;
  var
    i: integer;
    t: Real;
  begin

    if not (Body in ([BN_MERCURY..BN_MOON] - [BN_PLUTO])) then
      exit(0.0);
    if(Body = BN_MOON) and not (Value in [1..7]) then
      exit(0.0)
    else
      if(Body < BN_MOON) and not (Value in [1..6]) then
        exit(0.0);

    t := Centuries(jd1, jd2);
    Result := 0.0;

    if(Body = BN_MOON) then
      begin
        for i := 0 to 4 do
          {$IfDef FPC}
          Result += (Moon[pred(Value)][i] * PowerTo(t,i));
          {$Else}
          Result := Result + (Moon[pred(Value)][i] * PowerTo(t,i));
          {$Endif}

        Result := RangeTo(Result, 360.0);
      end
    else
      begin
        InitData_ ();

        for i := 0 to 3 do
          {$IfDef FPC}
          Result += (Data_[pred(Body)][pred(Value)][i] * Power(t,i));
          {$Else}
          Result := Result + (Data_[pred(Body)][pred(Value)][i] * Power(t,i));
          {$EndIf}

        if (not((Value = OE_SEMIMAJORAXIS) or (Value = OE_ECCENTRICITY))) then
          Result := RangeTo(Result, 360.0);
      end;
  end;

procedure BesselianToJ2000(var pv: TRealMatrix2_3);
  var
    rr, rv: TRealVektor3;
    vr, vv: TRealVektor3;
  begin

    iauZp(rr);
    iauZp(rv);

    iauZp(vr);
    iauZp(vv);

    {$IfDef FPC}
    iauRxp(Mrr, pv[0], rr);
    iauRxp(Mvr, pv[1], vr);
    iauRxp(Mrv, pv[0], rv);
    iauRxp(Mvv, pv[1], vv);

    iauPpp(rr, vr, pv[0]);
    iauPpp(rv, vv, pv[1]);
    {$Else}
    iauRxp(TRealMatrix3_3(Mrr), TRealVektor3(pv[0]), rr);
    iauRxp(TRealMatrix3_3(Mvr), TRealVektor3(pv[1]), vr);
    iauRxp(TRealMatrix3_3(Mrv), TRealVektor3(pv[0]), rv);
    iauRxp(TRealMatrix3_3(Mvv), TRealVektor3(pv[1]), vv);

    iauPpp(rr, vr, TRealVektor3(pv[0]));
    iauPpp(rv, vv, TRealVektor3(pv[1]));
    {$EndIF}

  end;

function  Julian (const Year, Month, Day, Hour, Minute, Second: Integer): Real;
  var
    ju: longint;
    i, dm: integer;
  begin

    dm := nDaysMonth(Year, Month);

    if (Day < 1) or (Day > dm) or (Month < 1) or (Month > 12) then
      exit(0.0);

    if (Year = 1582) and (Month = 10) and (Day > 4) and (Day < 15) then
      exit(0.0);

    if (Year < -4711) then
      ju := trunc(365.25 * (Year + 4712.0)) + Day - 1
    else
      ju := trunc(365.25 * (Year + 4711.0)) + Day + 365;

    for i := 1 to Month-1 do
      {$IfDef FPC}
      ju += nDaysMonth(Year, i);
      {$Else}
      ju := ju + nDaysMonth(Year, i);
      {$EndIF}

    if ((Year > 1582) or ((Year = 1582) and ((Month > 10) or  ((Month = 10) and (Day > 14))))) then
      begin
        {$IfDef FPC}
        ju += (Year - 1601) div 400;
        ju -= (Year - 1601) div 100;
        ju -= 10;
        {$Else}
        ju := ju + (Year - 1601) div 400;
        ju := ju - (Year - 1601) div 100;
        ju := ju - 10;
        {$EndIF}
      end;

    Result := (ju + (Hour + Minute / 60.0 + Second / 3600.0) / 24.0 - 0.5);
  end;

procedure Gregorian(const dj1, dj2: Real; var iy, im, id: integer; var fd: Real);
  var
    d, n, dm, i: integer;
    j, r, x: Real;

  begin
    JulianDateToDateAndTime(dj1, dj2, j, fd);

    d := 0;

    if (j > 2299160.0) then
      begin
        iy := trunc(j / 365.25 - 4712.0);

        {$IfDef FPC}
        d -= (iy - 1600) div 400;
        d += (iy-1600) div 100;

        j += (d + 10);
        {$Else}
        d := d - (iy - 1600) div 400;
        d := d + (iy-1600) div 100;

        j := j + (d + 10);
        {$EndIF}
      end;


    x := j / 365.25 - 4712.0;
    if (x < 0) then
      {$IfDef FPC}
      x -= 1;
      {$Else}
      x := x - 1;
      {$EndIF}

    r := (abs(x) - abs(trunc(x)));
    iy := trunc(x);

    n := 337 + nDaysMonth(iy, 2);

    {$IFDef FPC}
    id := round(r * n);
    {$Else}
    id := Integer(round(r * n));
    {$EndIf}

    if (iy < 0) and (id = 0) then
      {$IfDef FPC}
      iy += 1;
      {$Else}
      iy := iy + 1;
      {$EndIF}

    if (x < 0.0) then
      if (id = 0) then
        id := 1
      else
        id := n - id + 1
    else
      Inc(id);

  if (x > 0.0) then
    begin
      if (id > n) then
        begin
          {$IfDef FPC}
          iy += 1;
          {$Else}
          iy := iy + 1;
          {$EndIf}
          id := 1;
        end
      else
        if (j > 2299160.0) then
          begin
            {$IfDef FPC}
            id -= (iy-1600) div 400;
            id += (iy-1600) div 100;
            id -= d;
            {$Else}
            id := id - (iy-1600) div 400;
            id := id + (iy-1600) div 100;
            id := id - d;
            {$EndIf}
          end;
    end;

  for i := 1 to 12 do
    begin
      dm := nDaysMonth(iy, i);
      im := i;

      if (dm >= id) then
        break;

      {$IfDef FPC}
      id -= dm;
      {$Else}
      id := id - dm;
      {$EndIf}
    end;
  end;

function  SolveKepler(M: Real; const e: Real): Real; {***** From Roger Sinnott *****}
  var
    i,F,K: integer;
    N,D,E0,M1: Real;
  begin

    if(M <> 0) then
      begin
        F := Trunc(M / abs(M));
        M := abs(M) / (D2Pi);

        M := MODF(M, i);
        {$IfDef FPC}
        M *= D2Pi * F;
        {$Else}
        M := M * D2Pi * F;
        {$EndIf}
      end;

    if (M < 0) then
      {$IfDef FPC}
      M += D2Pi;
      {$Else}
      M := M + D2Pi;
      {$EndIf}

    if(M > Pi) then
      begin
        F := -1;
        M := D2Pi - M;
      end
    else
      F := 1;

    E0 := Pi / 2;
    D := Pi / 4;

    for i := 0 to 79 do
      begin
        M1 := E0 - e * sin(E0);
        N := M - M1;
        K := sign(N);

        {$IfDef FPC}
        E0 += D * K;
        D /= 2;
      end;
    E0 *= F;
        {$ELSE}
        E0 := E0 + D * K;
        D := D / 2;
      end;
    E0 :=  E0 * F;
        {$EndIF}

    Result := E0;
  end;

function  Houses(const Value: integer; const TZ, Lon, Lat, Jul: Real): Real;
  var
    i: integer;
    c, d, e, r, s, t, r0: Real;
    TempLat: Real;
  const
    k: TRealVektor3 = (6.6460656,2400.0513,0.0000258);
  begin
    TempLat := Lat;

    d := Jul + TZ / 24.0 + 0.5;
    t := (Jul - 2415020.5) / 36525.0;

    r := 0.0;
    for i := 0 to 2 do
      {$IfDef FPC}
      r += k[i] * PowerTo(t, i);
      {$ELSE}
      r := r + k[i] * PowerTo(t, i);
      {$EndIF}

    d  := RangeTo(24 * MODF(d, t) - TZ, 24.0);

    r := DD2R * RangeTo((r + d) * 15.0 + Lon,360.0);
    r0 := r;

    //e := DD2R * (Obliquity(Jul) + ephNutation(nOBLIQUITY, Jul, 0.0));
    e := iauObl80(DJ00, Jul-DJ00) + ephNutation(nOBLIQUITY, Jul, 0.0);

    {$IfDef FPC}
    TempLat *= DD2R;
    {$ELSE}
    TempLat := TempLat * DD2R;
    {$EndIF}

    case Value of
    1, 7:
      begin
        d := cos(r);
        t := -sin(r) * cos(e) - tan(TempLat) * sin(e);

        if(t <> 0.0) then
          if (d = 0.0) then
            if (t < 0.0) then
              c := Pi
            else
              c := 0.0
          else
            c := ATANG2(d, t)
        else
          if (d < 0.0) then
            c := -Pi/2.0
          else
            c := Pi / 2.0;

        {$IfDef FPC}
        if (c < 0.0) then
          c += Pi;

        if (d < 0.0) then
          c += Pi;
        {$ELSE}
        if (c < 0.0) then
          c := c + Pi;

        if (d < 0.0) then
          c := c + Pi;
        {$EndIF}
      end;
    2, 8:
      begin
        d := 1.5;
        s := 1.0;
        t := 0.0;

        r0 := r + 120.0 * DD2R;
      end;
    3, 9:
      begin
        d := 3.0;
        s := 1.0;
        t := 0.0;

        r0 := r + 150.0 * DD2R;
      end;
    4, 10:
      begin
        c := ATANG2(Tan(r), cos(e));

        {$IfDef FPC}
        if (c < 0.0) then
          c += Pi;

        if (r > Pi) then
          c += Pi;
        {$ELSE}
        if (c < 0.0) then
          c := c + Pi;

        if (r > Pi) then
          c := c + Pi;
        {$EndIF}
      end;
    5, 11:
      begin
        d := 3.0;
        s := -1.0;
        t := Pi;

        r0 := r + 30.0 * DD2R;
      end;
    6, 12:
      begin
        d := 1.5;
        s := -1.0;
        t := Pi;

        r0 := r + 60.0 * DD2R;
      end;
    end;

    if (Value > 1) and (Value <> 4) and (Value <> 7) and (Value <> 10) then
      begin
        if (TempLat = 0.0) then
          TempLat := 0.0001;

        for i := 0 to 9 do
          begin
            c := s * sin(r0) * tan(e) * tan(TempLat);
            c := arccos(c);
            if (c < 0.0) then
              {$IfDef FPC}
              c += Pi;
              {$Else}
              c := c + Pi;
              {$EndIf}

            if (s > 0.0) then
              r0 := r + Pi - (c / d)
            else
              r0 := r + (c / d);
          end;

        c := ATANG2(tan(r0), cos(e));

        {$IfDef FPC}
        if(c < 0.0) then
          c += Pi;
        if(sin(r0) < 0.0) then
          c += Pi;

        c += t;
        {$Else}
        if(c < 0.0) then
          c := c + Pi;
        if(sin(r0) < 0.0) then
          c := c + Pi;

        c := c + t;
        {$EndIf}
      end;

    if (Value = 4) or ((Value > 6) and (Value <> 10)) then
      {$IfDef FPC}
      c += Pi;
      {$Else}
      c := c + Pi;
      {$EndIf}

    Result := (RangeTo(DR2D * c, 360.0));
  end;

function  EclipticCoords(const Value, Adjust: integer; Asc, Dec: Real; const Jul: Real): Real;
  var
    c, e, x, y: Real;
  begin
    c := 0;

    {$IfDef FPC}
    Asc *= DD2R;
    Dec *= DD2R;

    e := iauObl80(DJ00, Jul-DJ00);

    if ((Adjust and 1) <> 0) then
      e += ephNutation(nOBLIQUITY, Jul, 0.0);
    {$Else}
    Asc := Asc * DD2R;
    Dec := Dec * DD2R;

    e := iauObl80(DJ00, Jul-DJ00);

    if ((Adjust and 1) <> 0) then
      e := e + ephNutation(nOBLIQUITY, Jul, 0.0);
    {$EndIf}

    if (Value = CV_LON) then
      begin
        y := sin(Asc) * cos(e) + tan(Dec) * sin(e);
        x := cos(Asc);

        if (x = 0) and (y = 0) then
          c := PLERR_ATAN2ERROR
        else
          c := RangeTo(DR2D * ATANG2(y, x), 360.0);
      end
    else
      if(Value = CV_LAT) then
        c := DR2D * arcsin(sin(Dec) * cos(e) - cos(Dec) * sin(Asc) * sin(e))
    else
      c := 0.0;

    Result := c;
  end;

function  HorizontalCoords(const Value: integer; const Asc: Real; Dec: Real; const Lon: Real; Lat: Real; const Jul: Real): Real;
  var
    c, h: Real;
  begin
    {$IFDef FPC}
    Dec *= DD2R;
    Lat *= DD2R;
    {$Else}
    Dec := Dec * DD2R;
    Lat := Lat * DD2R;
    {$EndIf}

    h := DD2R * RangeTo(DR2D * iauGmst82(DJ00, Jul- DJ00) + Lon - Asc, 360.0);

    if (Value = CV_AZI) then
      c := ATANG2(sin(h), cos(h) * sin(Lat) - tan(Dec) * cos(Lat)) + Pi
    else
      if(Value = CV_ALT) then
        c := arcsin(sin(Lat) * sin(Dec) + cos(Lat) * cos(Dec) * cos(h))
    else
      c := 0.0;

    Result := DR2D * c;
  end;

function  EquatorialCoords(const Value, Adjust, Origin: integer; LonAzi, LatEle, LonEcu, LatEcu, Jul: Real): Real;
  var
    c, e: Real;
  begin
    {$IFDef FPC}
    LonAzi *= DD2R;
    LatEle *= DD2R;
    LonEcu *= DD2R;
    LatEcu *= DD2R;
    {$Else}
    LonAzi := LonAzi * DD2R;
    LatEle := LatEle * DD2R;
    LonEcu := LonEcu * DD2R;
    LatEcu := LatEcu * DD2R;
    {$EndIf}

  case Origin of
    COR_ECLIPTICS :
      begin
        e := iauObl80(DJ00, Jul-DJ00);

        if ((Adjust and 8) <> 0) then
          {$IFDef FPC}
          e += ephNutation(nOBLIQUITY, Jul, 0.0);
          {$Else}
          e := e + ephNutation(nOBLIQUITY, Jul, 0.0);
          {$EndIf}

        if (Value = CV_ASC) or (Value = CV_HOR) then
          begin
            c := ATANG2(sin(LonAzi) * cos(e) - tan(LatEle) * sin(e), cos(LonAzi));

            if(Value = CV_HOR) then
              c := RangeTo(DR2D * (iauGmst82(DJ00, Jul-DJ00) + LonEcu-c) / 15.0, 24.0)
            else
              c := RangeTo(DR2D*c,360.0);
          end
        else
          if (Value = CV_DEC) then
            c := DR2D * arcsin(sin(LatEle) * cos(e) + cos(LatEle) * sin(LonAzi) * sin(e))
          else
            c := 0.0;
      end;
    COR_HORIZONTALS :
      begin
        if (Value = CV_ASC) or (Value = CV_HOR) then
          begin
            c := ATANG2(cos(LatEle) * sin(LonAzi), (sin(LatEle) * cos(LatEcu) + cos(LatEle) * sin(LatEcu) * cos(LonAzi)));
          //c := ATANG2(sin(LonAzi), (cos(LonAzi) * sin(LatEcu) + tan(LatEle)) * cos(LatEcu));

            if (Value = CV_ASC) then
              c := RangeTo(DR2D * (iauGmst82(DJ00, Jul-DJ00) + LonEcu - c), 360.0)
            else
              c := RangeTo(DR2D*c/15.0,24.0);
          end
        else
          if (Value = CV_DEC) then
            c := DR2D * arcsin(sin(LatEle) * sin(LatEcu) - cos(LatEle) * cos(LonAzi) * cos(LatEcu))
          else
            c := 0.0;
      end;
    else
      c := 0.0;
    end;

    Result := c;
  end;

function  EnsureSequentiality(bound: Real; var v1, v2, v3: Real): boolean;
  var
    q1, q3: Real;
  begin
    q1 := bound / 4.0;
    q3 := bound - q1;

    {$IfDef FPC}
    if (v2 < q1) and (v1 > q3) then
      v2 += bound;

    if (v3 < q1) and (v2 > q3) then
      v3 += bound;

    if (v2 < q1) and (v3 > q3) then
      v2 += bound;

    if (v1 < q1) and (v2 > q3) then
      v1 += bound;
    {$Else}
    if (v2 < q1) and (v1 > q3) then
      v2 := v2 + bound;

    if (v3 < q1) and (v2 > q3) then
      v3 := v3 + bound;

    if (v2 < q1) and (v3 > q3) then
      v2 := v2 + bound;

    if (v1 < q1) and (v2 > q3) then
      v1 := v1 + bound;
    {$EndIf}

    Result := (v1 > v2) and (v2 > v3);
  end;

// Test Passage for an event
function  PassageTest(const v, i: integer; const s, c, z, k1, t0, a0, d0: Real; var v0, a2, d2, v2: Real): Real;
  var
    a, b, d, e, d1, h0, h1, h2, l0, l2, t3, v1: Real;
  begin
    //if (a2 < a0) then a2 := a2 + D2Pi;
    l0 := t0 + i * k1;
    l2 := l0 + k1;
    h0 := l0 - a0;
    h2 := l2 - a2;

    h1 := (h2 + h0) / 2.0; // hour angle
    d1 := (d2 + d0) / 2.0; // dec

    if (v = GV_PASSAGE) then
      begin
        h0 := RangeTo(h0, D2Pi);
        h2 := RangeTo(h2, D2Pi);

        if (h0 > h2) then
          begin
            {$IfDef FPC}
            h2 += D2Pi;
            {$Else}
            h2 := h2 + D2Pi;
            {$EndIf}

            e := (D2Pi - h0) / (h2 - h0);
          end
        else
          exit(-1.0);
      end
    else
      begin
        if (i <= 0) then
          v0 := s * sin(d0) + c * cos(d0) * cos(h0) - z;

        v2 := s * sin(d2) + c * cos(d2) * cos(h2) - z;
        v1 := s * sin(d1) + c * cos(d1) * cos(h1) - z;

        if (sign(v0) = sign(v2)) then
          exit(-1.0);

        a := 2.0 * v2 - 4.0 * v1 + 2.0 * v0;
        b := 4.0 * v1 - 3.0 * v0 - v2;
        d := b * b - 4.0 * a * v0;

        if (d < 0.0) then
          exit(-1.0);

        d := sqrt(d);

        e := (d - b) / (2.0 * a);

        if (e > 1.0) or (e < 0.0) then
          e := -(d + b) / (2.0 * a);
      end;

    //t3 = i + e + 1.0 / 120.0;
    t3 := i + e;

    if (v = GV_RISING)  and (v0 < 0.0) and (v2 > 0.0) then
      Result := t3
    else
      if (v = GV_SETTING) and (v0 > 0.0) and (v2 < 0.0) then
        Result := t3
    else
      if (v = GV_PASSAGE) then
        Result := t3
    else
      Result := -1.0;
  end;

function  Passage(const Version: integer; Frame: integer; const Body, Value: integer; const utc1: Real; utc2: Real; const Lon, Lat, TZ, Elevation, Height: Real): Real;
//DOUBLE STDCALL Passage(int Version, int Frame, int Body,int Value, DOUBLE utc1, DOUBLE utc2, DOUBLE Lon, DOUBLE Lat, DOUBLE TZ, DOUBLE xp, DOUBLE yp, DOUBLE dut1, DOUBLE hm, DOUBLE ra, DOUBLE rb)
  var
    //e: boolean; // never used
    i: integer;
    jd, phi: Real;
    hl, a ,d, h, t, r, v, s, c, z: Real;
    a0, a1, a2, a3, d0, d1, d2, d3, v0, k1: Real;
  begin

    r := 6378100.0;
    {$IfDef FPC}
    utc2 -= (TZ / 24.0);
    {$Else}
    utc2 := utc2 - (TZ / 24.0);
    {$EndIf}

    if (Body = BN_EARTH) or (Body < BN_MERCURY) or (Body > BN_SUN) then
      exit(PLERR_WRONGOBJECT);

    if (Value < GV_PASSAGE) or (Value > GV_SETTING) then
      exit(PLERR_WRONGVALUE);

    if (Frame < FR_J2000) then //Frame = (Frame < J2000) ? OBSD : OBS;
      Frame := FR_CIRS
    else
     Frame := FR_FMOD;

    if (Elevation <> 0.0) then
      h := Elevation
    else
      if (Body = BN_SUN ) then
        h := -0.8333
    else
      if (Body = BN_MOON) then
        h := 0.125
    else
      h := -0.5667;

    if (Height > 0.0) then
      {$IfDef FPC}
      h -= (0.00527778 * sqrt(Height) + DR2D * arccos(r / (r + Height)));
      {$Else}
      h := h - (0.00527778 * sqrt(Height) + DR2D * arccos(r / (r + Height)));
      {$EndIf}

    JulianDateToDateAndTime(utc1, utc2, jd, t);

    t := (jd - DJ00);
    phi := DD2R * Lat;
    v0 := 0.0;
    v := 0.0;
    s := sin(phi);
    c := cos(phi);
    k1 := 15.0 * DD2R * 1.0027379;
    //hl := PassageLST(t, Lon / 360.0, TZ / 24.0);
    //t := t - TZ / 24.0;
    hl := iauGmst82(DJ00, t) - k1 * TZ + DD2R * Lon;

    {$IfDef FPC}
    t -= TZ / 24.0;
    {$Else}
    t := t - TZ / 24.0;
    {$EndIf}

    a1 := DD2R * Ephem(Version, Frame, Body, GV_RIGHTASCENSION, 5, DJ00, t+0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
    a2 := DD2R * Ephem(Version, Frame, Body, GV_RIGHTASCENSION, 5, DJ00, t+0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
    a3 := DD2R * Ephem(Version, Frame, Body, GV_RIGHTASCENSION, 5, DJ00, t+1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
    d1 := DD2R * Ephem(Version, Frame, Body, GV_DECLINATION   , 5, DJ00, t+0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
    d2 := DD2R * Ephem(Version, Frame, Body, GV_DECLINATION   , 5, DJ00, t+0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
    d3 := DD2R * Ephem(Version, Frame, Body, GV_DECLINATION   , 5, DJ00, t+1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);

    if (Value = GV_PASSAGE) then
      z := 24.0 * k1
    else
      z := cos(DD2R * (90.0 - h));

    {e  :=} EnsureSequentiality(D2Pi, a1, a2, a3);
    a0 := a1;
    d0 := d1;
    r  := -1.0;

   for i := 0 to 23 do
     begin
       t := (i + 1.0) / 24.0;
       a := a1 + t * (2.0 * (a2 - a1) + (a3 - 2.0 * a2 + a1) * (2.0 * t - 1));
       d := d1 + t * (2.0 * (d2 - d1) + (d3 - 2.0 * d2 + d1) * (2.0 * t - 1));

       t := PassageTest(Value, i, s, c, z, k1, hl, a0, d0, v0, a, d, v);

       a0 := a;
       d0 := d;
       v0 := v;

       if (t >= 0.0) then
         begin
           r := t;
           break;
         end;
    end;

  Result := r;
  end;

function  LightTime(const r: Real):Real;
  begin
    result := r / DC;
  end;

function  AnnualAberration(const Value: integer; const jd1, jd2, ls, lp, bp: Real): Real;
  var
    e, k, p: Real;
  begin

    k := DD2R * kAberracion;
    e := OrbitalElements(BN_EARTH, OE_ECCENTRICITY, jd1, jd2);
    p := DD2R * OrbitalElements(BN_EARTH, OE_PERIHELIUM, jd1, jd2);

    if (Value = 1) or (Value = GV_EARTHLONGITUDE) or (Value = GV_RIGHTASCENSION) then
      Result := DR2D * (lp + k * (e * cos(p-lp) - cos(ls-lp)) / cos(bp))
    else
      if (Value = 2) or (Value = GV_EARTHLATITUDE) or (Value = GV_DECLINATION) then
        Result := DR2D * (bp + k * sin(bp) * (e * sin(p-lp) - sin(ls-lp)))
    else
      Result := 0.0;
  end;

function  RealAnomaly(const EA, e: Real): Real; inline;
  begin
    Result := iauAnp( 2 *ATANG2(sqrt(1 + e) * sin(EA/2), sqrt(1 - e) * cos(EA / 2)));
  end;

// Algorithm from: Professor Steve Dutch, Natural and Applied Sciences, University of Wisconsin-Green Bay
//                Office: LS 463 phone: 465-2246, e-mail: dutchs@uwgb.edu, website: http://www.uwgb.edu/dutchs
// Note: webside is broken, email propably too.
function  CoordToUTM(const Value, Datum: integer; const Lon: Real; Lat, a_, b_: Real): Real;
  var
    n, p, e_, e2, nu: Real;
    ZoneH, ZoneV, ZoneCM: integer;
    A, B, C, D, E, S, K1, K2, K3, K4, K5: Real;

  begin
    //Lon = -Lon;
    if (Value < ZV_North) or (Value > ZV_ZoneV) then
      exit(0.0);

    if (Lon < 0.0) then
      ZoneH := trunc(((180.0 + Lon) / 6.0) + 1)
    else
      ZoneH := trunc((Lon/6.0)+31);

    if (Value = ZV_ZoneH) then
      Result := ZoneH
    else
      if (Value = ZV_ZoneV) then
        begin
          ZoneV := trunc((Lat / 8.0));

          if (Lat > 0.0) then
            Inc(ZoneV);

          if (Lat < -84.0) then
            ZoneV := Ord('A')
          else
            if (Lat < -72.0) then
               ZoneV := Ord('C')
          else
            if (Lat < -64.0) then
              ZoneV := Ord('D')
          else
            if (Lat < -32.0) then
              ZoneV := 76 + ZoneV
          else
            if (Lat > 72.0) then
              ZoneV := Ord('Z')
          else
            if (Lat < 8.0) then
              ZoneV := 77 + ZoneV
          else
             ZoneV := 78 + ZoneV;

          Result := ZoneV;
        end
    else
      begin
        ZoneCM := 6 * ZoneH - 183;

       if (Datum > 0) and (Datum < 24) then
          begin
            a_ := Datums[Datum-1][0];
            b_ := Datums[Datum-1][1];
          end;

        if (a_ = 0.0) or (b_ = 0.0) then
          exit(0.0);

        e_ := sqrt(1.0 - power(b_ / a_, 2));
        e2 := e_*e_ / (1.0 - e_*e_);
        n := (a_ - b_) / (a_ + b_);
        {$IfDef FPC}
        Lat *= DD2R;
        {$Else}
        Lat := Lat * DD2R;
        {$EndIf}
        //rho := a_ * (1.0 - e*e) / power(1.0 - power(e * sin(Lat), 2), 3.0 / 2.0);
        nu := a_ / sqrt(1 - power(e_ * sin(Lat), 2));
        p := DD2R * (Lon - ZoneCM);

        A := a_ * (1.0 - n + 5.0 * (n*n) / 4.0 * (1.0-n) + (81.0 * power(n, 4) / 64.0) * (1.0 - n));
        B := (3.0 * a_ * n / 2.0) * (1 - n - 7.0 * (n*n) / 8.0 * (1.0-n) + 55.0 * power(n, 4) / 64.0);
        C := (15.0 * a_ * n*n / 16.0) * (1.0 - n + 3.0 * (n*n) / 4.0 * (1.0-n));
        D := (35.0 * a_ * power(n, 3) / 48.0) * (1.0 - n + 11.0 * (n * n) / 16.0);
        E := (315.0 * a_ * power(n, 4) /51.0) * (1.0-n);
        S := A * Lat - B * sin(2.0 * Lat) + C * sin(4.0*Lat) - D * sin(6.0 * Lat) + E * sin(8.0 * Lat);

        if (Value = ZV_North) then
          begin
            K1 := k0 * S;
            K2 := nu * sin(Lat) * sin(Lat) * k0 / 2.0;
            K3 := ((nu * sin(Lat) * power(cos(Lat), 3)) / 24.0) *
                  (5.0 - power(tan(Lat), 2) + 9.0 * e2 * power(cos(Lat), 2) + 4.0 * e2 * e2 * power(COS(Lat), 4)) *
                  k0;

            if (Lat < 0) then
              Result := 10000000.0 + K1 + K2 * power(p,2) + K3 * power(p, 4)
            else
              Result := K1 + K2 * power(p, 2) + K3 * power(p, 4);
          end
        else
          if (Value = ZV_East) then
            begin
              K4 := nu * cos(Lat) * k0;
              K5 := power(cos(Lat), 3) * (nu / 6.0) * (1.0 - power(tan(Lat), 2) +
                    e2 * power(cos(Lat), 2)) * k0;

              Result := 500000.0 + K4 * p + K5 * power(p, 3);
            end
          else
            Result := 0.0;
      end;
  end;

// Works with general values for Latitude and Longitude, but 1 or 2 works for compatiblity too.
// Algorithm from: Professor Steve Dutch, Natural and Applied Sciences, University of Wisconsin-Green Bay
//                Office: LS 463 phone: 465-2246, e-mail: dutchs@uwgb.edu, website: http://www.uwgb.edu/dutchs
// Note: webside is broken, email propably too.
function  UTMToCoord(Value: integer; const Datum, ZoneH: integer; ZoneV: Char; North, East, a, b: Real): Real;
  var
    ZoneCM: integer;
    x, e, e1, e2, mu, fp, M: Real;
    Q1, Q2, Q3, Q4, Q5, Q6, Q7: Real;
    D, C1, N1, R1, T1, J1, J2, J3, J4: Real;
  begin
    if Value = 1 then
      Value := GV_LATITUDE
    else
      if Value = 2 then
        Value := GV_LONGITUDE
    else
      if (Value < GV_LONGITUDE) or (Value > GV_LATITUDE ) then
        exit(0.0);

    ZoneV := AnsiUpperCase(ZoneV)[1];

    if (ZoneH > 0) then
      ZoneCM := 6 * ZoneH - 183
    else
      ZoneCM := 3;

    if (Datum > 0) and (Datum < 24) then
      begin
        a := Datums[Datum-1][0];
        b := Datums[Datum-1][1];
      end;

    if (a = 0.0) or (b = 0.0) then
      exit(0.0);

    x := 500000.0 - East;
    e := sqrt(1.0 - power(b / a, 2));
    e2 := e*e / (1.0 - e*e);

    if (ZoneV < 'N') then
      M := North-10000000.0
    else
      M := North / k0;

    mu := M / (a * (1.0 - power(e, 2) / 4.0 - 3.0*power(e, 4) / 64.0 -
          5.0*power(e, 6) / 256.0));
    e1 := (1.0 - sqrt(1.0- e*e)) / (1.0 + sqrt(1.0 - e*e));
    J1 := 3.0*e1 / 2.0 - 27.0 * power(e1, 3) / 32.0;
    J2 := 21.0 * power(e1, 2) / 16.0 - 55.0 * power(e1, 4) / 32.0;
    J3 := 151.0 * power(e1, 3) / 96.0;
    J4 := 1097.0 * power(e1, 4) / 512.0;
    fp := mu + J1*sin(2.0*mu) + J2*sin(4.0*mu) +
          J3*sin(6.0*mu) + J4*sin(8.0 * mu);

    C1 := e2 * power(cos(fp), 2);
    T1 := power(tan(fp), 2);
    R1 := a * (1.0 - e*e) / power(1.0 - power(e*sin(fp), 2), 3/2);
    N1 := a / sqrt(1.0 - power(e*sin(fp), 2));
    D  := x / (N1 * k0);

    if (Value = GV_LATITUDE) then
      begin
        Q1 := N1 * TAN(fp) / R1;
        Q2 := D * D / 2.0;
        Q3 := (5.0 + 3.0*T1 + 10.0*C1 - 4.0*C1*C1 - 9.0*e2) * power(D, 4) / 24.0;
        Q4 := (61.0 + 90.0*T1 + 298.0*C1 + 45.0*T1*T1 - 252.0*e2 - 3.0*C1*C1) *
              power(D, 6) / 720.0;

        Result := DR2D*(fp - Q1 * (Q2+Q3+Q4));
      end
    else
      if (Value = GV_LONGITUDE) then // Longitude
        begin
          Q5 := D;
          Q6 := (1.0 + 2.0*T1 + C1) * power(D,3) / 6.0;
          Q7 :=(5.0 - 2.0*C1 + 28.0*T1 - 3.0*C1*C1 + 8.0*e2 + 24.0*T1*T1) *
               power(D, 5) / 120.0;

        //Result := -(ZoneCM - DR2D * ((Q5 - Q6 + Q7) / COS(fp)));
          Result :=  (ZoneCM - DR2D * ((Q5 - Q6 + Q7) / COS(fp)));
        end
    else
      Result := 0.0;
  end;

  function  VSOP87_all(Version: integer; const Body, Value: integer; const tdb1, tdb2: Real): Real;
    var
      l, b, r, e, t: Real;
      p1, p2: TRealVektor3;
    begin
      e := 0.0;

       if (Body < 1) then
        exit(0.0);
      if not (Value in [1..9]) then
        exit(0.0);


      if not (Version in [0..5]) then // Try to converd to 0..5
        if (Version = Ord('0')) then
          Version := 0
        else
        {$IfDef FPC}
          if (Version in [Ord('A')..Ord('E')]) then
            Version -= (Ord('A') -1)
        else
          if (Version in [Ord('a')..Ord('e')]) then
            Version -= (Ord('a') -1)
        else
          exit (0.0);
        {$Else}
          if (Version in [Ord('A')..Ord('E')]) then
            Version := Version - (Ord('A') -1)
        else
          if (Version in [Ord('a')..Ord('e')]) then
            Version := Version - (Ord('a') -1)
        else
          exit (0.0);
        {$EndIf}


      if (Version = 0) and (Value > 6) then
        exit(0.0);
      if (Version = 1) or (Version = 5) then
        begin
          if (Body > 9) then
            exit(0.0)
        end
      else
        if (Body > 8) then
          exit(0.0);

      if (Version = 1) or (Version = 3) or (Version = 5) then
        begin
          if (Value >= GV_LONGITUDE) then
            begin
              p1[0] := VSOP87_all(Version, Body, GV_POS_X, tdb1, tdb2);
              p1[1] := VSOP87_all(Version, Body, GV_POS_Y, tdb1, tdb2);
              p1[2] := VSOP87_all(Version, Body, GV_POS_Z, tdb1, tdb2);

              case Value of
                GV_LATITUDE:
                  exit(ATANG2(p1[2], sqrt(p1[0]*p1[0] + p1[1]*p1[1])));
                GV_RADIUS:
                  exit(sqrt(p1[0]*p1[0] + p1[1]*p1[1] + p1[2]*p1[2]));
                GV_LONGITUDE:
                  exit(ATANG2(p1[1], p1[0]));
                else
                  exit(0.0);
              end;
            end
          else
            if (Value >= GV_VEL_X) then
              begin
                e := VSOP87_all(Version, Body, Value-3, tdb1, tdb2+0.5);
                exit (e - VSOP87_all(Version, Body, Value-3, tdb1, tdb2-0.5));
              end;
        end
      else
        if (Version = 2) or  (Version = 4) then
          begin
            if (Value < GV_VEL_X) then
              begin
                l := VSOP87_all(Version, Body, GV_LONGITUDE, tdb1, tdb2);
                b := VSOP87_all(Version, Body, GV_LATITUDE , tdb1, tdb2);
                r := VSOP87_all(Version, Body, GV_RADIUS   , tdb1, tdb2);

                case Value of
                  1: exit (r * cos(l) * cos(b));
                  2: exit (r * sin(l) * cos(b));
                  3: exit (r * sin(b));
                  else
                    exit(0.0);
                end;
              end
            else
              if (Value < GV_LONGITUDE) then
                begin
                  l := VSOP87_all(Version, Body, GV_LONGITUDE, tdb1, tdb2+0.5);
                  b := VSOP87_all(Version, Body, GV_LATITUDE , tdb1, tdb2+0.5);
                  r := VSOP87_all(Version, Body, GV_RADIUS   , tdb1, tdb2+0.5);

                  p2[0] := r * cos(l) * cos(b);
                  p2[1] := r * sin(l) * cos(b);
                  p2[2] := r * sin(b);

                  l := VSOP87_all(Version, Body, GV_LONGITUDE, tdb1, tdb2-0.5);
                  b := VSOP87_all(Version, Body, GV_LATITUDE , tdb1, tdb2-0.5);
                  r := VSOP87_all(Version, Body, GV_RADIUS   , tdb1, tdb2-0.5);

                  p1[0] := r * cos(l) * cos(b);
                  p1[1] := r * sin(l) * cos(b);
                  p1[2] := r * sin(b);

                  iauPmp(p2, p1, p2);

                  exit(p2[Value-4]);
                end;
          end;

      t := Centuries(tdb1, tdb2) / 10.0;

      case Version of
        0: e := VSOP870(Body,Value,t);
        1: e := VSOP87A(Body,Value,t);
        2: e := VSOP87B(Body,Value,t);
        3: e := VSOP87C(Body,Value,t);
        4: e := VSOP87D(Body,Value,t);
        5: e := VSOP87E(Body,Value,t);
        else
          e := 0.0;
      end;

      Result := e;

    end;

  function  EphemHelio0(const Body, Value: integer; const tdb1, tdb2: Real): Real;
    var
      j: integer;
      a, b, e, x, y, z, r, n, i, w, t, v: Real;
    begin
      t := Centuries(tdb1, tdb2);
      e := 0.0;

      if(Body = BN_EARTH) and (Value < GV_LONGITUDE) then
        begin
          InitData_();
          for j := 0 to 3 do
            {$IfDef FPC}
            e += Data_[pred(Body)][pred(Value)][j] * PowerTo(t,j); // body could be used as const
            {$Else}
            e := e + Data_[pred(Body)][pred(Value)][j] * PowerTo(t,j); // body could be used as const
            {$EndIf}

          if not ((Value = OE_SEMIMAJORAXIS) or (Value = OE_ECCENTRICITY)) then
            e := RangeTo(e, 360.0);

          exit(e);
        end;

    case Value of
      OE_PERIHELIUM,        // b = e cos(p)       e : eccentricity
      OE_ECCENTRICITY:      // a = e sin(p)       p : perihelion longitude
        begin
          a := VSOP870(Body, E_SIN_P, t/10.0);
          b := VSOP870(Body, E_COS_P, t/10.0);

          e := ATANG2(a, b);

          if (Value = OE_ECCENTRICITY) then
            e := b / cos(e)
          else
            e := RangeTo(DR2D * e, 360.0);

        end;
      OE_INCLINATION,       // a = sin(g) sin(G)  G : ascending node longitude
      OE_ASCENDINGNODE:     // b = sin(g) cos(G)  g : semi-inclination
        begin
          a := VSOP870(Body, SIN_g_SIN_G, t/10.0);
          b := VSOP870(Body, SIN_g_COS_G, t/10.0);

          e := ATANG2(a, b);

          if (Value = OE_INCLINATION) then
            e := 2 * arcsin(b / cos(e));

          e := RangeTo(DR2D*e, 360.0);
        end;
      OE_SEMIMAJORAXIS,
      OE_MEANLONGITUDE:
        begin
          e := VSOP870(Body, Value, t/10.0);

          if (Value = MEANLONGITUDE) then
             e := RangeTo(DR2D*e, 360.0);
        end;
      VSOP870_POS_X,
      VSOP870_POS_Y,
      VSOP870_POS_Z,
      GV_LONGITUDE,
      GV_LATITUDE,
      GV_RADIUS:
        begin
          b := EphemHelio0(Body, OE_PERIHELIUM, tdb1, tdb2);
          i := EphemHelio0(Body, OE_INCLINATION, tdb1, tdb2);
          e := EphemHelio0(Body, OE_ECCENTRICITY, tdb1, tdb2);
          a := EphemHelio0(Body, OE_SEMIMAJORAXIS, tdb1, tdb2);
          r := EphemHelio0(Body, OE_MEANLONGITUDE, tdb1, tdb2);
          n := EphemHelio0(Body, OE_ASCENDINGNODE, tdb1, tdb2);

          t := SolveKepler(DD2R*(r - b), e);

          w := DD2R * RangeTo(b - n, 360.0);

          {$IfDef FPC}
          n *= DD2R;
          i *= DD2R;
          {$Else}
          n := n * DD2R;
          i := i * DD2R;
          {$EndIf}

          x := a * (cos(t) - e);
          y := a * (sqrt(1.0 - sqr(e)) * sin(t));

          v := ATANG2(y, x);
          r := sqrt(sqr(x) + sqr(y));

          x := r * (cos(n) * cos(v+w) - sin(n) * sin(v+w) * cos(i));
          y := r * (sin(n) * cos(v+w) + cos(n) * sin(v+w) * cos(i));
          z := r * (                             sin(v+w) * sin(i));

          case Value of
            VSOP870_POS_X:
              e := x;
            VSOP870_POS_Y:
              e := y;
            VSOP870_POS_Z:
              e := z;
            GV_LONGITUDE:
              e := RangeTo(DR2D*ATANG2(y, x), 360.0);
            GV_LATITUDE:
              e := DR2D * ATANG2(z, sqrt(sqr(x) + SQR(y)));
            GV_RADIUS:
              e := sqrt(sqr(x) + sqr(y) + sqr(z));
          end;
        end;
      else
        Result := 0.0;
      end;

      Result := e;
    end;

{************************************************************************************/
/* Geocentric Spherical Coordinates of Moon from the book:                          */
/*   Astronomical Algotithms, Jean Meeus, @1991 by Willmann-Bell, Inc.              */
/*     using Chapront ELP-2000/82 lunar theory using terms in:                      */
/*       Astronomy and Astrophysics, M. Chapront-Touzé & J. Chapront, Vol 190, 1988 */
/************************************************************************************}
procedure EphemMoon(const tdb1, tdb2: Real; var l, b, r: Real);
  var
    i: integer;
    e,q,t: Real;
    a: TRealVektor3;
    d: Array [0..4] of Real;

  begin
    t := Centuries(tdb1, tdb2);

    a[0] := DD2R * RangeTo(119.75 +    131.849 * t, 360.0);
    a[1] := DD2R * RangeTo( 53.09 + 479264.290 * t, 360.0);
    a[2] := DD2R * RangeTo(313.45 + 481266.484 * t, 360.0);

    e := 1 - 0.002516 * t - 0.0000074 * sqr(t);

    d[0] := DD2R * OrbitalElements(BN_MOON, OE_MEANLONGITUDE    ,tdb1, tdb2);
    d[1] := DD2R * OrbitalElements(BN_MOON, ARG_MEANELONGATION  ,tdb1, tdb2);
    d[2] := DD2R * OrbitalElements(BN_MOON, ARG_SOLARANOMALY    ,tdb1, tdb2);
    d[3] := DD2R * OrbitalElements(BN_MOON, ARG_LUNARANOMALY    ,tdb1, tdb2);
    d[4] := DD2R * OrbitalElements(BN_MOON, ARG_ARGUMENTLATITUDE,tdb1, tdb2);

    b := 0.0;
    l := 0.0;
    r := 0.0;


    {$IfDef FPC}
    for i := 0 to 59 do
      begin
         q := rlMoon[i][0] * d[1] + rlMoon[i][1] * d[2] +
              rlMoon[i][2] * d[3] + rlMoon[i][3] * d[4];

         l += (clrMoon[i][0]) * sin(q) * PowerTo(e, abs(rlMoon[i][1]));
         r += (clrMoon[i][1]) * cos(q) * PowerTo(e, abs(rlMoon[i][1]));

         q := bMoon[i][0] * d[1] + bMoon[i][1] * d[2] +
             bMoon[i][2] * d[3] + bMoon[i][3] * d[4];

         b += (cbMoon[i]) * sin(q) * PowerTo(e, abs(bMoon[i][1]));
      end;

    l +=  (0.003958 * sin(a[0]) + 0.000318 * sin(a[1]) + 0.001962 * sin(d[0]-d[4]));
    b += (-0.002235 * sin(d[0]) + 0.000382 * sin(a[2]) + 0.000175 * sin(a[0]-d[4]) +
          0.000175 * sin(a[0]+d[4]) + 0.000127 * sin(d[0]-d[3]) - 0.000115 * sin(d[0]+d[3]));

    while(b < -90.0) do
      b += 90.0;

    while(b > 90.0) do
      b -= 90.0;
    {$Else}
    for i := 0 to 59 do
      begin
         q := rlMoon[i][0] * d[1] + rlMoon[i][1] * d[2] +
              rlMoon[i][2] * d[3] + rlMoon[i][3] * d[4];

         l := l + (clrMoon[i][0]) * sin(q) * PowerTo(e, abs(rlMoon[i][1]));
         r := r + (clrMoon[i][1]) * cos(q) * PowerTo(e, abs(rlMoon[i][1]));

         q := bMoon[i][0] * d[1] + bMoon[i][1] * d[2] +
             bMoon[i][2] * d[3] + bMoon[i][3] * d[4];

         b := b + (cbMoon[i]) * sin(q) * PowerTo(e, abs(bMoon[i][1]));
      end;

    l := l +  (0.003958 * sin(a[0]) + 0.000318 * sin(a[1]) + 0.001962 * sin(d[0]-d[4]));
    b := b + (-0.002235 * sin(d[0]) + 0.000382 * sin(a[2]) + 0.000175 * sin(a[0]-d[4]) +
          0.000175 * sin(a[0]+d[4]) + 0.000127 * sin(d[0]-d[3]) - 0.000115 * sin(d[0]+d[3]));

    while(b < -90.0) do
      b := b + 90.0;

    while(b > 90.0) do
      b := b - 90.0;
    {$EndIf}

    r := (r + 385000.56) / 149504201.0;
    l := RangeTo(l + DR2D*d[0], 360.0);

  end;

{******************************************************************
* Ref : Bureau des Longitudes - 95.1, J. Chapront, G. Francou (BDL)
* Object:
* Computation of heliocentric rectangular coordinates of Pluto.
* Source : DE200 (Jet Propulsion Laboratory).
* Frame : dynamical mean equinox and equator DJ00 (DE200).
* The ephemerides are computed with a method of approximation
* using frequency analysis :
* J. Chapront, 1995, Astron. Atrophys. Sup. Ser., 109, 181.
*******************************************************************
function EphemPluto(const Value: integer; const tdb1, tdb2: Real): Real; // Valids between: [01/01/1700-24/01/2100].
  const
    tdeb = 2341972.5;
  //tfin = 2488092.5;
    dt = 146120.0;
  var
    x, f, fx, wx, cf, sf: Real;;
    v, w, r: TRealVektor3;
    imax, imin: integer;
    i, m: byte;
  begin

  //Check up the date
  //if ((tdb1+tdb2)<tdeb) or ((tdb1+tdb2)>tfin)) then
    exit(0.0);

    for i := 0 to 2 do
      r[i] := 0.0;

  //Change variable
    x := 2.0 * ((tdb1+tdb2)-tdeb) / dt - 1.0; fx = x * dt / 2.0;
  //Compute the positions (secular terms)
    wx := 1.0;
    v[0] = v[1] = v[2] = 0.0;

    for i := 0 to 3 do
      begin
        v[0] := v[0] + axPluto[i] * wx;
        v[1] := v[1] + ayPluto[i] * wx;
        v[2] := v[2] + azPluto[i] * wx;
        wx := wx * x;
      end

  //Compute the positions (periodic and Poisson terms)
    imax := 0;
    wx := 1.0;
    for m := 0 to 2 do
      begin
        for i := 0 to 2 do
          w[i] = 0.0;

        imin := imax + 1;
        imax := imax + nfPluto[m];

        for i := imin to imax do
          begin
            f  := fqPluto[i-1] * fx; cf = cos(f); sf = sin(f);
            w[0] += cxPluto[i-1] * cf + sxPluto[i-1] * sf;
            w[1] += cyPluto[i-1] * cf + syPluto[i-1] * sf;
            w[2] += czPluto[i-1] * cf + szPluto[i-1] * sf;
          end;

        for i := 0 to 2 do
          v[i] :=  v[i] + w[i] * wx;

        wx := wx * x;
      end;

    for i := 0  to 2 do
      begin
        r[i] := v[i] / 100000.0;
        r[i] := r[i] / 100000.0;
      end;

    case Value of
      LATITUDE: Result := (DR2D*ATANG2(r[2], sqrt(r[0]*r[0] + r[1]*r[1])));
      LONGITUDE: Result := (RangeTo(DR2D*ATANG2(r[1], r[0]), 360.0));
      RADIUS: Result := (sqrt(r[0]*r[0] + r[1]*r[1] + r[2]*r[2]));
      POS_X: Result := (r[0]);
      POS_Y: Result := (r[1]);
      POS_Z: Result := (r[2]);
      else
        Result := 0.0;
    end;
  end;
**************************************************************************}

{*************************************************************************/
/* Heliocentric Spherical Coordinates of Pluto from:                     */
/*   Goffin, Meeus & Steyaert from then book                             */
/*     Astronomical Algotithms, Jean Meeus, @1991 by Willmann-Bell, Inc. */
/*   Reference Frame: J2000.0 (1885 to 2099)                             */
/*************************************************************************}
procedure EphemPluto(const tdb1, tdb2: Real; var l, b, r: Real); // Validas entre: [1885-2099].
  var
    i: integer;
    t, a: Real;
    j, s, p: Real;
  begin

    t := Centuries(tdb1, tdb2);
    b := 0.0;
    l := 0.0;
    r := 0.0;

    j := DD2R * (34.35 + 3034.9057 * t);
    s := DD2R * (50.08 + 1222.1138 * t);
    p := DD2R * (238.96 + 144.9600 * t);

    {$IfDef FPC}
    for i := 0 to 42 do
      begin
        a := nPluto[i][0] * j + nPluto[i][1] * s + nPluto[i][2] * p;
        l += (cPluto[i][0] * sin(a) + cPluto[i][1] * cos(a));
        b += (cPluto[i][2] * sin(a) + cPluto[i][3] * cos(a));
        r += (cPluto[i][4] * sin(a) + cPluto[i][5] * cos(a));
      end;

    b -= 3.908202;
    r += 40.7247248;
    l += (238.956786 + 144.96 * t);
    {$Else}
    for i := 0 to 42 do
      begin
        a := nPluto[i][0] * j + nPluto[i][1] * s + nPluto[i][2] * p;
        l := l + (cPluto[i][0] * sin(a) + cPluto[i][1] * cos(a));
        b := b + (cPluto[i][2] * sin(a) + cPluto[i][3] * cos(a));
        r := r + (cPluto[i][4] * sin(a) + cPluto[i][5] * cos(a));
      end;

    b := b - 3.908202;
    r := r + 40.7247248;
    l := l + (238.956786 + 144.96 * t);
    {$EndIf}

    l := RangeTo(l, 360.0);
  end;

function  GetFilesDir():boolean;
  var
    l, p, i: integer;
    fi: TStringList;
    line: String;
  begin
    filesDir := '';
    fi := TStringList.create;
    line := GetCurrentDir + PathDelim + 'PlanEph.cfg';

    if FileExists(line) then
      begin
        try
          fi.LoadFromFile(line);

          for i := 0 to fi.count-1 do
            begin
              line := fi[i];

              strrmeol(line);
              line := trim(line);

              if (line[1] = '#') or (line [1] = ';') or ((line[1] = '/') and (line[2] = '/')) then
                continue;

              line := trim(line);

              {$IfDef FPC}
              if line.StartsWith('binaries', true) then
              {$Else}
              if Copy(line, 1, 8) = 'binaries' then
              {$EndIf}
                begin
                  p := pos(line, '=');

                  if (p <> 0) then
                    begin
                      filesDir := copy(line, p + 1, Length(line) - 1 - p);
                      break;
                    end;
                end;
            end;
        finally
          fi.free;
        end;
    end;

    l := Length(filesDir);
    if (l = 0) then
      //filesDir := 'C:\Astro\Ephemerides\bin' + PathDelim
      filesDir := GetCurrentDir + PathDelim + 'bin' + PathDelim
    else
      {$IfDef FPC}
      if not (filesDir.EndsWith(PathDelim)) then
      {$Else}
      if not (Copy(filesDir, Length(filesDir)-Length(PathDelim), Length(PathDelim)) = PathDelim) then
      {$EndIf}
           filesDir += PathDelim;

    Result := true;
  end;

function  GetDEValue(const Value: String): Real;
  var
    s: String;
    i: integer;
  begin
    for i := 0 to NCON-1 do
       begin
         SetString(s, PCHAR(@CNAM[i]), 6);
         s := Trim(s);

         if (s = Value) then
           exit(CVAL[i]);
       end;

    Result := 0.0;
  end;

function  InitPlanetEphem(deNum: integer): boolean;
  begin
    KM := false;
    NRECL := 4;
    BARY := true;
    SOLUTION := deNum;
    fileYear := -100000;
    NRASSIGNED := false;

    NAMFIL := '';

    if not isFilesDir then
      isFilesDir := GetFilesDir();

    case SOLUTION of
        8: begin KSIZE := 1876; NSOL := 19; end; // inpop08ale
       80: begin KSIZE := 1876; NSOL := 19; end; // inpop08att
       10: begin KSIZE := 1876; NSOL := 19; end; // inpop10ele
       13: begin KSIZE := 1876; NSOL := 19; end; // inpop13cle
      100: begin KSIZE := 1876; NSOL := 19; end; // inpop10ett
      130: begin KSIZE := 1876; NSOL := 19; end; // inpop13ctt
      102: begin KSIZE := 1546; NSOL :=  0; end;
      200: begin KSIZE := 1652; NSOL :=  1; end;
      202: begin KSIZE := 1652; NSOL :=  2; end;
      403: begin KSIZE := 2036; NSOL :=  3; end;
      405: begin KSIZE := 2036; NSOL :=  4; end;
      406: begin KSIZE := 1456; NSOL :=  5; end;
      410: begin KSIZE := 2036; NSOL :=  6; end;
      413: begin KSIZE := 2036; NSOL :=  7; end;
      414: begin KSIZE := 2036; NSOL :=  8; end;
      418: begin KSIZE := 2036; NSOL :=  9; end;
      421: begin KSIZE := 2036; NSOL := 10; end;
      422: begin KSIZE := 2036; NSOL := 11; end;
      423: begin KSIZE := 2036; NSOL := 12; end;
      424: begin KSIZE := 2036; NSOL := 13; end;
      430: begin KSIZE := 2036; NSOL := 14; end;
     4300: begin KSIZE := 1964; NSOL := 15; end; // 430t
      431: begin KSIZE := 2036; NSOL := 16; end;
      432: begin KSIZE := 1876; NSOL := 17; end;
     4320: begin KSIZE := 1964; NSOL := 18; end; // 432t
    else
      exit(false);
    end;

    IRECSZ := NRECL * KSIZE;
    NCOEFFS := KSIZE div 2;

    Result := true;
  end;

procedure EndPlanetEphem();
  begin
    if NRASSIGNED then
      CloseFile(NRFILE);

    NRASSIGNED := False;

    fileYear := -100000;
  end;

function  CheckBinaryFileHeader(const deSolution: integer; const ET: Real): integer;  //Read
  var
    y, headSize: integer;
    sg: char;
  begin

    if not (SOLUTION = deSolution) then
      begin
        if NRASSIGNED then
          begin
            CloseFile(NRFILE);
            NRASSIGNED := False;
          end;

       if not (InitPlanetEphem(deSolution))then
         exit(PLERR_UNKNOWNSOLUTION);
      end;

    y := SolutionFiles[NSOL][1];

    while(y <= SolutionFiles[NSOL][2]) do
      begin
        if ((Julian(y + SolutionFiles[NSOL][3], 1, 1, 0, 0, 0) + 0.5) > ET) then
          break;

        //if((Cal2JD(y + SolutionFiles[NSOL][3], 1, 1) + 0.5) > ET) then
          //break;

        {iau_CAL2JD(y + SolutionFiles[NSOL][3], 1, 1, &J1, &J2, &e);
        if ((J1 + J2) > ET) then
          break; }
        {$IfDef FPC}
        y += SolutionFiles[NSOL][3];
        {$Else}
        y := y + SolutionFiles[NSOL][3];
        {$EndIf}
    end;

    if (y = fileYear) then
      exit(1);

    headSize := 0;
    fileYear := -100000;

    if NRASSIGNED then
      begin
        CloseFile(NRFILE);
        NRASSIGNED := False;
      end;

    if (y < 0) then
      sg := 'm'
    else
      sg := 'p';

    if (SOLUTION =  8) then
      NAMFIL := filesDir + PathDelim + 'inpop08a_m1000_p1000_littleendian.dat'
    else
      if (SOLUTION = 10) then
        NAMFIL := filesDir + PathDelim + 'inpop10e_tdb_m1000_p1000_littleendian.dat'
    else
      if (SOLUTION = 13) then
        NAMFIL := filesDir + PathDelim + 'inpop13c_TCB_m1000_p1000_littleendian.dat'
    else
      if (SOLUTION = 80) then
        NAMFIL := filesDir + PathDelim + 'inpop08a_m1000_p1000_tt.dat'
    else
      if (SOLUTION = 100) then
        NAMFIL := filesDir  + PathDelim + 'inpop10e_tdb_m1000_p1000_tt.dat'
    else
      if (SOLUTION = 130) then
        NAMFIL := filesDir + PathDelim + 'inpop13c_TDB_m1000_p1000_littleendian.dat'
    else
      if (SOLUTION = 431) then
        NAMFIL := filesDir + 'de' + IntToStr(SOLUTION) + PathDelim + 'bin' + sg + FormatFloat('00000', abs(y)) + '.' + IntToStr(SOLUTION)
    else
      if (SOLUTION > 4000) then
        NAMFIL := filesDir + 'de' + IntToStr(SOLUTION div 10) + 't' + PathDelim + 'bin' + sg + FormatFloat('0000', abs(y)) + '.' + IntToStr(SOLUTION div 10) + 't'
    else
      NAMFIL := filesDir + 'de' + IntToStr(SOLUTION) + PathDelim + 'bin' + sg + FormatFloat('0000', abs(y)) + '.' + IntToStr(SOLUTION);

    Try
      AssignFile(NRFILE, NAMFIL);
      Reset(NRFILE);

      NRASSIGNED := True;
    except
      NRASSIGNED := False;      //Could course Errors, but to not free it is even worse
      exit(PLERR_NOFILE);
    end;

    fileYear := y;


    {$IfDef FPC}
    BlockRead(NRFILE, TTL    , sizeof(TTL)       );
    headSize += sizeof(TTL);
    BlockRead(NRFILE, CNAM   , 2400              );
    headSize += 2400;
    BlockRead(NRFILE, SS     , sizeof(SS)        );
    headSize += sizeof(SS);
    BlockRead(NRFILE, NCON   , sizeof(NCON)      );
    headSize += sizeof(NCON);
    BlockRead(NRFILE, plAU   , sizeof(plAU)      );
    headSize += sizeof(plAU);
    BlockRead(NRFILE, EMRAT  , sizeof(EMRAT)     );
    headSize += sizeof(EMRAT);
    BlockRead(NRFILE, IPT    , 36*sizeof(integer));
    headSize += 36*sizeof(integer);
    BlockRead(NRFILE, NUMDE  , sizeof(NUMDE)     );
    headSize += sizeof(NUMDE);
    BlockRead(NRFILE, IPT[12], 3*sizeof(integer) );
    headSize += 3*sizeof(integer);

    if (NUMDE < 100) then
      begin
        BlockRead(NRFILE, NCOEFFS, sizeof(Integer));
        headSize += sizeof(integer);
        BlockRead(NRFILE, IPT[13], 3*sizeof(integer));
        headSize += 3*sizeof(integer);

        KSIZE := NCOEFFS * 2;
        IRECSZ := NRECL * KSIZE;
      end;

      if (NCON > 400) then
        begin
          BlockRead(NRFILE, CNAM[400], 6*(NCON-400));
          headSize += 6*(NCON-400);
        end;

      if (SOLUTION > 430) then
        begin
          if (headSize <= (IRECSZ - 3*sizeof(integer))) then
            begin
              BlockRead(NRFILE, IPT[13], 3*sizeof(integer));
              headSize += 3*sizeof(integer);
            end;

          if (headSize <= (IRECSZ - 3*sizeof(integer))) then
            begin
              BlockRead(NRFILE, IPT[14], 3*sizeof(integer));
              headSize += 3*sizeof(integer);
            end;
        end;
    {$Else}
    BlockRead(NRFILE, TTL    , sizeof(TTL)       );
    headSize := headSize + sizeof(TTL);
    BlockRead(NRFILE, CNAM   , 2400              );
    headSize := headSize + 2400;
    BlockRead(NRFILE, SS     , sizeof(SS)        );
    headSize := headSize + sizeof(SS);
    BlockRead(NRFILE, NCON   , sizeof(NCON)      );
    headSize := headSize + sizeof(NCON);
    BlockRead(NRFILE, plAU   , sizeof(plAU)      );
    headSize := headSize + sizeof(plAU);
    BlockRead(NRFILE, EMRAT  , sizeof(EMRAT)     );
    headSize := headSize + sizeof(EMRAT);
    BlockRead(NRFILE, IPT    , 36*sizeof(integer));
    headSize := headSize + 36*sizeof(integer);
    BlockRead(NRFILE, NUMDE  , sizeof(NUMDE)     );
    headSize := headSize + sizeof(NUMDE);
    BlockRead(NRFILE, IPT[12], 3*sizeof(integer) );
    headSize := headSize + 3*sizeof(integer);

    if (NUMDE < 100) then
      begin
        BlockRead(NRFILE, NCOEFFS, sizeof(Integer));
        headSize := headSize + sizeof(integer);
        BlockRead(NRFILE, IPT[13], 3*sizeof(integer));
        headSize := headSize + 3*sizeof(integer);

        KSIZE := NCOEFFS * 2;
        IRECSZ := NRECL * KSIZE;
      end;

    if (NCON > 400) then
      begin
        BlockRead(NRFILE, CNAM[400], 6*(NCON-400));
        headSize := headSize + 6*(NCON-400);
      end;

    if (SOLUTION > 430) then
      begin
        if (headSize <= (IRECSZ - 3*sizeof(integer))) then
          begin
            BlockRead(NRFILE, IPT[13], 3*sizeof(integer));
            headSize := headSize + 3*sizeof(integer);
          end;

        if (headSize <= (IRECSZ - 3*sizeof(integer))) then
          begin
            BlockRead(NRFILE, IPT[14], 3*sizeof(integer));
            headSize := headSize + 3*sizeof(integer);
          end;
      end;
    {$EndIf}

    BlockRead(NRFILE, dummy , IRECSZ-headSize);

    BlockRead(NRFILE, CVAL  , 8*NCON       );
    BlockRead(NRFILE, dummy , IRECSZ-8*NCON);

    Result := 1;
  end;

//IMPLICIT double PRECISION (A-H,O-Z)
Procedure SPLIT(const TT: Real; var FR0, Fr1: Real);
  begin
  FR0 := trunc(TT);
  FR1 := TT - FR0;

  if not ((TT >= 0.0 ) or (FR1 = 0.0)) then
    begin
      {$IfDef FPC}
      FR0 -= 1.0;
      FR1 += 1.0;
      {$Else}
      FR0 := FR0 - 1.0;
      FR1 := FR1 + 1.0;
      {$EndIf}
    end;
  end;

//IMPLICIT DOUBLE PRECISION (A-H,O-Z)
//DOUBLE PRECISION BUF(NCF,NCM,*),T(2),PV(NCM,*),PC(18),VC(18)
procedure INTERP(BUF: PDouble; const T: TRealVektor2; const NCF, NCM, NA, IFL: integer; var PV: Array of Real);
  var
    i, j, L, NP, NV, DT1: integer;
    PC, VC: Array [0..17] of Real;
    TC, DNA, TWOT, TEMP, VFAC: Real;
    Ptr: PDouble;
  begin
    TWOT := 0.0;
    VC[1] := 1.0;
    NP := 2;
    NV := 3;
    PC[0] := 1.0;
    PC[1] := 0.0;

    DNA  := NA;
    DT1  := trunc(T[0]);
    TEMP := DNA * T[0];
    L    := trunc(TEMP-DT1);
  //L    := trunc((TEMP-DT1)+1);

  //TC IS THE NORMALIZED CHEBYSHEV TIME (-1 .LE. TC .LE. 1)
    TC := 2.0 * (fmod(TEMP, 1.0) + DT1) - 1.0;
    if(TC <> PC[1]) then
      begin
        PC[1] := TC;
        TWOT := TC + TC;
      end;

  //BE SURE THAT AT LEAST 'NCF' POLYNOMIALS HAVE BEEN EVALUATED AND ARE STORED IN THE ARRAY 'PC'.
    if (NP < NCF) then
      for i := NP to pred(NCF) do
        PC[i] := TWOT * PC[i-1] - PC[i-2];

  //INTERPOLATE TO GET POSITION FOR EACH COMPONENT
    for i := 0 to NCM-1 do
      begin
        PV[i] := 0.0;
        for j:= pred(NCF) downto 0 do
          begin
            {$IfDef FPC}
            //PV[i] := PC[j] * PDouble(PByte(BUF) + (L*NCM*NCF + i*NCF + j) * SizeOf(Double))^;
            Ptr   := PDouble(PByte(BUF) + (L*NCM*NCF + i*NCF + j) * SizeOf(Double));
            PV[i] += PC[j] * Ptr^;
            {$Else}
            //PV[i] := PV[i] + PC[j] * PDouble(PByte(BUF) + (L*NCM*NCF + i*NCF + j) * SizeOf(Double))^;
            Ptr   := PDouble(PByte(BUF) + (L*NCM*NCF + i*NCF + j) * SizeOf(Double));
            PV[i] := PV[i] + PC[j] * Ptr^;
            {$EndIf}
          end;
      end;
    if (IFL <= 1) then
      exit;

  //IF VELOCITY INTERPOLATION IS WANTED, BE SURE ENOUGH DERIVATIVE POLYNOMIALS HAVE BEEN GENERATED AND STORED.
    VFAC  := (DNA+DNA) / T[1];
    VC[2] := TWOT + TWOT;
    if(NV < NCF) then
      for i := NV to pred(NCF) do
        VC[i] := TWOT * VC[i-1] + PC[i-1] + PC[i-1] - VC[i-2];

  //INTERPOLATE TO GET VELOCITY FOR EACH COMPONENT
    for i := 0 to pred(NCM) do
      begin
        PV[NCM + i] := 0.0;

        {$IfDef FPC}
        for j := NCF-1 downto 0 do
          begin
            //PV[NCM + i] += VC[j] * PDouble(PByte(BUF) + (L*NCM*NCF + i*NCF + j) * SizeOf(Double))^;

            Ptr := PDouble(PByte(BUF) + (L*NCM*NCF + i*NCF + j) * SizeOf(Double));
            PV[NCM + i] += VC[j] * Ptr^;
          end;

        PV[NCM + i] *= VFAC;
        {$Else}
        for j := NCF-1 downto 0 do
          begin
            //PV[NCM + i] := PV[NCM + i] + VC[j] * PDouble(PByte(BUF) + (L*NCM*NCF + i*NCF + j) * SizeOf(Double))^;

            Ptr := PDouble(PByte(BUF) + (L*NCM*NCF + i*NCF + j) * SizeOf(Double));
            PV[NCM + i] := PV[NCM + i] + VC[j] * Ptr^;
          end;

        PV[NCM + i] := PV[NCM + i] * VFAC;
        {$EndIf}
      end;
  end;

function  STATE(const ET: TRealVektor2; const LIST: TIntVektor14; var PV: TRealMatrix13_6; var PNUT: TRealVektor6): integer;
  var
    i, j, NR: integer;
    S,AUFAC: Real;
    T: TRealVektor2;
    PJD: TRealVektor4;
    tmp1,tmp2: Real;
    //BUF: Array of Real;          //************************************************//
    BUF: Array[0..1499] of Double; //!!! *** It must be Double no matter what *** !!!//
    Ptr: PDouble;                  //************************************************//

  begin
    if (ET[0] = 0.0) then
      exit(PLERR_OUTOFRANGE);

    S := ET[0] - 0.5;

    SPLIT(S, PJD[0], PJD[1]);
    SPLIT(ET[1], PJD[2], PJD[3]);

    {$IfDef FPC}
    PJD[0] += PJD[2] + 0.5;
    PJD[1] += PJD[3];

    SPLIT(PJD[1], PJD[2], PJD[3]);

    PJD[0] += PJD[2];
    {$Else}
    PJD[0] := PJD[0] + PJD[2] + 0.5;
    PJD[1] := PJD[1] + PJD[3];

    SPLIT(PJD[1], PJD[2], PJD[3]);

    PJD[0] := PJD[0] + PJD[2];
    {$EndIf}

  //ERROR RETURN FOR EPOCH OUT OF RANGE
    if ((PJD[0]+PJD[3]) < SS[0]) or ((PJD[0]+PJD[3]) > SS[1]) then
      exit (PLERR_OUTOFRANGE);

  //CALCULATE RECORD # AND RELATIVE TIME IN INTERVAL
    NR := trunc((PJD[0]-SS[0])/SS[2]) + 3;
    if (PJD[0] = SS[1]) then
      Dec(NR);

    tmp1 := (NR-3) * SS[2] + SS[0];
    tmp2 := PJD[0] - tmp1;
    T[0] := (tmp2 + PJD[3]) / SS[2];

    //READ CORRECT RECORD IF NOT IN CORE
    Seek(NRFILE, (NR-1)*IRECSZ);
    BlockRead(NRFILE, BUF, NCOEFFS*sizeof(double));

    if (KM) then
      begin
        T[1] := SS[2] * 86400.0;
        AUFAC := 1.0;
      end

    else
      begin
        T[1]  := SS[2];
        AUFAC := 1.0 / plAU;
       end;

  //INTERPOLATE SSBARY SUN
    Ptr := PDouble(PByte(@BUF) + (IPT[10][0]-1) * SizeOf(Double));
    INTERP(Ptr, T, IPT[10][1], 3, IPT[10][2], 2, PVSUN);
    for i := 0 to 5 do
      PVSUN[i] := PVSUN[i] * AUFAC;

  //CHECK AND INTERPOLATE WHICHEVER BODIES ARE REQUESTED
    for i := 0 to 9 do
      begin
        if (LIST[i] = 0) then
          continue;

        Ptr := PDouble(PByte(@BUF) + (IPT[i][0]-1) * SizeOf(Double));
        INTERP(Ptr, T, IPT[i][1], 3, IPT[i][2], LIST[i], PV[i]);

        for j := 0 to 5 do
          PV[i][j] := PV[i][j] * AUFAC;

        if (i < 9) and not (BARY) then
          for j := 0 to 5 do
            PV[i][j] := PV[i][j] - PVSUN[j];
     end;

  //DO NUTATIONS IF REQUESTED (AND IF ON FILE)
    if (LIST[10] > 0) and (IPT[11][1] > 0) then
      begin
        Ptr := PDouble(PByte(@BUF) + (IPT[11][0]-1) * SizeOf(Double));
        INTERP(Ptr , T, IPT[11][1], 2, IPT[11][2], LIST[10], PNUT);
      end;

  //GET LIBRATIONS IF REQUESTED (AND IF ON FILE)
    if (LIST[11] > 0) and (IPT[12][1] > 0) then
      begin
        Ptr := PDouble(PByte(@BUF) + (IPT[12][0]-1) * SizeOf(Double));
        INTERP(Ptr, T, IPT[12][1], 3, IPT[12][2], LIST[11], PV[10]);
      end;

  //GET TT-TDB OR TCG-TCB OR LUNAR EULER ANGEL RATES IF REQUESTED (AND IF ON FILE)
    if (LIST[12] > 0) and (IPT[13][1] > 0) then
      begin
        Ptr := PDouble(PByte(@BUF) + (IPT[13][0]-1) * SizeOf(Double));
        INTERP(Ptr, T, IPT[13][1], 3, IPT[13][2], LIST[12], PV[11]);
      end;
  //GET JPL TT-TDB IF REQUESTED (AND IF ON FILE)
    if (LIST[13] > 0) and (IPT[14][1] > 0) then
      begin
        Ptr := PDouble(PByte(@BUF) + (IPT[14][0]-1) * SizeOf(Double));
        INTERP(Ptr, T, IPT[14][1],3,IPT[14][2],LIST[13],PV[12]);
      end;

    Result := 1;
  end;

//IMPLICIT double PRECISION (A-H,O-Z)
function  plEph(const deSOL: integer; const ET1, ET2: Real; const NTARG, NCENT: integer; var RRD: TRealVektor6): integer;
  var
    i,j,r,K: Integer;
    LIST: TIntVektor14;
    ET: TRealVektor2;
    PV: TRealMatrix13_6;
  begin

    if (NTARG = NCENT) then
      exit(PLERR_WRONGCENTER);

    i := CheckBinaryFileHeader(deSOL, ET1 + ET2);  //broken!
    if (i < 1) then
      exit(i);

    for i := 0 to 5 do
      RRD[i] := 0;

    for i := 0 to 13 do
      LIST[i] := 0;

    ET[0] := ET1;
    ET[1] := ET2;

    for i := 0 to 12 do
      for j := 0 to 5 do
        PV[i][j] := 0;

  //CHECK FOR NUTATION CALL
    if(NTARG = 14) then
      begin
        if(IPT[11][1] > 0) then
          begin
           LIST[10] := 2;
           r := STATE(ET, LIST, PV, RRD);

           if(r <= -10000) then
             exit(r);

           exit(1);
          end
        else
        exit(PLERR_NONUTATIONS);
      end;

  //CHECK FOR LIBRATIONS
    if (NTARG = 15) then
      begin
        if(IPT[12][1] > 0) then
          begin
            LIST[11] := 2;

            r := STATE(ET, LIST, PV, RRD);
            if(r <=-10000) then
              exit(r);

            for i :=0 to 5 do
              RRD[i] := PV [10][i];

            exit(1);
          end
      else
        exit(PLERR_NOLIBRATIONS);
     end;

    //CHECK FOR TT-TDB OR TCG-TCB OR LUNAR EULER ANGEL RATES (JPL)
    if ((deSOL>100) and (NTARG = 16)) or ((deSOL < 100) and (NTARG = 17)) then
      begin
        if(IPT[13][1] > 0) then
          begin
            LIST[12] := 2;

            STATE(ET, LIST, PV, RRD);

            for i := 0 to 5 do
              RRD[i] := PV[11][i];

            exit(1);
          end
        else
          if (deSOL<100) then
            exit(PLERR_NOTTMTDB)
          else
            exit(PLERR_NOLUNARANGLES);
      end;

    //CHECK FOR TT-TDB (JPL)
    if (deSOL > 100) and (NTARG = 17) then
      begin
        if(IPT[14][1] > 0) then
          begin
            LIST[13] := 2;

            STATE(ET, LIST, PV, RRD);

            for i := 0 to 5 do
              RRD[i] := PV[11][i];

            exit(1);
          end
        else
        exit(PLERR_NOTTMTDB);
    end;

    //SET UP PROPER ENTRIES IN 'LIST' ARRAY FOR STATE CALL
    for i := 0 to 1 do
      begin
        if (i = 0) then
          K := NTARG - 1
        else
          K := NCENT - 1;

        if (K = 2) then
          LIST[9] := 2;

        if (K <= 9) then
          LIST[K] := 2;

        if(K = 9) or (K = 12) then
          LIST[2] := 2;
      end;

    r := STATE(ET, LIST, PV, RRD);
    if (r <=-10000) then
      exit(r);

    if (NTARG = 11) or (NCENT = 11) then
      for i := 0 to 5 do
        PV[10][i] := PVSUN[i];

    if (NTARG = 12) or (NCENT = 12) then
      for i := 0 to 5 do
        PV[11][i] := 0.0;

    if (NTARG = 13) or (NCENT = 13) then
      for i := 0 to 5 do
        PV[12][i] := PV[2][i];

    if (NTARG * NCENT = 30) and (NTARG + NCENT = 13) then
      for i := 0 to 5 do
        PV[2][i] := 0.0
    else
      begin
        if(LIST[2] = 2) then
          for i := 0 to 5 do
            PV[2][i] := PV[2][i] - PV[9][i] / (1.0 + EMRAT);

        if (LIST[9] = 2) then
          for i := 0 to 5 do
            PV[9][i] := PV[2][i] + PV[9][i];
      end;

    for i := 0 to 5 do
      RRD[i] := PV[NTARG-1][i] - PV[NCENT - 1][i];

    Result := 1;
  end;

function  jplEph(const deSOL: integer; const ET1, ET2: Real; const NTARG, NCENT, NVAL: integer): Real;
  begin
    if (NVAL < 0) or (NVAL > 6) then
      exit(0.0);

    if (ET1 <> plET1) or (ET2 <> plET2) or (deSOL <> plSOL) or (NTARG <> plARG) or (NCENT <> plCEN) then
       begin
         plET1 := ET1;
         plET1 := ET2;
         plSOL := deSOL;
         plARG := NTARG;
         plCEN := NCENT;

         plEph(deSOL, ET1, ET2, NTARG, NCENT, plResult);
       end;

    Result := plResult[NVAL-1];
  end;

function ephObliquity(const Version, Frame: integer; tt1, tt2: Real): Real;
  var
    obl,dpsi,deps: Real;
  begin
    if (Frame = FR_J2000) or (Frame < FR_CIRS) then
      begin
        tt1 := DJ00;
        tt2 := 0.0;
      end;

    if (Version >= 423) then
      obl := iauObl06(tt1, tt2)
    else
       obl := iauObl80(tt1,tt2);

    if ((Frame <= FR_J2000) and (Frame >= FR_CIRS)) or (Frame >= FR_TOD) then
      begin
        if  (Version >= 423) then
          iauNut06a(tt1, tt2, dpsi, deps)
        else
          if ((Version > 7) and (Version < 100)) or (Version > 400) then
            iauNut00a(tt1, tt2, dpsi, deps)
        else
          iauNut80(tt1, tt2, dpsi, deps);

        {$IfDef FPC}
        obl += deps;
        {$Else}
        obl := obl + deps;
        {$EndIf}
      end;

    if ((Version > 7) and (Version < 100)) or ((Version > 400) and (Version < 423)) then
      begin
        iauPr00(tt1, tt2, dpsi, deps);

        {$IfDef FPC}
        obl += deps;
        {$Else}
        obl := obl + deps;
        {$EndIf}
      end;

    Result := obl;
  end;

// Astronomical Almanac 2013
// e = Earth heliocentric, q = Body heliocentric, p = Body geocentric
function  rLightDeflectionAA(var e, p: TRealVektor3): Real;
  var
    k: Real;
    q: TRealVektor3;
    pr, er, qr: Real;
    pdq, edp, qde: Real;
    pn, en, qn: TRealVektor3;
    //p1, e1, q1: TRealVektor3;
  begin
    iauPpp(p, e, q);
    iauPn(p, pr, pn);
    iauPn(e, er, en);
    iauPn(q, qr, qn);

    pdq := iauPdp(pn, qn);
    edp := iauPdp(en, pn);
    qde := iauPdp(qn, en);

    k := 0.01720209895; // Gauss

    {$IfDef FPC}
    k *= 2.0 * k / (DC * DC * er);
    k /= (1.0 + qde);
    k *= iauPm(pn);
    {$Else}
    k := k * 2.0 * k / (DC * DC * er);
    k := k / (1.0 + qde);
    k := k * iauPm(pn);
    {$EndIf}

    iauSxp(pdq, en, en);
    iauSxp(edp, qn, qn);

    iauPmp(en, qn, pn);
    iauSxp(k, pn, pn);

    iauPpp(p, pn, p);

    {
    k = SRS / er;

    iauSxp(k * pdq / (1.0 + qde), en, e1);
    iauSxp(k * edp / (1.0 + qde), qn, q1);
    iauPmp(e1, q1, p1);

    iauPpp(pn, p1, p); iauSxp(pr, p, p);
    }

    //iauPpp(en, e1, e); iauSxp(er, e, e);
    //iauPpp(qn, q1, q); iauSxp(qr, q, q);

    Result := er;
  end;

function  rLightDeflection(var e, p: TRealVektor3): Real;
  var
    w, er, qr, pr, qdqpe: Real;
    q, en, qn, pn, eq, qpe, peq: TRealVektor3;
  begin
    iauPpp(p, e, q);
    iauPn(e, er, en);
    iauPn(q, qr, qn);
    iauPn(p, pr, pn);

    {q . (q + e) }
    iauPpp(qn, en, qpe);
    qdqpe := iauPdp(qn, qpe);

    w := SRS / er / gmax(qdqpe, 1e-9);

    iauPxp(en, qn, eq);
    iauPxp(pn, eq, peq);

    p[0] := pr * (pn[0] + w * peq[0]);
    p[1] := pr * (pn[1] + w * peq[1]);
    p[2] := pr * (pn[2] + w * peq[2]);

    Result := er;
  end;

procedure rAnnualAberrationAA(var evb, p: TRealVektor3);
  var
    ev, np: TRealVektor3;
    r, v, B1, w1, w2, pdv: Real;
  begin
    iauPn(p, &r, np);
    iauSxp(AULT / DAYSEC, evb, ev);

    v := iauPm(ev);
    B1 := SQRT(1.0 - v * v);
    //B1 := SQRT(1.0 - SQRT(ev[0]*ev[0] + ev[1]*ev[1] + ev[2]*ev[2]));

    pdv := iauPdp(np, ev);
    w2 := 1.0 + pdv;
    w1 := w2 / (1.0 + B1);

    p[0] := r * (B1 * np[0] + w1 * ev[0]) / w2;
    p[1] := r * (B1 * np[1] + w1 * ev[1]) / w2;
    p[2] := r * (B1 * np[2] + w1 * ev[2]) / w2;

    //iauSxp(B1, np, np);
    //iauSxp(w1, ev, ev);

    //iauPpp(np, ev, np);
    //iauSxp(r/w2, pv, p);
  end;

procedure rAnnualAberration(const er: Real; var evb, p: TRealVektor3);
  var
    ev, np:TRealVektor3;
    r, lz, w1, w2, pdv: Real;
  begin
    r := sqrt(p[0]*p[0] + p[1]*p[1] + p[2]*p[2]);

    np[0] := p[0] / r;
    np[1] := p[1] / r;
    np[2] := p[2] / r;

    ev[0] := evb[0] * AULT / DAYSEC;
    ev[1] := evb[1] * AULT / DAYSEC;
    ev[2] := evb[2] * AULT / DAYSEC;

    lz := SQRT(1.0 - (ev[0]*ev[0] + ev[1]*ev[1] + ev[2]*ev[2]));
    pdv := np[0] * ev[0] + np[1] * ev[1] + np[2] * ev[2];

    w1 := 1.0 + pdv / (1.0 + lz);
    w2 := SRS / er;

    p[0] := r * (np[0] * lz + w1 * ev[0] + w2 * (ev[0] - pdv * np[0]));
    p[1] := r * (np[1] * lz + w1 * ev[1] + w2 * (ev[1] - pdv * np[1]));
    p[2] := r * (np[2] * lz + w1 * ev[2] + w2 * (ev[2] - pdv * np[2]));
  end;

procedure rPolarMotion(const xp, yp, sp, longitude: Real; var p: TRealVektor3);
  var
    xpl, ypl, xpm, ypm, zpm, sinL, cosL, tioL: Real;
  begin

    tioL := longitude + sp;
    sinL := sin(tioL);
    cosL := cos(tioL);

    xpl := xp * cosL - yp * sinL;
    ypl := xp * sinL + yp * cosL;

    zpm := p[2] - xpl * p[0] + ypl * p[1];
    xpm := p[0] + xpl * p[2];
    ypm := p[1] - xpl * p[2];

    p[0] := xpm;
    p[1] := ypm;
    p[2] := zpm;
  end;

procedure rDiurnalParallax(const obpv: TRealMatrix2_3; var p: TRealVektor3);
  begin
    {$IfDef FPC}
    p[0] -= obpv[0][0];
    p[1] -= obpv[0][1];
    p[2] -= obpv[0][2];
    {$Else}
    p[0] := p[0] - obpv[0][0];
    p[1] := p[1] - obpv[0][1];
    p[2] := p[2] - obpv[0][2];
    {$EndIf}
  end;

procedure rDiurnalParallaxAA(const er, sp, era: Real; lon, lat: Real; var obpv: TRealMatrix2_3; var p: TRealVektor3);
  var
    ra,dc,ha,rp,dp,rt,ot: Real;
   // ob: TRealvektor3;
  begin
    iauC2s(p, ra, dc);

    ha := era + sp + lon - ra;
    {$IfDef FPC}
    ot := iauPm(obpv[0]);
    {$Else}
    ot := iauPm(TRealvektor3(obpv[0]));
    {$EndIf}

    //iauZp(ob);
    iauC2s(p, lon, lat);// I tryed to fix that, since it would only set lon and at to 0 when ob would be used

    rt := er - ot * (COS(lat)*COS(ha)*COS(dc) + SIN(lat)*SIN(dc));
    dp := dc + ot * (COS(lat)*COS(ha)*SIN(dc) - SIN(lat)*SIN(dc));
    rp := ra - ot * COS(lat) * COS(ha) / COS(dc);

    //iauS2c(rp, dp, p);
    //iauPn(p, rt, p);
    iauS2c(rp, dp, p);
    iauSxp(rt, p, p);
  end;

procedure rDiurnalAberrationAA(const lt: Real; var obpv: TRealMatrix2_3; var p: TRealVektor3);
  var
    t: TRealVektor3;
  begin
    {$IfDef FPC}
    iauSxp(lt, obpv[1], t);
    {$Else}
    iauSxp(lt, TRealvektor3(obpv[1]), t);
    {$EndIf}

    iauPpp(p, t, p);
  end;

procedure rDiurnalAberration(var obpv: TRealMatrix2_3; var p: TRealVektor3);
  var
    f, r, diurab: Real;
  begin
    iauPn(p, r, p);

    diurab := sqrt(obpv[1][0]*obpv[1][0] + obpv[1][1]*obpv[1][1]) / CMPS;
    f := 1.0 - diurab * p[1];

    {$IfDef FPC}
    p[0] *= f;
    p[2] *= f;
    {$Else}
    p[0] := p[0] * f;
    p[2] := p[2] * f;
    {$EndIf}
    p[1] := f * (p[1] + diurab);

    iauSxp(r, p, p);
  end;

procedure rRefraction(const refA, refB: Real; var p: TRealVektor3);
  var
    n: TRealVektor3;
    d, f, r, w, zm, tz, cosd: Real;
  const
    CELMIN: Real = 1e-6;
    SELMIN: Real = 0.05;
  begin
    iauPn(p, r, n);

    r := sqrt(n[0] * n[0] + n[1] * n[1]);

    if (r < CELMIN) then
      r := CELMIN;

    if (n[2] < SELMIN) then
      zm := SELMIN
    else
      zm := n[2];

    tz := r / zm;
    w := refB * tz * tz;

    d := (refA + w) * tz / (1.0+ (refA + 3.0*w) / (zm*zm));
    cosd := 1.0 - d * d / 2.0;
    f := cosd - d * zm / r;

    p[2] := p[2] * cosd + d * r;

    {$IfDef FPC}
    p[0] *= f;
    p[1] *= f;
    {$Else}
    p[0] := p[0] * f;
    p[1] := p[1] * f;
    {$EndIf}
  end;

procedure rEquatorialToHorizontal(const e: TRealVektor3; const lat: Real; var h: TRealVektor3);
  var
    x, y, z: Real;
    sinL, cosL: Real;
  begin

    x := e[0];
    y := e[1];
    z := e[2];

    sinL := sin(lat);
    cosL := cos(lat);

    h[0] := x * sinL - z * cosL;
    h[2] := x * cosL + z * sinL;
    h[1] := y;
  end;

procedure rHorizontalToEquatorial(const h: TRealVektor3; const lat: Real; var e: TRealVektor3);
  var
    x, y, z: Real;
    sinL, cosL: Real;
  begin
    x := h[0];
    y := h[1];
    z := h[2];

    sinL := sin(lat);
    cosL := cos(lat);

    e[0] :=  x * sinL + z * cosL;
    e[2] := -x * cosL + z * sinL;
    e[1] :=  y;
  end;

function  RawEphem(const Version, Body, Value: integer; const tdb1, tdb2: Real; var epvh, epvb, pv: TRealMAtrix2_3): integer;
  var
    l, b, r, d, obl: Real;
    p: TRealVektor3;
    rp: TRealMatrix3_3;

    i, j: byte;
    HelpVektor: TRealVektor6;

  begin
    d := 0.5;
    iauZpv(pv);

    if (Body = BN_SUN) then
      exit(1);

    if (Body = BN_SSB) then
      begin
      iauPvmpv(epvh, epvb, pv);
      exit(1);
    end;

    if(Version > 7) then
      begin
        r := plEph(Version, tdb1, tdb2, Body, 11, HelpVektor);
        if (r <= PLERR_NOFILE) then
          exit(Trunc(r));

        for i := 0 to 1 do
          for j := 0 to 2 do
            pv[i][j] := HelpVektor[i*3 + j];

        if (Version >= 100) and (Version < 200) then
          BesselianToJ2000(pv);
      end
    else
      if (Body > BN_EMB) then
        exit(PLERR_WRONGOBJECT)
    else
      if (Version = VN_PLAN94) then
        begin
          if (Body = BN_SUN) then
            exit(PLERR_WRONGOBJECT)
          else
            if (Body = BN_PLUTO) or (Body = BN_MOON) then
              exit(PLERR_WRONGVALUE)
          else
            if (Body = BN_EARTH) then
              begin
                {$IfDef FPC}
                iauCp(epvh[0], pv[0]);
                iauCp(epvh[1], pv[1]);
                {$Else}
                iauCp(TRealvektor3(epvh[0]), TRealvektor3(pv[0]));
                iauCp(TRealvektor3(epvh[1]), TRealvektor3(pv[1]));
                {$EndIf}
              end
          else
            if (Body = BN_SSB) then
              begin
                {$IfDef FPC}
                iauPmp(epvh[0], epvb[0], pv[0]);
                iauPmp(epvh[1], epvb[1], pv[1]);
                {$Else}
                iauPmp(TRealvektor3(epvh[0]), TRealvektor3(epvb[0]), TRealvektor3(pv[0]));
                iauPmp(TRealvektor3(epvh[1]), TRealvektor3(epvb[1]), TRealvektor3(pv[1]));
                {$EndIf}
              end
          else
            begin
              if (Body = BN_EMB) then
                iauPlan94(tdb1, tdb2, 3, pv)
              else
                iauPlan94(tdb1, tdb2, Body, pv);
            end;
        end
    else
      if (Body = BN_MOON) then
        begin
          EphemMoon(tdb1, tdb2, l, b, r);

          {$IfDef FPC}
          l *= DD2R;
          b *= DD2R;
          {$Else}
          l := l * DD2R;
          b := b * DD2R;
          {$EndIf}

          pv[0][2] := r * sin(b);
          pv[0][1] := r * sin(l) * cos(b);
          pv[0][0] := r * cos(l) * cos(b);

          iauPmat76(tdb1, tdb2, rp);
          iauTr(rp, rp);

          obl := ephObliquity(Version, FR_J2000, DJ00, 0.0);
          {$IfDef FPC}
          RotVX(-obl, pv[0]);

          iauRxp(rp, pv[0], pv[0]);
          iauPpp(pv[0], epvh[0], pv[0]);
          {$Else}
          RotVX(-obl, TRealvektor3(pv[0]));

          iauRxp(rp, TRealvektor3(pv[0]), TRealvektor3(pv[0]));
          iauPpp(TRealvektor3(pv[0]), TRealvektor3(epvh[0]), TRealvektor3(pv[0]));
          {$EndIf}

          if (Value > 3) and (Value < 7) then
            begin
              EphemMoon(tdb1, tdb2+d, l, b, r);

              {$IfDef FPC}
              l *= DD2R;
              b *= DD2R;
              {$Else}
              l := l * DD2R;
              b := b * DD2R;
              {$EndIf}

              pv[1][2] := r * sin(b);
              pv[1][0] := r * cos(l) * cos(b);
              pv[1][1] := r * sin(l) * cos(b);

              EphemMoon(tdb1, tdb2-d, l, b, r);

              {$IfDef FPC}
              iauRxp(rp, pv[1], pv[1]); 

              l *= DD2R;
              b *= DD2R;
              {$Else}
              iauRxp(rp, TRealvektor3(pv[1]), TRealvektor3(pv[1]));

              l := l * DD2R;
              b := b * DD2R;
              {$EndIf}

              p[2] := r * sin(b);
              p[0] := r * cos(l) * cos(b);
              p[1] := r * sin(l) * cos(b);

              iauRxp(rp, p, p);

              {$IfDef FPC}
              iauPmp(pv[1], p, pv[1]);
              iauPpp(pv[1], epvh[1], pv[1]);
              {$Else}
              iauPmp(TRealvektor3(pv[1]), p, TRealvektor3(pv[1]));
              iauPpp(TRealvektor3(pv[1]), TRealvektor3(epvh[1]), TRealvektor3(pv[1]));
              {$EndIf}
            end;
        end
    else
      if (Body = BN_PLUTO) then
        begin
          EphemPluto(tdb1, tdb2, l, b, r);

          {$IfDef FPC}
          l *= DD2R;
          b *= DD2R;
          {$Else}
          l := l * DD2R;
          b := b * DD2R;
          {$EndIf}

          pv[0][2] := r * sin(b);
          pv[0][1] := r * sin(l) * cos(b);
          pv[0][0] := r * cos(l) * cos(b);

          obl := ephObliquity(Version, FR_J2000, DJ00, 0.0);

          {$IfDef FPC}
          RotVX(-obl, pv[0]);
          {$Else}
          RotVX(-obl, TRealvektor3(pv[1]));
          {$EndIf}

          if (Value > 3) and (Value < 7) then
            begin
              EphemPluto(tdb1, tdb2+d, l, b, r);

              {$IfDef FPC}
              l *= DD2R;
              b *= DD2R;
              {$Else}
              l := l * DD2R;
              b := b * DD2R;
              {$EndIf}

              pv[1][2] := r * sin(b);
              pv[1][0] := r * cos(l) * cos(b);
              pv[1][1] := r * sin(l) * cos(b);

              EphemPluto(tdb1, tdb2-d, l, b, r);

              {$IfDef FPC}
              RotVX(-obl, pv[1]);

              l *= DD2R;
              b *= DD2R;
              {$Else}
              RotVX(-obl, TRealVektor3(pv[1]));

              l := l * DD2R;
              b := b * DD2R;
              {$EndIf}

              p[0] := (r * cos(l) * cos(b));
              p[1] := (r * sin(l) * cos(b));
              p[2] := (r * sin(b));

              RotVX(-obl, p);

              {$IfDef FPC}
              iauPmp(pv[1], p, pv[1]);
              {$Else}
              iauPmp(TRealvektor3(pv[1]), p, TRealvektor3(pv[1]));
              {$EndIf}
            end;
      end
    else
      if (Body = BN_SSB) then
        begin
          obl := ephObliquity(Version, FR_J2000, DJ00, 0.0);

          pv[0][0] := -VSOP87_all(5, 9, GV_POS_X, tdb1, tdb2);
          pv[0][1] := -VSOP87_all(5, 9, GV_POS_Y, tdb1, tdb2);
          pv[0][2] := -VSOP87_all(5, 9, GV_POS_Z, tdb1, tdb2);

          if (Value > 3) and (Value < 7) then
            begin
              pv[1][0] := VSOP87_all(5, 9, GV_POS_X, tdb1, tdb2+d);
              pv[1][1] := VSOP87_all(5, 9, GV_POS_Y, tdb1, tdb2+d);
              pv[1][2] := VSOP87_all(5, 9, GV_POS_Z, tdb1, tdb2+d);

              {$IfDef FPC}
              RotVX(-obl, pv[1]);
              {$Else}
              RotVX(-obl, TRealvektor3(pv[1]));
              {$EndIf}

              p[0] := VSOP87_all(5, 9, GV_POS_X, tdb1, tdb2-d);
              p[1] := VSOP87_all(5, 9, GV_POS_Y, tdb1, tdb2-d);
              p[2] := VSOP87_all(5, 9, GV_POS_Z, tdb1, tdb2-d);

              RotVX(-obl, p);

              {$IfDef FPC}
              iauPmp(pv[1], p, pv[1]);
              {$Else}
              iauPmp(TRealvektor3(pv[1]), p, TRealvektor3(pv[1]));
              {$EndIf}
            end;
      end
    else
      if (Body = BN_EMB) then
        begin
          obl := ephObliquity(Version, FR_J2000, DJ00, 0.0);

          pv[0][0] := VSOP87_all(1, 9, GV_POS_X, tdb1, tdb2);
          pv[0][1] := VSOP87_all(1, 9, GV_POS_Y, tdb1, tdb2);
          pv[0][2] := VSOP87_all(1, 9, GV_POS_Z, tdb1, tdb2);

          {$IfDef FPC}
          RotVX(-obl, pv[0]);
          {$Else}
          RotVX(-obl, TRealvektor3(pv[0]));
          {$EndIf}

          if (Value > 3) and (Value < 7) then
            begin
              pv[1][0] := VSOP87_all(1, 9, GV_POS_X, tdb1, tdb2+d);
              pv[1][1] := VSOP87_all(1, 9, GV_POS_Y, tdb1, tdb2+d);
              pv[1][2] := VSOP87_all(1, 9, GV_POS_Z, tdb1, tdb2+d);

              {$IfDef FPC}
              RotVX(-obl, pv[1]);
              {$Else}
              RotVX(-obl, TRealvektor3(pv[1]));
              {$EndIf}

              p[0] := VSOP87_all(1, 9, GV_POS_X, tdb1, tdb2-d);
              p[1] := VSOP87_all(1, 9, GV_POS_Y, tdb1, tdb2-d);
              p[2] := VSOP87_all(1, 9, GV_POS_Z, tdb1, tdb2-d);

              RotVX(-obl, p);

              {$IfDef FPC}
              iauPmp(pv[1], p, pv[1]);
              {$Else}
              iauPmp(TRealvektor3(pv[1]), p, TRealvektor3(pv[1]));
              {$EndIf}
            end;
        end
    else
      if (Version = 0) then
        begin
          obl := ephObliquity(Version, FR_J2000, DJ00, 0.0);

          pv[0][0] := EphemHelio0(Body, VSOP870_POS_X, tdb1, tdb2); // could be in else
          pv[0][1] := EphemHelio0(Body, VSOP870_POS_Y, tdb1, tdb2);
          pv[0][2] := EphemHelio0(Body, VSOP870_POS_Z, tdb1, tdb2);

          {$IfDef FPC}
          RotVX(-obl, pv[0]);
          {$Else}
          RotVX(-obl, TRealvektor3(pv[0]));
          {$EndIf}

          if (Value > 3) and (Value < 7) then
            begin
              pv[1][0] := EphemHelio0(Body, VSOP870_POS_X, tdb1, tdb2+d);
              pv[1][1] := EphemHelio0(Body, VSOP870_POS_Y, tdb1, tdb2+d);
              pv[1][2] := EphemHelio0(Body, VSOP870_POS_Z, tdb1, tdb2+d);

              {$IfDef FPC}
              RotVX(-obl, pv[1]);
              {$Else}
              RotVX(-obl, TRealvektor3(pv[1]));
              {$EndIf}

              p[0] := EphemHelio0(Body, VSOP870_POS_X, tdb1, tdb2-d);
              p[1] := EphemHelio0(Body, VSOP870_POS_Y, tdb1, tdb2-d);
              p[2] := EphemHelio0(Body, VSOP870_POS_Z, tdb1, tdb2-d);

              RotVX(-obl, p);

              {$IfDef FPC}
              iauPmp(pv[1], p, pv[1]);
              {$Else}
              iauPmp(TRealvektor3(pv[1]), p, TRealvektor3(pv[1]));
              {$EndIf}
            end;
        end
    else
      if (Version = 5) then
        begin
          obl := ephObliquity(Version, FR_J2000, DJ00, 0.0);

          pv[0][0] := VSOP87_all(Version,Body,GV_POS_X,tdb1,tdb2) - VSOP87_all(Version,9,GV_POS_X,tdb1,tdb2);
          pv[0][1] := VSOP87_all(Version,Body,GV_POS_Y,tdb1,tdb2) - VSOP87_all(Version,9,GV_POS_Y,tdb1,tdb2);
          pv[0][2] := VSOP87_all(Version,Body,GV_POS_Z,tdb1,tdb2) - VSOP87_all(Version,9,GV_POS_Z,tdb1,tdb2);

          {$IfDef FPC}
          RotVX(-obl, pv[0]);
          {$Else}
          RotVX(-obl, TRealvektor3(pv[0]));
          {$EndIf}

          if (Value > 3) and (Value < 7) then
            begin
              pv[1][0] := VSOP87_all(Version,Body,GV_POS_X,tdb1,tdb2+d) - VSOP87_all(Version,9,GV_POS_X,tdb1,tdb2+d);
              pv[1][1] := VSOP87_all(Version,Body,GV_POS_Y,tdb1,tdb2+d) - VSOP87_all(Version,9,GV_POS_Y,tdb1,tdb2+d);
              pv[1][2] := VSOP87_all(Version,Body,GV_POS_Z,tdb1,tdb2+d) - VSOP87_all(Version,9,GV_POS_Z,tdb1,tdb2+d);

              {$IfDef FPC}
              RotVX(-obl, pv[1]);
              {$Else}
              RotVX(-obl, TRealvektor3(pv[1]));
              {$EndIf}

              p[0] := VSOP87_all(Version,Body,GV_POS_X,tdb1,tdb2-d) - VSOP87_all(Version,9,GV_POS_X,tdb1,tdb2-d);
              p[1] := VSOP87_all(Version,Body,GV_POS_Y,tdb1,tdb2-d) - VSOP87_all(Version,9,GV_POS_Y,tdb1,tdb2-d);
              p[2] := VSOP87_all(Version,Body,GV_POS_Z,tdb1,tdb2-d) - VSOP87_all(Version,9,GV_POS_Z,tdb1,tdb2-d);

              RotVX(-obl, p);

              {$IfDef FPC}
              iauPmp(pv[1], p, pv[1]);
              {$Else}
              iauPmp(TRealvektor3(pv[1]), p, TRealvektor3(pv[1]));
              {$EndIf}
            end;
        end
    else
      if (Version = 1) or (Version = 3) then
        begin
          if (Version = 3) then
            begin
              iauPmat76(tdb1, tdb2, rp);
              iauTr(rp, rp);

              obl := ephObliquity(Version, FR_FMOD, tdb1, tdb2);
            end
          else
            obl := ephObliquity(Version, FR_J2000, DJ00, 0.0);

          pv[0][0] := VSOP87_all(Version, Body, GV_POS_X, tdb1, tdb2);
          pv[0][1] := VSOP87_all(Version, Body, GV_POS_Y, tdb1, tdb2);
          pv[0][2] := VSOP87_all(Version, Body, GV_POS_Z, tdb1, tdb2);

          {$IfDef FPC}
          RotVX(-obl, pv[0]);

          if (Version = 3) then
            iauRxp(rp, pv[0], pv[0]);
          {$Else}
          RotVX(-obl, TRealvektor3(pv[1]));
          if (Version = 3) then
            iauRxp(rp, TRealvektor3(pv[0]), TRealvektor3(pv[0]));
          {$Endif}

          if (Value > 3) and (Value < 7) then
            begin
              pv[1][0] := VSOP87_all(Version, Body ,GV_POS_X, tdb1, tdb2+d);
              pv[1][1] := VSOP87_all(Version, Body, GV_POS_Y, tdb1, tdb2+d);
              pv[1][2] := VSOP87_all(Version, Body, GV_POS_Z, tdb1, tdb2+d);

              {$IfDef FPC}
              RotVX(-obl, pv[1]);

              if (Version = 3) then
                iauRxp(rp, pv[1], pv[1]);
              {$Else}
              RotVX(-obl, TRealvektor3(pv[1]));

              if (Version = 3) then
                iauRxp(rp, TRealvektor3(pv[1]), TRealvektor3(pv[1]));
              {$Endif}

              p[0] := VSOP87_all(Version, Body, GV_POS_X, tdb1, tdb2-d);
              p[1] := VSOP87_all(Version, Body, GV_POS_Y, tdb1, tdb2-d);
              p[2] := VSOP87_all(Version, Body, GV_POS_Z, tdb1, tdb2-d);

              RotVX(-obl, p);

              if (Version = 3) then
                iauRxp(rp, p, p);

              {$IfDef FPC}
              iauPmp(pv[1], p, pv[1]);
              {$Else}
              iauPmp(TRealvektor3(pv[1]), p, TRealvektor3(pv[1]));
              {$Endif}
            end
        end
    else
      if (Version = 2) or (Version = 4) then
        begin
          if (Version = 4) then
            begin
              iauPmat76(tdb1, tdb2, rp);
              iauTr(rp, rp);

              obl := ephObliquity(Version, FR_FMOD, tdb1, tdb2);
            end
          else
            obl := ephObliquity(Version, FR_J2000, DJ00, 0.0);

          l := VSOP87_all(Version, Body, GV_LONGITUDE, tdb1, tdb2);
          b := VSOP87_all(Version, Body, GV_LATITUDE , tdb1, tdb2);
          r := VSOP87_all(Version, Body, GV_RADIUS   , tdb1, tdb2);

          pv[0][0] := r * cos(l) * cos(b);
          pv[0][1] := r * sin(l) * cos(b);
          pv[0][2] := r * sin(b);

          {$IfDef FPC}
          RotVX(-obl, pv[0]);

          if (Version = 4) then
            iauRxp(rp, pv[0], pv[0]);
          {$Else}
          RotVX(-obl, TRealvektor3(pv[0]));

          if (Version = 4) then
            iauRxp(rp, TRealvektor3(pv[0]), TRealvektor3(pv[0]));
          {$Endif}

          if (Value > 3) and (Value < 7) then
            begin
              l := VSOP87_all(Version, Body, GV_LONGITUDE, tdb1, tdb2+d);
              b := VSOP87_all(Version, Body, GV_LATITUDE , tdb1, tdb2+d);
              r := VSOP87_all(Version, Body, GV_RADIUS   , tdb1, tdb2+d);

              pv[1][0] := r * cos(l) * cos(b);
              pv[1][1] := r * sin(l) * cos(b);
              pv[1][2] := r * sin(b);

              {$IfDef FPC}
              RotVX(-obl, pv[1]);

              if (Version = 4) then
                iauRxp(rp, pv[1], pv[1]);
              {$Else}
              RotVX(-obl, TRealvektor3(pv[1]));

              if (Version = 4) then
                iauRxp(rp, TRealvektor3(pv[1]), TRealvektor3(pv[1]));
              {$Endif}

              l := VSOP87_all(Version, Body, GV_LONGITUDE, tdb1, tdb2-d);
              b := VSOP87_all(Version, Body, GV_LATITUDE , tdb1, tdb2-d);
              r := VSOP87_all(Version, Body, GV_RADIUS   , tdb1, tdb2-d);

              p[0] := r * cos(l) * cos(b);
              p[1] := r * sin(l) * cos(b);
              p[2] := r * sin(b);

              RotVX(-obl, p);

              if (Version = 4) then
                iauRxp(rp, p, p);

              {$IfDef FPC}
              iauPmp(pv[1], p, pv[1]);
              {$Else}
              iauPmp(TRealvektor3(pv[1]), p, TRealvektor3(pv[1]));
              {$Endif}
            end;
        end
    else
      exit(PLERR_WRONGOBJECT);

    Result := 1;
  end;

function  EarthEphem(const Version: integer; const tdb1, tdb2: Real; var pvh, pvb: TRealMatrix2_3): integer;
  var
    i,j: integer;
    r, obl: Real;
    rp: TRealMatrix3_3;
    Helper : TRealVektor6;
  begin
    if (Version > 7) then
      begin
        r := plEph(Version, tdb1, tdb2, 3, 11, Helper);
        if (r <= PLERR_NOFILE) then
          exit(trunc(r));

        for i := 0 to 1 do
          for j := 0 to 2 do
            pvh[i][j] := Helper[i*3 + j];

        r := plEph(Version, tdb1, tdb2, 3, 12, Helper);
        if (r <= PLERR_NOFILE) then
          exit(trunc(r));

        for i := 0 to 1 do
          for j := 0 to 2 do
            pvb[i][j] := Helper[i*3 + j];

        if (Version >= 100) and (Version < 200) then
          begin
            BesselianToJ2000(pvh);
            BesselianToJ2000(pvb);
          end;
      end
    else if (Version = 7) then
      iauEpv00(tdb1, tdb2, pvh, pvb)
    else
      begin
        if (Version = 3) or (Version = 4) then
          begin
            obl := ephObliquity(Version, FR_FMOD, tdb1, tdb2);

            iauPmat76(tdb1, tdb2, rp);
            iauTr(rp, rp);

            pvh[0][0] := VSOP87_all(3, 3, GV_POS_X, tdb1, tdb2);
            pvh[0][1] := VSOP87_all(3, 3, GV_POS_Y, tdb1, tdb2);
            pvh[0][2] := VSOP87_all(3, 3, GV_POS_Z, tdb1, tdb2);

            {$IfDef FPC}
            RotVX(-obl, pvh[0]);
            iauRxp(rp, pvh[0], pvh[0]);
            {$Else}
            RotVX(-obl, TRealvektor3(pvh[0]));
            iauRxp(rp, TRealvektor3(pvh[0]), TRealvektor3(pvh[0]));
            {$EndIf}
          end
        else
          begin
            obl := ephObliquity(Version, FR_J2000, DJ00, 0.0);

            pvh[0][0] := VSOP87_all(1, 3, GV_POS_X, tdb1, tdb2);
            pvh[0][1] := VSOP87_all(1, 3, GV_POS_Y, tdb1, tdb2);
            pvh[0][2] := VSOP87_all(1, 3, GV_POS_Z, tdb1, tdb2);

            {$IfDef FPC}
            RotVX(-obl, pvh[0]);
            {$Else}
            RotVX(-obl, TRealvektor3(pvh[0]));
            {$EndIf}
          end;

        pvb[0][0] := VSOP87_all(5, 3, GV_POS_X, tdb1, tdb2);
        pvb[0][1] := VSOP87_all(5, 3, GV_POS_Y, tdb1, tdb2);
        pvb[0][2] := VSOP87_all(5, 3, GV_POS_Z, tdb1, tdb2);

        {$IfDef FPC}
        RotVX(-obl, pvb[0]);
        {$Else}
        RotVX(-obl, TRealvektor3(pvb[0]));
        {$EndIf}

        pvb[1][0] := VSOP87_all(5, 3, GV_POS_X, tdb1, tdb2+0.5);
        pvb[1][1] := VSOP87_all(5, 3, GV_POS_Y, tdb1, tdb2+0.5);
        pvb[1][2] := VSOP87_all(5, 3, GV_POS_Z, tdb1, tdb2+0.5);

        {$IfDef FPC}
        RotVX(-obl, pvb[1]);
        {$Else}
        RotVX(-obl, TRealvektor3(pvb[1]));
        {$EndIf}

        rp[1][0] := VSOP87_all(5, 3, GV_POS_X, tdb1, tdb2-0.5);
        rp[1][1] := VSOP87_all(5, 3, GV_POS_Y, tdb1, tdb2-0.5);
        rp[1][2] := VSOP87_all(5, 3, GV_POS_Z, tdb1, tdb2-0.5);

        {$IfDef FPC}
        RotVX(-obl, rp[1]);
        iauPmp(pvb[1], rp[1], pvb[1]);
        {$Else}
        RotVX(-obl, TRealvektor3(rp[1]));
        iauPmp(TRealvektor3(pvb[1]), TRealvektor3(rp[1]), TRealvektor3(pvb[1]));
        {$EndIf}
    end;

    Result := 1;
  end;

function  FrameTransform(const Version, Frame, Body, Adjust: integer; const tt1, tt2: Real; var {eph, evb,} p: TRealVektor3): boolean;
  var
    {$IfDef FPC}
    r: boolean = false;
    {$Else}
    r: boolean;
    {$EndIf}
    rb, rp, rn, rbp, rc2i: TRealMatrix3_3;
    dpsi, deps, epsa{, er}: Real;
  begin
    {$IfNDef FPC}
    r := false;
    {$EndIf}

    if (Body = 0) and (Frame = FR_J2000) then
      exit(true)
    else
      begin
        r := ((Version >= 400) and (Frame < FR_GCRS)) or ((Version >= 100) and (Frame = FR_J2000)) or
             ((Version >= 8)   and (Frame < FR_GCRS)) or (Frame = FR_J2000);

        if (r) then
          exit(r);
      end;

    if ((Body = 0) or (Version < 7) or ((Version > 100) and (Version < 400))) and (Frame < FR_J2000) then
      begin
        if (Version >= 423) then
          iauBp06(tt1, tt2, rb, rp, rbp)
        else
          iauBp00(tt1, tt2, rb, rp, rbp);

        iauTr(rb, rb); iauRxp(rb, p, p);
      end;

    //if ((Adjust and 256) = 0) and not (Body = BN_EARTH) and not (Body = BN_MOON) and (((Frame < J2000) ans (Frame >= GCRS)) or (Frame >= MOD)) then
    //if ((Adjust and 256) = 0) and not (Body = BN_EARTH) and (((Frame < FR_J2000) and (Frame >= FR_GCRS)) or (Frame >= FR_FMOD))then
      //begin
        //er := rLightDeflectionAA(eph, p);
        //er := rLightDeflection(eph, p);
        //rAnnualAberration(er, evb, p);
        //rAnnualAberrationAA(evb, p);
      //end;

    if (Frame >= FR_J2000) then
      begin
        if (Frame = FR_J2000) then
          r := true;

        if (Version >= 423) then
          iauBp06(tt1, tt2, rb, rp, rbp)
        else
          if ((Version > 7) and (Version < 100)) or (Version > 400) then
            iauBp00(tt1, tt2, rb, rp, rbp)
        else
          iauPmat76(tt1, tt2, rp);

        if (Frame >= FR_FMOD) then
          begin
            if (Frame = FR_FMOD) then
              r := true;

            iauRxp(rp, p, p);
          end;

        if (Frame >= FR_TOD) then
          begin
            if (Frame = FR_TOD) then
              r := true;

            if (Version >= 423) then
              iauNum06a(tt1, tt2, rn{%H-})
            else
              if ((Version > 7) and (Version < 100)) or (Version > 400) then
                iauNum00a(tt1, tt2, rn)
            else
              begin
                iauNut80(tt1, tt2, dpsi, deps);

                {$IfDef FPC}
                dpsi += ddPsi;
                deps += ddEps;
                {$Else}
                dpsi := dpsi + ddPsi;
                deps := deps + ddEps;
                {$EndIf}

                epsa := iauObl80(tt1, tt2);
                iauNumat(epsa, dpsi, deps, rn);
              end;

            iauRxp(rn, p, p);
          end;
      end
    else
      if (Frame >= FR_CIRS) then
        begin
          if ((Adjust and AD_CIO_BASED) > 0) then
            begin
              if (Version >= 423) then
                iauC2i06a(tt1, tt2, rc2i)
              else
                if ((Version > 7) and (Version < 100)) or (Version > 400) then
                  iauC2i00a(tt1, tt2, rc2i)
              else
                begin
                  iauPnm80(tt1, tt2, rn);
                  iauC2ibpn(tt1, tt2, rn, rc2i);
                end;

              iauRxp(rc2i, p, p);
            end
          else
            begin
              if (Version >= 423) then
                iauBp06(tt1, tt2, rb, rp, rbp)
              else
                if ((Version > 7) and (Version < 100)) or (Version > 400) then
                  iauBp00(tt1, tt2, rb, rp, rbp)
              else
                iauPmat76(tt1, tt2, rp);

              if (Version > 7) and ((Version <= 100) or (Version >= 400)) then
                iauRxp(rbp, p, p)
              else
                iauRxp(rp, p, p);

              if (Version >= 423) then
                iauNum06a(tt1, tt2, rn)
              else
                if ((Version > 7) and (Version < 100)) or (Version > 400) then
                  iauNum00a(tt1, tt2, rn)
              else
                begin
                  iauNut80(tt1, tt2, dpsi, deps);
                  {$IfDef FPC}
                  dpsi += ddPsi;
                  deps += ddEps;
                  {$Else}
                  dpsi := dpsi + ddPsi;
                  deps := deps + ddEps;
                  {$EndIf}

                  epsa := iauObl80(tt1, tt2);
                  iauNumat(epsa, dpsi, deps, rn);
                end;

              iauRxp(rn, p, p);
            end;

        if (Frame = FR_CIRS) then
          r := true;
      end;

    Result := r;
  end;

function  FrameTransformMatrix(const Version, Frame, Body, Adjust: integer; const tt1, tt2: Real; {var eph, evb: TRealVektor3;} var tm: TRealMatrix3_3): boolean;
  var
    {$IfDef FPC}
    r: boolean = false;
    {$Else}
    r: boolean;
    {$EndIf}
    rb, rp, rn, rbp, rc2i: TRealMatrix3_3;
    dpsi, deps, epsa: Real;
  begin
    {$IfNDef FPC}
    r := false;
    {$EndIf}

    iauIr(tm);

    if (Body = 0 ) and (Frame = FR_J2000) then
      exit(true)
    else
      begin
       r := ((Version >= 400) and (Frame < FR_GCRS)) or ((Version >= 100) and (Frame = FR_J2000)) or
            ((Version >= 8)   and (Frame < FR_GCRS)) or (Frame = FR_J2000);
      if (r) then
        exit(r);
      end;

    if ((Body = 0) or (Version < 7) or ((Version > 100) and (Version < 400)) and (Frame < FR_J2000)) then
      begin
        if (Version >= 423) then
          iauBp06(tt1, tt2, rb, rp, rbp)
        else
          iauBp00(tt1, tt2, rb, rp, rbp);

        iauTr(rb, rb); iauRxr(rb, tm, tm);
      end;

    if (Frame >= FR_J2000) then
      begin
        if (Frame = FR_J2000) then
          r := true;

        if (Version >= 423) then
          iauBp06(tt1, tt2, rb, rp, rbp)
        else
          if (Version in [8..99]) or (Version > 400) then
            iauBp00(tt1, tt2, rb, rp, rbp)
        else
          iauPmat76(tt1, tt2, rp);

      if (Frame >= FR_FMOD) then
        begin
          if (Frame = FR_FMOD) then
            r := true;
          iauRxr(rp, tm, tm);
        end;

      if (Frame >= FR_TOD) then
        begin
          if (Frame = FR_TOD) then
            r := true;

          if (Version >= 423) then
            iauNum06a(tt1, tt2, rn{%H-})
          else
            if (Version in [8..99]) or (Version > 400) then
              iauNum00a(tt1, tt2, rn)
            else
              begin
                iauNut80(tt1, tt2, dpsi, deps);

                {$IfDef FPC}
                dpsi += ddPsi;
                deps += ddEps;
                {$Else}
                dpsi := dpsi + ddPsi;
                deps := deps + ddEps;
                {$EndIf}

                epsa := iauObl80(tt1, tt2);
                iauNumat(epsa, dpsi, deps, rn);
              end;

          iauRxr(rn, tm, tm);
        end;
      end
    else
     if (Frame >= FR_CIRS) then
       begin
         if ((Adjust and AD_CIO_BASED) > 0) then
           begin
             if (Version >= 423) then
               iauC2i06a(tt1, tt2, rc2i)
             else
               if (Version in [8..99]) or (Version > 400) then
                 iauC2i00a(tt1, tt2, rc2i)
             else
               begin
                 iauPnm80(tt1, tt2, rn);
                 iauC2ibpn(tt1, tt2, rn, rc2i);
               end;

             iauRxr(rc2i, tm, tm);
           end
         else
           begin
             if (Version >= 423) then
               iauBp06(tt1, tt2, rb, rp, rbp)
             else
               if ((Version > 7) and (Version < 100)) or (Version > 400) then
                 iauBp00(tt1, tt2, rb, rp, rbp)
             else
               iauPmat76(tt1, tt2, rp);

             if (Version > 7) and ((Version <= 100) or (Version >= 400)) then
               iauRxr(rbp, tm, tm)
             else
               iauRxr(rp, tm, tm);

             if (Version >= 423) then
               iauNum06a(tt1, tt2, rn)
             else
               if ((Version > 7) and (Version < 100)) or (Version > 400) then
                 iauNum00a(tt1, tt2, rn)
               else
                 begin
                   iauNut80(tt1, tt2, dpsi, deps);

                   {$IfDef FPC}
                   dpsi += ddPsi;
                   deps += ddEps;
                   {$Else}
                   dpsi := dpsi + ddPsi;
                   deps := deps + ddEps;
                   {$EndIf}

                   epsa := iauObl80(tt1, tt2);
                   iauNumat(epsa, dpsi, deps, rn);
                 end;

             iauRxr(rn, tm, tm);
           end;

         if (Frame = FR_CIRS) then
           r := true;
       end;

     Result := r;
  end;

function  BodyLightTime(const Version, Body: integer; const topo: boolean; const tdb1, tdb2: Real; var obpv, epvh, epvb: TRealMatrix2_3): Real;
  const
    muc2 = 0.000295912208232213 / sqr(DC);
  var
    n: integer;
    e, p, q: TRealMatrix2_3;
    t, rp, re , rq, rb, r: Real;
  begin
    if (Body = BN_EARTH) then
      exit(0.0);

    iauZpv(q);

    if (topo) then
      iauPvmpv(epvh, obpv, e)
    else
      iauCpv(epvh, e);

    {$IfDef FPC}
    rp := iauPm(e[0]);
    {$Else}
    rp := iauPm(TRealVektor3(e[0]));
    {$EndIf}

    re := rp;
    rb := 0.0;
    t := 0.0;
    n := 0;

    while (abs(rp - rb) > 1e-9) do
      begin
        Inc(n);
        rb := rp;

        if (n = 10) then
          break;

        if (Body = BN_SUN) then
          begin
            t := rp / DC;

            if (Version > 7) then
              begin
                EarthEphem(Version, tdb1, tdb2-t, e, p);

                if (topo) then
                  iauPvmpv(e, obpv, e);

                {$IfDef FPC}
                rp := iauPm(e[0]);
                {$Else}
                rb := iauPm(TRealVektor3(e[0]));
                {$EndIf}
              end;
          end
        else
          begin
            r := RawEphem(Version, Body, 0, tdb1, tdb2-t, epvh, epvb, q);

            if ( r <= PLERR_NOFILE) then
              exit(r);

            iauPvmpv(q, e, p);

            {$IfDef FPC}
            rp := iauPm(p[0]);
            rq := iauPm(q[0]);
            {$Else}
            rp := iauPm(TRealVektor3(p[0]));
            rq := iauPm(TRealVektor3(q[0]));
            {$EndIf}

            t := (rp + 2.0*muc2 * ln((rp + re + rq) / (rp - re + rq))) / DC;
          end;

        if (Version < 8) then
          break;
      end;

    Result := t;
  end;

function AstrometricLightTime(const Version, Body: integer; const topo: boolean; const tdb1, tdb2, Lon, Lat, hm, xp, yp, sp, era: Real): Real;
  var
    tm: TRealMatrix3_3;
    obpv, epvh, epvb: TRealMatrix2_3;
  begin
    if (Body = BN_EARTH) then
      exit(0.0);

    EarthEphem(Version, tdb1, tdb2, epvh, epvb);

    if (topo) then
      begin
        iauPvtob(Lon, Lat, hm, xp, yp, sp, era, obpv);

        {$IfDef FPC}
        obpv[0][0] /= DAU;
        obpv[0][1] /= DAU;
        obpv[0][2] /= DAU;
        {$Else}
        obpv[0][0] := obpv[0][0] / DAU;
        obpv[0][1] := obpv[0][1] / DAU;
        obpv[0][2] := obpv[0][2] / DAU;
        {$EndIf}

        if (Version >= 423) then
          BPNMatrix(2006, tdb1, tdb2, tm);

        if (Version >= 400) then
          BPNMatrix(2000, tdb1, tdb2, tm)
        else
          BPNMatrix(1900, tdb1, tdb2, tm);

        iauTr(tm ,tm);

        {$IfDef FPC}
        iauRxp(tm, obpv[0], obpv[0]);
        {$Else}
        iauRxp(tm, TRealVektor3(obpv[0]), TRealVektor3(obpv[0]));
        {$EndIf}
      end;

    Result := BodyLightTime(Version, Body, topo, tdb1, tdb2, obpv, epvh, epvb);
  end;

function  Ephem(const Version, Frame, Body, Value: integer; Adjust: integer; const utc1: Real; utc2, Lon, Lat: Real; const TZ: Real; xp, yp, dut1: Real; const hm, ra, rb: Real): Real;
  var
    topo: boolean;
    i, j: integer;
    r, lt, sp, era, obl: Real;
    tm, dtm: TRealMatrix3_3;
    //DOUBLE l,b,r,lt,sp,era,obl;
    epvh, epvb: TRealMatrix2_3;
    tai1,tai2,tdb1,tdb2,tt1,tt2: Real;
    pv, tmp, obpv: TRealMatrix2_3;
  begin

    if (Version = 6) then
      exit(PLERR_NOFILE);
    if not (Value in [1 ..21]) then
      exit(PLERR_WRONGVALUE);
    if (Body = BN_TDB) and (Value > 1) then
      exit(PLERR_WRONGVALUE);
    if (Body = BN_TCB) and (Value > 1) then
      exit(PLERR_WRONGVALUE);
    if (Body = BN_TCB) and (Version < 8) then
      exit(PLERR_WRONGVALUE);
    if (Frame < FR_ICRS) or (Frame > FR_OBS) then
      exit(PLERR_WRONGFRAME);
    if (Body < BN_MERCURY) or (Body > BN_TCB) then
      exit(PLERR_WRONGOBJECT);
    if (Frame > FR_OBSD) and (Frame < FR_J2000) then
      exit(PLERR_WRONGFRAME);
    if (Body = BN_NUTATIONS) and (Value > 4) then
      exit(PLERR_WRONGVALUE);
    if (Body = BN_LIBRATIONS) and (Value > 6) then
      exit(PLERR_WRONGVALUE);
    if (Body = BN_EARTH) and (Value > GV_RADIUS) then
      exit(PLERR_WRONGVALUE);
    if (Body = BN_NUTATIONS) and (Version < 8) then
      exit(PLERR_NONUTATIONS);
    if (Body = BN_LIBRATIONS) and (Version < 8) then
      exit(PLERR_NOLIBRATIONS);

    if (Body = BN_SUN) then
      if (Value < GV_LONGITUDE) then
        exit(0.0)
      else
        if (Value < GV_EARTHLONGITUDE) or (Value = GV_ELONGATION) then
          exit(PLERR_WRONGVALUE);

    if (Value >= GV_PASSAGE) then
      exit (Passage(Version, Frame, Body, Value, utc1, utc2, Lon, Lat, TZ, 0.0, 0.0));

    //if (Value >= PASSAGE) then
    //  exit(Passage(Version, Frame, Body, Value, utc1, utc2, Lon, Lat, TZ, xp, yp, dut1, hm, ra, rb));

    lt := 0.0;

    {$IfDef FPC}
    utc2 -= (TZ / 24.0);
    dut1 /= 86400;
    xp *= DAS2R;
    yp *= DAS2R;
    Lon *= DD2R;
    Lat *= DD2R;
    {$Else}
    utc2 := utc2 - (TZ / 24.0);
    dut1 := dut1 / 86400;
    xp := xp * DAS2R;
    yp := yp * DAS2R;
    Lon := Lon * DD2R;
    Lat := Lat * DD2R;
    {$EndIf}

    iauZpv(pv);
    iauZpv(obpv);
    iauZpv(epvh);
    iauZpv(epvb);
    topo := ((Adjust and AD_GEOCENTRIC) = 0) and (Value >= GV_EARTHLONGITUDE);
    //if (Frame < TOPO) or ((Frame >= J2000) and (Frame < TOP)) then
      //Adjust := Adjust or GEOCENTRIC;

    // Calculate Time Scales
    if ((Adjust and 8) = 0) or (Body = BN_TDB) then
      begin
        if (UtcToTai(utc1, utc2, tai1, tai2) < 0) then
          exit(PLERR_WRONGDATE);

        iauTaitt(tai1, tai2, tt1, tt2);
        Tt2Tdb(tt1, tt2, tdb1, tdb2);
      end
    else
      begin
        Tt2Tdb(utc1, utc2, tai1, tai2);
        tt1  := utc1 - (tai1-utc1);
        tt2  := utc2 - (tai2 - utc2);
        tai1 := utc1;
        tai2 := utc2;
        tdb1 := utc1;
        tdb2 := utc2;
      end;

    if (Version < 8) and (Body = BN_TDB) then
      exit((tt1 - tdb1) + (tt2 - tdb2));

    // Calculate additional values for terrestrial, topographic and observed frames
    sp := iauSp00(tt1, tt2);

    if ((Adjust and AD_CIO_BASED) > 0) then
      era := iauEra00(utc1, utc2+dut1)
    else
      if (Version >= 423) then
        era := iauGst06a(utc1, utc2+dut1, tt1, tt2)
    else
      if ((Version > 7) and (Version < 100)) or (Version > 400) then
        era := iauGst00a(utc1, utc2+dut1, tt1, tt2)
    else
      begin
        era := iauGmst82(utc1, utc2+dut1) + iauEqeq94(tdb1, tdb2) + ddPsi * cos(iauObl80(tt1, tt2));
        sp := 0.0;
      end;

    iauPvtob(Lon, Lat, hm, xp, yp, sp, era, obpv);

    {$IfDef FPC}
    obpv[0][0] /= DAU;
    obpv[0][1] /= DAU;
    obpv[0][2] /= DAU;
    {$Else}
    obpv[0][0] := obpv[0][0] / DAU;
    obpv[0][1] := obpv[0][1] / DAU;
    obpv[0][2] := obpv[0][2] / DAU;
    {$EndIf}

    // Adjust for Light Time
    r := EarthEphem(Version, tdb1, tdb2, epvh, epvb);
    if (r <= PLERR_NOFILE) then
      exit(r);
    if ((Adjust and AD_LIGHTTIME) > 0) and (Body < BN_NUTATIONS) then  // and ((Value < LONGITUDE) or (Value > RADIUS ))
      begin
        if (topo) then
          begin
            if (Frame < FR_J2000) then
              BPNMatrix(2000, tt1, tt2, tm)
            else
              BPNMatrix(1900, tdb1, tdb2, tm);

            iauTr(tm ,tm);

            {$IfDef FPC}
            iauRxp(tm, obpv[0], tmp[0]);
            {$Else}
            iauRxp(tm, TRealVektor3(obpv[0]), TRealVektor3(tmp[0]));
            {$EndIf}
          end;

        lt := BodyLightTime(Version, Body, topo, tdb1, tdb2, tmp, epvh, epvb);

        EarthEphem(Version, tdb1, tdb2-lt, epvh, epvb);

        if (lt <= PLERR_NOFILE) then
          exit(lt);
      end;

    // Get Planetary Ephemerides and return its value if it don't require any further transformation
    r := RawEphem(Version, Body, Value, tdb1, tdb2-lt, epvh, epvb, pv);
    if (r <= PLERR_NOFILE) then //To fix
      exit(r);

    if (Body >= BN_NUTATIONS) then
      exit(pv[(Value - 1) div 3][(Value - 1) mod 3]);

    if (Frame = FR_BCRS) then
      begin
        iauPvmpv(epvh, epvb, tmp);
        iauPvmpv(pv, tmp, pv);

        if (Value = GV_ELONGATION) then
          iauPvmpv(epvh, tmp, epvh);
      end;

    // Return the required value
    if (Value < GV_EARTHLONGITUDE) then
      begin
        if (Value >= GV_VEL_X) and (Value <=  GV_VEL_Z) then
          begin
            obl := ephObliquity(Version, Frame, DJ00, 0.0);

            FrameTransformMatrix(Version, Frame, Body, Adjust, tt1, tt2+0.5, {epvh[0], epvb[1],} dtm);
            iauRx(obl, dtm);
            FrameTransformMatrix(Version, Frame, Body, Adjust, tt1, tt2-0.5, {epvh[0], epvb[1],} tm);
            iauRx(obl, tm);

            for i := 0 to 2 do
              for j := 0 to 2 do
                {$IfDef FPC}
                dtm[i][j] -= tm[i][j];
                {$Else}
                dtm[i][j] := dtm[i][j] - tm[i][j];
                {$EndIf}

            FrameTransformMatrix(Version, Frame, Body, Adjust, tt1, tt2, {epvh[0], epvb[1],} tm);
            iauRx(obl, tm);

            {$IfDef FPC}
            iauRxp(tm, pv[1], pv[1]);
            iauRxp(dtm, pv[0], pv[0]);
            iauPpp(pv[0], pv[1], pv[1]);
            {$Else}
            iauRxp(tm, TRealVektor3(pv[1]), TRealVektor3(pv[1]));
            iauRxp(TRealMatrix3_3(dtm), TRealVektor3(pv[0]), TRealVektor3(pv[0]));
            iauPpp(TRealVektor3(pv[0]), TRealVektor3(pv[1]), TRealVektor3(pv[1]));
            {$EndIf}

            exit(pv[1][Value-GV_VEL_X]);
          end;

        obl := ephObliquity(Version, Frame, tt1, tt2);

        {$IfDef FPC}
        FrameTransform(Version, Frame, Body, Adjust or 256, tt1, tt2, {epvh[0], epvb[1],} pv[0]);
        RotVX(obl, pv[0]);
        {$Else}
        FrameTransform(Version, Frame, Body, Adjust or 256, tt1, tt2, {epvh[0], epvb[1],} TRealVektor3(pv[0]));
        RotVX(obl, TRealVektor3(pv[0]));
        {$EndIf}

        if (Value <  GV_LONGITUDE) then
          exit (pv[(Value - 1) div 3][(Value - 1) mod 3])
        else
          if (Value = GV_LONGITUDE) then
            exit(RangeTo(DR2D * arctan2(pv[0][1],pv[0][0]), 360.0))
        else
          if (Value = GV_LATITUDE) then
            exit(DR2D*arctan2(pv[0][2], sqrt(pv[0][0] * pv[0][0] + pv[0][1] * pv[0][1])))
        else
          if (Value = GV_RADIUS) then
            exit(sqrt(pv[0][0] * pv[0][0] + pv[0][1] * pv[0][1] + pv[0][2] * pv[0][2]));
      end
    else
      begin
        {$IfDef FPC}
        iauPmp(pv[0], epvh[0], pv[0]);
        if (Value = GV_ELONGATION) then
          begin
            Adjust := Adjust or 256;
            iauSxp(-1.0, epvh[0], epvh[0]);
            FrameTransform(Version, Frame, Body, Adjust, tt1, tt2, {epvh[0], epvb[1],} epvh[0]);
          end;

        FrameTransform(Version, Frame, Body, Adjust, tt1, tt2, {epvh[0], epvb[1],} pv[0]);
        {$Else}
        iauPmp(TRealVektor3(pv[0]), TRealVektor3(epvh[0]), TRealVektor3(pv[0]));
        if (Value = GV_ELONGATION) then
          begin
            Adjust := Adjust or 256;
            iauSxp(-1.0, TRealVektor3(epvh[0]), TRealVektor3(epvh[0]));
            FrameTransform(Version, Frame, Body, Adjust, tt1, tt2, {epvh[0], epvb[1],} TRealVektor3(epvh[0]));
          end;

        FrameTransform(Version, Frame, Body, Adjust, tt1, tt2, {epvh[0], epvb[1],} TRealVektor3(pv[0]));
        {$EndIf}

       //if (Value = ELONGATION) then
         //if (Frame < J2000) then
           //Frame := CIRS;
         // else
           //Frame :=  TOD;

        if (Frame >= FR_TEF) or ((Frame < FR_J2000) and (Frame >= FR_ITRS)) then
          begin
            //h := r - (era + lon + sp);

            {$IfDef FPC}
            RotVZ((era + Lon + sp), pv[0]);
            RotVZ((era + Lon + sp), obpv[0]);
            rPolarMotion(xp, yp, sp, Lon, pv[0]);

            if (Value = GV_ELONGATION) then
              begin
                RotVZ((era + Lon + sp), epvh[0]);
                rPolarMotion(xp, yp, sp, Lon, epvh[0]);
              end;

            {$Else}
            RotVZ((era + Lon + sp), TRealVektor3(pv[0]));
            RotVZ((era + Lon + sp), TRealVektor3(obpv[0]));
            rPolarMotion(xp, yp, sp, Lon, TRealVektor3(pv[0]));

            if (Value = GV_ELONGATION) then
              begin
                RotVZ((era + Lon + sp), TRealVektor3(epvh[0]));
                rPolarMotion(xp, yp, sp, Lon, TRealVektor3(epvh[0]));
              end;
            {$EndIf}

            //iauPom00(xp, yp, sp, tm);
            //iauRxp(tm, pv, pv);

            if (Frame >= FR_TOP) or ((Frame < FR_J2000) and (Frame >= FR_TOPO))  then
              begin
                {$IfDef FPC}
                if (topo) then
                  rDiurnalParallax(obpv, pv[0]);

                if topo and (Value = GV_ELONGATION) then
                  rDiurnalParallax(obpv, epvh[0]);

                // rDiurnalAberration(obpv, pv[0]);

                if (Frame >= FR_OBS) or ((Frame < FR_J2000) and (Frame >= FR_OBSD)) then
                  begin
                    rEquatorialToHorizontal(pv[0], Lat, pv[0]);
                    rRefraction(ra, rb, pv[0]);

                    if (Value < GV_ELEVATION) then
                      rHorizontalToEquatorial(pv[0], Lat, pv[0])
                    else
                      if (Value = GV_ELONGATION) then
                        begin
                          rEquatorialToHorizontal(epvh[0], Lat, epvh[0]);
                          rRefraction(ra, rb, epvh[0]);
                          rHorizontalToEquatorial(epvh[0], Lat, epvh[0]);
                        end;
                  end
                else
                  if (Value >= GV_ELEVATION) then
                    rEquatorialToHorizontal(pv[0], Lat, pv[0]);

                if (Value = GV_ELONGATION) then
                  RotVZ(-(era + Lon + sp), epvh[0])
                else
                  if (Value < GV_ELEVATION) then
                    RotVZ(-(era + Lon + sp), pv[0]);
                {$Else}
                if (topo) then
                  rDiurnalParallax(obpv, TRealVektor3(pv[0]));

                if topo and (Value = GV_ELONGATION) then
                  rDiurnalParallax(obpv, TRealVektor3(epvh[0]));

                // rDiurnalAberration(obpv, pv[0]);

                if (Frame >= FR_OBS) or ((Frame < FR_J2000) and (Frame >= FR_OBSD)) then
                  begin
                    rEquatorialToHorizontal(TRealVektor3(pv[0]), Lat, TRealVektor3(pv[0]));
                    rRefraction(ra, rb, TRealVektor3(pv[0]));

                    if (Value < GV_ELEVATION) then
                      rHorizontalToEquatorial(TRealVektor3(pv[0]), Lat, TRealVektor3(pv[0]))
                    else
                      if (Value = GV_ELONGATION) then
                        begin
                          rEquatorialToHorizontal(TRealVektor3(epvh[0]), Lat, TRealVektor3(epvh[0]));
                          rRefraction(ra, rb, TRealVektor3(epvh[0]));
                          rHorizontalToEquatorial(TRealVektor3(epvh[0]), Lat, TRealVektor3(epvh[0]));
                        end;
                  end
                else
                  if (Value >= GV_ELEVATION) then
                    rEquatorialToHorizontal(TRealVektor3(pv[0]), Lat, TRealVektor3(pv[0]));

                if (Value = GV_ELONGATION) then
                  RotVZ(-(era + Lon + sp), TRealVektor3(epvh[0]))
                else
                  if (Value < GV_ELEVATION) then
                    RotVZ(-(era + Lon + sp), TRealVektor3(pv[0]));
                {$EndIf}
              end
            else
              begin
                {$IfDef FPC}
                if (topo) then
                  rDiurnalParallax(obpv, pv[0]);

                if topo and (Value = GV_ELONGATION) then
                  rDiurnalParallax(obpv, epvh[0]);

                if (Value >= GV_ELEVATION) then
                  rEquatorialToHorizontal(pv[0], Lat, pv[0])
                else
                  begin
                    if (Value = GV_ELONGATION) then
                      RotVZ(-(era + Lon + sp), epvh[0]);

                    RotVZ(-(era + Lon + sp), pv[0]);
                  end;
                {$Else}
                if (topo) then
                  rDiurnalParallax(obpv, TRealVektor3(pv[0]));

                if topo and (Value = GV_ELONGATION) then
                  rDiurnalParallax(obpv, TRealVektor3(epvh[0]));

                if (Value >= GV_ELEVATION) then
                  rEquatorialToHorizontal(TRealVektor3(pv[0]), Lat, TRealVektor3(pv[0]))
                else
                  begin
                    if (Value = GV_ELONGATION) then
                      RotVZ(-(era + Lon + sp), TRealVektor3(epvh[0]));

                    RotVZ(-(era + Lon + sp), TRealVektor3(pv[0]));
                  end;
                {$EndIf}
            end;
          end
        else
          begin
            {$IfDef FPC}
            if topo then
              rDiurnalParallax(obpv, pv[0]);

            if topo and (Value = GV_ELONGATION) then
              rDiurnalParallax(obpv, epvh[0]);

            if (Value >= GV_ELEVATION) then
              begin
                RotVZ((era + Lon + sp), pv[0]);
                rEquatorialToHorizontal(pv[0], Lat, pv[0]);
              end;
            {$Else}
            if topo then
              rDiurnalParallax(obpv, TRealVektor3(pv[0]));

            if topo and (Value = GV_ELONGATION) then
              rDiurnalParallax(obpv, TRealVektor3(epvh[0]));

            if (Value >= GV_ELEVATION) then
              begin
                RotVZ((era + Lon + sp), TRealVektor3(pv[0]));
                rEquatorialToHorizontal(TRealVektor3(pv[0]), Lat, TRealVektor3(pv[0]));
              end;
            {$EndIf}
          end;

        if (Value < GV_RIGHTASCENSION) then
          begin
            obl := ephObliquity(Version, Frame, tt1, tt2);
           {$IfDef FPC}
            RotVX(obl, pv[0]);
            {$Else}
            RotVX(obl, TRealVektor3(pv[0]));
            {$EndIf}
          end;

        if (Value = GV_EARTHLONGITUDE) then
          exit(RangeTo(DR2D * arctan2(pv[0][1], pv[0][0]), 360.0))
        else
          if (Value = GV_EARTHLATITUDE)then
            exit(DR2D * arctan2(pv[0][2], sqrt(pv[0][0] * pv[0][0] + pv[0][1] * pv[0][1])))
        else
          if (Value = GV_EARTHRADIUS) then
            exit(sqrt(pv[0][0] * pv[0][0] + pv[0][1] * pv[0][1] + pv[0][2] * pv[0][2]))
        else
          if (Value = GV_RIGHTASCENSION) then
            exit(RangeTo(DR2D * arctan2(pv[0][1], pv[0][0]), 360.0))
        else
          if (Value = GV_DECLINATION) then
            exit(DR2D * iauAnpm(arctan2(pv[0][2], sqrt(pv[0][0] * pv[0][0] + pv[0][1] * pv[0][1]))))
        else
          if (Value = GV_HOURANGLE) then
            begin
              r := arctan2(pv[0][1], pv[0][0]);
              exit(RangeTo(DR2D * (era + sp + Lon - r) / 15.0, 24.0));
             end
        else
          if (Value = GV_ELEVATION) then
            exit(DR2D * iauAnpm(arctan2(pv[0][2], sqrt(pv[0][0] * pv[0][0] + pv[0][1] * pv[0][1]))))
        else
          if (Value = GV_AZIMUTH) then
            exit(RangeTo(DR2D*arctan2(pv[0][1], -pv[0][0]), 360.0))
        else
          if (Value = GV_ELONGATION) then
            begin
              //iauSxp(-1.0, epvh[0], epvh[0]);
              {$IfDef FPC}
              exit(RangeTo(DR2D*iauSepp(pv[0], epvh[0]), 360.0));
              {$Else}
              exit(RangeTo(DR2D*iauSepp(TRealVektor3(pv[0]), TRealVektor3(epvh[0])), 360.0));
              {$EndIf}

              {l := ATANG2(pv[0][1], pv[0][0]);
              r := ATANG2(epvh[0][1], epvh[0][0]) + DPI;
              b := ATANG2(pv[0][2], sqrt(pv[0][0]*pv[0][0] + pv[0][1]*pv[0][1]));
              exit(RangeTo(DR2D*(ACOS(cos(b) * cos(l - r))), 360.0));}
            end
      end;

    Result := 0.0;
  end;

end.
