unit utils;

{$mode objfpc}{$H+}
{$WARN 5057 off : Local variable "$1" does not seem to be initialized}
interface

uses
  Classes, SysUtils, iausofa;

procedure RefractionAB(const phpa, tk, rh, wl: Real; var refa, refb: Real);
procedure JulianDateToDateAndTime(jd1, jd2: Real; var date, time: Real);
procedure BPNMatrix(const Model: integer; const jd1, jd2: Real; var rbpn: TRealMatrix3_3); STDCALL;
function  UtcToTai(const utc1, utc2: Real; var tai1, tai2: Real): integer;
function  ModF (const x: Real; var intpart: integer): Real; inline;  overload;
function  ModF (const x: Real; var intpart: Real): Real; inline; overload;

implementation

const
  IAU_MODEL_1900 = 1900;
  IAU_MODEL_2000 = 2000;
  IAU_MODEL_2006 = 2006;

function  ModF (const x: Real; var intpart: integer): Real; inline;  overload;
  begin
    intpart := trunc(x);

    Result := x - intpart;
  end;

function  ModF (const x: Real; var intpart: Real): Real; inline; overload;
  var
    TempIntPart: integer;
  begin
    Result := ModF(x, TempIntPart);
    intpart :=  TempIntPart;
  end;

procedure RefractionAB(const phpa, tk, rh, wl: Real; var refa, refb: Real);
  begin
    iauRefco(phpa, tk, rh, wl, refa, refb);
  end;

procedure JulianDateToDateAndTime(jd1, jd2: Real; var date, time: Real);
  var
    d1, d2, t1, t2: Real;
  begin
    t1 := ModF(jd1, d1);
    t2 := ModF(jd2, d2);

    date := d1 + d2 + 0.5;
    time := t1 + t2 - 0.5;

    while (time > 1.0) do
      begin
        time -= 1.0;
        date += 1.0;
      end;

    while (time < 0.0) do
      begin
        time += 1.0;
        date -= 1.0;
      end;
  end;

procedure BPNMatrix(const Model: integer; const jd1, jd2: Real; var rbpn: TRealMatrix3_3); STDCALL;
  begin
    iauZr(rbpn);

    case Model of
      IAU_MODEL_1900: iauPnm80(jd1, jd2, rbpn);
      IAU_MODEL_2000: iauPnm00a(jd1, jd2, rbpn);
      IAU_MODEL_2006: iauPnm06a(jd1, jd2, rbpn);
    end;
  end;

function  UtcToTai(const utc1, utc2: Real; var tai1, tai2: Real): integer;
  var
    t1, t2: Real;
  begin
    JulianDateToDateAndTime(utc1, utc2, t1, t2);

    if (t1 < 2436934.5) then
      begin
        tai1 := utc1;
        tai2 := utc2;
        Result := 0;
      end
    else
      Result := iauUtctai(utc1, utc2, tai1, tai2);
  end;

end.

