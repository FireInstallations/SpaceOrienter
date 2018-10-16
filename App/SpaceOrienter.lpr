program SpaceOrienter;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  cmem, // the c memory manager is on some systems much faster for multi-threading
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, datetimectrls, lazcontrols,
  spaceorienter_main, Config, GetHotkey, SpOri_Main, MultiLangueStrings;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Initialize;
  Application.CreateForm(TFrm_Spori, Frm_Spori);
  //Please Note: CreateForm of all other Froms are locaded in the Form.Create function of the main form
  Application.Run;
end.

