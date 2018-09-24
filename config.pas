unit Config;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, SpinEx, DateTimePicker, {SynEdit,} {SynCompletion,} {RTTICtrls,}
  Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  Buttons, EditBtn, Spin, ExtCtrls, MaskEdit, DBGrids, DbCtrls, ECImageMenu,
  ECSwitch, ECEditBtns;

type

  TKoord = Record
      Lon: Real;
      Lat:  Real;
     end;


  { TFrm_Config }

  TFrm_Config = class(TForm)
    BitBtn_NwCnfg: TBitBtn;
    Bt_Up: TButton;
    Bt_Con: TButton;
    Bt_HtKy: TButton;
    CBx_Rate: TComboBox;
    CBx_Tag: TComboBox;
    CbBx_Ort: TComboBox;
    CmbBx_Baud: TComboBox;
    CmbBx_ComPort: TComboBox;
    ECEdBtn_Htky: TECSpeedBtnPlus;
    Ed_HtKy: TEdit;
    Img_Info_HtKy: TImage;
    Lbl_HtKy: TLabel;
    Lbl_NwCnfg: TLabel;
    Lbl_Sw_HtKy: TLabel;
    Sw_HtKy: TECSwitch;
    TE_Plan: TDateTimePicker;
    DE_Day: TDateTimePicker;
    TE_Time: TDateTimePicker;
    FlSpEd_Lat: TFloatSpinEdit;
    FlSpEd_Lon: TFloatSpinEdit;
    Img_ComCon: TImage;
    Img_ComWarn: TImage;
    Img_ComInfo: TImage;
    Img_Info_Redo: TImage;
    Img_CkB_DSOff: TImage;
    ImgMn: TECImageMenu;
    Img_Auto: TImage;
    Img_CkB_Off: TImage;
    Img_CkB_On: TImage;
    Img_Info_Lat: TImage;
    Img_Info_Baud: TImage;
    Img_Info_ComPort: TImage;
    Img_Info_AutoCon: TImage;
    Img_Info_ManW: TImage;
    Img_Info_Lon: TImage;
    Img_Info_Ort: TImage;
    Img_Info_PortableMode: TImage;
    Img_Info_Exprt: TImage;
    Img_Info_AutoTime: TImage;
    Img_Info_Con: TImage;
    Img_Info_Time: TImage;
    Img_Info_Day: TImage;
    Img_Msg: TImage;
    Img_Non: TImage;
    Img_off: TImage;
    Img_On: TImage;
    Img_Schnuppe: TImage;
    Img_tm: TImage;
    ImgLst_Mn: TImageList;
    Img_ZHS_G: TImage;
    Img_ZHS_W: TImage;
    Lbl_ManW: TLabel;
    Lbl_Sw_AutoCon: TLabel;
    Lbl_Sw_ManW: TLabel;
    Lbl_Ardo: TLabel;
    Lbl_ComMsg: TLabel;
    Lbl_Baud: TLabel;
    Lbl_ComPort: TLabel;
    Lbl_AutoCon: TLabel;
    Lbl_Con: TLabel;
    Lbl_Ort: TLabel;
    Lbl_Sw_PortableMode: TLabel;
    Lbl_Sw_Exprt: TLabel;
    Lbl_Sw_AutoTime: TLabel;
    Lbl_Exprt: TLabel;
    Lbl_AutoTime: TLabel;
    Lbl_PortableMode: TLabel;
    Lbl_Lat: TLabel;
    Lbl_Lon: TLabel;
    Lbl_Sw_Redo: TLabel;
    Lbl_am_Plan: TLabel;
    Lbl_Auto: TLabel;
    Lbl_Msg: TLabel;
    Lbl_Non: TLabel;
    Lbl_Plan: TLabel;
    Lbl_PrVers: TLabel;
    Lbl_tm: TLabel;
    Lbl_um_Plan: TLabel;
    Lbl_Redo: TLabel;
    Lbl_ZHS: TLabel;
    Lb_Day: TLabel;
    Lb_Time: TLabel;
    PgCont_Pnl: TPageControl;
    Pnl_ueber: TPanel;
    PgsB_ComCon: TProgressBar;
    Sw_ManW: TECSwitch;
    Sw_PortableMode: TECSwitch;
    Sw_Exprt: TECSwitch;
    Sw_Redo: TECSwitch;
    Sw_AutoTime: TECSwitch;
    Sw_AutoCon: TECSwitch;
    TbSht_Alg: TTabSheet;
    TbSht_Con: TTabSheet;
    TbSht_Loc: TTabSheet;
    TbSht_Info: TTabSheet;
    TbSht_Time: TTabSheet;
    TbSht_Up: TTabSheet;
    UpDn_test: TUpDown;
    UpDn_test1: TUpDown;
    procedure BitBtn_NwCnfgClick(Sender: TObject);
    procedure Ed_HtKyEditingDone(Sender: TObject);
    procedure Bt_Con1Click(Sender: TObject);
    procedure Bt_HtKyClick(Sender: TObject);
    procedure Bt_UpClick(Sender: TObject);
    procedure Bt_ConClick(Sender: TObject);
    procedure CbBx_OrtEditingDone(Sender: TObject);
    procedure CBx_RateEditingDone(Sender: TObject);
    procedure CBx_TagEditingDone(Sender: TObject);
    procedure DE_DayChange(Sender: TObject);
    procedure DE_DayEditingDone(Sender: TObject);
    procedure FlSpEd_LatEditingDone(Sender: TObject);
    procedure FlSpEd_LonEditingDone(Sender: TObject);
    procedure FormClose(Sender: TObject; var {%H-}CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Img_AutoClick(Sender: TObject);
    procedure Img_MsgClick(Sender: TObject);
    procedure Img_tmClick(Sender: TObject);
    procedure Img_NonClick(Sender: TObject);
    procedure ImgMnSelectionChange(Sender: TObject; {%H-}User: boolean);
    procedure Img_ZHS_WClick(Sender: TObject);
    procedure Img_ZHS_WMouseDown(Sender: TObject; {%H-}Button: TMouseButton;
      {%H-}Shift: TShiftState; {%H-}X, {%H-}Y: Integer);
    procedure Img_ZHS_WMouseUp(Sender: TObject; {%H-}Button: TMouseButton;
      {%H-}Shift: TShiftState; {%H-}X, {%H-}Y: Integer);
    procedure Lbl_Sw_AutoTimeClick(Sender: TObject);
    procedure Lbl_Sw_ExprtClick(Sender: TObject);
    procedure Lbl_Sw_PortableModeClick(Sender: TObject);
    procedure Lbl_Sw_RedoClick(Sender: TObject);
    procedure Sw_AutoTimeChange(Sender: TObject);
    procedure Sw_ExprtChange(Sender: TObject);
    procedure Sw_ManWChange(Sender: TObject);
    procedure Sw_PortableModeChange(Sender: TObject);
    procedure Sw_AutoConChange(Sender: TObject);
    procedure Sw_RedoChange(Sender: TObject);
    procedure TE_PlanEditingDone(Sender: TObject);
    procedure TE_TimeChange(Sender: TObject);
    procedure TE_TimeEditingDone(Sender: TObject);
  private
      {private declarations}
  public
    function Koordinaten (Stadt:String):TKoord;
    procedure AllUpOff ();
  end;

var
  Frm_Config   : TFrm_Config;

implementation

uses
  SpaceOrienter_Haupt;

{$R *.lfm}

{ TFrm_Config }

//Usefull: ComboboxEx,  TECTabCtrl
// --!> Allg. <!--
// Benachrichtigungen
// API für übersetzungen anlegen
// StadtListe

function TFrm_Config.Koordinaten (Stadt:String):TKoord; //Dynamisch, laden + Speichern ermöglichen; own file
  begin
//    ShowMessage(Stadt);
    case (Trim(AnsiLowerCase(Stadt))) of
      'none':
        begin
          Result.Lon := 0;
          Result.Lat  := 0;
        end;

      'aachen':
        begin
          Result.Lon := 50.775346;
          Result.Lat := 6.0838870;
         end;
      'augsburg':
        begin
          Result.Lon := 48.370545;
          Result.Lat := 10.897790;
         end;
      'bamberg':
        begin
          Result.Lon := 49.898814;
          Result.Lat := 10.902764;
         end;
      'bergisch gladbach':
        begin
          Result.Lon := 50.992309;
          Result.Lat := 7.1286210;
         end;
      'berlin':
        begin
          Result.Lon := 52.520007;
          Result.Lat := 13.404954;
         end;
      'bielefeld':
        begin
          Result.Lon := 52.030228;
          Result.Lat := 8.5324710;
         end;
      'bochum':
        begin
          Result.Lon := 51.481845;
          Result.Lat := 7.2162360;
         end;
      'bonn':
        begin
          Result.Lon := 50.737430;
          Result.Lat := 7.0982070;
         end;
      'bottrop':
        begin
          Result.Lon := 51.529086;
          Result.Lat := 6.9446890;
         end;
      'brünn':
        begin
          Result.Lon := 49.195060;
          Result.Lat := 16.606837;
         end;
      'braunschweig':
        begin
          Result.Lon := 52.268874;
          Result.Lat := 10.526770;
         end;
      'bremen':
        begin
          Result.Lon := 53.079296;
          Result.Lat := 8.8016940;
         end;
      'bremerhaven':
        begin
          Result.Lon := 53.539584;
          Result.Lat := 8.5809420;
         end;
      'chemnitz':
        begin
          Result.Lon := 50.827845;
          Result.Lat := 12.921370;
         end;
      'cottbus':
        begin
          Result.Lon := 51.756311;
          Result.Lat := 14.332868;
         end;
      'düsseldorf':
        begin
          Result.Lon := 51.227741;
          Result.Lat := 6.7734560;
         end;
      'darmstadt':
        begin
          Result.Lon := 49.872825;
          Result.Lat := 8.6511930;
         end;
      'dessau-roßlau':
        begin
          Result.Lon := 51.842828;
          Result.Lat := 12.230393;
         end;
      'dortmund':
        begin
          Result.Lon := 51.513587;
          Result.Lat := 7.4652980;
         end;
      'dresden':
        begin
          Result.Lon := 51.050409;
          Result.Lat := 13.737262;
         end;
      'duisburg':
        begin
          Result.Lon := 51.434408;
          Result.Lat := 6.7623290;
         end;
      'erfurt':
        begin
          Result.Lon := 50.984768;
          Result.Lat := 11.029880;
         end;
      'erlangen':
        begin
          Result.Lon := 49.589674;
          Result.Lat := 11.011961;
         end;
      'essen':
        begin
          Result.Lon := 51.455643;
          Result.Lat := 7.0115550;
         end;
      'fürth':
        begin
          Result.Lon := 49.477117;
          Result.Lat := 10.988667;
         end;
      'flensburg':
        begin
          Result.Lon := 54.793743;
          Result.Lat := 9.4469960;
         end;
      'frankfurt (oder)':
        begin
          Result.Lon := 52.347224;
          Result.Lat := 14.550567;
         end;
      'frankfurt am main':
        begin
          Result.Lon := 50.110922;
          Result.Lat := 8.6821270;
         end;
      'freiburg im breisgau':
        begin
          Result.Lon := 47.999008;
          Result.Lat := 7.8421040;
         end;
      'görlitz':
        begin
          Result.Lon := 51.150627;
          Result.Lat := 14.968707;
         end;
      'göttingen':
        begin
          Result.Lon := 51.541280;
          Result.Lat := 9.9158040;
         end;
      'gütersloh':
        begin
          Result.Lon := 51.903238;
          Result.Lat := 8.3857530;
         end;
      'gelsenkirchen':
        begin
          Result.Lon := 51.517744;
          Result.Lat := 7.0857170;
         end;
      'gera':
        begin
          Result.Lon := 50.885071;
          Result.Lat := 12.080720;
         end;
      'graz':
        begin
          Result.Lon := 47.070714;
          Result.Lat := 15.439504;
         end;
      'hagen':
        begin
          Result.Lon := 51.367078;
          Result.Lat := 7.4632840;
         end;
      'halle (saale)':
        begin
          Result.Lon := 51.496980;
          Result.Lat := 11.968803;
         end;
      'hamburg':
        begin
          Result.Lon := 53.551085;
          Result.Lat := 9.9936820;
         end;
      'hamm':
        begin
          Result.Lon := 51.673858;
          Result.Lat := 7.8159820;
         end;
      'hannover':
        begin
          Result.Lon := 52.375892;
          Result.Lat := 9.7320100;
         end;
      'haunau':
        begin
          Result.Lon := 60.791660;
          Result.Lat := 22.903331;
         end;
      'heidelberg':
        begin
          Result.Lon := 49.398752;
          Result.Lat := 8.6724340;
         end;
      'heilbronn':
        begin
          Result.Lon := 49.142693;
          Result.Lat := 9.2108790;
         end;
      'herne':
        begin
          Result.Lon := 51.536895;
          Result.Lat := 7.2009150;
         end;
      'hildesheim':
        begin
          Result.Lon := 52.154778;
          Result.Lat := 9.9579650;
         end;
      'ingolstadt':
        begin
          Result.Lon := 48.766535;
          Result.Lat := 11.425754;
         end;
      'jena':
        begin
          Result.Lon := 50.927054;
          Result.Lat := 11.589237;
         end;
      'köln':
        begin
          Result.Lon := 50.937531;
          Result.Lat := 6.9602790;
         end;
      'königs wusterhausen':
        begin
          Result.Lon := 52.295891;
          Result.Lat := 13.622838;
         end;
      'kaiserslautern':
        begin
          Result.Lon := 49.440066;
          Result.Lat := 7.7491260;
         end;
      'karlsruhe':
        begin
          Result.Lon := 49.006890;
          Result.Lat := 8.4036530;
         end;
      'kassel':
        begin
          Result.Lon := 51.312711;
          Result.Lat := 9.4797460;
         end;
      'kiel':
        begin
          Result.Lon := 54.323293;
          Result.Lat := 10.122765;
         end;
      'koblenz':
        begin
          Result.Lon := 50.356943;
          Result.Lat := 7.5889960;
         end;
      'krefeld':
        begin
          Result.Lon := 51.338761;
          Result.Lat := 6.5853420;
         end;
      'lübeck':
        begin
          Result.Lon := 53.865467;
          Result.Lat := 10.686559;
         end;
      'leibzig':
        begin
          Result.Lon := 51.339695;
          Result.Lat := 12.373075;
         end;
      'leverkusen':
        begin
          Result.Lon := 51.045925;
          Result.Lat := 7.0192200;
         end;
      'linz':
        begin
          Result.Lon := 48.306940;
          Result.Lat := 14.285830;
         end;
      'ludwigsburg':
        begin
          Result.Lon := 48.894062;
          Result.Lat := 9.1954640;
         end;
      'ludwigshafen am rhein':
        begin
          Result.Lon := 49.477410;
          Result.Lat := 8.4451800;
         end;
      'mönchengladbach':
        begin
          Result.Lon := 51.180457;
          Result.Lat := 6.4428040;
         end;
      'mülheim an der ruhr':
        begin
          Result.Lon := 51.418568;
          Result.Lat := 6.8845230;
         end;
      'münchen':
        begin
          Result.Lon := 48.135125;
          Result.Lat := 11.581980;
         end;
      'münster':
        begin
          Result.Lon := 51.960665;
          Result.Lat := 7.6261350;
         end;
      'magdeburg':
        begin
          Result.Lon := 52.120533;
          Result.Lat := 11.627624;
        end;
      'mainz':
        begin
          Result.Lon := 49.992862;
          Result.Lat := 8.2472530;
         end;
      'mannheim':
        begin
          Result.Lon := 49.487459;
          Result.Lat := 8.4660390;
         end;
      'moers':
        begin
          Result.Lon := 51.451604;
          Result.Lat := 6.6408150;
         end;
      'nürnberg':
        begin
          Result.Lon := 49.452102;
          Result.Lat := 11.076665;
         end;
      'neuss':
        begin
          Result.Lon := 51.204197;
          Result.Lat := 6.6879510;
         end;
      'oberhausen':
        begin
          Result.Lon := 51.496334;
          Result.Lat := 6.8637760;
         end;
      'offenbach am main':
        begin
          Result.Lon := 50.095636;
          Result.Lat := 8.7760840;
         end;
      'oldenburg (oldb)':
        begin
          Result.Lon := 53.143450;
          Result.Lat := 8.2145520;
         end;
      'osnabrück':
        begin
          Result.Lon := 52.279911;
          Result.Lat := 8.0471790;
         end;
      'paderborn':
        begin
          Result.Lon := 51.718921;
          Result.Lat := 8.7575090;
         end;
      'pforzheim':
        begin
          Result.Lon := 48.892186;
          Result.Lat := 8.6946290;
         end;
      'pilsen':
        begin
          Result.Lon := 49.738431;
          Result.Lat := 13.373637;
         end;
      'plauen':
        begin
          Result.Lon := 50.497613;
          Result.Lat := 12.136868;
         end;
      'potsdam':
        begin
          Result.Lon := 52.390569;
          Result.Lat := 13.064473;
         end;
      'prag':
        begin
          Result.Lon := 50.075538;
          Result.Lat := 14.437800;
         end;
      'recklingshausen':
        begin
          Result.Lon := 51.614065;
          Result.Lat := 7.1979450;
         end;
      'regensburg':
        begin
          Result.Lon := 49.013430;
          Result.Lat := 12.101624;
         end;
      'remscheid':
        begin
          Result.Lon := 51.178742;
          Result.Lat := 7.1896960;
         end;
      'reutlingen':
        begin
          Result.Lon := 48.506939;
          Result.Lat := 9.2038040;
         end;
      'rostock':
        begin
          Result.Lon := 54.092441;
          Result.Lat := 12.099147;
         end;
      'saarbrücken':
        begin
          Result.Lon := 49.240157;
          Result.Lat := 6.9969330;
         end;
      'salzgitter':
        begin
          Result.Lon := 52.137866;
          Result.Lat := 10.389913;
         end;
      'schwerin':
        begin
          Result.Lon := 53.635502;
          Result.Lat := 11.401250;
         end;
      'siegen':
        begin
          Result.Lon := 50.883849;
          Result.Lat := 8.0209590;
         end;
      'solingen':
        begin
          Result.Lon := 51.165220;
          Result.Lat := 7.0671160;
         end;
      'stuttgart':
        begin
          Result.Lon := 48.775846;
          Result.Lat := 9.1829320;
         end;
      'ulm':
        begin
          Result.Lon := 48.401082;
          Result.Lat := 9.9876080;
         end;
      'würzburg':
        begin
          Result.Lon := 49.791304;
          Result.Lat := 9.9533550;
         end;
      'weimar':
        begin
          Result.Lon := 50.979493;
          Result.Lat := 11.323544;
         end;
      'wien':
        begin
          Result.Lon := 48.208174;
          Result.Lat := 16.373819;
         end;
      'wiesbaden':
        begin
          Result.Lon := 50.078218;
          Result.Lat := 8.2397610;
         end;
      'witten':
        begin
          Result.Lon := 51.443893;
          Result.Lat := 7.3531970;
         end;
      'wolfsburg':
        begin
          Result.Lon := 52.422650;
          Result.Lat := 10.786546;
         end;
      'wuppertal':
        begin
          Result.Lon := 51.256213;
          Result.Lat := 7.1507640;
         end;
      'zeuthen':
        begin
          Result.Lon := 52.347652;
          Result.Lat := 13.620762;
         end;
      'zwickau':
        begin
          Result.Lon := 50.710217;
          Result.Lat := 12.473372;
         end;
     else
      raise Exception.Create('Fehler: Konnte Ort nicht finden!');
    end;

   end;

procedure TFrm_Config.AllUpOff ();
  begin
    Img_Auto.Picture    := Img_Off.Picture;
    Img_Msg.Picture     := Img_Off.Picture;
    Img_tm.Picture      := Img_Off.Picture;
    Img_Non.Picture     := Img_Off.Picture;

    Lbl_Plan.Enabled    := false;
    Lbl_am_Plan.Enabled := false;
    Lbl_um_Plan.Enabled := false;
    CBx_Rate.Enabled    := false;
    CBx_Tag.Enabled     := false;
    Sw_Redo.Enabled     := false;
    Lbl_Redo.Enabled    := false;
    Lbl_Sw_Redo.Enabled := false;
    TE_Plan.Enabled     := false;
   end;

procedure TFrm_Config.FormCreate(Sender: TObject);
begin
  ImgMn.ItemIndex       := 0;
  PgCont_Pnl.ActivePage := TbSht_Alg;
end;

procedure TFrm_Config.Bt_UpClick(Sender: TObject);
  begin
    Frm_Spori.Update_ ();
   end;

procedure TFrm_Config.Bt_Con1Click(Sender: TObject);
begin

end;

procedure TFrm_Config.Ed_HtKyEditingDone(Sender: TObject);
begin

end;

procedure TFrm_Config.BitBtn_NwCnfgClick(Sender: TObject);
  var
    StarMode: integer;
    HK: String;
    PortableMode: boolean;
  begin
    with Frm_Spori do
      begin
        StarMode := CB_StrMode.ItemIndex;
        HK     := Ed_Nr.Text;
        PortableMode := StrToBool(Options[ON_PortableMode]);

        DefaultOptions ();
        LoadOptions ();

        Frm_Spori.SetPortableMode(PortableMode);

        Frm_Spori.ProgressStarMode(StarMode);

        Ed_Nr.Text := HK;
        ProgressNumber ();
      end;
  end;

//PortableVersion
//Fix Lat/lon

procedure TFrm_Config.Bt_HtKyClick(Sender: TObject);
begin

end;

procedure TFrm_Config.Bt_ConClick(Sender: TObject);
  begin
    Frm_Spori.Connect();
   end;

procedure TFrm_Config.CbBx_OrtEditingDone(Sender: TObject);
  var
    TempKoord: TKoord;
  begin
    TempKoord        := Koordinaten (CbBx_Ort.Caption);
    FlSpEd_Lat.Value := TempKoord.Lat;
    FlSpEd_Lon.Value := TempKoord.Lon;

    Frm_Spori.Options[ON_Place] := CbBx_Ort.Caption;
    Frm_Spori.Options[ON_Lon]   := FloatToStr(TempKoord.Lon);
    Frm_Spori.Options[ON_Lat]   := FloatToStr(TempKoord.Lat);
   end;

procedure TFrm_Config.CBx_RateEditingDone(Sender: TObject);
  begin
    Frm_Spori.Options[ON_UpdateRate] := IntToStr(CBx_Rate.ItemIndex);
   end;

procedure TFrm_Config.CBx_TagEditingDone(Sender: TObject);
  begin
    Frm_Spori.Options[ON_UpdateDay] := IntToStr(CBx_Tag.ItemIndex);
   end;

procedure TFrm_Config.DE_DayChange(Sender: TObject);
  begin
    Frm_Spori.DiffD   := De_Day.Date - Date;
    Frm_Spori.NoEntry := true;
   end;

procedure TFrm_Config.De_DayEditingDone(Sender: TObject);
  begin
    Frm_Spori.Options[ON_Date] := DateToStr(De_Day.Date);
    Frm_Spori.NoEntry := false;
   end;

procedure TFrm_Config.FlSpEd_LatEditingDone(Sender: TObject);
begin
  Frm_Spori.Lb_Lat_G.Caption  := FloatToStr(FlSpEd_Lat.Value);
  Frm_Spori.Lb_Lat_G1.Caption := FloatToStr(FlSpEd_Lat.Value);

  Frm_Spori.Angle ();

  Frm_Spori.Options[ON_Lat] := FloatToStr(FlSpEd_Lat.Value);
end;

procedure TFrm_Config.FlSpEd_LonEditingDone(Sender: TObject);
begin
  Frm_Spori.Lb_Lon_G.Caption  := FloatToStr(FlSpEd_Lon.Value);
  Frm_Spori.Lb_Lon_G1.Caption := FloatToStr(FlSpEd_Lon.Value);

  Frm_Spori.Angle ();

  Frm_Spori.Options[ON_Lon] := FloatToStr(FlSpEd_Lon.Value);
end;

procedure TFrm_Config.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Frm_Spori.Show;
end;

procedure TFrm_Config.Img_AutoClick(Sender: TObject);
  begin
    AllUpOff ();
    Img_Auto.Picture :=  Img_On.Picture;

    Frm_Spori.Options[ON_UpdateMode] := '0';
   end;

procedure TFrm_Config.Img_MsgClick(Sender: TObject);
  begin
    AllUpOff ();
    Img_Msg.Picture  := Img_On.Picture;

    Frm_Spori.Options[ON_UpdateMode] := '1';
   end;

procedure TFrm_Config.Img_tmClick(Sender: TObject);
  begin
    AllUpOff ();
    Img_tm.Picture      := Img_On.Picture;

    TE_Plan.Time        := Time;

    Lbl_Plan.Enabled    := true;
    Lbl_am_Plan.Enabled := true;
    Lbl_um_Plan.Enabled := true;
    CBx_Rate.Enabled    := true;
    CBx_Tag.Enabled     := true;
    Sw_Redo.Enabled     := true;
    Lbl_Redo.Enabled    := true;
    Lbl_Sw_Redo.Enabled := true;
    TE_Plan.Enabled     := true;

    Frm_Spori.Options[ON_UpdateMode] := '2';
   end;

procedure TFrm_Config.Img_NonClick(Sender: TObject);
  begin
    AllUpOff ();
    Img_Non.Picture  := Img_On.Picture;

    Frm_Spori.Options[ON_UpdateMode] := '3';
   end;

procedure TFrm_Config.ImgMnSelectionChange(Sender: TObject; User: boolean);
  begin
    case ImgMn.itemIndex of
      0: PgCont_Pnl.ActivePage := TbSht_Alg;
      1: PgCont_Pnl.ActivePage := TbSht_Up;
      2: PgCont_Pnl.ActivePage := TbSht_Con;
      3: PgCont_Pnl.ActivePage := TbSht_Loc;
      4: PgCont_Pnl.ActivePage := TbSht_Time;
      5: PgCont_Pnl.ActivePage := TbSht_Info;
     end;
  end;

procedure TFrm_Config.Img_ZHS_WClick(Sender: TObject);
  begin
    Close;
   end;

procedure TFrm_Config.Img_ZHS_WMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  begin
    Img_ZHS_W.Visible  := false;
    Img_ZHS_G.Visible  := true;
    Lbl_ZHS.Font.Color := $a5a5a5;
  end;

procedure TFrm_Config.Img_ZHS_WMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  begin
    Img_ZHS_W.Visible  := true;
    Img_ZHS_G.Visible  := false;
    Lbl_ZHS.Font.Color := $00DFDFDF;
  end;

procedure TFrm_Config.Lbl_Sw_AutoTimeClick(Sender: TObject);
  begin
    if (Sw_AutoTime.Checked) then
      begin
        Sw_AutoTime.Checked     := false;
        Lbl_Sw_AutoTime.Caption := 'Aus';
      end
     else
       begin
        Sw_AutoTime.Checked     := true;
        Lbl_Sw_AutoTime.Caption := 'Ein';
       end;
   end;

procedure TFrm_Config.Lbl_Sw_ExprtClick(Sender: TObject);
  begin
    if (Sw_Exprt.Checked) then
      begin
        Sw_Exprt.Checked     := false;
        Lbl_Sw_Exprt.Caption := 'Aus';
      end
     else
       begin
        Sw_Exprt.Checked     := true;
        Lbl_Sw_Exprt.Caption := 'Ein';
       end;
   end;

procedure TFrm_Config.Lbl_Sw_PortableModeClick(Sender: TObject);
  begin
    if (Sw_PortableMode.Checked) then
      begin
        Sw_PortableMode.Checked     := false;
        Lbl_Sw_PortableMode.Caption := 'Aus';
      end
     else
       begin
        Sw_PortableMode.Checked     := true;
        Lbl_Sw_PortableMode.Caption := 'Ein';
       end;
   end;

procedure TFrm_Config.Lbl_Sw_RedoClick(Sender: TObject);
  begin
    if (Sw_Redo.Checked) then
      begin
        Sw_Redo.Checked     := false;
        Lbl_Sw_Redo.Caption := 'Aus';
      end
     else
       begin
        Sw_Redo.Checked     := true;
        Lbl_Sw_Redo.Caption := 'Ein';
       end;
   end;

procedure TFrm_Config.Sw_AutoTimeChange(Sender: TObject);
  begin
    if (Sw_AutoTime.Checked) then
      begin
        Lb_Time.Enabled         := false;
        TE_Time.Enabled         := false;
        Lb_Day.Enabled          := false;
        DE_Day.Enabled          := false;
        Lbl_Sw_AutoTime.Caption := 'Ein';

        Frm_Spori.Options[ON_AutoTimeMode] := 'True';
       end
     else
       begin
         Lb_Time.Enabled         := true;
         TE_Time.Enabled         := true;
         Lb_Day.Enabled          := true;
         DE_Day.Enabled          := true;
         Lbl_Sw_AutoTime.Caption := 'Aus';

         Frm_Spori.DiffD         := DE_Day.Date - Date;
         Frm_Spori.DiffT         := StrToTime(TimeToStr(TE_Time.Time)) - Time;
         Frm_Spori.Options[ON_AutoTimeMode] := 'False';
        end;
   end;

procedure TFrm_Config.Sw_ExprtChange(Sender: TObject);
  begin
    if (Sw_Exprt.Checked) then
      begin
        Lbl_Sw_Exprt.Caption           := 'Ein';

        Frm_Spori.MI_Sicht_Exp.Checked := true;
        Frm_Spori.ProgressExpertMode ();
       end
     else
      begin
        Lbl_Sw_Exprt.Caption           := 'Aus';

        Frm_Spori.MI_Sicht_Exp.Checked := false;
        Frm_Spori.ProgressExpertMode ();
       end;
   end;

procedure TFrm_Config.Sw_ManWChange(Sender: TObject);
  begin
    if (Sw_ManW.Checked) then
      begin
        Lbl_Sw_ManW.Caption := 'Ein';
        Frm_Spori.Options[ON_AutoValueMode] := 'False';
       end
     else
      begin
        Lbl_Sw_ManW.Caption := 'Aus';
        Frm_Spori.Options[ON_AutoValueMode] := 'True';
       end;
   end;

procedure TFrm_Config.Sw_PortableModeChange(Sender: TObject);


  begin
    Frm_Spori.Options[ON_PortableMode] := BoolToStr(Sw_PortableMode.Checked, 'True', 'False');
    Lbl_Sw_PortableMode.Caption := BoolToStr(Sw_PortableMode.Checked, 'Ein', 'Aus');

    Frm_Spori.SetPortableMode(Sw_PortableMode.Checked);
   end;

procedure TFrm_Config.Sw_AutoConChange(Sender: TObject);
  begin
    if (Sw_AutoCon).Checked then
      begin
        Lbl_Sw_AutoCon.Caption := 'Ein';
        //ED_Port.Enabled        := false;

        Frm_Spori.Options[ON_AutoComMode] := 'True';
       end
     else
      begin
        Lbl_Sw_AutoCon.Caption := 'Ein';
        //ED_Port.Enabled        := true;

        Frm_Spori.Options[ON_AutoComMode] := 'False';
       end;
    //Frm_Spori.Connect ();
   end;

procedure TFrm_Config.Sw_RedoChange(Sender: TObject);
  begin
    if (Sw_Redo.Checked) then
      begin
        Lbl_Sw_Redo.Caption   := 'Ein';
        Frm_Spori.Options[ON_ReDo] := 'True';
       end
     else
      begin
        Lbl_Sw_Redo.Caption   := 'Aus';
        Frm_Spori.Options[ON_ReDo] := 'False';
       end;
   end;

procedure TFrm_Config.TE_PlanEditingDone(Sender: TObject);
  begin
    Frm_Spori.Options[ON_UpdateTime] := TimeToStr(TE_Plan.Time);
   end;

procedure TFrm_Config.TE_TimeChange(Sender: TObject);
  begin
    Frm_Spori.DiffT   := StrToTime(TimeToStr(TE_Time.Time))- Time;
    Frm_Spori.NoEntry := true;
   end;

procedure TFrm_Config.TE_TimeEditingDone(Sender: TObject);
  begin
    Frm_Spori.Options[ON_Time] := TimeToStr(TE_Time.Time);
    Frm_Spori.NoEntry := false;
   end;

{ TFrm_Config }

end.

