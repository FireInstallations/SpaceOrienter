program SpaceOrienter;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, datetimectrls, lazcontrols,
  spaceorienter_main, Config, GetHotkey, SpOri_Main, MultiLangueStrings;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Initialize;
  Application.CreateForm(TFrm_Spori, Frm_Spori);
  //Please Note: CreateForm of Frm_Config is locaded in the Form.Create function of the main form
  Application.Run;
end.

