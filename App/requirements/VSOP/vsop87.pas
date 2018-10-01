unit VSOP87;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Math;

const
  VSOP_MEANLONGITUDE = 1;
  VSOP_SEMIMAJORAXIS = 2;
  VSOP_E_COS_P       = 3;
  VSOP_E_SIN_P       = 4;
  VSOP_SIN_g_COS_G   = 5;
  VSOP_SIN_g_SIN_G   = 6;
  VSOP_LONGITUDE     = 7;
  VSOP_LATITUDE      = 8;
  VSOP_RADIUS        = 9;

  VSOP_COORD_X = 1;
  VSOP_COORD_Y = 2;
  VSOP_COORD_Z = 3;

function VSOP870(const Astro, Valor: integer; const T: Real): Real;
function VSOP87A(const Astro, Valor: integer; const  T: Real): Real;
function VSOP87B(const Astro, Valor: integer; const  T: Real): Real;
function VSOP87C(const Astro, Valor: integer; const  T: Real): Real;
function VSOP87D(const Astro, Valor: integer; const  T: Real): Real;
function VSOP87E(const Astro, Valor: integer; const  T: Real): Real;

implementation

type
  VSOPTrm = Record
    A,B,C: Real;
  end;
  TVSOPTrmArray = Array of VSOPTrm;
  TVSOPBodyTermArray =  Array of TVSOPTrmArray;

//---------- VSO870 ------------

                   {$I VSOPMer.pas}  {$I VSOPVen.pas}                    {$I VSOPMar.pas}
 {$I  VSOPJup.pas} {$I VSOPSat.pas}  {$I VSOPUra.pas}  {$I VSOPNep.pas}  {$I VSPOPEmb.pas}

//---------- VSO87A ------------

                   {$I VSOPMerA.pas} {$I VSOPVenA.pas} {$I VSOPEarA.pas} {$I VSOPMarA.pas}
 {$I VSOPJupA.pas} {$I VSOPSatA.pas} {$I VSOPUraA.pas} {$I VSOPNepA.pas} {$I VSOPEmbA.pas}

//---------- VSO87B ------------

                   {$I VSOPMerB.pas} {$I VSOPVenB.pas} {$I VSOPEarB.pas} {$I VSOPMarB.pas}
 {$I VSOPJupB.pas} {$I VSOPSatB.pas} {$I VSOPUraB.pas} {$I VSOPNepB.pas}

//---------- VSO87C ------------

                   {$I VSOPMerC.pas} {$I VSOPVenC.pas} {$I VSOPEarC.pas} {$I VSOPMarC.pas}
 {$I VSOPJupC.pas} {$I VSOPSatC.pas} {$I VSOPUraC.pas} {$I VSOPNepC.pas}

//---------- VSO87D ------------

                   {$I VSOPMerD.pas} {$I VSOPVenD.pas} {$I VSOPEarD.pas} {$I VSOPMarD.pas}
 {$I VSOPJupD.pas} {$I VSOPSatD.pas} {$I VSOPUraD.pas} {$I VSOPNepD.pas}

//---------- VSO87E ------------

 {$I VSOPSunE.pas} {$I VSOPMerE.pas} {$I VSOPVenE.pas} {$I VSOPEarE.pas} {$I VSOPMarE.pas}
 {$I VSOPJupE.pas} {$I VSOPSatE.pas} {$I VSOPUraE.pas} {$I VSOPNepE.pas}

function VSOP870(const Astro, Valor: integer; const T: Real): Real;
  var
    VSOP, t_: Real;
    i,j: integer;
    Terms: TVSOPBodyTermArray;

  function getBody ():TVSOPBodyTermArray;
    begin
      setlength(Result, 6);

      case Valor of
        VSOP_MEANLONGITUDE:
          case Astro of
            1:
              begin
                setlength(Result, 4);

                {$IfDef FPC}
                Result[0] := Mer0L0;
                Result[1] := Mer0L1;
                Result[2] := Mer0L2;
                Result[3] := Mer0L3;
                {$Else}
                Result[0] := @Mer0L0;
                Result[1] := @Mer0L1;
                Result[2] := @Mer0L2;
                Result[3] := @Mer0L3;
                {$EndIf}
              end;
            2:
              begin
                setlength(Result, 4);

                {$IfDef FPC}
                Result[0] := Ven0L0;
                Result[1] := Ven0L1;
                Result[2] := Ven0L2;
                Result[3] := Ven0L3;
                {$Else}
                Result[0] := @Ven0L0;
                Result[1] := @Ven0L1;
                Result[2] := @Ven0L2;
                Result[3] := @Ven0L3;
                {$EndIf}
              end;
            4:
              begin
                {$IfDef FPC}
                Result[0] := Mar0L0;
                Result[1] := Mar0L1;
                Result[2] := Mar0L2;
                Result[3] := Mar0L3;
                Result[4] := Mar0L4;
                Result[5] := Mar0L5;
                {$Else}  
                Result[0] := @Mar0L0;
                Result[1] := @Mar0L1;
                Result[2] := @Mar0L2;
                Result[3] := @Mar0L3;
                Result[4] := @Mar0L4;
                Result[5] := @Mar0L5;
                {$EndIf}
              end;
            5:
              begin
                {$IfDef FPC}
                Result[0] := Jup0L0;
                Result[1] := Jup0L1;
                Result[2] := Jup0L2;
                Result[3] := Jup0L3;
                Result[4] := Jup0L4;
                Result[5] := Jup0L5;  
                {$Else}        
                Result[0] := @Jup0L0;
                Result[1] := @Jup0L1;
                Result[2] := @Jup0L2;
                Result[3] := @Jup0L3;
                Result[4] := @Jup0L4;
                Result[5] := @Jup0L5;
                {$EndIf}
              end;
            6:
              begin
                {$IfDef FPC}
                Result[0] := Sat0L0;
                Result[1] := Sat0L1;
                Result[2] := Sat0L2;
                Result[3] := Sat0L3;
                Result[4] := Sat0L4;
                Result[5] := Sat0L5;  
                {$Else}    
                Result[0] := @Sat0L0;
                Result[1] := @Sat0L1;
                Result[2] := @Sat0L2;
                Result[3] := @Sat0L3;
                Result[4] := @Sat0L4;
                Result[5] := @Sat0L5;
                {$EndIf}
              end;
            7:
              begin
                {$IfDef FPC}
                Result[0] := Ura0L0;
                Result[1] := Ura0L1;
                Result[2] := Ura0L2;
                Result[3] := Ura0L3;
                Result[4] := Ura0L4;
                Result[5] := Ura0L5;  
                {$Else}
                Result[0] := @Ura0L0;
                Result[1] := @Ura0L1;
                Result[2] := @Ura0L2;
                Result[3] := @Ura0L3;
                Result[4] := @Ura0L4;
                Result[5] := @Ura0L5;
                {$EndIf}
              end;
            8:
              begin
                {$IfDef FPC}
                Result[0] := Nep0L0;
                Result[1] := Nep0L1;
                Result[2] := Nep0L2;
                Result[3] := Nep0L3;
                Result[4] := Nep0L4;
                Result[5] := Nep0L5;
                {$Else}    
                Result[0] := @Nep0L0;
                Result[1] := @Nep0L1;
                Result[2] := @Nep0L2;
                Result[3] := @Nep0L3;
                Result[4] := @Nep0L4;
                Result[5] := @Nep0L5;
                {$EndIf}
              end;
            9:
              begin
                {$IfDef FPC}
                Result[0] := Emb0L0;
                Result[1] := Emb0L1;
                Result[2] := Emb0L2;
                Result[3] := Emb0L3;
                Result[4] := Emb0L4;
                Result[5] := Emb0L5;
                {$Else}
                Result[0] := @Emb0L0;
                Result[1] := @Emb0L1;
                Result[2] := @Emb0L2;
                Result[3] := @Emb0L3;
                Result[4] := @Emb0L4;
                Result[5] := @Emb0L5;
                {$EndIf}
              end;
            else
          end;
        VSOP_SEMIMAJORAXIS:
          case Astro of
            1:
              begin
                setlength(Result, 3);

                {$IfDef FPC}
                Result[0] := Mer0a0;
                Result[1] := Mer0a1;
                Result[2] := Mer0a2;
                {$Else}
                Result[0] := @Mer0a0;
                Result[1] := @Mer0a1;
                Result[2] := @Mer0a2;
                {$EndIf}
              end;
            2:
              begin
                setlength(Result, 3);

                {$IfDef FPC}
                Result[0] := Ven0a0;
                Result[1] := Ven0a1;
                Result[2] := Ven0a2;
                {$Else}  
                Result[0] := @Ven0a0;
                Result[1] := @Ven0a1;
                Result[2] := @Ven0a2;
                {$EndIf}
              end;
            4:
              begin
                setlength(Result, 3);

                {$IfDef FPC}
                Result[0] := Mar0a0;
                Result[1] := Mar0a1;
                Result[2] := Mar0a2; 
                {$Else} 
                Result[0] := @Mar0a0;
                Result[1] := @Mar0a1;
                Result[2] := @Mar
                {$EndIf}
              end;
            5:
              begin
                {$IfDef FPC}
                Result[0] := Jup0a0;
                Result[1] := Jup0a1;
                Result[2] := Jup0a2;
                Result[3] := Jup0a3;
                Result[4] := Jup0a4;
                Result[5] := Jup0a5;
                {$Else} 
                Result[0] := @Jup0a0;
                Result[1] := @Jup0a1;
                Result[2] := @Jup0a2;
                Result[3] := @Jup0a3;
                Result[4] := @Jup0a4;
                Result[5] := @Jup0a5;
                {$EndIf}
              end;
            6:
              begin
                {$IfDef FPC}
                Result[0] := Sat0a0;
                Result[1] := Sat0a1;
                Result[2] := Sat0a2;
                Result[3] := Sat0a3;
                Result[4] := Sat0a4;
                Result[5] := Sat0a5;
                {$Else}  
                Result[0] := @Sat0a0;
                Result[1] := @Sat0a1;
                Result[2] := @Sat0a2;
                Result[3] := @Sat0a3;
                Result[4] := @Sat0a4;
                Result[5] := @Sat0a5;
                {$EndIf}
              end;
            7:
              begin
                {$IfDef FPC}
                Result[0] := Ura0a0;
                Result[1] := Ura0a1;
                Result[2] := Ura0a2;
                Result[3] := Ura0a3;
                Result[4] := Ura0a4;
                Result[5] := Ura0a5;   
                {$Else}  
                Result[0] := @Ura0a0;
                Result[1] := @Ura0a1;
                Result[2] := @Ura0a2;
                Result[3] := @Ura0a3;
                Result[4] := @Ura0a4;
                Result[5] := @Ura0a5;
                {$EndIf}
              end;
            8:
              begin
                {$IfDef FPC}
                Result[0] := Nep0a0;
                Result[1] := Nep0a1;
                Result[2] := Nep0a2;
                Result[4] := Nep0a3;
                Result[4] := Nep0a4;
                Result[5] := Nep0a5;
                {$Else}   
                Result[0] := @Nep0a0;
                Result[1] := @Nep0a1;
                Result[2] := @Nep0a2;
                Result[4] := @Nep0a3;
                Result[4] := @Nep0a4;
                Result[5] := @Nep0a5;
                {$EndIf}
              end;
            9:
              begin
                setlength(Result, 3);

                {$IfDef FPC}
                Result[0] := Emb0a0;
                Result[1] := Emb0a1;
                Result[2] := Emb0a2;
                {$Else}    
                Result[0] := @Emb0a0;
                Result[1] := @Emb0a1;
                Result[2] := @Emb0a2;
                {$EndIf}
              end;
            else
          end;
        VSOP_E_COS_P:
          case Astro of
            1:
              begin
                {$IfDef FPC}
                Result[0] := Mer0k0;
                Result[1] := Mer0k1;
                Result[2] := Mer0k2;
                Result[3] := Mer0k3;
                Result[4] := Mer0k4;
                Result[5] := Mer0k5;  
                {$Else}       
                Result[0] := @Mer0k0;
                Result[1] := @Mer0k1;
                Result[2] := @Mer0k2;
                Result[3] := @Mer0k3;
                Result[4] := @Mer0k4;
                Result[5] := @Mer0k5;
                {$EndIf}
              end;
            2:
              begin
                {$IfDef FPC}
                Result[0] := Ven0k0;
                Result[1] := Ven0k1;
                Result[2] := Ven0k2;
                Result[3] := Ven0k3;
                Result[4] := Ven0k4;
                Result[5] := Ven0k5;
                {$Else}    
                Result[0] := @Ven0k0;
                Result[1] := @Ven0k1;
                Result[2] := @Ven0k2;
                Result[3] := @Ven0k3;
                Result[4] := @Ven0k4;
                Result[5] := @Ven0k5;
                {$EndIf}
              end;
            4:
              begin
                {$IfDef FPC}
                Result[0] := Mar0K0;
                Result[1] := Mar0K1;
                Result[2] := Mar0K2;
                Result[3] := Mar0K3;
                Result[4] := Mar0K4;
                Result[5] := Mar0K5; 
                {$Else}  
                Result[0] := @Mar0K0;
                Result[1] := @Mar0K1;
                Result[2] := @Mar0K2;
                Result[3] := @Mar0K3;
                Result[4] := @Mar0K4;
                Result[5] := @Mar0K5;
                {$EndIf}
              end;
            5:
              begin
                setlength(Result, 5);

                {$IfDef FPC}
                Result[0] := Jup0K0;
                Result[1] := Jup0K1;
                Result[2] := Jup0K2;
                Result[3] := Jup0K3;
                Result[4] := Jup0K4;
                {$Else} 
                Result[0] := @Jup0K0;
                Result[1] := @Jup0K1;
                Result[2] := @Jup0K2;
                Result[3] := @Jup0K3;
                Result[4] := @Jup0K4;
                {$EndIf}
              end;
            6:
              begin
                {$IfDef FPC}
                Result[0] := Sat0K0;
                Result[1] := Sat0K1;
                Result[2] := Sat0K2;
                Result[3] := Sat0K3;
                Result[4] := Sat0K4;
                Result[5] := Sat0K5;  
                {$Else}  
                Result[0] := @Sat0K0;
                Result[1] := @Sat0K1;
                Result[2] := @Sat0K2;
                Result[3] := @Sat0K3;
                Result[4] := @Sat0K4;
                Result[5] := @Sat0K5;
                {$EndIf}
              end;
            7:
              begin
                setlength(Result, 5);

                {$IfDef FPC}
                Result[0] := Ura0K0;
                Result[1] := Ura0K1;
                Result[2] := Ura0K2;
                Result[3] := Ura0K3;
                Result[4] := Ura0K4; 
                {$Else}  
                Result[0] := @Ura0K0;
                Result[1] := @Ura0K1;
                Result[2] := @Ura0K2;
                Result[3] := @Ura0K3;
                Result[4] := @Ura0K4;
                {$EndIf}
              end;
            8:
              begin
                {$IfDef FPC}
                Result[0] := Nep0K0;
                Result[1] := Nep0K1;
                Result[2] := Nep0K2;
                Result[3] := Nep0K3;
                Result[4] := Nep0K4;
                Result[5] := Nep0K5; 
                {$Else}
                Result[0] := @Nep0K0;
                Result[1] := @Nep0K1;
                Result[2] := @Nep0K2;
                Result[3] := @Nep0K3;
                Result[4] := @Nep0K4;
                Result[5] := @Nep0K5;
                {$EndIf}
              end;
            9:
              begin
                {$IfDef FPC}
                Result[0] := Emb0k0;
                Result[1] := Emb0k1;
                Result[2] := Emb0k2;
                Result[3] := Emb0k3;
                Result[4] := Emb0k4;
                Result[5] := Emb0k5;   
                {$Else}  
                Result[0] := @Emb0k0;
                Result[1] := @Emb0k1;
                Result[2] := @Emb0k2;
                Result[3] := @Emb0k3;
                Result[4] := @Emb0k4;
                Result[5] := @Emb0k5;
                {$EndIf}
              end;
            else
          end;
        VSOP_E_SIN_P:
          case Astro of
            1:
              begin
                {$IfDef FPC}
                Result[0] := Mer0h0;
                Result[1] := Mer0h1;
                Result[2] := Mer0h2;
                Result[3] := Mer0h3;
                Result[4] := Mer0h4;
                Result[5] := Mer0h5;   
                {$Else}
                Result[0] := @Mer0h0;
                Result[1] := @Mer0h1;
                Result[2] := @Mer0h2;
                Result[3] := @Mer0h3;
                Result[4] := @Mer0h4;
                Result[5] := @Mer0h5;
                {$EndIf}
              end;
            2:
              begin
                {$IfDef FPC}
                Result[0] := Ven0h0;
                Result[1] := Ven0h1;
                Result[2] := Ven0h2;
                Result[3] := Ven0h3;
                Result[4] := Ven0h4;
                Result[5] := Ven0h5; 
                {$Else}  
                Result[0] := @Ven0h0;
                Result[1] := @Ven0h1;
                Result[2] := @Ven0h2;
                Result[3] := @Ven0h3;
                Result[4] := @Ven0h4;
                Result[5] := @Ven0h5;
                {$EndIf}
              end;
            4:
              begin
                {$IfDef FPC}
                Result[0] := Mar0h0;
                Result[1] := Mar0h1;
                Result[2] := Mar0h2;
                Result[3] := Mar0h3;
                Result[4] := Mar0h4;
                Result[5] := Mar0h5;    
                {$Else}      
                Result[0] := @Mar0h0;
                Result[1] := @Mar0h1;
                Result[2] := @Mar0h2;
                Result[3] := @Mar0h3;
                Result[4] := @Mar0h4;
                Result[5] := @Mar0h5;
                {$EndIf}
              end;
            5:
              begin
                setlength(Result, 5);

                {$IfDef FPC}
                Result[0] := Jup0h0;
                Result[1] := Jup0h1;
                Result[2] := Jup0h2;
                Result[3] := Jup0h3;
                Result[4] := Jup0h4; 
                {$Else}
                Result[0] := @Jup0h0;
                Result[1] := @Jup0h1;
                Result[2] := @Jup0h2;
                Result[3] := @Jup0h3;
                Result[4] := @Jup0h4;
                {$EndIf}
              end;
            6:
              begin
                {$IfDef FPC}
                Result[0] := Sat0h0;
                Result[1] := Sat0h1;
                Result[2] := Sat0h2;
                Result[4] := Sat0h3;
                Result[4] := Sat0h4;
                Result[5] := Sat0h5; 
                {$Else}  
                Result[0] := @Sat0h0;
                Result[1] := @Sat0h1;
                Result[2] := @Sat0h2;
                Result[4] := @Sat0h3;
                Result[4] := @Sat0h4;
                Result[5] := @Sat0h5;
                {$EndIf}
              end;
            7:
              begin
                {$IfDef FPC}
                setlength(Result, 5);

                Result[0] := Ura0h0;
                Result[1] := Ura0h1;
                Result[2] := Ura0h2;
                Result[3] := Ura0h3;
                Result[4] := Ura0h4;  
                {$Else}    
                Result[0] := @Ura0h0;
                Result[1] := @Ura0h1;
                Result[2] := @Ura0h2;
                Result[3] := @Ura0h3;
                Result[4] := @Ura0h4;
                {$EndIf}
              end;
            8:
              begin
                {$IfDef FPC}
                Result[0] := Nep0h0;
                Result[1] := Nep0h1;
                Result[2] := Nep0h2;
                Result[3] := Nep0h3;
                Result[4] := Nep0h4;
                Result[5] := Nep0h5;  
                {$Else}  
                Result[0] := @Nep0h0;
                Result[1] := @Nep0h1;
                Result[2] := @Nep0h2;
                Result[3] := @Nep0h3;
                Result[4] := @Nep0h4;
                Result[5] := @Nep0h5;
                {$EndIf}
              end;
            9:
              begin
                {$IfDef FPC}
                Result[0] := Emb0h0;
                Result[1] := Emb0h1;
                Result[2] := Emb0h2;
                Result[3] := Emb0h3;
                Result[4] := Emb0h4;
                Result[5] := Emb0h5;  
                {$Else}    
                Result[0] := @Emb0h0;
                Result[1] := @Emb0h1;
                Result[2] := @Emb0h2;
                Result[3] := @Emb0h3;
                Result[4] := @Emb0h4;
                Result[5] := @Emb0h5;
                {$EndIf}
              end;
            else
          end;
        VSOP_SIN_g_COS_G:
          case Astro of
            1:
              begin
                {$IfDef FPC}
                Result[0] := Mer0q0;
                Result[1] := Mer0q1;
                Result[2] := Mer0q2;
                Result[3] := Mer0q3;
                Result[4] := Mer0q4;
                Result[5] := Mer0q5;    
                {$Else}     
                Result[0] := @Mer0q0;
                Result[1] := @Mer0q1;
                Result[2] := @Mer0q2;
                Result[3] := @Mer0q3;
                Result[4] := @Mer0q4;
                Result[5] := @Mer0q5;
                {$EndIf}
              end;
            2:
              begin
                {$IfDef FPC}
                Result[0] := Ven0q0;
                Result[1] := Ven0q1;
                Result[2] := Ven0q2;
                Result[3] := Ven0q3;
                Result[4] := Ven0q4;
                Result[5] := Ven0q5;
                {$Else}  
                Result[0] := @Ven0q0;
                Result[1] := @Ven0q1;
                Result[2] := @Ven0q2;
                Result[3] := @Ven0q3;
                Result[4] := @Ven0q4;
                Result[5] := @Ven0q5;
                {$EndIf}
              end;
            4:
              begin
                {$IfDef FPC}
                Result[0] := Mar0q0;
                Result[1] := Mar0q1;
                Result[2] := Mar0q2;
                Result[3] := Mar0q3;
                Result[4] := Mar0q4;
                Result[5] := Mar0q5; 
                {$Else}  
                Result[0] := @Mar0q0;
                Result[1] := @Mar0q1;
                Result[2] := @Mar0q2;
                Result[3] := @Mar0q3;
                Result[4] := @Mar0q4;
                Result[5] := @Mar0q5;
                {$EndIf}
              end;
            5:
              begin
                setlength(Result, 4);

                {$IfDef FPC}
                Result[0] := Jup0q0;
                Result[1] := Jup0q1;
                Result[2] := Jup0q2;
                Result[3] := Jup0q3;  
                {$Else}   
                Result[0] := @Jup0q0;
                Result[1] := @Jup0q1;
                Result[2] := @Jup0q2;
                Result[3] := @Jup0q3;
                {$EndIf}
              end;
            6:
              begin
                setlength(Result, 5);

                {$IfDef FPC}
                Result[0] := Sat0q0;
                Result[1] := Sat0q1;
                Result[2] := Sat0q2;
                Result[3] := Sat0q3;
                Result[4] := Sat0q4;   
                {$Else}  
                Result[0] := @Sat0q0;
                Result[1] := @Sat0q1;
                Result[2] := @Sat0q2;
                Result[3] := @Sat0q3;
                Result[4] := @Sat0q4;
                {$EndIf}
              end;
            7:
              begin
                setlength(Result, 4);

                {$IfDef FPC}
                Result[0] := Ura0q0;
                Result[1] := Ura0q1;
                Result[2] := Ura0q2;
                Result[3] := Ura0q3;  
                {$Else} 
                Result[0] := @Ura0q0;
                Result[1] := @Ura0q1;
                Result[2] := @Ura0q2;
                Result[3] := @Ura0q3;
                {$EndIf}
              end;
            8:
              begin
                setlength(Result, 4);

                {$IfDef FPC}
                Result[0] := Nep0q0;
                Result[1] := Nep0q1;
                Result[2] := Nep0q2;
                Result[3] := Nep0q3; 
                {$Else}
                {$EndIf}
              end;
            9:
              begin
                {$IfDef FPC}
                Result[0] := Emb0q0;
                Result[1] := Emb0q1;
                Result[2] := Emb0q2;
                Result[3] := Emb0q3;
                Result[4] := Emb0q4;
                Result[5] := Emb0q5;  
                {$Else}
                Result[0] := @Nep0q0;
                Result[1] := @Nep0q1;
                Result[2] := @Nep0q2;
                Result[3] := @Nep0q3;
                {$EndIf}
              end;
            else
          end;
        VSOP_SIN_g_SIN_G:
          case Astro of
            1:
              begin
                {$IfDef FPC}
                Result[0] := Mer0p0;
                Result[1] := Mer0p1;
                Result[2] := Mer0p2;
                Result[3] := Mer0p3;
                Result[4] := Mer0p4;
                Result[5] := Mer0p5;     
                {$Else}      
                Result[0] := @Mer0p0;
                Result[1] := @Mer0p1;
                Result[2] := @Mer0p2;
                Result[3] := @Mer0p3;
                Result[4] := @Mer0p4;
                Result[5] := @Mer0p5;
                {$EndIf}
              end;
            2:
              begin
                {$IfDef FPC}
                Result[0] := Ven0p0;
                Result[1] := Ven0p1;
                Result[2] := Ven0p2;
                Result[3] := Ven0p3;
                Result[4] := Ven0p4;
                Result[5] := Ven0p5;  
                {$Else}
                Result[0] := @Ven0p0;
                Result[1] := @Ven0p1;
                Result[2] := @Ven0p2;
                Result[3] := @Ven0p3;
                Result[4] := @Ven0p4;
                Result[5] := @Ven0p5;
                {$EndIf}
              end;
            4:
              begin
                setlength(Result, 5);

                {$IfDef FPC}
                Result[0] := Mar0p0;
                Result[1] := Mar0p1;
                Result[2] := Mar0p2;
                Result[3] := Mar0p3;
                Result[4] := Mar0p4; 
                {$Else} 
                Result[0] := @Mar0p0;
                Result[1] := @Mar0p1;
                Result[2] := @Mar0p2;
                Result[3] := @Mar0p3;
                Result[4] := @Mar0p4;
                {$EndIf}
              end;
            5:
              begin
                setlength(Result, 4);

                {$IfDef FPC}
                Result[0] := Jup0p0;
                Result[1] := Jup0p1;
                Result[2] := Jup0p2;
                Result[3] := Jup0p3; 
                {$Else}     
                Result[0] := @Jup0p0;
                Result[1] := @Jup0p1;
                Result[2] := @Jup0p2;
                Result[3] := @Jup0p3;
                {$EndIf}
              end;
            6:
              begin
                setlength(Result, 5);

                {$IfDef FPC}
                Result[0] := Sat0p0;
                Result[1] := Sat0p1;
                Result[2] := Sat0p2;
                Result[3] := Sat0p3;
                Result[4] := Sat0p4; 
                {$Else}    
                Result[0] := @Sat0p0;
                Result[1] := @Sat0p1;
                Result[2] := @Sat0p2;
                Result[3] := @Sat0p3;
                Result[4] := @Sat0p4;
                {$EndIf}
              end;
            7:
              begin
                setlength(Result, 4);

                {$IfDef FPC}
                Result[0] := Ura0p0;
                Result[1] := Ura0p1;
                Result[2] := Ura0p2;
                Result[3] := Ura0p3; 
                {$Else}   
                Result[0] := @Ura0p0;
                Result[1] := @Ura0p1;
                Result[2] := @Ura0p2;
                Result[3] := @Ura0p3;
                {$EndIf}
              end;
            8:
              begin
                setlength(Result, 4);

                {$IfDef FPC}
                Result[0] := Nep0p0;
                Result[1] := Nep0p1;
                Result[2] := Nep0p2;
                Result[3] := Nep0p3; 
                {$Else} 
                Result[0] := @Nep0p0;
                Result[1] := @Nep0p1;
                Result[2] := @Nep0p2;
                Result[3] := @Nep0p3;
                {$EndIf}
              end;
            9:
              begin
                {$IfDef FPC}
                Result[0] := Emb0p0;
                Result[1] := Emb0p1;
                Result[2] := Emb0p2;
                Result[3] := Emb0p3;
                Result[4] := Emb0p4;
                Result[5] := Emb0p5;  
                {$Else} 
                Result[0] := @Emb0p0;
                Result[1] := @Emb0p1;
                Result[2] := @Emb0p2;
                Result[3] := @Emb0p3;
                Result[4] := @Emb0p4;
                Result[5] := @Emb0p5;
                {$EndIf}
              end;
            else
          end;
      end;
    end;

  begin
    if (Astro = 3) then
      exit(0.0);
    if not (Astro in [1..9]) then
      exit(0.0);

    Terms := getBody ();
    VSOP := 0.0;

    for i := 0 to high(Terms) do
      begin
        t_ := 0.0;

        //Write('Astro: ', Astro, ', Val: ', Valor, ', i: ', i);
        //writeln(', lV: ', high(Terms[i]));

        for j :=0 to high(Terms[i]) do
            t_ += Terms[i][j].A * COS(Terms[i][j].B + Terms[i][j].C*T);

        VSOP += t_ * Power(T, i);
        //Writeln('VSOP0 -> VSOP: ', VSOP:4:7);
      end;
    Result := VSOP;

  end;

function VSOP87A(const Astro, Valor: integer; const T: Real): Real;
  var
    VSOP, t_: Real;
    i, j: integer;
    Terms: TVSOPBodyTermArray;

  function getBody (): TVSOPBodyTermArray;
    begin
      setlength(Result, 6);

      case Valor of
        VSOP_COORD_X:
          case Astro of
            1:
              begin
                {$IfDef FPC}
                Result[0] := MerAX0;
                Result[1] := MerAX1;
                Result[2] := MerAX2;
                Result[3] := MerAX3;
                Result[4] := MerAX4;
                Result[5] := MerAX5; 
                {$Else}    
                Result[0] := @MerAX0;
                Result[1] := @MerAX1;
                Result[2] := @MerAX2;
                Result[3] := @MerAX3;
                Result[4] := @MerAX4;
                Result[5] := @MerAX5;
                {$EndIf}
              end;
            2:
              begin
                {$IfDef FPC}
                Result[0] := VenAX0;
                Result[1] := VenAX1;
                Result[2] := VenAX2;
                Result[3] := VenAX3;
                Result[4] := VenAX4;
                Result[5] := VenAX5; 
                {$Else}     
                Result[0] := @VenAX0;
                Result[1] := @VenAX1;
                Result[2] := @VenAX2;
                Result[3] := @VenAX3;
                Result[4] := @VenAX4;
                Result[5] := @VenAX5;
                {$EndIf}
              end;
            3:
              begin
                {$IfDef FPC}
                Result[0] := EarAX0;
                Result[1] := EarAX1;
                Result[2] := EarAX2;
                Result[3] := EarAX3;
                Result[4] := EarAX4;
                Result[5] := EarAX5; 
                {$Else}   
                Result[0] := @EarAX0;
                Result[1] := @EarAX1;
                Result[2] := @EarAX2;
                Result[3] := @EarAX3;
                Result[4] := @EarAX4;
                Result[5] := @EarAX5;
                {$EndIf}
              end;
            4:
              begin 
                {$IfDef FPC}
                Result[0] := MarAX0;
                Result[1] := MarAX1;
                Result[2] := MarAX2;
                Result[3] := MarAX3;
                Result[4] := MarAX4;
                Result[5] := MarAX5;
                {$Else}   
                Result[0] := @MarAX0;
                Result[1] := @MarAX1;
                Result[2] := @MarAX2;
                Result[3] := @MarAX3;
                Result[4] := @MarAX4;
                Result[5] := @MarAX5;
                {$EndIf}
              end;
            5:
              begin 
                {$IfDef FPC}
                Result[0] := JupAX0;
                Result[1] := JupAX1;
                Result[2] := JupAX2;
                Result[3] := JupAX3;
                Result[4] := JupAX4;
                Result[5] := JupAX5; 
                {$Else}     
                Result[0] := @JupAX0;
                Result[1] := @JupAX1;
                Result[2] := @JupAX2;
                Result[3] := @JupAX3;
                Result[4] := @JupAX4;
                Result[5] := @JupAX5;
                {$EndIf}
              end;
            6:
              begin
                {$IfDef FPC}
                Result[0] := SatAX0;
                Result[1] := SatAX1;
                Result[2] := SatAX2;
                Result[3] := SatAX3;
                Result[4] := SatAX4;
                Result[5] := SatAX5; 
                {$Else}     
                Result[0] := @SatAX0;
                Result[1] := @SatAX1;
                Result[2] := @SatAX2;
                Result[3] := @SatAX3;
                Result[4] := @SatAX4;
                Result[5] := @SatAX5;
                {$EndIf}
              end;
            7:
              begin
                setlength(Result, 5);
                
                {$IfDef FPC}
                Result[0] := UraAX0;
                Result[1] := UraAX1;
                Result[2] := UraAX2;
                Result[3] := UraAX3;
                Result[4] := UraAX4; 
                {$Else}   
                Result[0] := @UraAX0;
                Result[1] := @UraAX1;
                Result[2] := @UraAX2;
                Result[3] := @UraAX3;
                Result[4] := @UraAX4;
                {$EndIf}
              end;
            8:
              begin
                setlength(Result, 5);
                
                {$IfDef FPC}
                Result[0] := NepAX0;
                Result[1] := NepAX1;
                Result[2] := NepAX2;
                Result[3] := NepAX3;
                Result[4] := NepAX4;  
                {$Else}    
                Result[0] := @NepAX0;
                Result[1] := @NepAX1;
                Result[2] := @NepAX2;
                Result[3] := @NepAX3;
                Result[4] := @NepAX4;
                {$EndIf}
              end;
            9:
              begin 
                {$IfDef FPC}
                Result[0] := EmbAX0;
                Result[1] := EmbAX1;
                Result[2] := EmbAX2;
                Result[3] := EmbAX3;
                Result[4] := EmbAX4;
                Result[5] := EmbAX5;  
                {$Else}    
                Result[0] := @EmbAX0;
                Result[1] := @EmbAX1;
                Result[2] := @EmbAX2;
                Result[3] := @EmbAX3;
                Result[4] := @EmbAX4;
                Result[5] := @EmbAX5;
                {$EndIf}
              end;
          end;
        VSOP_COORD_Y:
          case Astro of
            1:
              begin     
                {$IfDef FPC}
                Result[0] := MerAY0;
                Result[1] := MerAY1;
                Result[2] := MerAY2;
                Result[3] := MerAY3;
                Result[4] := MerAY4;
                Result[5] := MerAY5;    
                {$Else}   
                Result[0] := @MerAY0;
                Result[1] := @MerAY1;
                Result[2] := @MerAY2;
                Result[3] := @MerAY3;
                Result[4] := @MerAY4;
                Result[5] := @MerAY5;
                {$EndIf}
              end;
            2:
              begin     
                {$IfDef FPC}
                Result[0] := VenAY0;
                Result[1] := VenAY1;
                Result[2] := VenAY2;
                Result[3] := VenAY3;
                Result[4] := VenAY4;
                Result[5] := VenAY5;  
                {$Else} 
                Result[0] := @VenAY0;
                Result[1] := @VenAY1;
                Result[2] := @VenAY2;
                Result[3] := @VenAY3;
                Result[4] := @VenAY4;
                Result[5] := @VenAY5;
                {$EndIf}
              end;
            3:
              begin  
                {$IfDef FPC}
                Result[0] := EarAY0;
                Result[1] := EarAY1;
                Result[2] := EarAY2;
                Result[3] := EarAY3;
                Result[4] := EarAY4;
                Result[5] := EarAY5; 
                {$Else}  
                  Result[0] := @EarAY0;
                  Result[1] := @EarAY1;
                  Result[2] := @EarAY2;
                  Result[3] := @EarAY3;
                  Result[4] := @EarAY4;
                  Result[5] := @EarAY5;
                {$EndIf}
              end;
            4:
              begin   
                {$IfDef FPC}
                Result[0] := MarAY0;
                Result[1] := MarAY1;
                Result[2] := MarAY2;
                Result[3] := MarAY3;
                Result[4] := MarAY4;
                Result[5] := MarAY5; 
                {$Else} 
                Result[0] := @MarAY0;
                Result[1] := @MarAY1;
                Result[2] := @MarAY2;
                Result[3] := @MarAY3;
                Result[4] := @MarAY4;
                Result[5] := @MarAY5;
                {$EndIf}
              end;
            5:
              begin   
                {$IfDef FPC}
                Result[0] := JupAY0;
                Result[1] := JupAY1;
                Result[2] := JupAY2;
                Result[3] := JupAY3;
                Result[4] := JupAY4;
                Result[5] := JupAY5; 
                {$Else}    
                Result[0] := @JupAY0;
                Result[1] := @JupAY1;
                Result[2] := @JupAY2;
                Result[3] := @JupAY3;
                Result[4] := @JupAY4;
                Result[5] := @JupAY5;
                {$EndIf}
              end;
            6:
              begin   
                {$IfDef FPC}
                Result[0] := SatAY0;
                Result[1] := SatAY1;
                Result[2] := SatAY2;
                Result[3] := SatAY3;
                Result[4] := SatAY4;
                Result[5] := SatAY5; 
                {$Else}   
                Result[0] := @SatAY0;
                Result[1] := @SatAY1;
                Result[2] := @SatAY2;
                Result[3] := @SatAY3;
                Result[4] := @SatAY4;
                Result[5] := @SatAY5;
                {$EndIf}
              end;
            7:
              begin
                setlength(Result, 5);
                    
                {$IfDef FPC}
                Result[0] := UraAY0;
                Result[1] := UraAY1;
                Result[2] := UraAY2;
                Result[3] := UraAY3;
                Result[4] := UraAY4; 
                {$Else} 
                Result[0] := @UraAY0;
                Result[1] := @UraAY1;
                Result[2] := @UraAY2;
                Result[3] := @UraAY3;
                Result[4] := @UraAY4;
                {$EndIf}
              end;
            8:
              begin
                setlength(Result, 5);
                   
                {$IfDef FPC}
                Result[0] := NepAY0;
                Result[1] := NepAY1;
                Result[2] := NepAY2;
                Result[3] := NepAY3;
                Result[4] := NepAY4;  
                {$Else}  
                Result[0] := @NepAY0;
                Result[1] := @NepAY1;
                Result[2] := @NepAY2;
                Result[3] := @NepAY3;
                Result[4] := @NepAY4;
                {$EndIf}
              end;
            9:
              begin  
                {$IfDef FPC}
                Result[0] := EmbAY0;
                Result[1] := EmbAY1;
                Result[2] := EmbAY2;
                Result[3] := EmbAY3;
                Result[4] := EmbAY4;
                Result[5] := EmbAY5;  
                {$Else}     
                Result[0] := @EmbAY0;
                Result[1] := @EmbAY1;
                Result[2] := @EmbAY2;
                Result[3] := @EmbAY3;
                Result[4] := @EmbAY4;
                Result[5] := @EmbAY5;
                {$EndIf}
              end;
          end;
      VSOP_COORD_Z:
          case Astro of
            1:
              begin    
                {$IfDef FPC}
                Result[0] := MerAZ0;
                Result[1] := MerAZ1;
                Result[2] := MerAZ2;
                Result[3] := MerAZ3;
                Result[4] := MerAZ4;
                Result[5] := MerAZ5;   
                {$Else} 
                Result[0] := @MerAZ0;
                Result[1] := @MerAZ1;
                Result[2] := @MerAZ2;
                Result[3] := @MerAZ3;
                Result[4] := @MerAZ4;
                Result[5] := @MerAZ5;
                {$EndIf}
              end;
            2:
              begin  
                {$IfDef FPC}
                Result[0] := VenAZ0;
                Result[1] := VenAZ1;
                Result[2] := VenAZ2;
                Result[3] := VenAZ3;
                Result[4] := VenAZ4;
                Result[5] := VenAZ5;  
                {$Else}   
                Result[0] := @VenAZ0;
                Result[1] := @VenAZ1;
                Result[2] := @VenAZ2;
                Result[3] := @VenAZ3;
                Result[4] := @VenAZ4;
                Result[5] := @VenAZ5;
                {$EndIf}
              end;
            3:
              begin  
                {$IfDef FPC}
                Result[0] := EarAZ0;
                Result[1] := EarAZ1;
                Result[2] := EarAZ2;
                Result[3] := EarAZ3;
                Result[4] := EarAZ4;
                Result[5] := EarAZ5; 
                {$Else} 
                Result[0] := @EarAZ0;
                Result[1] := @EarAZ1;
                Result[2] := @EarAZ2;
                Result[3] := @EarAZ3;
                Result[4] := @EarAZ4;
                Result[5] := @EarAZ5;
                {$EndIf}
              end;
            4:
              begin  
                {$IfDef FPC}
                Result[0] := MarAZ0;
                Result[1] := MarAZ1;
                Result[2] := MarAZ2;
                Result[3] := MarAZ3;
                Result[4] := MarAZ4;
                Result[5] := MarAZ5; 
                {$Else} 
                Result[0] := @MarAZ0;
                Result[1] := @MarAZ1;
                Result[2] := @MarAZ2;
                Result[3] := @MarAZ3;
                Result[4] := @MarAZ4;
                Result[5] := @MarAZ5;
                {$EndIf}
              end;
            5:
              begin   
                {$IfDef FPC}
                Result[0] := JupAZ0;
                Result[1] := JupAZ1;
                Result[2] := JupAZ2;
                Result[3] := JupAZ3;
                Result[4] := JupAZ4;
                Result[5] := JupAZ5;  
                {$Else}    
                Result[0] := @JupAZ0;
                Result[1] := @JupAZ1;
                Result[2] := @JupAZ2;
                Result[3] := @JupAZ3;
                Result[4] := @JupAZ4;
                Result[5] := @JupAZ5;
                {$EndIf}
              end;
            6:
              begin   
                {$IfDef FPC}
                Result[0] := SatAZ0;
                Result[1] := SatAZ1;
                Result[2] := SatAZ2;
                Result[3] := SatAZ3;
                Result[4] := SatAZ4;
                Result[5] := SatAZ5;              
                {$Else}   
                Result[0] := @SatAZ0;
                Result[1] := @SatAZ1;
                Result[2] := @SatAZ2;
                Result[3] := @SatAZ3;
                Result[4] := @SatAZ4;
                Result[5] := @SatAZ5;
                {$EndIf}
              end;
            7:
              begin   
                {$IfDef FPC}
                Result[0] := UraAZ0;
                Result[1] := UraAZ1;
                Result[2] := UraAZ2;
                Result[3] := UraAZ3;  
                {$Else}    
                Result[0] := @UraAZ0;
                Result[1] := @UraAZ1;
                Result[2] := @UraAZ2;
                Result[3] := @UraAZ3;
                {$EndIf}
              end;
            8:
              begin
                setlength(Result, 4);

                {$IfDef FPC}
                Result[0] := NepAZ0;
                Result[1] := NepAZ1;
                Result[2] := NepAZ2;
                Result[3] := NepAZ3;   
                {$Else}    
                Result[0] := @NepAZ0;
                Result[1] := @NepAZ1;
                Result[2] := @NepAZ2;
                Result[3] := @NepAZ3;
                {$EndIf}
              end;
            9:
              begin         
                {$IfDef FPC}
                Result[0] := EmbAZ0;
                Result[1] := EmbAZ1;
                Result[2] := EmbAZ2;
                Result[3] := EmbAZ3;
                Result[4] := EmbAZ4;
                Result[5] := EmbAZ5;   
                {$Else}  
                Result[0] := @EmbAZ0;
                Result[1] := @EmbAZ1;
                Result[2] := @EmbAZ2;
                Result[3] := @EmbAZ3;
                Result[4] := @EmbAZ4;
                Result[5] := @EmbAZ5;
                {$EndIf}
              end;
            end;
      end;
    end;

  begin
    if not (Astro in [1..9]) then
      exit(0.0);

    Terms := getBody ();
    VSOP := 0.0;

    for i := 0 to high(Terms) do
      begin
        t_ := 0.0;

        for j := 0 to high(Terms[i]) do
            t_ += Terms[i][j].A * COS(Terms[i][j].B + Terms[i][j].C*T);

        VSOP += (t_ * power(T, i));
      end;
    Result := VSOP;
  end;

function VSOP87B(const Astro, Valor: integer; const T: Real): Real;
  var
    VSOP, t_: Real;
    i,j: integer;
    Terms: TVSOPBodyTermArray;

  function getBody(): TVSOPBodyTermArray;
    begin
      setlength(Result, 6);

      case Valor of
        VSOP_LONGITUDE:
          case Astro of
            1:
              begin

                {$IfDef FPC}
                Result[0] := MerBL0;
                Result[1] := MerBL1;
                Result[2] := MerBL2;
                Result[3] := MerBL3;
                Result[4] := MerBL4;
                Result[5] := MerBL5;   
                {$Else}  
                Result[0] := @MerBL0;
                Result[1] := @MerBL1;
                Result[2] := @MerBL2;
                Result[3] := @MerBL3;
                Result[4] := @MerBL4;
                Result[5] := @MerBL5;
                {$EndIf}
              end;
            2:
              begin
                {$IfDef FPC}
                Result[0] := VenBL0;
                Result[1] := VenBL1;
                Result[2] := VenBL2;
                Result[3] := VenBL3;
                Result[4] := VenBL4;
                Result[5] := VenBL5;       
                {$Else} 
                Result[0] := @VenBL0;
                Result[1] := @VenBL1;
                Result[2] := @VenBL2;
                Result[3] := @VenBL3;
                Result[4] := @VenBL4;
                Result[5] := @VenBL5;
                {$EndIf}
              end;
            3:
              begin 
                {$IfDef FPC}
                Result[0] := EarBL0;
                Result[1] := EarBL1;
                Result[2] := EarBL2;
                Result[3] := EarBL3;
                Result[4] := EarBL4;
                Result[5] := EarBL5;
                {$Else}  
                Result[0] := @EarBL0;
                Result[1] := @EarBL1;
                Result[2] := @EarBL2;
                Result[3] := @EarBL3;
                Result[4] := @EarBL4;
                Result[5] := @EarBL5;
                {$EndIf}
              end;
            4:
              begin 
                {$IfDef FPC}
                Result[0] := MarBL0;
                Result[1] := MarBL1;
                Result[2] := MarBL2;
                Result[3] := MarBL3;
                Result[4] := MarBL4;
                Result[5] := MarBL5;  
                {$Else}   
                Result[0] := @MarBL0;
                Result[1] := @MarBL1;
                Result[2] := @MarBL2;
                Result[3] := @MarBL3;
                Result[4] := @MarBL4;
                Result[5] := @MarBL5;
                {$EndIf}
              end;
            5:
              begin  
                {$IfDef FPC}
                Result[0] := JupBL0;
                Result[1] := JupBL1;
                Result[2] := JupBL2;
                Result[3] := JupBL3;
                Result[4] := JupBL4;
                Result[5] := JupBL5; 
                {$Else}   
                Result[0] := @JupBL0;
                Result[1] := @JupBL1;
                Result[2] := @JupBL2;
                Result[3] := @JupBL3;
                Result[4] := @JupBL4;
                Result[5] := @JupBL5;
                {$EndIf}
              end;
            6:
              begin
                {$IfDef FPC}
                Result[0] := SatBL0;
                Result[1] := SatBL1;
                Result[2] := SatBL2;
                Result[3] := SatBL3;
                Result[4] := SatBL4;
                Result[5] := SatBL5; 
                {$Else}   
                Result[0] := @SatBL0;
                Result[1] := @SatBL1;
                Result[2] := @SatBL2;
                Result[3] := @SatBL3;
                Result[4] := @SatBL4;
                Result[5] := @SatBL5;
                {$EndIf}
              end;
            7:
              begin
                Setlength(Result, 5);
                 
                {$IfDef FPC}
                Result[0] := UraBL0;
                Result[1] := UraBL1;
                Result[2] := UraBL2;
                Result[3] := UraBL3;
                Result[4] := UraBL4; 
                {$Else} 
                Result[0] := @UraBL0;
                Result[1] := @UraBL1;
                Result[2] := @UraBL2;
                Result[3] := @UraBL3;
                Result[4] := @UraBL4;
                {$EndIf}
              end;
            8:
              begin
                Setlength(Result, 4);
                 
                {$IfDef FPC}
                Result[0] := NepBL0;
                Result[1] := NepBL1;
                Result[2] := NepBL2;
                Result[3] := NepBL3; 
                {$Else}    
                Result[0] := @NepBL0;
                Result[1] := @NepBL1;
                Result[2] := @NepBL2;
                Result[3] := @NepBL3;
                {$EndIf}
              end;
          end;
        VSOP_LATITUDE:
          case Astro of
            1:
              begin
                {$IfDef FPC}
                Result[0] := MerBB0;
                Result[1] := MerBB1;
                Result[2] := MerBB2;
                Result[3] := MerBB3;
                Result[4] := MerBB4;
                Result[5] := MerBB5; 
                {$Else} 
                Result[0] := @MerBB0;
                Result[1] := @MerBB1;
                Result[2] := @MerBB2;
                Result[3] := @MerBB3;
                Result[4] := @MerBB4;
                Result[5] := @MerBB5;
                {$EndIf}
              end;
            2:
              begin   
                {$IfDef FPC}
                Result[0] := VenBB0;
                Result[1] := VenBB1;
                Result[2] := VenBB2;
                Result[3] := VenBB3;
                Result[4] := VenBB4;
                Result[5] := VenBB5; 
                {$Else}  
                Result[0] := @VenBB0;
                Result[1] := @VenBB1;
                Result[2] := @VenBB2;
                Result[3] := @VenBB3;
                Result[4] := @VenBB4;
                Result[5] := @VenBB5;
                {$EndIf}
              end;
            3:
              begin 
                {$IfDef FPC}
                Result[0] := EarBB0;
                Result[1] := EarBB1;
                Result[2] := EarBB2;
                Result[3] := EarBB3;
                Result[4] := EarBB4;
                Result[5] := EarBB5;   
                {$Else} 
                Result[0] := @EarBB0;
                Result[1] := @EarBB1;
                Result[2] := @EarBB2;
                Result[3] := @EarBB3;
                Result[4] := @EarBB4;
                Result[5] := @EarBB5;
                {$EndIf}
              end;
            4:
              begin  
                {$IfDef FPC}
                Result[0] := MarBB0;
                Result[1] := MarBB1;
                Result[2] := MarBB2;
                Result[3] := MarBB3;
                Result[4] := MarBB4;
                Result[5] := MarBB5; 
                {$Else}   
                Result[0] := @MarBB0;
                Result[1] := @MarBB1;
                Result[2] := @MarBB2;
                Result[3] := @MarBB3;
                Result[4] := @MarBB4;
                Result[5] := @MarBB5;
                {$EndIf}
              end;
            5:
              begin  
                {$IfDef FPC}
                Result[0] := JupBB0;
                Result[1] := JupBB1;
                Result[2] := JupBB2;
                Result[3] := JupBB3;
                Result[4] := JupBB4;
                Result[5] := JupBB5;
                {$Else} 
                Result[0] := @JupBB0;
                Result[1] := @JupBB1;
                Result[2] := @JupBB2;
                Result[3] := @JupBB3;
                Result[4] := @JupBB4;
                Result[5] := @JupBB5;
                {$EndIf}
              end;
            6:
              begin 
                {$IfDef FPC}
                Result[0] := SatBB0;
                Result[1] := SatBB1;
                Result[2] := SatBB2;
                Result[3] := SatBB3;
                Result[4] := SatBB4;
                Result[5] := SatBB5;
                {$Else}   
                Result[0] := @SatBB0;
                Result[1] := @SatBB1;
                Result[2] := @SatBB2;
                Result[3] := @SatBB3;
                Result[4] := @SatBB4;
                Result[5] := @SatBB5;
                {$EndIf}
              end;
            7:
              begin
                Setlength(Result, 4);
                
                {$IfDef FPC}
                Result[0] := UraBB0;
                Result[1] := UraBB1;
                Result[2] := UraBB2;
                Result[3] := UraBB3; 
                {$Else}   
                Result[0] := @UraBB0;
                Result[1] := @UraBB1;
                Result[2] := @UraBB2;
                Result[3] := @UraBB3;
                {$EndIf}
              end;
            8:
              begin
                Setlength(Result, 4);
                  
                {$IfDef FPC}
                Result[0] := NepBB0;
                Result[1] := NepBB1;
                Result[2] := NepBB2;
                Result[3] := NepBB3;      
                {$Else} 
                Result[0] := @NepBB0;
                Result[1] := @NepBB1;
                Result[2] := @NepBB2;
                Result[3] := @NepBB3;
                {$EndIf}
              end;
          end;
        VSOP_RADIUS:
          case Astro of
            1:
              begin       
                {$IfDef FPC}
                Result[0] := MerBR0;
                Result[1] := MerBR1;
                Result[2] := MerBR2;
                Result[3] := MerBR3;
                Result[4] := MerBR4;
                Result[5] := MerBR5; 
                {$Else} 
                Result[0] := @MerBR0;
                Result[1] := @MerBR1;
                Result[2] := @MerBR2;
                Result[3] := @MerBR3;
                Result[4] := @MerBR4;
                Result[5] := @MerBR5;
                {$EndIf}
              end;
            2:
              begin  
                {$IfDef FPC}
                Result[0] := VenBR0;
                Result[1] := VenBR1;
                Result[2] := VenBR2;
                Result[3] := VenBR3;
                Result[4] := VenBR4;
                Result[5] := VenBR5;
                {$Else}
                Result[0] := @VenBR0;
                Result[1] := @VenBR1;
                Result[2] := @VenBR2;
                Result[3] := @VenBR3;
                Result[4] := @VenBR4;
                Result[5] := @VenBR5;
                {$EndIf}
              end;
            3:
              begin  
                {$IfDef FPC}
                Result[0] := EarBR0;
                Result[1] := EarBR1;
                Result[2] := EarBR2;
                Result[3] := EarBR3;
                Result[4] := EarBR4;
                Result[5] := EarBR5; 
                {$Else} 
                Result[0] := @EarBR0;
                Result[1] := @EarBR1;
                Result[2] := @EarBR2;
                Result[3] := @EarBR3;
                Result[4] := @EarBR4;
                Result[5] := @EarBR5;
                {$EndIf}
              end;
            4:
              begin   
                {$IfDef FPC}
                Result[0] := MarBR0;
                Result[1] := MarBR1;
                Result[2] := MarBR2;
                Result[3] := MarBR3;
                Result[4] := MarBR4;
                Result[5] := MarBR5; 
                {$Else}   
                Result[0] := @MarBR0;
                Result[1] := @MarBR1;
                Result[2] := @MarBR2;
                Result[3] := @MarBR3;
                Result[4] := @MarBR4;
                Result[5] := @MarBR5;
                {$EndIf}
              end;
            5:
              begin     
                {$IfDef FPC}
                Result[0] := JupBR0;
                Result[1] := JupBR1;
                Result[2] := JupBR2;
                Result[3] := JupBR3;
                Result[4] := JupBR4;
                Result[5] := JupBR5;  
                {$Else}  Result[0] := @JupBR0;
                Result[1] := @JupBR1;
                Result[2] := @JupBR2;
                Result[3] := @JupBR3;
                Result[4] := @JupBR4;
                Result[5] := @JupBR5;
                {$EndIf}
              end;
            6:
              begin   
                {$IfDef FPC}
                Result[0] := SatBR0;
                Result[1] := SatBR1;
                Result[2] := SatBR2;
                Result[3] := SatBR3;
                Result[4] := SatBR4;
                Result[5] := SatBR5; 
                {$Else}  
                Result[0] := @SatBR0;
                Result[1] := @SatBR1;
                Result[2] := @SatBR2;
                Result[3] := @SatBR3;
                Result[4] := @SatBR4;
                Result[5] := @SatBR5;
                {$EndIf}
              end;
            7:
              begin
                Setlength(Result, 5);
                
                {$IfDef FPC}
                Result[0] := UraBR0;
                Result[1] := UraBR1;
                Result[2] := UraBR2;
                Result[3] := UraBR3;
                Result[4] := UraBR4;
                {$Else}   
                Result[0] := @UraBR0;
                Result[1] := @UraBR1;
                Result[2] := @UraBR2;
                Result[3] := @UraBR3;
                Result[4] := @UraBR4;
                {$EndIf}
              end;
            8:
              begin
                Setlength(Result, 5);
                  
                {$IfDef FPC}
                Result[0] := NepBR0;
                Result[1] := NepBR1;
                Result[2] := NepBR2;
                Result[3] := NepBR3;
                Result[4] := NepBR4;
                {$Else}  
                Result[0] := @NepBR0;
                Result[1] := @NepBR1;
                Result[2] := @NepBR2;
                Result[3] := @NepBR3;
                Result[4] := @NepBR4;
                {$EndIf}
              end;
          end;
      end;
    end;

  begin

    if not (Astro in [1..8]) then
      exit(0.0);

    Terms := getBody();
    VSOP := 0.0;

    for i := 0 to high(Terms)do
      begin
        t_ := 0.0;

        for j := 0 to high(Terms[i]) do
          t_ += Terms[i][j].A * COS(Terms[i][j].B + Terms[i][j].C*T);

      VSOP += (t * power(T, i));
      end;

    Result := VSOP;
  end;

function VSOP87C(const Astro, Valor: integer; const T: Real): Real;
  var
    VSOP, t_: Real;
    i, j: integer;
    Terms: TVSOPBodyTermArray;

  function getBody(): TVSOPBodyTermArray;
    begin
      setlength(Result, 6);

      case Valor of
        VSOP_COORD_X:
          case Astro of
            1:
              begin 
                {$IfDef FPC}
                Result[0] := MerCX0;
                Result[1] := MerCX1;
                Result[2] := MerCX2;
                Result[3] := MerCX3;
                Result[4] := MerCX4;
                Result[5] := MerCX5;
                {$Else}
                Result[0] := @MerCX0;
                Result[1] := @MerCX1;
                Result[2] := @MerCX2;
                Result[3] := @MerCX3;
                Result[4] := @MerCX4;
                Result[5] := @MerCX5;
                {$EndIf}
              end;
            2:
              begin 
                {$IfDef FPC}
                Result[0] := VenCX0;
                Result[1] := VenCX1;
                Result[2] := VenCX2;
                Result[3] := VenCX3;
                Result[4] := VenCX4;
                Result[5] := VenCX5;  
                {$Else}
                Result[0] := @VenCX0;
                Result[1] := @VenCX1;
                Result[2] := @VenCX2;
                Result[3] := @VenCX3;
                Result[4] := @VenCX4;
                Result[5] := @VenCX5;
                {$EndIf}
              end;
            3:
              begin    
                {$IfDef FPC}
                Result[0] := EarCX0;
                Result[1] := EarCX1;
                Result[2] := EarCX2;
                Result[3] := EarCX3;
                Result[4] := EarCX4;
                Result[5] := EarCX5;   
                {$Else}   
                Result[0] := @EarCX0;
                Result[1] := @EarCX1;
                Result[2] := @EarCX2;
                Result[3] := @EarCX3;
                Result[4] := @EarCX4;
                Result[5] := @EarCX5;
                {$EndIf}
              end;
            4:
              begin  
                {$IfDef FPC}
                Result[0] := MarCX0;
                Result[1] := MarCX1;
                Result[2] := MarCX2;
                Result[3] := MarCX3;
                Result[4] := MarCX4;
                Result[5] := MarCX5;   
                {$Else}  
                Result[0] := @MarCX0;
                Result[1] := @MarCX1;
                Result[2] := @MarCX2;
                Result[3] := @MarCX3;
                Result[4] := @MarCX4;
                Result[5] := @MarCX5;
                {$EndIf}
              end;
            5:
              begin  
                {$IfDef FPC}
                Result[0] := JupCX0;
                Result[1] := JupCX1;
                Result[2] := JupCX2;
                Result[3] := JupCX3;
                Result[4] := JupCX4;
                Result[5] := JupCX5; 
                {$Else}
                Result[0] := @JupCX0;
                Result[1] := @JupCX1;
                Result[2] := @JupCX2;
                Result[3] := @JupCX3;
                Result[4] := @JupCX4;
                Result[5] := @JupCX5;
                {$EndIf}
              end;
            6:
              begin 
                {$IfDef FPC}
                Result[0] := SatCX0;
                Result[1] := SatCX1;
                Result[2] := SatCX2;
                Result[3] := SatCX3;
                Result[4] := SatCX4;
                Result[5] := SatCX5;
                {$Else}
                Result[0] := @SatCX0;
                Result[1] := @SatCX1;
                Result[2] := @SatCX2;
                Result[3] := @SatCX3;
                Result[4] := @SatCX4;
                Result[5] := @SatCX5;
                {$EndIf}
              end;
            7:
              begin  
                {$IfDef FPC}
                Result[0] := UraCX0;
                Result[1] := UraCX1;
                Result[2] := UraCX2;
                Result[3] := UraCX3;
                Result[4] := UraCX4;
                Result[5] := UraCX5;  
                {$Else} 
                Result[0] := @UraCX0;
                Result[1] := @UraCX1;
                Result[2] := @UraCX2;
                Result[3] := @UraCX3;
                Result[4] := @UraCX4;
                Result[5] := @UraCX5;
                {$EndIf}
              end;
            8:
              begin  
                {$IfDef FPC}
                Result[0] := NepCX0;
                Result[1] := NepCX1;
                Result[2] := NepCX2;
                Result[3] := NepCX3;
                Result[4] := NepCX4;
                Result[5] := NepCX5; 
                {$Else}  
                Result[0] := @NepCX0;
                Result[1] := @NepCX1;
                Result[2] := @NepCX2;
                Result[3] := @NepCX3;
                Result[4] := @NepCX4;
                Result[5] := @NepCX5;
                {$EndIf}
              end;
          end;
        VSOP_COORD_Y:
          case Astro of
            1:
              begin 
                {$IfDef FPC}
                Result[0] := MerCY0;
                Result[1] := MerCY1;
                Result[2] := MerCY2;
                Result[3] := MerCY3;
                Result[4] := MerCY4;
                Result[5] := MerCY5;  
                {$Else}
                Result[0] := @MerCY0;
                Result[1] := @MerCY1;
                Result[2] := @MerCY2;
                Result[3] := @MerCY3;
                Result[4] := @MerCY4;
                Result[5] := @MerCY5;
                {$EndIf}
              end;
            2:
              begin  
                {$IfDef FPC}
                Result[0] := VenCY0;
                Result[1] := VenCY1;
                Result[2] := VenCY2;
                Result[3] := VenCY3;
                Result[4] := VenCY4;
                Result[5] := VenCY5;
                {$Else}  
                Result[0] := @VenCY0;
                Result[1] := @VenCY1;
                Result[2] := @VenCY2;
                Result[3] := @VenCY3;
                Result[4] := @VenCY4;
                Result[5] := @VenCY5;
                {$EndIf}
              end;
            3:
              begin  
                {$IfDef FPC}
                Result[0] := EarCY0;
                Result[1] := EarCY1;
                Result[2] := EarCY2;
                Result[3] := EarCY3;
                Result[4] := EarCY4;
                Result[5] := EarCY5;  
                {$Else}
                Result[0] := @EarCY0;
                Result[1] := @EarCY1;
                Result[2] := @EarCY2;
                Result[3] := @EarCY3;
                Result[4] := @EarCY4;
                Result[5] := @EarCY5;
                {$EndIf}
              end;
            4:
              begin   
                {$IfDef FPC}
                Result[0] := MarCY0;
                Result[1] := MarCY1;
                Result[2] := MarCY2;
                Result[3] := MarCY3;
                Result[4] := MarCY4;
                Result[5] := MarCY5;  
                {$Else}  
                Result[0] := @MarCY0;
                Result[1] := @MarCY1;
                Result[2] := @MarCY2;
                Result[3] := @MarCY3;
                Result[4] := @MarCY4;
                Result[5] := @MarCY5;
                {$EndIf}
              end;
            5:
              begin  
                {$IfDef FPC}
                Result[0] := JupCY0;
                Result[1] := JupCY1;
                Result[2] := JupCY2;
                Result[3] := JupCY3;
                Result[4] := JupCY4;
                Result[5] := JupCY5;  
                {$Else}   
                Result[0] := @JupCY0;
                Result[1] := @JupCY1;
                Result[2] := @JupCY2;
                Result[3] := @JupCY3;
                Result[4] := @JupCY4;
                Result[5] := @JupCY5;
                {$EndIf}
              end;
            6:
              begin    
                {$IfDef FPC}
                Result[0] := SatCY0;
                Result[1] := SatCY1;
                Result[2] := SatCY2;
                Result[3] := SatCY3;
                Result[4] := SatCY4;
                Result[5] := SatCY5; 
                {$Else} 
                Result[0] := @SatCY0;
                Result[1] := @SatCY1;
                Result[2] := @SatCY2;
                Result[3] := @SatCY3;
                Result[4] := @SatCY4;
                Result[5] := @SatCY5;
                {$EndIf}
              end;
            7:
              begin    
                {$IfDef FPC}
                Result[0] := UraCY0;
                Result[1] := UraCY1;
                Result[2] := UraCY2;
                Result[3] := UraCY3;
                Result[4] := UraCY4;
                Result[5] := UraCY5;  
                {$Else} 
                Result[0] := @UraCY0;
                Result[1] := @UraCY1;
                Result[2] := @UraCY2;
                Result[3] := @UraCY3;
                Result[4] := @UraCY4;
                Result[5] := @UraCY5;
                {$EndIf}
              end;
            8:
              begin   
                {$IfDef FPC}
                Result[0] := NepCY0;
                Result[1] := NepCY1;
                Result[2] := NepCY2;
                Result[3] := NepCY3;
                Result[4] := NepCY4;
                Result[5] := NepCY5; 
                {$Else}      
                Result[0] := @NepCY0;
                Result[1] := @NepCY1;
                Result[2] := @NepCY2;
                Result[3] := @NepCY3;
                Result[4] := @NepCY4;
                Result[5] := @NepCY5;
                {$EndIf}
              end;
          end;
        VSOP_COORD_Z:
          case Astro of
            1:
              begin   
                {$IfDef FPC}
                Result[0] := MerCZ0;
                Result[1] := MerCZ1;
                Result[2] := MerCZ2;
                Result[3] := MerCZ3;
                Result[4] := MerCZ4;
                Result[5] := MerCZ5;  
                {$Else}   
                Result[0] := @MerCZ0;
                Result[1] := @MerCZ1;
                Result[2] := @MerCZ2;
                Result[3] := @MerCZ3;
                Result[4] := @MerCZ4;
                Result[5] := @MerCZ5;
                {$EndIf}
              end;
            2:
              begin 
                {$IfDef FPC}
                Result[0] := VenCZ0;
                Result[1] := VenCZ1;
                Result[2] := VenCZ2;
                Result[3] := VenCZ3;
                Result[4] := VenCZ4;
                Result[5] := VenCZ5;  
                {$Else} 
                Result[0] := @VenCZ0;
                Result[1] := @VenCZ1;
                Result[2] := @VenCZ2;
                Result[3] := @VenCZ3;
                Result[4] := @VenCZ4;
                Result[5] := @VenCZ5;
                {$EndIf}
              end;
            3:
              begin
                Setlength(Result, 5);
                
                {$IfDef FPC}
                Result[0] := EarCZ0;
                Result[1] := EarCZ1;
                Result[2] := EarCZ2;
                Result[3] := EarCZ3;
                Result[4] := EarCZ4;  
                {$Else}  
                Result[0] := @EarCZ0;
                Result[1] := @EarCZ1;
                Result[2] := @EarCZ2;
                Result[3] := @EarCZ3;
                Result[4] := @EarCZ4;
                {$EndIf}
              end;
            4:
              begin  
                {$IfDef FPC}
                Result[0] := MarCZ0;
                Result[1] := MarCZ1;
                Result[2] := MarCZ2;
                Result[3] := MarCZ3;
                Result[4] := MarCZ4;
                Result[5] := MarCZ5;  
                {$Else} 
                Result[0] := @MarCZ0;
                Result[1] := @MarCZ1;
                Result[2] := @MarCZ2;
                Result[3] := @MarCZ3;
                Result[4] := @MarCZ4;
                Result[5] := @MarCZ5;
                {$EndIf}
              end;
            5:
              begin   
                {$IfDef FPC}
                Result[0] := JupCZ0;
                Result[1] := JupCZ1;
                Result[2] := JupCZ2;
                Result[3] := JupCZ3;
                Result[4] := JupCZ4;
                Result[5] := JupCZ5;  
                {$Else}    
                Result[0] := @JupCZ0;
                Result[1] := @JupCZ1;
                Result[2] := @JupCZ2;
                Result[3] := @JupCZ3;
                Result[4] := @JupCZ4;
                Result[5] := @JupCZ5;
                {$EndIf}
              end;
            6:
              begin   
                {$IfDef FPC}
                Result[0] := SatCZ0;
                Result[1] := SatCZ1;
                Result[2] := SatCZ2;
                Result[3] := SatCZ3;
                Result[4] := SatCZ4;
                Result[5] := SatCZ5;  
                {$Else}  
                Result[0] := @SatCZ0;
                Result[1] := @SatCZ1;
                Result[2] := @SatCZ2;
                Result[3] := @SatCZ3;
                Result[4] := @SatCZ4;
                Result[5] := @SatCZ5;
                {$EndIf}
              end;
            7:
              begin   
                {$IfDef FPC}
                Result[0] := UraCZ0;
                Result[1] := UraCZ1;
                Result[2] := UraCZ2;
                Result[3] := UraCZ3;
                Result[4] := UraCZ4;
                Result[5] := UraCZ5;  
                {$Else}     
                Result[0] := @UraCZ0;
                Result[1] := @UraCZ1;
                Result[2] := @UraCZ2;
                Result[3] := @UraCZ3;
                Result[4] := @UraCZ4;
                Result[5] := @UraCZ5;
                {$EndIf}
              end;
            8:
              begin  
                {$IfDef FPC}
                Result[0] := NepCZ0;
                Result[1] := NepCZ1;
                Result[2] := NepCZ2;
                Result[3] := NepCZ3;
                Result[4] := NepCZ4;
                Result[5] := NepCZ5;  
                {$Else}
                Result[0] := @NepCZ0;
                Result[1] := @NepCZ1;
                Result[2] := @NepCZ2;
                Result[3] := @NepCZ3;
                Result[4] := @NepCZ4;
                Result[5] := @NepCZ5;
                {$EndIf}
              end;
          end;
      end;
    end;

  begin

    if not (Astro in [1..8]) then
      exit(0.0);

    Terms := getBody();
    VSOP := 0.0;

    for i := 0 to high(Terms)do
      begin
        t_ := 0.0;

        for j := 0 to high(Terms[i]) do
          t_ += Terms[i][j].A * cos(Terms[i][j].B + Terms[i][j].C*T);

        VSOP += (t_ * power(T, i));
      end;

    Result := VSOP;
  end;

function VSOP87D(const Astro, Valor: integer; const T: Real): Real;
 var
   VSOP, t_: Real;
   i, j: integer;
   Terms: TVSOPBodyTermArray;

 function getBody(): TVSOPBodyTermArray;
    begin
      setlength(Result, 6);

      case Valor of
        VSOP_LONGITUDE:
          case Astro of
            1:
              begin  
                {$IfDef FPC}
                Result[0] := MerDL0;
                Result[1] := MerDL1;
                Result[2] := MerDL2;
                Result[3] := MerDL3;
                Result[4] := MerDL4;
                Result[5] := MerDL5; 
                {$Else}  
                Result[0] := @MerDL0;
                Result[1] := @MerDL1;
                Result[2] := @MerDL2;
                Result[3] := @MerDL3;
                Result[4] := @MerDL4;
                Result[5] := @MerDL5;
                {$EndIf}
              end;
            2:
              begin  
                {$IfDef FPC}
                Result[0] := VenDL0;
                Result[1] := VenDL1;
                Result[2] := VenDL2;
                Result[3] := VenDL3;
                Result[4] := VenDL4;
                Result[5] := VenDL5; 
                {$Else}  
                Result[0] := @VenDL0;
                Result[1] := @VenDL1;
                Result[2] := @VenDL2;
                Result[3] := @VenDL3;
                Result[4] := @VenDL4;
                Result[5] := @VenDL5;
                {$EndIf}
              end;
            3:
              begin
                {$IfDef FPC}
                Result[0] := EarDL0;
                Result[1] := EarDL1;
                Result[2] := EarDL2;
                Result[3] := EarDL3;
                Result[4] := EarDL4;
                Result[5] := EarDL5;    
                {$Else}
                Result[0] := @EarDL0;
                Result[1] := @EarDL1;
                Result[2] := @EarDL2;
                Result[3] := @EarDL3;
                Result[4] := @EarDL4;
                Result[5] := @EarDL5;
                {$EndIf}
              end;
            4:
              begin    
                {$IfDef FPC}
                Result[0] := MarDL0;
                Result[1] := MarDL1;
                Result[2] := MarDL2;
                Result[3] := MarDL3;
                Result[4] := MarDL4;
                Result[5] := MarDL5;
                {$Else} 
                Result[0] := @MarDL0;
                Result[1] := @MarDL1;
                Result[2] := @MarDL2;
                Result[3] := @MarDL3;
                Result[4] := @MarDL4;
                Result[5] := @MarDL5;
                {$EndIf}
              end;
            5:
              begin    
                {$IfDef FPC}
                Result[0] := JupDL0;
                Result[1] := JupDL1;
                Result[2] := JupDL2;
                Result[3] := JupDL3;
                Result[4] := JupDL4;
                Result[5] := JupDL5;  
                {$Else}   
                Result[0] := @JupDL0;
                Result[1] := @JupDL1;
                Result[2] := @JupDL2;
                Result[3] := @JupDL3;
                Result[4] := @JupDL4;
                Result[5] := @JupDL5;
                {$EndIf}
              end;
            6:
              begin       
                {$IfDef FPC}
                Result[0] := SatDL0;
                Result[1] := SatDL1;
                Result[2] := SatDL2;
                Result[3] := SatDL3;
                Result[4] := SatDL4;
                Result[5] := SatDL5;  
                {$Else}  
                Result[0] := @SatDL0;
                Result[1] := @SatDL1;
                Result[2] := @SatDL2;
                Result[3] := @SatDL3;
                Result[4] := @SatDL4;
                Result[5] := @SatDL5;
                {$EndIf}
              end;
            7:
              begin         
                {$IfDef FPC}
                Result[0] := UraDL0;
                Result[1] := UraDL1;
                Result[2] := UraDL2;
                Result[3] := UraDL3;
                Result[4] := UraDL4;
                Result[5] := UraDL5;      
                {$Else} 
                Result[0] := @UraDL0;
                Result[1] := @UraDL1;
                Result[2] := @UraDL2;
                Result[3] := @UraDL3;
                Result[4] := @UraDL4;
                Result[5] := @UraDL5;
                {$EndIf}
              end;
            8:
              begin         
                {$IfDef FPC}
                Result[0] := NepDL0;
                Result[1] := NepDL1;
                Result[2] := NepDL2;
                Result[3] := NepDL3;
                Result[4] := NepDL4;
                Result[5] := NepDL5; 
                {$Else} 
                Result[0] := @NepDL0;
                Result[1] := @NepDL1;
                Result[2] := @NepDL2;
                Result[3] := @NepDL3;
                Result[4] := @NepDL4;
                Result[5] := @NepDL5;
                {$EndIf}
              end;
          end;
        VSOP_LATITUDE:
          case Astro of
            1:
              begin         
                {$IfDef FPC}
                Result[0] := MerDB0;
                Result[1] := MerDB1;
                Result[2] := MerDB2;
                Result[3] := MerDB3;
                Result[4] := MerDB4;
                Result[5] := MerDB5; 
                {$Else} 
                Result[0] := @MerDB0;
                Result[1] := @MerDB1;
                Result[2] := @MerDB2;
                Result[3] := @MerDB3;
                Result[4] := @MerDB4;
                Result[5] := @MerDB5;
                {$EndIf}
              end;
            2:
              begin         
                {$IfDef FPC}
                Result[0] := VenDB0;
                Result[1] := VenDB1;
                Result[2] := VenDB2;
                Result[3] := VenDB3;
                Result[4] := VenDB4;
                Result[5] := VenDB5; 
                {$Else} 
                Result[0] := @VenDB0;
                Result[1] := @VenDB1;
                Result[2] := @VenDB2;
                Result[3] := @VenDB3;
                Result[4] := @VenDB4;
                Result[5] := @VenDB5;
                {$EndIf}
              end;
            3:
              begin
                Setlength(Result, 5);
                            
                {$IfDef FPC}
                Result[0] := EarDB0;
                Result[1] := EarDB1;
                Result[2] := EarDB2;
                Result[3] := EarDB3;
                Result[4] := EarDB4; 
                {$Else} 
                Result[0] := @EarDB0;
                Result[1] := @EarDB1;
                Result[2] := @EarDB2;
                Result[3] := @EarDB3;
                Result[4] := @EarDB4;
                {$EndIf}
              end;
            4:
              begin         
                {$IfDef FPC}
                Result[0] := MarDB0;
                Result[1] := MarDB1;
                Result[2] := MarDB2;
                Result[3] := MarDB3;
                Result[4] := MarDB4;
                Result[5] := MarDB5; 
                {$Else} 
                Result[0] := @MarDB0;
                Result[1] := @MarDB1;
                Result[2] := @MarDB2;
                Result[3] := @MarDB3;
                Result[4] := @MarDB4;
                Result[5] := @MarDB5;
                {$EndIf}
              end;
            5:
              begin         
                {$IfDef FPC}
                Result[0] := JupDB0;
                Result[1] := JupDB1;
                Result[2] := JupDB2;
                Result[3] := JupDB3;
                Result[4] := JupDB4;
                Result[5] := JupDB5;
                {$Else}  
                Result[0] := @JupDB0;
                Result[1] := @JupDB1;
                Result[2] := @JupDB2;
                Result[3] := @JupDB3;
                Result[4] := @JupDB4;
                Result[5] := @JupDB5;
                {$EndIf}
              end;
            6:
              begin         
                {$IfDef FPC}
                Result[0] := SatDB0;
                Result[1] := SatDB1;
                Result[2] := SatDB2;
                Result[3] := SatDB3;
                Result[4] := SatDB4;
                Result[5] := SatDB5; 
                {$Else}  
                Result[0] := @SatDB0;
                Result[1] := @SatDB1;
                Result[2] := @SatDB2;
                Result[3] := @SatDB3;
                Result[4] := @SatDB4;
                Result[5] := @SatDB5;
                {$EndIf}
              end;
            7:
              begin
                Setlength(Result, 5);
                            
                {$IfDef FPC}
                Result[0] := UraDB0;
                Result[1] := UraDB1;
                Result[2] := UraDB2;
                Result[3] := UraDB3;
                Result[4] := UraDB4; 
                {$Else}
                Result[0] := @UraDB0;
                Result[1] := @UraDB1;
                Result[2] := @UraDB2;
                Result[3] := @UraDB3;
                Result[4] := @UraDB4;
                {$EndIf}
              end;
            8:
              begin         
                {$IfDef FPC}
                Result[0] := NepDB0;
                Result[1] := NepDB1;
                Result[2] := NepDB2;
                Result[3] := NepDB3;
                Result[4] := NepDB4;
                Result[5] := NepDB5;
                {$Else}   
                Result[0] := @NepDB0;
                Result[1] := @NepDB1;
                Result[2] := @NepDB2;
                Result[3] := @NepDB3;
                Result[4] := @NepDB4;
                Result[5] := @NepDB5;
                {$EndIf}
              end;
          end;
        VSOP_RADIUS:
          case Astro of
            1:
              begin         
                {$IfDef FPC}
                Result[0] := MerDR0;
                Result[1] := MerDR1;
                Result[2] := MerDR2;
                Result[3] := MerDR3;
                Result[4] := MerDR4;
                Result[5] := MerDR5;
                {$Else}  
                Result[0] := @MerDR0;
                Result[1] := @MerDR1;
                Result[2] := @MerDR2;
                Result[3] := @MerDR3;
                Result[4] := @MerDR4;
                Result[5] := @MerDR5;
                {$EndIf}
              end;
            2:
              begin         
                {$IfDef FPC}
                Result[0] := VenDR0;
                Result[1] := VenDR1;
                Result[2] := VenDR2;
                Result[3] := VenDR3;
                Result[4] := VenDR4;
                Result[5] := VenDR5;
                {$Else}  
                Result[0] := @VenDR0;
                Result[1] := @VenDR1;
                Result[2] := @VenDR2;
                Result[3] := @VenDR3;
                Result[4] := @VenDR4;
                Result[5] := @VenDR5;
                {$EndIf}
              end;
            3:
              begin         
                {$IfDef FPC}
                Result[0] := EarDR0;
                Result[1] := EarDR1;
                Result[2] := EarDR2;
                Result[3] := EarDR3;
                Result[4] := EarDR4;
                Result[5] := EarDR5;
                {$Else}   
                Result[0] := @EarDR0;
                Result[1] := @EarDR1;
                Result[2] := @EarDR2;
                Result[3] := @EarDR3;
                Result[4] := @EarDR4;
                Result[5] := @EarDR5;
                {$EndIf}
              end;
            4:
              begin         
                {$IfDef FPC}
                Result[0] := MarDR0;
                Result[1] := MarDR1;
                Result[2] := MarDR2;
                Result[3] := MarDR3;
                Result[4] := MarDR4;
                Result[5] := MarDR5; 
                {$Else}  
                Result[0] := @MarDR0;
                Result[1] := @MarDR1;
                Result[2] := @MarDR2;
                Result[3] := @MarDR3;
                Result[4] := @MarDR4;
                Result[5] := @MarDR5;
                {$EndIf}
              end;
            5:
              begin         
                {$IfDef FPC}
                Result[0] := JupDR0;
                Result[1] := JupDR1;
                Result[2] := JupDR2;
                Result[3] := JupDR3;
                Result[4] := JupDR4;
                Result[5] := JupDR5; 
                {$Else}     
                Result[0] := @JupDR0;
                Result[1] := @JupDR1;
                Result[2] := @JupDR2;
                Result[3] := @JupDR3;
                Result[4] := @JupDR4;
                Result[5] := @JupDR5;
                {$EndIf}
              end;
            6:
              begin         
                {$IfDef FPC}
                Result[0] := SatDR0;
                Result[1] := SatDR1;
                Result[2] := SatDR2;
                Result[3] := SatDR3;
                Result[4] := SatDR4;
                Result[5] := SatDR5; 
                {$Else}    
                Result[0] := @SatDR0;
                Result[1] := @SatDR1;
                Result[2] := @SatDR2;
                Result[3] := @SatDR3;
                Result[4] := @SatDR4;
                Result[5] := @SatDR5;
                {$EndIf}
              end;
            7:
              begin
                Setlength(Result, 5);
                            
                {$IfDef FPC}
                Result[0] := UraDR0;
                Result[1] := UraDR1;
                Result[2] := UraDR2;
                Result[3] := UraDR3;
                Result[4] := UraDR4;
                {$Else}   
                Result[0] := @UraDR0;
                Result[1] := @UraDR1;
                Result[2] := @UraDR2;
                Result[3] := @UraDR3;
                Result[4] := @UraDR4;
                {$EndIf}
              end;
            8:
              begin
                Setlength(Result, 5);
                            
                {$IfDef FPC}
                Result[0] := NepDR0;
                Result[1] := NepDR1;
                Result[2] := NepDR2;
                Result[3] := NepDR3;
                Result[4] := NepDR4;
                {$Else}
                Result[0] := @NepDR0;
                Result[1] := @NepDR1;
                Result[2] := @NepDR2;
                Result[3] := @NepDR3;
                Result[4] := @NepDR4;
                {$EndIf}
              end;
          end;
      end;
    end;

begin
  if not (Astro in [1..8]) then
    exit(0.0);

  Terms := getBody();
  VSOP := 0.0;

  for i := 0 to high(Terms)do
    begin
      t_ := 0.0;

      for j := 0 to high(Terms[i]) do
        t_ += Terms[i][j].A * cos(Terms[i][j].B + Terms[i][j].C*T);

      VSOP += (t_ * power(T, i));
    end;

  Result := VSOP;
end;

function VSOP87E(const Astro, Valor: integer; const T: Real): Real;
  var
    VSOP,t_ : Real;
    i, j: integer;
    Terms: TVSOPBodyTermArray;

  function getBody(): TVSOPBodyTermArray;
    begin
      setlength(Result, 6);

      case Valor of
        VSOP_COORD_X:
          case Astro of
            1:
              begin 
                {$IfDef FPC}
                Result[0] := MerEX0;
                Result[1] := MerEX1;
                Result[2] := MerEX2;
                Result[3] := MerEX3;
                Result[4] := MerEX4;
                Result[5] := MerEX5;
                {$Else}
                Result[0] := @MerEX0;
                Result[1] := @MerEX1;
                Result[2] := @MerEX2;
                Result[3] := @MerEX3;
                Result[4] := @MerEX4;
                Result[5] := @MerEX5;
                {$EndIf}
              end;
            2:
              begin  
                {$IfDef FPC}
                Result[0] := VenEX0;
                Result[1] := VenEX1;
                Result[2] := VenEX2;
                Result[3] := VenEX3;
                Result[4] := VenEX4;
                Result[5] := VenEX5;
                {$Else}  
                Result[0] := @VenEX0;
                Result[1] := @VenEX1;
                Result[2] := @VenEX2;
                Result[3] := @VenEX3;
                Result[4] := @VenEX4;
                Result[5] := @VenEX5;
                {$EndIf}
              end;
            3:
              begin
              {$IfDef FPC}
                Result[0] := EarEX0;
                Result[1] := EarEX1;
                Result[2] := EarEX2;
                Result[3] := EarEX3;
                Result[4] := EarEX4;
                Result[5] := EarEX5;
                {$Else}   
                Result[0] := @EarEX0;
                Result[1] := @EarEX1;
                Result[2] := @EarEX2;
                Result[3] := @EarEX3;
                Result[4] := @EarEX4;
                Result[5] := @EarEX5;
                {$EndIf}
              end;
            4:
              begin     
                {$IfDef FPC}
                Result[0] := MarEX0;
                Result[1] := MarEX1;
                Result[2] := MarEX2;
                Result[3] := MarEX3;
                Result[4] := MarEX4;
                Result[5] := MarEX5;
                {$Else} 
                Result[0] := @MarEX0;
                Result[1] := @MarEX1;
                Result[2] := @MarEX2;
                Result[3] := @MarEX3;
                Result[4] := @MarEX4;
                Result[5] := @MarEX5;
                {$EndIf}
              end;
            5:
              begin  
                {$IfDef FPC}
                Result[0] := JupEX0;
                Result[1] := JupEX1;
                Result[2] := JupEX2;
                Result[3] := JupEX3;
                Result[4] := JupEX4;
                Result[5] := JupEX5;
                {$Else}
                Result[0] := @JupEX0;
                Result[1] := @JupEX1;
                Result[2] := @JupEX2;
                Result[3] := @JupEX3;
                Result[4] := @JupEX4;
                Result[5] := @JupEX5;
                {$EndIf}
              end;
            6:
              begin  
                {$IfDef FPC}
                Result[0] := SatEX0;
                Result[1] := SatEX1;
                Result[2] := SatEX2;
                Result[3] := SatEX3;
                Result[4] := SatEX4;
                Result[5] := SatEX5;
                {$Else} 
                Result[0] := @SatEX0;
                Result[1] := @SatEX1;
                Result[2] := @SatEX2;
                Result[3] := @SatEX3;
                Result[4] := @SatEX4;
                Result[5] := @SatEX5;
                {$EndIf}
              end;
            7:
              begin   
                {$IfDef FPC}
                Setlength(Result, 5);

                Result[0] := UraEX0;
                Result[1] := UraEX1;
                Result[2] := UraEX2;
                Result[3] := UraEX3;
                Result[4] := UraEX4;
                {$Else}
                Result[0] := @UraEX0;
                Result[1] := @UraEX1;
                Result[2] := @UraEX2;
                Result[3] := @UraEX3;
                Result[4] := @UraEX4;
                {$EndIf}
              end;
            8:
              begin   
                {$IfDef FPC}
                Setlength(Result, 5);

                Result[0] := NepEX0;
                Result[1] := NepEX1;
                Result[2] := NepEX2;
                Result[3] := NepEX3;
                Result[4] := NepEX4;
                {$Else} 
                Result[0] := @NepEX0;
                Result[1] := @NepEX1;
                Result[2] := @NepEX2;
                Result[3] := @NepEX3;
                Result[4] := @NepEX4;
                {$EndIf}
              end;
            9:
              begin     
                {$IfDef FPC}
                Result[0] := SunEX0;
                Result[1] := SunEX1;
                Result[2] := SunEX2;
                Result[3] := SunEX3;
                Result[4] := SunEX4;
                Result[5] := SunEX5;
                {$Else} 
                Result[0] := @SunEX0;
                Result[1] := @SunEX1;
                Result[2] := @SunEX2;
                Result[3] := @SunEX3;
                Result[4] := @SunEX4;
                Result[5] := @SunEX5;
                {$EndIf}
              end;
          end;
        VSOP_COORD_Y:
          case Astro of
            1:
              begin   
                {$IfDef FPC}
                Result[0] := MerEY0;
                Result[1] := MerEY1;
                Result[2] := MerEY2;
                Result[3] := MerEY3;
                Result[4] := MerEY4;
                Result[5] := MerEY5;
                {$Else}   
                Result[0] := @MerEY0;
                Result[1] := @MerEY1;
                Result[2] := @MerEY2;
                Result[3] := @MerEY3;
                Result[4] := @MerEY4;
                Result[5] := @MerEY5;
                {$EndIf}
              end;
            2:
              begin 
                {$IfDef FPC}
                Result[0] := VenEY0;
                Result[1] := VenEY1;
                Result[2] := VenEY2;
                Result[3] := VenEY3;
                Result[4] := VenEY4;
                Result[5] := VenEY5;
                {$Else}
                Result[0] := @VenEY0;
                Result[1] := @VenEY1;
                Result[2] := @VenEY2;
                Result[3] := @VenEY3;
                Result[4] := @VenEY4;
                Result[5] := @VenEY5;
                {$EndIf}
              end;
            3:
              begin   
                {$IfDef FPC}
                Result[0] := EarEY0;
                Result[1] := EarEY1;
                Result[2] := EarEY2;
                Result[3] := EarEY3;
                Result[4] := EarEY4;
                Result[5] := EarEY5;
                {$Else}   
                Result[0] := @EarEY0;
                Result[1] := @EarEY1;
                Result[2] := @EarEY2;
                Result[3] := @EarEY3;
                Result[4] := @EarEY4;
                Result[5] := @EarEY5;
                {$EndIf}
              end;
            4:
              begin  
                {$IfDef FPC}
                Result[0] := MarEY0;
                Result[1] := MarEY1;
                Result[2] := MarEY2;
                Result[3] := MarEY3;
                Result[4] := MarEY4;
                Result[5] := MarEY5;
                {$Else}    
                Result[0] := @MarEY0;
                Result[1] := @MarEY1;
                Result[2] := @MarEY2;
                Result[3] := @MarEY3;
                Result[4] := @MarEY4;
                Result[5] := @MarEY5;
                {$EndIf}
              end;
            5:
              begin  
                {$IfDef FPC}
                Result[0] := JupEY0;
                Result[1] := JupEY1;
                Result[2] := JupEY2;
                Result[3] := JupEY3;
                Result[4] := JupEY4;
                Result[5] := JupEY5;  
                {$Else}    
                Result[0] := @JupEY0;
                Result[1] := @JupEY1;
                Result[2] := @JupEY2;
                Result[3] := @JupEY3;
                Result[4] := @JupEY4;
                Result[5] := @JupEY5;
                {$EndIf}
              end;
            6:
              begin   
                {$IfDef FPC}
                Result[0] := SatEY0;
                Result[1] := SatEY1;
                Result[2] := SatEY2;
                Result[3] := SatEY3;
                Result[4] := SatEY4;
                Result[5] := SatEY5;  
                {$Else}  
                Result[0] := @SatEY0;
                Result[1] := @SatEY1;
                Result[2] := @SatEY2;
                Result[3] := @SatEY3;
                Result[4] := @SatEY4;
                Result[5] := @SatEY5;
                {$EndIf}
              end;
            7:
              begin
                Setlength(Result, 5);
                    
                {$IfDef FPC}
                Result[0] := UraEY0;
                Result[1] := UraEY1;
                Result[2] := UraEY2;
                Result[3] := UraEY3;
                Result[4] := UraEY4;   
                {$Else}   
                Result[0] := @UraEY0;
                Result[1] := @UraEY1;
                Result[2] := @UraEY2;
                Result[3] := @UraEY3;
                Result[4] := @UraEY4;
                {$EndIf}
              end;
            8:
              begin
                Setlength(Result, 5);
                   
                {$IfDef FPC}
                Result[0] := NepEY0;
                Result[1] := NepEY1;
                Result[2] := NepEY2;
                Result[3] := NepEY3;
                Result[4] := NepEY4; 
                {$Else} 
                Result[0] := @NepEY0;
                Result[1] := @NepEY1;
                Result[2] := @NepEY2;
                Result[3] := @NepEY3;
                Result[4] := @NepEY4;
                {$EndIf}
              end;
            9:
              begin     
                {$IfDef FPC}
                Result[0] := SunEY0;
                Result[1] := SunEY1;
                Result[2] := SunEY2;
                Result[3] := SunEY3;
                Result[4] := SunEY4;
                Result[5] := SunEY5; 
                {$Else}   
                Result[0] := @SunEY0;
                Result[1] := @SunEY1;
                Result[2] := @SunEY2;
                Result[3] := @SunEY3;
                Result[4] := @SunEY4;
                Result[5] := @SunEY5;
                {$EndIf}
              end;
          end;
        VSOP_COORD_Z:
          case Astro of
            1:
              begin     
                {$IfDef FPC}
                Result[0] := MerEZ0;
                Result[1] := MerEZ1;
                Result[2] := MerEZ2;
                Result[3] := MerEZ3;
                Result[4] := MerEZ4;
                Result[5] := MerEZ5; 
                {$Else}
                Result[0] := @MerEZ0;
                Result[1] := @MerEZ1;
                Result[2] := @MerEZ2;
                Result[3] := @MerEZ3;
                Result[4] := @MerEZ4;
                Result[5] := @MerEZ5;
                {$EndIf}
              end;
            2:
              begin      
                {$IfDef FPC}
                Result[0] := VenEZ0;
                Result[1] := VenEZ1;
                Result[2] := VenEZ2;
                Result[3] := VenEZ3;
                Result[4] := VenEZ4;
                Result[5] := VenEZ5; 
                {$Else} 
                Result[0] := @VenEZ0;
                Result[1] := @VenEZ1;
                Result[2] := @VenEZ2;
                Result[3] := @VenEZ3;
                Result[4] := @VenEZ4;
                Result[5] := @VenEZ5;
                {$EndIf}
              end;
            3:
              begin   
                {$IfDef FPC}
                Result[0] := EarEZ0;
                Result[1] := EarEZ1;
                Result[2] := EarEZ2;
                Result[3] := EarEZ3;
                Result[4] := EarEZ4;
                Result[5] := EarEZ5; 
                {$Else}   
                Result[0] := @EarEZ0;
                Result[1] := @EarEZ1;
                Result[2] := @EarEZ2;
                Result[3] := @EarEZ3;
                Result[4] := @EarEZ4;
                Result[5] := @EarEZ5;
                {$EndIf}
              end;
            4:
              begin 
                {$IfDef FPC}
                Result[0] := MarEZ0;
                Result[1] := MarEZ1;
                Result[2] := MarEZ2;
                Result[3] := MarEZ3;
                Result[4] := MarEZ4;
                Result[5] := MarEZ5; 
                {$Else}    
                Result[0] := @MarEZ0;
                Result[1] := @MarEZ1;
                Result[2] := @MarEZ2;
                Result[3] := @MarEZ3;
                Result[4] := @MarEZ4;
                Result[5] := @MarEZ5;
                {$EndIf}
              end;
            5:
              begin 
                {$IfDef FPC}
                Result[0] := JupEZ0;
                Result[1] := JupEZ1;
                Result[2] := JupEZ2;
                Result[3] := JupEZ3;
                Result[4] := JupEZ4;
                Result[5] := JupEZ5; 
                {$Else} 
                Result[0] := @JupEZ0;
                Result[1] := @JupEZ1;
                Result[2] := @JupEZ2;
                Result[3] := @JupEZ3;
                Result[4] := @JupEZ4;
                Result[5] := @JupEZ5;
                {$EndIf}
              end;
            6:
              begin 
                {$IfDef FPC}
                Result[0] := SatEZ0;
                Result[1] := SatEZ1;
                Result[2] := SatEZ2;
                Result[3] := SatEZ3;
                Result[4] := SatEZ4;
                Result[5] := SatEZ5; 
                {$Else}   
                Result[0] := @SatEZ0;
                Result[1] := @SatEZ1;
                Result[2] := @SatEZ2;
                Result[3] := @SatEZ3;
                Result[4] := @SatEZ4;
                Result[5] := @SatEZ5;
                {$EndIf}
              end;
            7:
              begin
                Setlength(Result, 4);
                    
                {$IfDef FPC}
                Result[0] := UraEZ0;
                Result[1] := UraEZ1;
                Result[2] := UraEZ2;
                Result[3] := UraEZ3; 
                {$Else}  
                Result[0] := @UraEZ0;
                Result[1] := @UraEZ1;
                Result[2] := @UraEZ2;
                Result[3] := @UraEZ3;
                {$EndIf}
              end;
            8:
              begin
                Setlength(Result, 4);
                   
                {$IfDef FPC}
                Result[0] := NepEZ0;
                Result[1] := NepEZ1;
                Result[2] := NepEZ2;
                Result[3] := NepEZ3; 
                {$Else}
                Result[0] := @NepEZ0;
                Result[1] := @NepEZ1;
                Result[2] := @NepEZ2;
                Result[3] := @NepEZ3;
                {$EndIf}
              end;
            9:
              begin 
                {$IfDef FPC}
                Result[0] := SunEZ0;
                Result[1] := SunEZ1;
                Result[2] := SunEZ2;
                Result[3] := SunEZ3;
                Result[4] := SunEZ4;
                Result[5] := SunEZ5; 
                {$Else} 
                Result[0] := @SunEZ0;
                Result[1] := @SunEZ1;
                Result[2] := @SunEZ2;
                Result[3] := @SunEZ3;
                Result[4] := @SunEZ4;
                Result[5] := @SunEZ5;
                {$EndIf}
              end;
          end;
      end;
    end;

 begin
   if not (Astro in [1..9]) then
      exit(0.0);

    Terms := getBody();
    VSOP := 0.0;

  for i := 0 to high(Terms)do
    begin
      t_ := 0.0;

      for j := 0 to high(Terms[i]) do
        t_ += Terms[i][j].A * COS(Terms[i][j].B + Terms[i][j].C*T);

      VSOP += (t_ * power(T, i));
    end;

  Result := VSOP;
end;

end.

