unit wmm;

{$mode objfpc}{$H+}
{$WARN 5057 off : Local variable "$1" does not seem to be initialized}
interface

  uses
    Classes, SysUtils, Math,
    Data;

  function wmm_Geomag (Value, Year, Month, Day: integer; Lon, Lat, Height: Real): Real;

  const
  //General Errors
    PLERR_NOFILE = -10000;
    PLERR_WRONGVALUE = -10006;
    PLERR_GENERALERROR = -10013;

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

implementation

type
  PARAMS = (
      SHDF,
      MODELNAME,
      PUBLISHER,
      RELEASEDATE,
      DATACUTOFF,
      MODELSTARTYEAR,
      MODELENDYEAR,
      EPOCH,
      INTSTATICDEG,
      INTSECVARDEG,
      EXTSTATICDEG,
      EXTSECVARDEG,
      GEOMAGREFRAD,
      NORMALIZATION,
      SPATBASFUNC);

  TRealVektorBUF = array[0..1023] of Real;
  TRealVektor8 = array[0..7] of Real;
  TSArray15 = Array[PARAMS] of String;

    MAGtype_Date = record
      Year: integer;
      Month: integer;
      Day: integer;
      DecimalYear: Real;
    end;

    MAGtype_CoordSpherical = record
      lambda: Real;  // longitude
      phig: Real;  // geocentric latitude
      r: Real;  // distance from the center of the ellipsoid
    end;

    MAGtype_CoordGeodetic = record
      lambda: Real;               // longitude
      phi: Real;               // geodetic latitude
      HeightAboveEllipsoid: Real; // height above the ellipsoid (HaE)
      HeightAboveGeoid: Real; // (height above the EGM96 geoid model )
      UseGeoid: integer;
    end;

    MAGtype_UTMParameters = record
      Easting: Real; // (X) in meters
      Northing: Real; // (Y) in meters  }
      Zone: integer; //UTM Zone
      IsNorthHemiSphere: boolean;
      CentralMeridian: Real;
      ConvergenceOfMeridians: Real;
      PointScale: Real;
    end;

    MAGtype_MagneticModel = record
      EditionDate: Real;
      epoch: Real; // Base time of Geomagnetic model epoch (yrs)
      ModelName: string;
      Main_Field_Coeff_G: array [0..1024] of Real;
      // C - Gauss coefficients of main geomagnetic model (nT) Index is (n * (n + 1) / 2 + m)
      Main_Field_Coeff_H: array [0..1024] of Real; // C - Gauss coefficients of main geomagnetic model (nT)
      Secular_Var_Coeff_G: array [0..1024] of Real;
      // CD - Gauss coefficients of secular geomagnetic model (nT/yr)
      Secular_Var_Coeff_H: array [0..1024] of Real;
      // CD - Gauss coefficients of secular geomagnetic model (nT/yr)
      nMax: integer;  // Maximum degree of spherical harmonic model
      nMaxSecVar: integer; // Maximum degree of spherical harmonic secular model
      SecularVariationUsed: boolean;
      // Whether or not the magnetic secular variation vector will be needed by program
      CoefficientFileEndDate: Real;
    end;

    MAGtype_Geoid = record
      NumbGeoidCols: integer;  // 360 degrees of longitude at 15 minute spacing
      NumbGeoidRows: integer;  // 180 degrees of latitude  at 15 minute spacing
      NumbHeaderItems: integer;  // min, max lat, min, max long, lat, long spacing
      ScaleFactor: integer;  // 4 grid cells per degree at 15 minute spacing
      GeoidHeightBuffer: array of Real;
      NumbGeoidElevs: integer;
      Geoid_Initialized: boolean;  // indicates successful initialization
      UseGeoid: boolean;  // Is the Geoid being used?
    end;

    MAGtype_Ellipsoid = record
      a: Real; // semi-major axis of the ellipsoid
      b: Real; // semi-minor axis of the ellipsoid
      fla: Real; // flattening
      epssq: Real; // first eccentricity squared
      eps: Real; // first eccentricity
      re: Real; // mean radius of  ellipsoid
    end;

    MAGtype_MagneticResults = record
      Bx: Real; // North
      By: Real; // East
      Bz: Real; // Down
    end;

    MAGtype_GeoMagneticElements = record
      Decl: Real;    //  1. Angle between the magnetic field vector and true north, positive east
      Incl: Real;    //  2. Angle between the magnetic field vector and the horizontal plane, positive down
      F: Real;       //  3. Magnetic Field Strength
      H: Real;       //  4. Horizontal Magnetic Field Strength
      X: Real;       //  5. Northern component of the magnetic field vector
      Y: Real;       //  6. Eastern component of the magnetic field vector
      Z: Real;       //  7. Downward component of the magnetic field vector
      GV: Real;      //  8. The Grid Variation
      Decldot: Real; //  9. Yearly Rate of change in declination
      Incldot: Real; // 10. Yearly Rate of change in inclination
      Fdot: Real;    // 11. Yearly rate of change in Magnetic field strength
      Hdot: Real;    // 12. Yearly rate of change in horizontal field strength
      Xdot: Real;    // 13. Yearly rate of change in the northern component
      Ydot: Real;    // 14. Yearly rate of change in the eastern component
      Zdot: Real;    // 15. Yearly rate of change in the downward component
      GVdot: Real;   // 16. Yearly rate of change in grid variation
    end;

    MAGtype_SphericalHarmonicVariables = record
      RelativeRadiusPower: array[0..128] of Real; // [earth_reference_radius_km / sph. radius ]^n
      cos_mlambda: array[0..128] of Real;         //cp(m)  - cosine of (m*spherical coord. longitude)
      sin_mlambda: array[0..128] of Real;         // sp(m)  - sine of (m*spherical coord. longitude)
    end;

    MAGtype_LegendreFunction = record
      Pcup: TRealVektorBUF; // Legendre Function
      dPcup: TRealVektorBUF; // Derivative of Legendre fcn
    end;

const
  BUFSIZE = 1024;
  MAXSIZE = 128;

  MAG_PS_MIN_LAT_DEGREE  =   -55; // Minimum Latitude for  Polar Stereographic projection in degrees
  MAG_PS_MAX_LAT_DEGREE  =    55; // Maximum Latitude for Polar Stereographic projection in degrees
  MAG_UTM_MIN_LAT_DEGREE = -80.5; // Minimum Latitude for UTM projection in degrees
  MAG_UTM_MAX_LAT_DEGREE =  84.5; // Maximum Latitude for UTM projection in degrees

  //MAG_GEO_POLE_TOLERANCE  = 1e-5;
  MAG_USE_GEOID           = true;  // true Geoid - Ellipsoid difference should be corrected, false otherwise

var
  haveCoeffs: boolean = False;
  GeomagGeoid: MAGtype_Geoid;
  GeomagEllipsoid: MAGtype_Ellipsoid;
  GeomagMagneticModel, GeomagTimedMagneticModel: MAGtype_MagneticModel;
  GeomagLegendreFunction: MAGtype_LegendreFunction;
  GeomagSphVariables: MAGtype_SphericalHarmonicVariables;
  GeomagGeoMagneticElements, GeomagErrors: MAGtype_GeoMagneticElements;
  schmidtQuasiNorm, GeomagPcupS: array[0..BUFSIZE - 1] of Real;
  GeomagF1, GeomagF2, GeomagPreSqr: array[0..BUFSIZE - 1] of Real;
  DoubleParams: array[0..2] of Real = (0.0, 0.0, 0.0);
  DateParams: array[0..2] of integer = (0, 0, 0);

function  CALCULATE_NUMTERMS (const N: Real): Real; inline;
  begin
    Result := (N * ( N + 1 ) / 2 + N)
  end;

function  ATanH (const x: Real): Real; inline;
  begin
    Result := (0.5 * ln((1 + x) / (1 - x)));
  end;

function  RAD2DEG (const Rad: Real): Real; inline;
  begin
    Result := (rad)*(180.0/Pi);
   end;

function  DEG2RAD (const deg: Real): Real; inline;
  begin
    Result := deg*(Pi/180.0)
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

//----------------------------------------------------------------------------\\

function DateToYear (const Year: integer; Month, Day: integer): Real; inline;
  var
    f: Real;
    i, n: integer;
  begin
    Dec (Month);
    n := Day;

    if (nDaysMonth (Year, 2) = 28) then
      Day := 0
    else
      Day := 1;

    f := 365.0 + Day;

    for i := 0 to Month - 1 do
      if (i = 1) then
        n += 28 + Day
      else
        n += nDaysMonth (Year, i + 1);

    Result := Year + ((n - 1) / f);

  end;

procedure MAG_SetDefaults (var Ellip: MAGtype_Ellipsoid; var Geoid: MAGtype_Geoid); inline;
  begin
    // Sets WGS-84 parameters
    with Ellip do
      begin
        a := 6378.137; // semi-major axis of the ellipsoid in
        b := 6356.7523142; // semi-minor axis of the ellipsoid in
        fla := 1 / 298.257223563; // flattening
        eps := sqrt (1 - (b * b) / (a * a)); //first eccentricity
        epssq := (eps * eps); //first eccentricity squared
        re := 6371.2; // Earth's radius
      end;

    // Sets EGM-96 model file parameter
    with Geoid do
      begin
        NumbGeoidCols := 1441; // 360 degrees of longitude at 15 minute spacing
        NumbGeoidRows := 721;  // 180 degrees of latitude  at 15 minute spacing
        NumbHeaderItems := 6;  // min, max lat, min, max long, lat, long spacing
        ScaleFactor := 4;      // 4 grid cells per degree at 15 minute spacing
        NumbGeoidElevs := NumbGeoidCols * NumbGeoidRows;
        Geoid_Initialized := False; //  Geoid will be initialized only if this is set to false
        UseGeoid := MAG_USE_GEOID;
      end;
  end;  //MAG_SetDefaults

function MAG_GetGeoidHeight (const Latitude, Longitude: Real; var DeltaHeight: Real; var Geoid: MAGtype_Geoid): boolean; inline;
  var
    Index: longint;
    Error_Code: integer = 0;
    PostX, PostY: Real;
    UpperY, LowerY: Real;
    DeltaX, DeltaY: Real;
    OffsetX, OffsetY: Real;
    ElevationSE, ElevationSW, ElevationNE, ElevationNW: Real;
  begin
    if not (Geoid.Geoid_Initialized) then
      exit (false);

    if ((Latitude < -90) or (Latitude > 90)) then
      Error_Code := Error_Code or 1; // Latitude out of range

    if ((Longitude < -180) or (Longitude > 360)) then
      Error_Code := Error_Code or 1; // Longitude out of range

    if (Error_Code = 0) then //no errors
      begin
        //  Compute X and Y Offsets into Geoid Height Array:
        if (Longitude < 0.0) then
          OffsetX := (Longitude + 360.0) * Geoid.ScaleFactor
        else
          OffsetX := Longitude * Geoid.ScaleFactor;

        OffsetY := (90.0 - Latitude) * Geoid.ScaleFactor;

        //  Find Four Nearest Geoid Height Cells for specified Latitude, Longitude;
        //  Assumes that (0,0) of Geoid Height Array is at Northwest corner:
        PostX := floor (OffsetX);
        if (PostX + 1) = Geoid.NumbGeoidCols then
          PostX -= 1;

        PostY := floor (OffsetY);
        if (PostY + 1) = Geoid.NumbGeoidRows then
          PostY -= 1;

        Index := trunc (PostY * Geoid.NumbGeoidCols + PostX);
        ElevationNW := Geoid.GeoidHeightBuffer[Index];
        ElevationNE := Geoid.GeoidHeightBuffer[Index + 1];

        Index := trunc ((PostY + 1) * Geoid.NumbGeoidCols + PostX);
        ElevationSW := Geoid.GeoidHeightBuffer[Index];
        ElevationSE := Geoid.GeoidHeightBuffer[Index + 1];

        //  Perform Bi-Linear Interpolation to compute Height above Ellipsoid:
        DeltaX := OffsetX - PostX;
        DeltaY := OffsetY - PostY;

        UpperY := ElevationNW + DeltaX * (ElevationNE - ElevationNW);
        LowerY := ElevationSW + DeltaX * (ElevationSE - ElevationSW);

        DeltaHeight := UpperY + DeltaY * (LowerY - UpperY);

        Result := true;
      end
    else
      Result := false;
  end; //MAG_GetGeoidHeight

procedure MAG_EquivalentLatLon (const lat, lon: Real; var repairedLat, repairedLon: Real); inline;
  var
    colat: Real;
  begin
    colat := 90 - lat;
    repairedLon := lon;

    if (colat < 0) then
      colat := -colat;

    while (colat > 360) do
      colat -= 360;

    if (colat > 180) then
      begin
        colat -= 180;
        repairedLon += 180;
      end;

    repairedLat := 90 - colat;

    if (repairedLon > 360) then
      repairedLon -= 360;

    if (repairedLon < -180) then
      repairedLon += 360;
  end; //MAG_EquivalentLatLon

function MAG_ConvertGeoidToEllipsoidHeight (var CoordGeodetic: MAGtype_CoordGeodetic; var Geoid: MAGtype_Geoid): boolean; inline;
    var
      GotError: boolean;
      lat, lon: Real;
      DeltaHeight: Real;
    begin
      if (Geoid.UseGeoid) then //Geoid correction required
        begin
        // To ensure that latitude is less than 90 call MAG_EquivalentLatLon()
        MAG_EquivalentLatLon (CoordGeodetic.phi, CoordGeodetic.lambda, Lat, Lon);

        GotError := MAG_GetGeoidHeight (lat, lon, DeltaHeight, Geoid);
        CoordGeodetic.HeightAboveEllipsoid := CoordGeodetic.HeightAboveGeoid + DeltaHeight / 1000;
        //  Input and output should be kilometers, However MAG_GetGeoidHeight returns Geoid height in meters - Hence division by 1000
        end
      else // Geoid correction not required, copy the MSL height to Ellipsoid height
        begin
        CoordGeodetic.HeightAboveEllipsoid := CoordGeodetic.HeightAboveGeoid;
        GotError := true;
        end;

      Result := GotError;
    end; //MAG_ConvertGeoidToEllipsoidHeight

procedure MAG_GeodeticToSpherical (const Ellip: MAGtype_Ellipsoid; const CoordGeodetic: MAGtype_CoordGeodetic; var CoordSpherical: MAGtype_CoordSpherical); inline;
  var
    CosLat, SinLat, rc, xp, zp: double; //all local variables
  begin
  {*Convert geodetic coordinates, (defined by the WGS-84
   * reference ellipsoid), to Earth Centered Earth Fixed Cartesian
   * coordinates, and then to spherical coordinates.}
    CosLat := cos (DEG2RAD(CoordGeodetic.phi));
    SinLat := sin (DEG2RAD(CoordGeodetic.phi));

    //compute the local radius of curvature on the WGS-84 reference ellipsoid
    rc := Ellip.a / sqrt (1.0 - Ellip.epssq * SinLat * SinLat);

    //compute ECEF Cartesian coordinates of specified point (for longitude=0)
    xp := (rc + CoordGeodetic.HeightAboveEllipsoid) * CosLat;
    zp := (rc * (1.0 - Ellip.epssq) + CoordGeodetic.HeightAboveEllipsoid) * SinLat;

    //compute spherical radius and angle lambda and phi of specified point
    CoordSpherical.r := sqrt (xp * xp + zp * zp);   //((rad)*(180.0L/M_PI))
    CoordSpherical.phig := RAD2DEG(arcsin (zp / CoordSpherical.r)); // geocentric latitude
    CoordSpherical.lambda := CoordGeodetic.lambda; // longitude

  end; //MAG_GeodeticToSpherical

procedure MAG_TMfwd4 (const Eps, Epssq, K0R4, K0R4oa: Real; const Acoeff: TRealVektor8; const Lam0, K0, falseE, falseN: Real; const XYonly: integer; const Lambda, Phi: Real; var X, Y, pscale, CoM: Real); inline;
  var
    U, V: Real;
    Xstar, Ystar: Real;
    T, Tsq, denom2: Real;
    sig1, sig2, comroo: Real;
    Lam, CLam, SLam, CPhi, SPhi: Real;
    P, part1, part2, denom, CChi, SChi: Real;
    c2u, s2u, c4u, s4u, c6u, s6u, c8u, s8u: Real;
    c2v, s2v, c4v, s4v, c6v, s6v, c8v, s8v: Real;
  begin
  { Ellipsoid to sphere
    --------- -- ------
   Convert longitude (Greenwhich) to longitude from the central meridian
   It is unnecessary to find the (-Pi, Pi] equivalent of the result.
   Compute its cosine and sine. }
    Lam := Lambda - Lam0;
    CLam := cos (Lam);
    SLam := sin (Lam);

    //   Latitude
    CPhi := cos (Phi);
    SPhi := sin (Phi);

  {   Convert geodetic latitude, Phi, to conformal latitude, Chi
     Only the cosine and sine of Chi are actually needed.        }
    P := exp (Eps * (0.5 * ln ((1 + (Eps * SPhi)) / (1 - (Eps * SPhi)))));
    part1 := (1 + SPhi) / P;
    part2 := (1 - SPhi) * P;
    denom := 1 / (part1 + part2);
    CChi := 2 * CPhi * denom;
    SChi := (part1 - part2) * denom;

  { Sphere to first plane
    ------ -- ----- -----
   Apply spherical theory of transverse Mercator to get (u,v) coordinates
   Note the order of the arguments in Fortran's version of ArcTan, i.e. atan2(y, x) = ATan(y/x)
   The two argument form of ArcTan is needed here: (0.5 * log((1 + x) / (1 - x))) }
    T := CChi * SLam;
    U := ATanH(T);
    V := arctan2 (SChi, CChi * CLam);

   { Trigonometric multiple angles
     ------------- -------- ------
      Compute Cosh of even multiples of U
      Compute Sinh of even multiples of U
      Compute Cos  of even multiples of V
      Compute Sin  of even multiples of V }
    Tsq := T * T;
    denom2 := 1 / (1 - Tsq);
    c2u := (1 + Tsq) * denom2;
    s2u := 2 * T * denom2;
    c2v := (-1 + CChi * CChi * (1 + CLam * CLam)) * denom2;
    s2v := 2 * CLam * CChi * SChi * denom2;
    c4u := 1 + 2 * s2u * s2u;
    s4u := 2 * c2u * s2u;
    c4v := 1 - 2 * s2v * s2v;
    s4v := 2 * c2v * s2v;
    c6u := c4u * c2u + s4u * s2u;
    s6u := s4u * c2u + c4u * s2u;
    c6v := c4v * c2v - s4v * s2v;
    s6v := s4v * c2v + c4v * s2v;
    c8u := 1 + 2 * s4u * s4u;
    s8u := 2 * c4u * s4u;
    c8v := 1 - 2 * s4v * s4v;
    s8v := 2 * c4v * s4v;

   {   First plane to second plane
       ----- ----- -- ------ -----
      Accumulate terms for X and Y }
    Xstar := Acoeff[3] * s8u * c8v;
    Xstar += Acoeff[2] * s6u * c6v;
    Xstar += Acoeff[1] * s4u * c4v;
    Xstar += Acoeff[0] * s2u * c2v;
    Xstar += U;
    Ystar := Acoeff[3] * c8u * s8v;
    Ystar += Acoeff[2] * c6u * s6v;
    Ystar += Acoeff[1] * c4u * s4v;
    Ystar += Acoeff[0] * c2u * s2v;
    Ystar += V;

    //   Apply isoperimetric radius, scale adjustment, and offsets
    X := K0R4 * Xstar + falseE;
    Y := K0R4 * Ystar + falseN;

   {  Point-scale and CoM
      ----- ----- --- ---  }
    if (XYonly = 1) then
      begin
      pscale := K0;
      CoM := 0;
      end
    else
      begin
      sig1 := 8 * Acoeff[3] * c8u * c8v;
      sig1 += 6 * Acoeff[2] * c6u * c6v;
      sig1 += 4 * Acoeff[1] * c4u * c4v;
      sig1 += 2 * Acoeff[0] * c2u * c2v;
      sig1 += 1;
      sig2 := 8 * Acoeff[3] * s8u * s8v;
      sig2 += 6 * Acoeff[2] * s6u * s6v;
      sig2 += 4 * Acoeff[1] * s4u * s4v;
      sig2 += 2 * Acoeff[0] * s2u * s2v;

      //    Combined square roots
      comroo := sqrt ((1 - Epssq * SPhi * SPhi) * denom2 * (sig1 * sig1 + sig2 * sig2));
      pscale := K0R4oa * 2 * denom * comroo;
      CoM := arctan2 (SChi * SLam, CLam) + arctan2 (sig2, sig1);
      end;
  end; // MAG_TMfwd4

function MAG_GetUTMParameters (Latitude, Longitude: Real; var Zone: integer; var IsNorthHemisphere: boolean; var CentralMeridian: Real): boolean; inline;
    var
      Long_Degrees, Lat_Degrees: longint;
      temp_zone: longint;
    begin
      Result := True;

      if (Latitude < DEG2RAD(MAG_UTM_MIN_LAT_DEGREE)) or
        (Latitude > DEG2RAD(MAG_UTM_MAX_LAT_DEGREE)) then
        Result := False; // Latitude out of range

      if ((Longitude < -Pi) or (Longitude > (2 * Pi))) then
        Result := False; // Longitude out of range

      if not Result then
        exit;

      //no errors
      if (Longitude < 0) then
        Longitude += (2 * Pi) + 1.0e-10;

      Lat_Degrees := trunc (Latitude * 180.0 / Pi);
      Long_Degrees := trunc (Longitude * 180.0 / Pi);

      if (Longitude < Pi) then
        temp_zone := trunc (31 + ((Longitude * 180.0 / Pi) / 6.0))
      else
        temp_zone := trunc (((Longitude * 180.0 / Pi) / 6.0) - 29);

      if (temp_zone > 60) then
        temp_zone := 1;

      //UTM special cases
      if ((Lat_Degrees > 55) and (Lat_Degrees < 64) and (Long_Degrees > -1) and (Long_Degrees < 3)) then
        temp_zone := 31;
      if ((Lat_Degrees > 55) and (Lat_Degrees < 64) and (Long_Degrees > 2) and (Long_Degrees < 12)) then
        temp_zone := 32;
      if ((Lat_Degrees > 71) and (Long_Degrees > -1) and (Long_Degrees < 9)) then
        temp_zone := 31;
      if ((Lat_Degrees > 71) and (Long_Degrees > 8) and (Long_Degrees < 21)) then
        temp_zone := 33;
      if ((Lat_Degrees > 71) and (Long_Degrees > 20) and (Long_Degrees < 33)) then
        temp_zone := 35;
      if ((Lat_Degrees > 71) and (Long_Degrees > 32) and (Long_Degrees < 42)) then
        temp_zone := 37;

      if (temp_zone >= 31) then
        CentralMeridian := (6 * temp_zone - 183) * Pi / 180.0
      else
        CentralMeridian := (6 * temp_zone + 177) * Pi / 180.0;

      Zone := temp_zone;

      if (Latitude < 0) then
        IsNorthHemisphere := False
      else
        IsNorthHemisphere := True;

    end; //MAG_GetUTMParameters

procedure MAG_GetTransverseMercator (const CoordGeodetic: MAGtype_CoordGeodetic; var UTMParameters: MAGtype_UTMParameters); inline;
  var
    Zone, XYonly: integer;
    IsNorthHemisphere: boolean;
    Acoeff: TRealVektor8;
    Eps, Epssq: Real;
    Lambda, Phi: Real;
    K0R4, K0R4oa: Real;
    X, Y, pscale, CoM: Real;
    Lam0, K0, falseE, falseN: Real;
  begin
    //Get the map projection  parameters
    K0 := 0.9996;
    Phi := DEG2RAD(CoordGeodetic.phi);
    Lambda := DEG2RAD(CoordGeodetic.lambda);

    MAG_GetUTMParameters (Phi, Lambda, Zone, IsNorthHemisphere, Lam0);

    if IsNorthHemisphere then
      falseN := 0
    else
      falseN := 10000000;
    falseE := 500000;

    // WGS84 ellipsoid
    Eps := 0.081819190842621494335;
    Epssq := 0.0066943799901413169961;
    K0R4 := 6367449.1458234153093;
    K0R4oa := 0.99832429843125277950;

    Acoeff[0] := 8.37731820624469723600E-04;
    Acoeff[1] := 7.60852777357248641400E-07;
    Acoeff[2] := 1.19764550324249124400E-09;
    Acoeff[3] := 2.42917068039708917100E-12;
    Acoeff[4] := 5.71181837042801392800E-15;
    Acoeff[5] := 1.47999793137966169400E-17;
    Acoeff[6] := 4.10762410937071532000E-20;
    Acoeff[7] := 1.21078503892257704200E-22;

    // WGS84 ellipsoid
    // Execution of the forward T.M. algorithm
    XYonly := 0;
    MAG_TMfwd4 (Eps, Epssq, K0R4, K0R4oa, Acoeff, Lam0, K0, falseE, falseN, XYonly,
      Lambda, Phi, X, Y, pscale, CoM);

    //   Report results
    UTMParameters.Easting := X; // UTM Easting (X) in meters
    UTMParameters.Northing := Y; // UTM Northing (Y) in meters
    UTMParameters.Zone := Zone; // UTM Zone
    UTMParameters.IsNorthHemiSphere := IsNorthHemisphere;
    UTMParameters.CentralMeridian := RAD2DEG(Lam0); // Central Meridian of the UTM Zone
    UTMParameters.ConvergenceOfMeridians := RAD2DEG(CoM);
    // Convergence of meridians of the UTM Zone and location
    UTMParameters.PointScale := pscale;

  end; // MAG_GetTransverseMercator

//MAGtype_MagneticModel *MAG_AllocateModelMemory(int NumTerms)
procedure MAG_AllocateModelMemory (var model: MAGtype_MagneticModel); inline; // Wirklich noch benötigt?
  var
    i: integer;
  begin
    with model do
      begin
        nMax := 0;
        epoch := 0;
        nMaxSecVar := 0;
        EditionDate := 0;
        ModelName := '';
        SecularVariationUsed := False;
        CoefficientFileEndDate := 0;

        for i := 0 to BUFSIZE do
          begin
            Main_Field_Coeff_G[i] := 0.0;
            Main_Field_Coeff_H[i] := 0.0;
            Secular_Var_Coeff_G[i] := 0.0;
            Secular_Var_Coeff_H[i] := 0.0;
          end;
      end;
  end;  //MAG_AllocateModelMemory

procedure MAG_AssignHeaderValues (var model: MAGtype_MagneticModel; const values: TSArray15); inline;
  begin  //    MAGtype_Date rleasedate;

    with  model do
      begin
      ModelName := values[PARAMS.MODELNAME];

    {releasedate.Year = 0;
    releasedate.Day = 0;
    releasedate.Month = 0;
    releasedate.DecimalYear = 0;
    sscanf(values[RELEASEDATE],"%d-%d-%d",&releasedate.Year,&releasedate.Month,&releasedate.Day);
    if(MAG_DateToYear (&releasedate, NULL)) model->EditionDate = releasedate.DecimalYear;}

      epoch := StrToFloat (values[MODELSTARTYEAR]);
      nMax := StrToInt (values[INTSTATICDEG]);
      nMaxSecVar := StrToInt (values[INTSECVARDEG]);
      CoefficientFileEndDate := StrToFloat (values[MODELENDYEAR]);

      if (nMaxSecVar > 0) then
        SecularVariationUsed := True
      else
        SecularVariationUsed := False;
      end;
  end;

function MAG_readMagneticModel_SHDF (const filename: string; var magneticmodels: MAGtype_MagneticModel; array_size: integer): integer; inline;
  var
    paramkeys: Array[PARAMS] of String = (
      'SHDF ',
      'ModelName: ',
      'Publisher: ',
      'ReleaseDate: ',
      'DataCutOff: ',
      'ModelStartYear: ',
      'ModelEndYear: ',
      'Epoch: ',
      'IntStaticDeg: ',
      'IntSecVarDeg: ',
      'ExtStaticDeg: ',
      'ExtSecVarDeg: ',
      'GeoMagRefRad: ',
      'Normalization: ',
      'SpatBasFunc: '
    );
    n, m, index, tempint, j: integer;
    Lines: TStrings;
    //coefftype: char; //Internal or External (I/E)
    i: PARAMS;
    paramvaluelength: integer = 0;
    newrecord: boolean = True;
    header_index: integer = -1;
    allocationflag: boolean = False;
    paramkeylength: integer = 0;
    paramvalue: string;
    gnm, hnm, dgnm, dhnm{, cutoff}: Real;
    paramvalues: array [PARAMS] of string;

    function GetVal3 (const Line : String): boolean;   // ReadError fix
      var
        Vals: TStringArray;
      begin
        if (Trim(Lines[j])[1] = '#') then
          exit(false)
        else
          Result := true;

        Vals := Line.Split(' ', TStringSplitOptions.ExcludeEmpty);
        //coefftype := Vals[0][1];
        n := StrToInt(Vals[1]);
        m := StrToInt(Vals[2]);
      end;

    procedure GetVal5 (const Line : String);   // ReadError fix
      var
        Vals: TStringArray; //sscanf (Lines[j], '%c,%d,%d,%lf,,%lf,', [@, @n, @m, @gnm, @dgnm])
      begin
        Vals := Line.Split(' ', TStringSplitOptions.ExcludeEmpty);
        //coefftype := Vals[0][1];
        n := StrToInt(Vals[1]);
        m := StrToInt(Vals[2]);
        gnm := StrToFloat(Vals[3]);
        dgnm := StrToFloat(Vals[4]);
      end;

    procedure GetVal7 (const Line : String);   // ReadError fix
      var
        Vals: TStringArray; //sscanf (Lines[j], '%c,%d,%d,%lf,%lf,%lf,%lf', [@, @n, @m, @gnm, @hnm, @dgnm, @dhnm]);
      begin
        Vals := Line.Split(' ', TStringSplitOptions.ExcludeEmpty);
        //coefftype := Vals[0][1];
        n := StrToInt(Vals[1]);
        m := StrToInt(Vals[2]);
        gnm := StrToFloat(Vals[3]);
        hnm := StrToFloat(Vals[4]);
        dgnm := StrToFloat(Vals[5]);
        dhnm := StrToFloat(Vals[6]);
      end;

  begin
    Result := -1;
    Lines := TStringList.Create;

      try
      Lines.LoadFromFile (filename);
      if not (Lines.Count > 0) then
        begin
        Lines.Free;
        exit (header_index);
        end;

      // Read records from the model file and store header information.
      for j := 0 to Lines.Count - 1 do
        begin
          Lines[j] := Trim (Lines[j]);

          if (Lines[j] = '') then
            continue
          else if (Lines[j][1] = '%') then
            begin
              Lines[j] := copy (Lines[j], 2, Lines[j].length - 1);

              if (newrecord) then
                begin
                  if (header_index > -1) then
                     MAG_AssignHeaderValues (magneticmodels, paramvalues{%H-});

                  Inc (header_index);

                  if (header_index >= array_size) then
                    begin
                      Lines.Free;
                      exit (array_size + 1);
                    end;

                  newrecord := False;
                  allocationflag := False;
                end;

              for i := SHDF to SPATBASFUNC do
                begin
                  paramkeylength := paramkeys[i].length;

                  if strlicomp (PChar (Lines[j]), PChar (paramkeys[i]), paramkeylength) = 0 then
                    begin
                      paramvaluelength := Lines[j].length - paramkeylength;
                      paramvalue := copy (Lines[j], paramkeylength, paramvaluelength);
                      paramvalues[i] := paramvalue;

                      if (stricomp (PChar (paramkeys[i]), PChar (paramkeys[INTSTATICDEG])) = 0) or
                         (stricomp (PChar (paramkeys[i]), PChar (paramkeys[EXTSTATICDEG])) = 0) then
                        begin
                          tempint := StrToInt (paramvalues[i]);

                          if (tempint > 0) and not (allocationflag) then
                            begin
                              //numterms := (tempint * ( tempint + 1 ) div 2 + tempint); //where is that needed??
                              MAG_AllocateModelMemory (magneticmodels);
                              allocationflag := True;
                            end;
                        end;

                      break;
                    end;
                end;
            end
          else if (GetVal3(Lines[j])) then
            begin
              if (m = 0) then
                begin
                  GetVal5(Lines[j]);

                  hnm := 0;
                  dhnm := 0;
                end
              else
                GetVal7(Lines[j]);

              newrecord := True;

              if not (allocationflag) then
                begin
                 Lines.Free;
                 exit (_DEGREE_NOT_FOUND);
                end;

              if (m <= n) then
                begin
                 index := (n * (n + 1) div 2 + m);

                 with magneticmodels do
                   begin
                     Main_Field_Coeff_G[index] := gnm;
                     Secular_Var_Coeff_G[index] := dgnm;
                     Main_Field_Coeff_H[index] := hnm;
                     Secular_Var_Coeff_H[index] := dhnm;
                   end;
                end;
            end
        else
        ; //process comments
        end;

      if (header_index > -1) then
        MAG_AssignHeaderValues (magneticmodels, paramvalues);

     { cutoff := magneticmodels.CoefficientFileEndDate;
      for i := 0 to array_size - 1 do     // Why?
        magneticmodels.CoefficientFileEndDate := cutoff; }

      Result := header_index + 1;

      finally
      Lines.Free;
      end;
  end; //MAG_readMagneticModel_SHDF

function MAG_readMagneticModel (const filename: string; var MagneticModel: MAGtype_MagneticModel): boolean; inline;
  var
    Lines: TStrings;
    New_Str: String;
    gnm, hnm, dgnm, dhnm: Real;
    epoch: String;
    m, n, index: integer;
    EOF_Flag: BoolEan = true;
    j: integer = 0;

  procedure GetValues (Line : String);   // ReadError fix
    var
      Vals: TStringArray;
    begin
      Vals := Line.Split(' ', TStringSplitOptions.ExcludeEmpty);
      n := StrToInt(Vals[0]);
      m := StrToInt(Vals[1]);
      gnm := StrToFloat(Vals[2]);
      hnm := StrToFloat(Vals[3]);
      dgnm := StrToFloat(Vals[4]);
      dhnm := StrToFloat(Vals[5]);
    end;

  begin
    Lines := TStringList.Create;
    Result := False;

    try
      Lines.LoadFromFile (filename);

      if not (Lines.Count > 0) then  //should we have a standard error printing routine ?
        begin
          Lines.Free;
          exit (False);
        end;

      with MagneticModel do
        begin
          Main_Field_Coeff_H[0] := 0.0;
          Main_Field_Coeff_G[0] := 0.0;
          Secular_Var_Coeff_H[0] := 0.0;
          Secular_Var_Coeff_G[0] := 0.0;
        end;

      sscanf (Lines[0], '%s%s', [@epoch, @New_Str]); //Well, I had to fix some Errors

      MagneticModel.ModelName := New_Str;
      MagneticModel.epoch     := StrToFloat(epoch);

      while EOF_Flag do
        begin
          Inc (j);

          Lines[j] := Trim(Lines[j]);

          //CHECK FOR LAST LINE IN FILE
          if (Lines[j].length >= 5) then
            New_Str := copy( Lines[j], 1, 5)
          else
            New_Str := '';

          if (New_Str = '99999') then
            begin
              EOF_Flag := false;
              break;
            end;

          //END OF FILE NOT ENCOUNTERED, GET VALUES
          GetValues (Lines[j]);

          if (m <= n) then
            begin
              index := (n * (n + 1) div 2 + m);

              with MagneticModel do
                begin
                  Main_Field_Coeff_G[index] := gnm;
                  Secular_Var_Coeff_G[index] := dgnm;
                  Main_Field_Coeff_H[index] := hnm;
                  Secular_Var_Coeff_H[index] := dhnm;
                end;
            end;
        end;

        Result := True;
      finally
        Lines.Free;
      end;
  end; //MAG_readMagneticModel

function MAG_robustReadMagModels (const filename: string; var magneticmodels: MAGtype_MagneticModel; const array_size: integer): boolean; inline;
  var
    Lines: TStrings; //char line[MAXLINELENGTH];
    n, i: integer;
    nMax: integer = 0;
  begin
    Lines := TStringList.Create;
    Result := False;

    try
      Lines.loadFromFile (filename);
      if not (Lines.Count > 0) then
        begin
          Lines.Free;
          exit (False);
        end;

      if (Trim(Lines[0])[1] = '%') then
        MAG_readMagneticModel_SHDF (filename, magneticmodels, array_size)
      else
        if (array_size = 1) then
          begin
            for i := 1 to Lines.Count - 1 do
              begin

                if copy(Lines[i],1, 5) = '99999' then //end of file
                  break;

                if (sscanf (Lines[i], '%d', [@n]) <> 1) then
                  break;

                if ((n > nMax) and (n > 0)) then
                  nMax := n;

              end;

            MAG_AllocateModelMemory (magneticmodels);
            magneticmodels.nMax := nMax;
            magneticmodels.nMaxSecVar := nMax;

            MAG_readMagneticModel (filename, magneticmodels);

            magneticmodels.CoefficientFileEndDate := magneticmodels.epoch + 5;
          end
      else
        begin
          Lines.Free;
          exit (False);
        end;

      GeomagMagneticModel := magneticmodels; //Rückgabe
      Result := True;
    finally;
      Lines.Free;
    end;
  end; ///MAG_robustReadMagModel

procedure MAG_TimelyModifyMagneticModel (const UserDate: MAGtype_Date; var MagneticModel, TimedMagneticModel: MAGtype_MagneticModel); inline;
  var
    n, m, index, a, b: integer;
  begin
    TimedMagneticModel.nMax := MagneticModel.nMax;
    TimedMagneticModel.epoch := MagneticModel.epoch;
    TimedMagneticModel.nMaxSecVar := MagneticModel.nMaxSecVar;
    TimedMagneticModel.EditionDate := MagneticModel.EditionDate;

    a := TimedMagneticModel.nMaxSecVar;
    b := (a * (a + 1) div 2 + a);

    TimedMagneticModel.ModelName := MagneticModel.ModelName;

    for n := 1 to MagneticModel.nMax do
      for m := 0 to n do
        begin
          index := (n * (n + 1) div 2 + m);

          if (index <= b) then
            begin
              TimedMagneticModel.Main_Field_Coeff_H[index] :=
                MagneticModel.Main_Field_Coeff_H[index] + (UserDate.DecimalYear - MagneticModel.epoch) *
                MagneticModel.Secular_Var_Coeff_H[index];

              TimedMagneticModel.Main_Field_Coeff_G[index] :=
                MagneticModel.Main_Field_Coeff_G[index] + (UserDate.DecimalYear - MagneticModel.epoch) *
                MagneticModel.Secular_Var_Coeff_G[index];

              TimedMagneticModel.Secular_Var_Coeff_H[index] := MagneticModel.Secular_Var_Coeff_H[index];
              //We need a copy of the secular var coef to calculate secular change
              TimedMagneticModel.Secular_Var_Coeff_G[index] := MagneticModel.Secular_Var_Coeff_G[index];
            end
          else
            begin
              TimedMagneticModel.Main_Field_Coeff_H[index] := MagneticModel.Main_Field_Coeff_H[index];
              TimedMagneticModel.Main_Field_Coeff_G[index] := MagneticModel.Main_Field_Coeff_G[index];
            end;
          end;
    end;

//MAGtype_LegendreFunction *MAG_AllocateLegendreFunctionMemory(int NumTerms)
procedure MAG_AllocateLegendreFunctionMemory (var LegendreFunction: MAGtype_LegendreFunction); inline;
  var
    i: integer;
  begin
    for i := 0 to BUFSIZE - 1 do
      begin
        LegendreFunction.Pcup[i] := 0.0;
        LegendreFunction.dPcup[i] := 0.0;
      end;
  end; //MAGtype_LegendreFunction

//MAGtype_SphericalHarmonicVariables* MAG_AllocateSphVarMemory(int nMax)
procedure MAG_AllocateSphVarMemory (var SphVariables: MAGtype_SphericalHarmonicVariables); inline;
    var
      i: integer;
    begin
      for i := 0 to MAXSIZE -1 do
        begin
          SphVariables.RelativeRadiusPower[i] := 0.0;
          SphVariables.cos_mlambda[i] := 0.0;
          SphVariables.sin_mlambda[i] := 0.0;
        end;

    end; //MAG_AllocateSphVarMemory

procedure MAG_ComputeSphericalHarmonicVariables (const Ellip: MAGtype_Ellipsoid; const CoordSpherical: MAGtype_CoordSpherical; const nMax: integer; var SphVariables: MAGtype_SphericalHarmonicVariables); inline;
  var
    i: integer;
    cos_lambda, sin_lambda: Real;
  begin
    cos_lambda := cos (DEG2RAD(CoordSpherical.lambda));
    sin_lambda := sin (DEG2RAD(CoordSpherical.lambda));

  {*for n = 0 ... model_order, compute (Radius of Earth / Spherical radius r)^(n+2)
   *for n  1..nMax-1 (this is much faster than calling pow MAX_N+1 times).}
    SphVariables.RelativeRadiusPower[0] := (Ellip.re / CoordSpherical.r) * (Ellip.re / CoordSpherical.r);

    for i := 1 to nMax do
      SphVariables.RelativeRadiusPower[i] :=
        SphVariables.RelativeRadiusPower[i - 1] * (Ellip.re / CoordSpherical.r);

  {* Compute cos(m*lambda), sin(m*lambda) for i = 0 ... nMax
   * cos(a + b) = cos(a)*cos(b) - sin(a)*sin(b)
   * sin(a + b) = cos(a)*sin(b) + sin(a)*cos(b)}
    SphVariables.cos_mlambda[0] := 1.0;
    SphVariables.sin_mlambda[0] := 0.0;
    SphVariables.cos_mlambda[1] := cos_lambda;
    SphVariables.sin_mlambda[1] := sin_lambda;

    for i := 2 to nMax do
      begin
        SphVariables.cos_mlambda[i] := SphVariables.cos_mlambda[i - 1] * cos_lambda -
          SphVariables.sin_mlambda[i - 1] * sin_lambda;
        SphVariables.sin_mlambda[i] := SphVariables.cos_mlambda[i - 1] * sin_lambda +
          SphVariables.sin_mlambda[i - 1] * cos_lambda;
      end;

  end; // MAG_ComputeSphericalHarmonicVariables

function MAG_PcupHigh (var Pcup, dPcup: TRealVektorBUF; const x: Real; const nMax: integer): boolean; inline;
  var
    k, kstart, m, n: integer;
    pm2, pm1, pmm, plm, rescalem, z, scalef: Real;
  begin
    scalef := 1.0e-280;

    if (abs (x) = 1.0) or (nMax = 0) then
      exit (False)
    else
      Result := True;

    for k := 0 to BUFSIZE - 1 do
      begin
        GeomagF1[k] := 0.0;
        GeomagF2[k] := 0.0;
        GeomagPreSqr[k] := 0.0;
      end;

    for n := 0 to 2 * nMax + 1 do
      GeomagPreSqr[n] := sqrt (n);

    k := 2;
    for n := 2 to nMax do
      begin
        Inc(k);

        GeomagF1[k] := (2 * n - 1) / n;
        GeomagF2[k] := (n - 1) / n;

        for m := 1 to n - 2 do
          begin
            k += 1;
            GeomagF1[k] := (2 * n - 1) / GeomagPreSqr[n + m] / GeomagPreSqr[n - m];
            GeomagF2[k] := GeomagPreSqr[n - m - 1] * GeomagPreSqr[n + m - 1] /
              GeomagPreSqr[n + m] / GeomagPreSqr[n - m];
          end;

        Inc(k, 2);
      end;

    // z = sin (geocentric latitude)
    z := sqrt ((1.0 - x) * (1.0 + x));

    pm1 := x;
    pm2 := 1.0;

    Pcup[0] := 1.0;
    Pcup[1] := pm1;
    dPcup[0] := 0.0;
    dPcup[1] := z;

    if nMax <= 0 then
      exit(false);

    k := 1;
    for n := 2 to nMax do
      begin
        Inc(k, n);

        plm := GeomagF1[k] * x * pm1 - GeomagF2[k] * pm2;
        Pcup[k] := plm;

        dPcup[k] := n * (pm1 - x * plm) / z;
        pm2 := pm1;

        pm1 := plm;
      end;

    pmm := GeomagPreSqr[2] * scalef;
    rescalem := 1.0 / scalef;
    kstart := 0;

    for m := 1 to nMax do
      begin
        rescalem := rescalem * z;

        // Calculate Pcup(m,m)
        kstart := kstart + m + 1;
        pmm := pmm * GeomagPreSqr[2 * m + 1] / GeomagPreSqr[2 * m];

        Pcup[kstart] := pmm * rescalem / GeomagPreSqr[2 * m + 1];
        dPcup[kstart] := -m * x * Pcup[kstart] / z;

        pm2 := pmm / GeomagPreSqr[2 * m + 1];

        // Calculate Pcup(m+1,m)
        k := kstart + m + 1;
        pm1 := x * GeomagPreSqr[2 * m + 1] * pm2;

        Pcup[k] := pm1 * rescalem;
        dPcup[k] := ((pm2 * rescalem) * GeomagPreSqr[2 * m + 1] - x * (m + 1) * Pcup[k]) / z;

        // Calculate Pcup(n,m)
        for n := m + 2 to nMax do
          begin
            k := k + n;
            plm := x * GeomagF1[k] * pm1 - GeomagF2[k] * pm2;

            Pcup[k] := plm * rescalem;
            dPcup[k] := (GeomagPreSqr[n + m] * GeomagPreSqr[n - m] * (pm1 * rescalem) -
              n * x * Pcup[k]) / z;

            pm2 := pm1;
            pm1 := plm;
          end;
      end;

    //Calculate Pcup(nMax,nMax)
    rescalem := rescalem * z;
    kstart := kstart + m + 1;
    pmm := pmm / GeomagPreSqr[2 * nMax];

    Pcup[kstart] := pmm * rescalem;
    dPcup[kstart] := -(nMax) * x * Pcup[kstart] / z;

  end; // MAG_PcupHigh

procedure MAG_PcupLow (var Pcup, dPcup: TRealVektorBUF; const x: Real; const nMax: integer); inline;
  var
    k, z: Real;
    n, m, index, index1, index2: integer;
  begin
    Pcup[0] := 1.0;
    dPcup[0] := 0.0;

    //sin (geocentric latitude) - sin_phi
    z := sqrt ((1.0 - x) * (1.0 + x));

    for n := 0 to BUFSIZE - 1 do
      schmidtQuasiNorm[n] := 0.0;

    //First, Compute the Gauss-normalized associated Legendre  functions
    for n := 1 to nMax do
      for m := 0 to n do
        begin
          index := (n * (n + 1) div 2 + m);

          if (n = m) then
            begin
              index1 := (n - 1) * n div 2 + m - 1;
              Pcup[index] := z * Pcup[index1];
              dPcup[index] := z * dPcup[index1] + x * Pcup[index1];
            end
          else
            if (n = 1) and (m = 0) then
              begin
                index1 := (n - 1) * n div 2 + m;
                Pcup[index] := x * Pcup[index1];
                dPcup[index] := x * dPcup[index1] - z * Pcup[index1];
              end
          else
            if (n > 1) and (n <> m) then
              begin
                index1 := (n - 2) * (n - 1) div 2 + m;
                index2 := (n - 1) * n div 2 + m;

                if (m > (n - 2)) then
                  begin
                    Pcup[index] := x * Pcup[index2];
                    dPcup[index] := x * dPcup[index2] - z * Pcup[index2];
                  end
                else
                  begin
                    k := (((n - 1) * (n - 1)) - (m * m)) / ((2 * n - 1) * (2 * n - 3));
                    Pcup[index] := x * Pcup[index2] - k * Pcup[index1];
                    dPcup[index] := x * dPcup[index2] - z * Pcup[index2] - k * dPcup[index1];
                  end;
              end;
        end;

    {* Compute the ration between the the Schmidt quasi-normalized associated Legendre
     * functions and the Gauss-normalized version.}
    schmidtQuasiNorm[0] := 1.0;

    for n := 1 to nMax do
      begin
        index := (n * (n + 1) div 2);
        index1 := (n - 1) * n div 2;

        // for m = 0
        schmidtQuasiNorm[index] := schmidtQuasiNorm[index1] * (2 * n - 1) / n;

        for m := 1 to n do
          begin
            index := (n * (n + 1) div 2 + m);
            index1 := (n * (n + 1) div 2 + m - 1);

            if (m = 1) then
              schmidtQuasiNorm[index] := schmidtQuasiNorm[index1] * sqrt (((n - m + 1) * 2) / (n + m))
            else
              schmidtQuasiNorm[index] := schmidtQuasiNorm[index1] * sqrt ((n - m + 1) / (n + m));
          end;
      end;

    for n := 1 to nMax do
      begin
        for m := 0 to n do
          begin
            index := (n * (n + 1) div 2 + m);
            Pcup[index] := Pcup[index] * schmidtQuasiNorm[index];
            dPcup[index] := -dPcup[index] * schmidtQuasiNorm[index];
            // The sign is changed since the new WMM routines use derivative with respect to latitude insted of co-latitude
          end;
      end;
  end;  // MAG_PcupLow

function MAG_AssociatedLegendreFunction (const CoordSpherical: MAGtype_CoordSpherical; const nMax: integer; var LegendreFunction: MAGtype_LegendreFunction): boolean; inline;
  var
    FLAG: boolean = True;
    sin_phi: Real;
  begin
    //(deg)*(M_PI/180.0L)
    sin_phi := sin ((CoordSpherical.phig) * (Pi / 180.0)); // sin  (geocentric latitude)

    if (nMax <= 16) or ((1 - abs (sin_phi)) < 1.0e-10) then// If nMax is less tha 16 or at the poles
      MAG_PcupLow (LegendreFunction.Pcup, LegendreFunction.dPcup, sin_phi, nMax)
    else
      FLAG := MAG_PcupHigh (LegendreFunction.Pcup, LegendreFunction.dPcup, sin_phi, nMax);

    Result := FLAG;
  end; //MAG_AssociatedLegendreFunction

procedure MAG_SummationSpecial (const MagneticModel: MAGtype_MagneticModel; const SphVariables: MAGtype_SphericalHarmonicVariables; const CoordSpherical: MAGtype_CoordSpherical; var MagneticResults: MAGtype_MagneticResults); inline;
  var
    n, index: integer;
    k, sin_phi, schmidtQuasiNorm1, schmidtQuasiNorm2, schmidtQuasiNorm3: Real;
  begin
    GeomagPcupS[0] := 1;

    for n := 1 to BUFSIZE - 1 do
      GeomagPcupS[n] := 0.0;

    schmidtQuasiNorm1 := 1.0;
    MagneticResults.By := 0.0;

    sin_phi := sin (DEG2RAD(CoordSpherical.phig));

    for n := 1 to MagneticModel.nMax do
      begin
        // Compute the ration between the Gauss-normalized associated Legendre functions and the Schmidt quasi-normalized version. This is equivalent to sqrt((m==0?1:2)*(n-m)!/(n+m!))*(2n-1)!!/(n-m)!
        index := (n * (n + 1) div 2 + 1);

        schmidtQuasiNorm2 := schmidtQuasiNorm1 * (2 * n - 1) / n;
        schmidtQuasiNorm3 := schmidtQuasiNorm2 * sqrt ((n * 2) / (n + 1));
        schmidtQuasiNorm1 := schmidtQuasiNorm2;

        if (n = 1) then
          GeomagPcupS[n] := GeomagPcupS[n - 1]
        else
          begin
            k := (((n - 1) * (n - 1)) - 1) / ((2 * n - 1) * (2 * n - 3));
            GeomagPcupS[n] := sin_phi * GeomagPcupS[n - 1] - k * GeomagPcupS[n - 2];
          end;

        {               1 nMax  (n+2)    n     m            m           m
                By =    SUM (a/r) (m)  SUM  [g cos(m p) + h sin(m p)] dP (sin(phi))
                           n=1             m=0   n            n           n  }
        // Equation 11 in the WMM Technical report. Derivative with respect to longitude, divided by radius.
        MagneticResults.By += SphVariables.RelativeRadiusPower[n] *
          (MagneticModel.Main_Field_Coeff_G[index] * SphVariables.sin_mlambda[1] -
          MagneticModel.Main_Field_Coeff_H[index] * SphVariables.cos_mlambda[1]) *
          GeomagPcupS[n] * schmidtQuasiNorm3;
        end;

    end; // MAG_SummationSpecial

procedure MAG_Summation (const LegendreFunction: MAGtype_LegendreFunction; const MagneticModel: MAGtype_MagneticModel; const SphVariables: MAGtype_SphericalHarmonicVariables; const CoordSpherical: MAGtype_CoordSpherical; var MagneticResults: MAGtype_MagneticResults); inline;
  var
    cos_phi: Real;
    m, n, index: integer;
  begin
    MagneticResults.Bz := 0.0;
    MagneticResults.By := 0.0;
    MagneticResults.Bx := 0.0;

    for n := 1 to MagneticModel.nMax do
      for m := 0 to n do
        begin
          index := (n * (n + 1) div 2 + m);

           {               nMax      (n+2)       n     m            m           m
                   Bz =   -SUM (a/r)   (n+1) SUM  [g cos(m p) + h sin(m p)] P (sin(phi))
                                   n=1              m=0   n            n           n  }
          // Equation 12 in the WMM Technical report.  Derivative with respect to radius.
          MagneticResults.Bz -= SphVariables.RelativeRadiusPower[n] *
            (MagneticModel.Main_Field_Coeff_G[index] * SphVariables.cos_mlambda[m] +
            MagneticModel.Main_Field_Coeff_H[index] * SphVariables.sin_mlambda[m]) *
            (n + 1) * LegendreFunction.Pcup[index];

           {            1 nMax  (n+2)    n     m            m           m
                   By =    SUM (a/r) (m)  SUM  [g cos(m p) + h sin(m p)] dP (sin(phi))
                              n=1             m=0   n            n           n  }
          // Equation 11 in the WMM Technical report. Derivative with respect to longitude, divided by radius.
          MagneticResults.By += SphVariables.RelativeRadiusPower[n] *
            (MagneticModel.Main_Field_Coeff_G[index] * SphVariables.sin_mlambda[m] -
            MagneticModel.Main_Field_Coeff_H[index] * SphVariables.cos_mlambda[m]) *
            m * LegendreFunction.Pcup[index];

           {                nMax  (n+2) n     m            m           m
                   Bx = - SUM (a/r)   SUM  [g cos(m p) + h sin(m p)] dP (sin(phi))
                              n=1         m=0   n            n           n  }
          // Equation 10  in the WMM Technical report. Derivative with respect to latitude, divided by radius.
          MagneticResults.Bx -= SphVariables.RelativeRadiusPower[n] *
            (MagneticModel.Main_Field_Coeff_G[index] * SphVariables.cos_mlambda[m] +
            MagneticModel.Main_Field_Coeff_H[index] * SphVariables.sin_mlambda[m]) *
            LegendreFunction.dPcup[index];
          end;

    cos_phi := cos (DEG2RAD(CoordSpherical.phig));

    if (abs (cos_phi) > 1.0e-10) then
      MagneticResults.By := MagneticResults.By / cos_phi
    else  // Special calculation for component - By - at Geographic poles. If the user wants to avoid using this function,  please make sure that the latitude is not exactly +/-90. An option is to make use the function MAG_CheckGeographicPoles.
      MAG_SummationSpecial (MagneticModel, SphVariables, CoordSpherical, MagneticResults);

  end; //MAG_Summation

procedure MAG_SecVarSummationSpecial (const MagneticModel: MAGtype_MagneticModel; const SphVariables: MAGtype_SphericalHarmonicVariables; const CoordSpherical: MAGtype_CoordSpherical; var MagneticResults: MAGtype_MagneticResults); inline;
  var
    n, index: integer;
    k, sin_phi, schmidtQuasiNorm1, schmidtQuasiNorm2, schmidtQuasiNorm3: Real;
  begin
    for n := 0 to BUFSIZE - 1 do
      GeomagPcupS[n] := 0.0;

    GeomagPcupS[0] := 1;
    schmidtQuasiNorm1 := 1.0;
    MagneticResults.By := 0.0;
    sin_phi := sin (DEG2RAD(CoordSpherical.phig));

    for n := 1 to MagneticModel.nMaxSecVar do
      begin
        index := (n * (n + 1) div 2 + 1);

        schmidtQuasiNorm2 := schmidtQuasiNorm1 * (2 * n - 1) / n;
        schmidtQuasiNorm3 := schmidtQuasiNorm2 * sqrt ((n * 2) / (n + 1));
        schmidtQuasiNorm1 := schmidtQuasiNorm2;

        if (n = 1) then
          GeomagPcupS[n] := GeomagPcupS[n - 1]
        else
          begin
            k := (((n - 1) * (n - 1)) - 1) / ((2 * n - 1) * (2 * n - 3));
            GeomagPcupS[n] := sin_phi * GeomagPcupS[n - 1] - k * GeomagPcupS[n - 2];
          end;

        {          1 nMax  (n+2)    n     m            m           m
                By =    SUM (a/r) (m)  SUM  [g cos(m p) + h sin(m p)] dP (sin(phi))
                           n=1             m=0   n            n           n  }
        // Derivative with respect to longitude, divided by radius.
        MagneticResults.By += SphVariables.RelativeRadiusPower[n] *
          (MagneticModel.Secular_Var_Coeff_G[index] * SphVariables.sin_mlambda[1] -
          MagneticModel.Secular_Var_Coeff_H[index] * SphVariables.cos_mlambda[1]) *
          GeomagPcupS[n] * schmidtQuasiNorm3;
      end;
  end; // SecVarSummationSpecial

procedure MAG_SecVarSummation (const LegendreFunction: MAGtype_LegendreFunction; var MagneticModel: MAGtype_MagneticModel; const SphVariables: MAGtype_SphericalHarmonicVariables; const CoordSpherical: MAGtype_CoordSpherical; var MagneticResults: MAGtype_MagneticResults); inline;
  var
    cos_phi: Real;
    m, n, index: integer;
  begin
    MagneticResults.Bz := 0.0;
    MagneticResults.By := 0.0;
    MagneticResults.Bx := 0.0;

    MagneticModel.SecularVariationUsed := True;

    for n := 1 to MagneticModel.nMaxSecVar do
      for m := 0 to n do
        begin
          index := (n * (n + 1) div 2 + m);

          {             nMax    (n+2)     n     m            m           m
                  Bz =   -SUM (a/r)   (n+1) SUM  [g cos(m p) + h sin(m p)] P (sin(phi))
                                  n=1              m=0   n            n           n  }
          //  Derivative with respect to radius.
          MagneticResults.Bz -= SphVariables.RelativeRadiusPower[n] *
            (MagneticModel.Secular_Var_Coeff_G[index] * SphVariables.cos_mlambda[m] +
            MagneticModel.Secular_Var_Coeff_H[index] * SphVariables.sin_mlambda[m]) *
            (n + 1) * LegendreFunction.Pcup[index];

          {           1 nMax  (n+2)    n     m            m           m
                  By =    SUM (a/r) (m)  SUM  [g cos(m p) + h sin(m p)] dP (sin(phi))
                             n=1             m=0   n            n           n  }
          // Derivative with respect to longitude, divided by radius.
          MagneticResults.By += SphVariables.RelativeRadiusPower[n] *
            (MagneticModel.Secular_Var_Coeff_G[index] * SphVariables.sin_mlambda[m] -
            MagneticModel.Secular_Var_Coeff_H[index] * SphVariables.cos_mlambda[m]) *
            m * LegendreFunction.Pcup[index];

          {            nMax  (n+2) n     m            m           m
                  Bx = - SUM (a/r)   SUM  [g cos(m p) + h sin(m p)] dP (sin(phi))
                             n=1         m=0   n            n           n  }
          // Derivative with respect to latitude, divided by radius.
          MagneticResults.Bx -= SphVariables.RelativeRadiusPower[n] *
            (MagneticModel.Secular_Var_Coeff_G[index] * SphVariables.cos_mlambda[m] +
            MagneticModel.Secular_Var_Coeff_H[index] * SphVariables.sin_mlambda[m]) *
            LegendreFunction.dPcup[index];
        end;

    cos_phi := cos (CoordSpherical.phig * (Pi / 180.0));
    if (abs (cos_phi) > 1.0e-10) then
      MagneticResults.By := MagneticResults.By / cos_phi
    //Special calculation for component By at Geographic poles
    else
      MAG_SecVarSummationSpecial (MagneticModel, SphVariables, CoordSpherical, MagneticResults);

  end; // MAG_SecVarSummation

procedure MAG_RotateMagneticVector (const CoordSpherical: MAGtype_CoordSpherical; const CoordGeodetic: MAGtype_CoordGeodetic; const MagneticResultsSph: MAGtype_MagneticResults; var MagneticResultsGeo: MAGtype_MagneticResults); inline;
  var
    Psi: Real;
  begin
    //Difference between the spherical and Geodetic latitudes
    Psi := (Pi / 180) * (CoordSpherical.phig - CoordGeodetic.phi);

    //Rotate spherical field components to the Geodetic system
    MagneticResultsGeo.Bz := MagneticResultsSph.Bx * sin (Psi) + MagneticResultsSph.Bz * cos (Psi);
    MagneticResultsGeo.Bx := MagneticResultsSph.Bx * cos (Psi) - MagneticResultsSph.Bz * sin (Psi);
    MagneticResultsGeo.By := MagneticResultsSph.By;
  end; // MAG_RotateMagneticVector

procedure MAG_CalculateGeoMagneticElements (const MagneticResultsGeo: MAGtype_MagneticResults; var GeoMagneticElements: MAGtype_GeoMagneticElements); inline;
  begin
    GeoMagneticElements.X := MagneticResultsGeo.Bx;
    GeoMagneticElements.Y := MagneticResultsGeo.By;
    GeoMagneticElements.Z := MagneticResultsGeo.Bz;
    GeoMagneticElements.H := sqrt (MagneticResultsGeo.Bx * MagneticResultsGeo.Bx +
      MagneticResultsGeo.By * MagneticResultsGeo.By);
    GeoMagneticElements.F := sqrt (GeoMagneticElements.H * GeoMagneticElements.H +
      MagneticResultsGeo.Bz * MagneticResultsGeo.Bz);
    GeoMagneticElements.Decl := arctan2 (GeoMagneticElements.Y, GeoMagneticElements.X) * (180.0 / Pi);
    GeoMagneticElements.Incl := arctan2 (GeoMagneticElements.Z, GeoMagneticElements.H) * (180.0 / Pi);
  end; //MAG_CalculateGeoMagneticElements

procedure MAG_CalculateSecularVariationElements (const MagneticVariation: MAGtype_MagneticResults; var MagneticElements: MAGtype_GeoMagneticElements); inline;
  begin
    MagneticElements.Xdot := MagneticVariation.Bx;
    MagneticElements.Ydot := MagneticVariation.By;
    MagneticElements.Zdot := MagneticVariation.Bz;
    MagneticElements.Hdot := (MagneticElements.X * MagneticElements.Xdot + MagneticElements.Y *
      MagneticElements.Ydot) / MagneticElements.H; // See equation 19 in the WMM technical report
    MagneticElements.Fdot := (MagneticElements.X * MagneticElements.Xdot + MagneticElements.Y *
      MagneticElements.Ydot + MagneticElements.Z * MagneticElements.Zdot) / MagneticElements.F;
    MagneticElements.Decldot := 180.0 / Pi * (MagneticElements.X * MagneticElements.Ydot -
      MagneticElements.Y * MagneticElements.Xdot) / (MagneticElements.H * MagneticElements.H);
    MagneticElements.Incldot := 180.0 / Pi * (MagneticElements.H * MagneticElements.Zdot -
      MagneticElements.Z * MagneticElements.Hdot) / (MagneticElements.F * MagneticElements.F);
    MagneticElements.GVdot := MagneticElements.Decldot;
  end;

procedure MAG_Geomag (const CoordSpherical: MAGtype_CoordSpherical; const CoordGeodetic: MAGtype_CoordGeodetic; var TimedMagneticModel: MAGtype_MagneticModel); inline;
  var
    MagneticResultsSph, MagneticResultsGeo, MagneticResultsSphVar,
    MagneticResultsGeoVar: MAGtype_MagneticResults;
  begin
    MAG_AllocateSphVarMemory (GeomagSphVariables);
    MAG_AllocateLegendreFunctionMemory (GeomagLegendreFunction); // For storing the ALF functions

    MAG_ComputeSphericalHarmonicVariables (GeomagEllipsoid, CoordSpherical,
      TimedMagneticModel.nMax, GeomagSphVariables); // Compute Spherical Harmonic variables
    MAG_AssociatedLegendreFunction (CoordSpherical, TimedMagneticModel.nMax, GeomagLegendreFunction);
    // Compute ALF

    MAG_Summation (GeomagLegendreFunction, TimedMagneticModel, GeomagSphVariables,
      CoordSpherical, MagneticResultsSph{%H-}); // Accumulate the spherical harmonic coefficients
    MAG_SecVarSummation (GeomagLegendreFunction, TimedMagneticModel, GeomagSphVariables,
      CoordSpherical, MagneticResultsSphVar{%H-}); //Sum the Secular Variation Coefficients

    MAG_RotateMagneticVector (CoordSpherical, CoordGeodetic, MagneticResultsSph, MagneticResultsGeo{%H-});
    // Map the computed Magnetic fields to Geodeitic coordinates
    MAG_RotateMagneticVector (CoordSpherical, CoordGeodetic, MagneticResultsSphVar, MagneticResultsGeoVar{%H-});
    // Map the secular variation field components to Geodetic coordinates

    MAG_CalculateGeoMagneticElements (MagneticResultsGeo, GeomagGeoMagneticElements);
    // Calculate the Geomagnetic elements, Equation 19 , WMM Technical report
    MAG_CalculateSecularVariationElements (MagneticResultsGeoVar, GeomagGeoMagneticElements);
    //Calculate the secular variation of each of the Geomagnetic elements
    //MAG_FreeLegendreMemory(LegendreFunction);
    //MAG_FreeSphVarMemory(SphVariables);
  end;

function MAG_CalculateGridVariation (location: MAGtype_CoordGeodetic; var elements: MAGtype_GeoMagneticElements): boolean; inline;
  var
    UTMParameters: MAGtype_UTMParameters;
  begin
    if (location.phi >= MAG_PS_MAX_LAT_DEGREE) then
      begin
        elements.GV := elements.Decl - location.lambda;
        Result := True;
      end
    else
      if (location.phi <= MAG_PS_MIN_LAT_DEGREE) then
        begin
          elements.GV := elements.Decl + location.lambda;
          Result := True;
        end
      else
        begin
          MAG_GetTransverseMercator (location, UTMParameters{%H-});
          elements.GV := elements.Decl - UTMParameters.ConvergenceOfMeridians;
          Result := False;
        end;
    end; // MAG_CalculateGridVariation

procedure MAG_WMMErrorCalc (const H: Real; var Uncertainty: MAGtype_GeoMagneticElements); inline;
  var
    decl_variable, decl_constant: Real;
  begin
    Uncertainty.F := WMM_UNCERTAINTY_F;
    Uncertainty.H := WMM_UNCERTAINTY_H;
    Uncertainty.X := WMM_UNCERTAINTY_X;
    Uncertainty.Z := WMM_UNCERTAINTY_Z;
    Uncertainty.Incl := WMM_UNCERTAINTY_I;
    Uncertainty.Y := WMM_UNCERTAINTY_Y;

    decl_variable := (WMM_UNCERTAINTY_D_COEF / H);
    decl_constant := (WMM_UNCERTAINTY_D_OFFSET);

    Uncertainty.Decl := sqrt (decl_constant * decl_constant + decl_variable * decl_variable);

    if (Uncertainty.Decl > 180) then
      Uncertainty.Decl := 180;
  end;

function wmm_Geomag (Value, Year, Month, Day: integer; Lon, Lat, Height: Real): Real;
  var
    TempDecimalSeparator: Char;
    r: double;
    epochs: integer = 1;
    fname: string;
    UserDate: MAGtype_Date;
    CoordGeodetic: MAGtype_CoordGeodetic;
    CoordSpherical: MAGtype_CoordSpherical;
  begin
    if not haveCoeffs then
      begin

      fname := (GetCurrentDir + PathDelim +'WMM.COF');

      //to ensure to get the right DecimalSeparator.
      TempDecimalSeparator := DefaultFormatSettings.DecimalSeparator;
      DefaultFormatSettings.DecimalSeparator := '.';

      MAG_robustReadMagModels (fname, GeomagMagneticModel, epochs);

      DefaultFormatSettings.DecimalSeparator := TempDecimalSeparator;

      if not (GeomagMagneticModel.ModelName = '') then
        begin
        MAG_AllocateModelMemory (GeomagTimedMagneticModel);
        // For storing the time modified WMM Model parameters
        // Set default values and constants, Check for Geographic Poles
        MAG_SetDefaults (GeomagEllipsoid, GeomagGeoid);

        GeomagGeoid.GeoidHeightBuffer := GeoidHeightBuffer;
        GeomagGeoid.Geoid_Initialized := True;
        GeomagGeoid.UseGeoid := True;
        haveCoeffs := True;
        end
      else
        exit (PLERR_NOFILE);
      end;

    if (DateParams[0] <> Year) or (DateParams[1] <> Month) or (DateParams[2] <> Day) or
      (DoubleParams[0] <> Lon) or (DoubleParams[1] <> Lat) or (DoubleParams[2] <> Height) then
      begin
      CoordGeodetic.phi := Lat;
      CoordGeodetic.phi := Lat;
      CoordGeodetic.lambda := Lon;
      CoordGeodetic.HeightAboveGeoid := Height / 1000.0;

      UserDate.DecimalYear := DateToYear (Year, Month, Day);

      //  CoordGeodetic.HeightAboveEllipsoid = Height / 1000.0;
      MAG_ConvertGeoidToEllipsoidHeight (CoordGeodetic, GeomagGeoid);

      DateParams[0] := Year;
      DateParams[1] := Month;
      DateParams[2] := Day;

      DoubleParams[0] := Lon;
      DoubleParams[1] := Lat;
      DoubleParams[2] := Height;

      if ((UserDate.DecimalYear > GeomagMagneticModel.CoefficientFileEndDate) or (UserDate.DecimalYear < GeomagMagneticModel.epoch)) then
        exit(PLERR_GENERALERROR);


      MAG_GeodeticToSpherical (GeomagEllipsoid, CoordGeodetic, CoordSpherical{%H-});
      //Convert from geodetic to Spherical Equations: 17-18, WMM Technical report
      MAG_TimelyModifyMagneticModel (UserDate, GeomagMagneticModel, GeomagTimedMagneticModel);
      //Time adjust the coefficients, Equation 19, WMM Technical report
      MAG_Geomag (CoordSpherical, CoordGeodetic, GeomagTimedMagneticModel);
      // Computes the geoMagnetic field elements and their time change

      if (Abs (Lat) > 55.0) then
        MAG_CalculateGridVariation (CoordGeodetic, &GeomagGeoMagneticElements);

      MAG_WMMErrorCalc (GeomagGeoMagneticElements.H, GeomagErrors);

      if (ABS (Lat) <= 55.0) then
        begin
        GeomagGeoMagneticElements.GV := 0.0;
        GeomagErrors.GV := 0.0;
        end;
      end;

    case Value of
      1: r := GeomagGeoMagneticElements.Decl;
      //  1. Angle between the magnetic field vector and true north, + east
      2: r := GeomagGeoMagneticElements.Incl;
      //  2. Angle between the magnetic field vector and the horizontal plane, + down
      3: r := GeomagGeoMagneticElements.F;       //  3. Magnetic Field Strength
      4: r := GeomagGeoMagneticElements.H;       //  4. Horizontal Magnetic Field Strength
      5: r := GeomagGeoMagneticElements.X;       //  5. Northern component of the magnetic field vector
      6: r := GeomagGeoMagneticElements.Y;       //  6. Eastern component of the magnetic field vector
      7: r := GeomagGeoMagneticElements.Z;       //  7. Downward component of the magnetic field vector
      8: r := GeomagGeoMagneticElements.GV;      //  8. The Grid Variation
      9: r := GeomagGeoMagneticElements.Decldot; //  9. Yearly Rate of change in declination
      10: r := GeomagGeoMagneticElements.Incldot; // 10. Yearly Rate of change in inclination
      11: r := GeomagGeoMagneticElements.Fdot;    // 11. Yearly rate of change in Magnetic field strength
      12: r := GeomagGeoMagneticElements.Hdot;    // 12. Yearly rate of change in horizontal field strength
      13: r := GeomagGeoMagneticElements.Xdot;    // 13. Yearly rate of change in the northern component
      14: r := GeomagGeoMagneticElements.Ydot;    // 14. Yearly rate of change in the eastern component
      15: r := GeomagGeoMagneticElements.Zdot;    // 15. Yearly rate of change in the downward component
      16: r := GeomagGeoMagneticElements.GVdot;   // 16. Yearly rate of change in grid variation
      17: r := GeomagErrors.Decl;
      //  1. Angle between the magnetic field vector and true north, + east
      18: r := GeomagErrors.Incl;
      //  2. Angle between the magnetic field vector and the horizontal plane, + down
      19: r := GeomagErrors.F;                    //  3. Magnetic Field Strength
      20: r := GeomagErrors.H;                    //  4. Horizontal Magnetic Field Strength
      21: r := GeomagErrors.X;                    //  5. Northern component of the magnetic field vector
      22: r := GeomagErrors.Y;                    //  6. Eastern component of the magnetic field vector
      23: r := GeomagErrors.Z;                    //  7. Downward component of the magnetic field vector
      24: r := GeomagErrors.GV;                   //  8. The Grid Variation
    else
      r := PLERR_WRONGVALUE;
      end;

    if (r = INFINITY) then
      r := 0.0;

    {if (r = NAN) then
      r := 0.0;   }

    Result := r;
  end;

end.
