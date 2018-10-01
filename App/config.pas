unit Config;

  {Copyright (C) <2018> <FireInstallations> <kettnerl [at] hu-berlin.de>

   This programm is free software; you can redistribute it and/or modify it
   under the terms of the GNU Library General Public License as published by
   the Free Software Foundation; either version 3 of the License, or (at your
   option) any later version.

   This program is distributed in the hope that it will be useful, but WITHOUT
   ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
   FITNESS FOR A PARTICULAR PURPOSE. See the GNU Library General Public License
   for more details.

   You should have received a copy of the GNU Library General Public License
   along with this library; if not, write to the Free Software Foundation,
   Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.}

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, SpinEx, DateTimePicker,
  Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  Buttons, EditBtn, Spin, ExtCtrls, MaskEdit, DBGrids, DbCtrls, ECImageMenu,
  ECSwitch, ECEditBtns, LCLType,
  GetHotkey;

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
    Bt_LoadStarList: TButton;
    Bt_ConfStarList: TButton;
    Bt_ResetStarList: TButton;
    CBx_Rate: TComboBox;
    CBx_Tag: TComboBox;
    CbBx_Ort: TComboBox;
    CmbBx_Baud: TComboBox;
    CmbBx_ComPort: TComboBox;
    ECEdBtn_Htky: TECSpeedBtnPlus;
    Ed_HtKy: TEdit;
    FlSpEd_Height: TFloatSpinEdit;
    Img_Info_HtKy: TImage;
    Img_Info_Height: TImage;
    Lbl_Height: TLabel;
    LbL_LoadStarList: TLabel;
    Lbl_ConfStarList: TLabel;
    Lbl_ResetStarList: TLabel;
    Lbl_HtKy: TLabel;
    Lbl_NwCnfg: TLabel;
    Lbl_Sw_HtKy: TLabel;
    OpnD_StarList: TOpenDialog;
    Sw_HtKy: TECSwitch;
    TbSht_StarList: TTabSheet;
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
    procedure Bt_ConfStarListClick(Sender: TObject);
    procedure Bt_LoadStarListClick(Sender: TObject);
    procedure Bt_ResetStarListClick(Sender: TObject);
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
    procedure Sw_HtKyChange(Sender: TObject);
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
    function KeyToStr (Key: Word): String; inline;
    function Koordinaten (Stadt:String):TKoord;
    procedure AllUpOff ();
  end;

var
  Frm_Config   : TFrm_Config;

implementation

uses
  spaceorienter_main;

{$R *.lfm}

{ TFrm_Config }

//Usefull: ComboboxEx,  TECTabCtrl
// Benachrichtigungen

function TFrm_Config.KeyToStr (Key: Word): String; inline; //Label for virtuel; own file
  begin
    case Key of
      VK_HIGHESTVALUE,
      VK_UNKNOWN,
      VK_UNDEFINED:  Result := '???';

      VK_0:          Result := '0';
      VK_1:          Result := '1';
      VK_2:          Result := '2';
      VK_3:          Result := '3';
      VK_4:          Result := '4';
      VK_5:          Result := '5';
      VK_6:          Result := '6';
      VK_7:          Result := '7';
      VK_8:          Result := '8';
      VK_9:          Result := '9';
      VK_A:          Result := 'A';
      VK_B:          Result := 'B';
      VK_C:          Result := 'C';
      VK_D:          Result := 'D';
      VK_E:          Result := 'E';
      VK_F:          Result := 'F';
      VK_G:          Result := 'G';
      VK_H:          Result := 'H';
      VK_I:          Result := 'I';
      VK_J:          Result := 'J';
      VK_K:          Result := 'K';
      VK_L:          Result := 'L';
      VK_M:          Result := 'M';
      VK_N:          Result := 'N';
      VK_O:          Result := 'O';
      VK_P:          Result := 'P';
      VK_Q:          Result := 'Q';
      VK_R:          Result := 'R';
      VK_S:          Result := 'S';
      VK_T:          Result := 'T';
      VK_U:          Result := 'U';
      VK_V:          Result := 'V';
      VK_W:          Result := 'W';
      VK_X:          Result := 'X';
      VK_Y:          Result := 'Y';
      VK_Z:          Result := 'Z';

      VK_F1:         Result := 'F1';
      VK_F2:         Result := 'F2';
      VK_F3:         Result := 'F2';
      VK_F4:         Result := 'F4';
      VK_F5:         Result := 'F5';
      VK_F6:         Result := 'F6';
      VK_F7:         Result := 'F7';
      VK_F8:         Result := 'F8';
      VK_F9:         Result := 'F9';
      VK_F10:        Result := 'F10';
      VK_F11:        Result := 'F11';
      VK_F12:        Result := 'F12';
      VK_F13:        Result := 'F13';
      VK_F14:        Result := 'F14';
      VK_F15:        Result := 'F15';
      VK_F16:        Result := 'F16';
      VK_F17:        Result := 'F17';
      VK_F18:        Result := 'F18';
      VK_F19:        Result := 'F19';
      VK_F20:        Result := 'F20';
      VK_F21:        Result := 'F21';
      VK_F22:        Result := 'F22';
      VK_F23:        Result := 'F23';
      VK_F24:        Result := 'F24';

      VK_TAB:        Result := 'Tab';
      VK_SHIFT:      Result := 'Shift'; // See also VK_LSHIFT, VK_RSHIFT
      VK_RETURN:     Result := 'Enter'; // The "Enter" key, also used for a keypad center press
      VK_BACK:       Result := 'Back';  // The "Backspace" key, dont confuse with the
                                        // Android BACK key which is mapped to VK_ESCAPE
      VK_CONTROL:    Result := 'Ctr';   // See also VK_LCONTROL, VK_RCONTROL
      VK_DELETE:     Result := 'Del';
      VK_MENU:       Result := 'Alt'; // The ALT key. Also called "Option" in Mac OS X. See also VK_LMENU, VK_RMENU
      VK_PAUSE:      Result := 'Pause'; // Pause/Break key
      VK_CAPITAL:    Result := 'Caps'; // CapsLock key
      VK_SPACE:      Result := 'Space';
      VK_END:        Result := 'End';
      VK_HOME:       Result := 'Home';
      VK_LEFT:       Result := 'Left';
      VK_UP:         Result := 'Up';
      VK_RIGHT:      Result := 'Right';
      VK_DOWN:       Result := 'Down';
      VK_SELECT:     Result := 'Selct';
      VK_PRINT:      Result := 'Print'; // PrintScreen key
      VK_EXECUTE:    Result := 'Execte';
      VK_SNAPSHOT:   Result := 'Snapsht';
      VK_INSERT:     Result := 'Insrt';
      VK_CLEAR:      Result := 'Clear';

      VK_LWIN:       Result := 'LSYS'; // In Mac OS X this is the Apple, or Command key. Windows Key in PC keyboards
      VK_RWIN:       Result := 'RSYS'; // In Mac OS X this is the Apple, or Command key. Windows Key in PC keyboards
      VK_ESCAPE:     Result := 'Esc';  // Also used for the hardware Back key in Android
      VK_PRIOR:      Result := 'PageUp'; // Page Up
      VK_NEXT:       Result := 'PageDwn'; // Page Down
      VK_SCROLL:     Result := 'Scrll';

      VK_NUMLOCK:    Result := 'Num';
      VK_NUMPAD0:    Result := 'Num0';
      VK_NUMPAD1:    Result := 'Num1';
      VK_NUMPAD2:    Result := 'Num2';
      VK_NUMPAD3:    Result := 'Num3';
      VK_NUMPAD4:    Result := 'Num4';
      VK_NUMPAD5:    Result := 'Num5';
      VK_NUMPAD6:    Result := 'Num6';
      VK_NUMPAD7:    Result := 'Num7';
      VK_NUMPAD8:    Result := 'Num8';
      VK_NUMPAD9:    Result := 'Num9';
      VK_MULTIPLY:   Result := 'Num*'; // VK_MULTIPLY up to VK_DIVIDE are usually in the numeric keypad in PC keyboards
      VK_ADD:        Result := 'Num+';
      VK_SEPARATOR:  Result := 'NumEntr';
      VK_SUBTRACT:   Result := 'Num-';
      VK_DECIMAL:    Result := 'Num' + DefaultFormatSettings.DecimalSeparator;
      VK_DIVIDE:     Result := 'Num/';

      VK_LBUTTON:    Result := 'LBtn';
      VK_RBUTTON:    Result := 'RBtn';
      VK_CANCEL:     Result := 'Cncl';
      VK_MBUTTON:    Result := 'MBtn';
      VK_XBUTTON1:   Result := 'XBtn1';
      VK_XBUTTON2:   Result := 'XBtn2';

      VK_OEM_PLUS:   Result := '+'; // For any country/region, the '+' key
      VK_OEM_COMMA:  Result := ','; // For any country/region, the ',' key
      VK_OEM_MINUS:  Result := '-'; // For any country/region, the '-' key
      VK_OEM_PERIOD: Result := '.'; // For any country/region, the '.' key

      //Application.ExtendedKeysSupport
      VK_LSHIFT:     Result := 'LShift';
      VK_RSHIFT:     Result := 'RShift';
      VK_LCONTROL:   Result := 'LCtr';
      VK_RCONTROL:   Result := 'RCtr';
      VK_LMENU:      Result := 'LAlt'; // Left ALT key (also named Option in Mac OS X)
      VK_RMENU:      Result := 'RAlt'; // Right ALT key (also named Option in Mac OS X)

      VK_HELP:       Result := 'Help';
      VK_APPS:       Result := 'Apps';   // The PopUp key in PC keyboards
      VK_SLEEP:      Result := 'Sleep';

      VK_PROCESSKEY: Result := 'Prgrss'; // IME Process key

      VK_KANA:       Result := 'Kana';
      //VK_HANGUL:     Result := 'Hangul';
      VK_JUNJA:      Result := 'Junja';
      VK_FINAL:      Result := 'Final';
      VK_HANJA:      Result := 'Hanja';
      //VK_KANJI:      Result := 'Kanji';
      VK_CONVERT:    Result := 'Conrt';
      VK_NONCONVERT: Result := 'NConrt';
      VK_ACCEPT:     Result := 'Acc';
      VK_MODECHANGE: Result := 'MdlCh';

      VK_ATTN:       Result := 'Attn';
      VK_CRSEL:      Result := 'CrSel';
      VK_EXSEL:      Result := 'ExSel';
      VK_EREOF:      Result := 'Ereof';
      VK_PLAY:       Result := 'Play';
      VK_ZOOM:       Result := 'Zoom';
      VK_NONAME:     Result := 'NoName';
      VK_PA1:        Result := 'Pa1';

      VK_LCL_POWER:  Result := 'Power';
      VK_LCL_CALL:   Result := 'Call';
      VK_LCL_ENDCALL:Result := 'EndCall';
      VK_LCL_AT:     Result := '@'; // Not equivalent to anything < $FF, will only be sent by a primary "@" key
                                    // but not for a @ key as secondary action of a "2" key for example
    else
     Result := '???';

{ Not Used Keys:

    VK_BROWSER_BACK        = $A6;
    VK_BROWSER_FORWARD     = $A7;
    VK_BROWSER_REFRESH     = $A8;
    VK_BROWSER_STOP        = $A9;
    VK_BROWSER_SEARCH      = $AA;
    VK_BROWSER_FAVORITES   = $AB;
    VK_BROWSER_HOME        = $AC;
    VK_VOLUME_MUTE         = $AD;
    VK_VOLUME_DOWN         = $AE;
    VK_VOLUME_UP           = $AF;
    VK_MEDIA_NEXT_TRACK    = $B0;
    VK_MEDIA_PREV_TRACK    = $B1;
    VK_MEDIA_STOP          = $B2;
    VK_MEDIA_PLAY_PAUSE    = $B3;
    VK_LAUNCH_MAIL         = $B4;
    VK_LAUNCH_MEDIA_SELECT = $B5;
    VK_LAUNCH_APP1         = $B6;
    VK_LAUNCH_APP2         = $B7;

    // VK_OEM keys are utilized only when Application.ExtendedKeysSupport is false

    VK_OEM_1               = $BA; // Used for miscellaneous characters; it can vary by keyboard.
                                  // For the US standard keyboard, the ';:' key

    VK_OEM_2               = $BF; // Used for miscellaneous characters; it can vary by keyboard.
                                  // For the US standard keyboard, the '/?' key
    VK_OEM_3               = $C0; // Used for miscellaneous characters; it can vary by keyboard.
                                  // For the US standard keyboard, the '`~' key

    VK_OEM_4               = $DB; // Used for miscellaneous characters; it can vary by keyboard.
                                  // For the US standard keyboard, the '[{' key
    VK_OEM_5               = $DC; // Used for miscellaneous characters; it can vary by keyboard.
                                  // For the US standard keyboard, the '\|' key
    VK_OEM_6               = $DD; // Used for miscellaneous characters; it can vary by keyboard.
                                  // For the US standard keyboard, the ']}' key
    VK_OEM_7               = $DE; // Used for miscellaneous characters; it can vary by keyboard.
                                  // For the US standard keyboard, the 'single-quote/double-quote' key
    VK_OEM_8               = $DF; // Used for miscellaneous characters; it can vary by keyboard.

    // $E0 Reserved
    // $E1 OEM specific
    VK_OEM_102             = $E2; // Either the angle bracket key or the backslash key on the RT 102-key keyboard

    VK_OEM_CLEAR  = $FE;}
    end;
  end;

function TFrm_Config.Koordinaten (Stadt:String):TKoord; //Dynamisch, laden + Speichern ermöglichen; own file
  begin
//    ShowMessage(Stadt);
    case (Trim(AnsiLowerCase(Stadt))) of
      'none':
        begin
          Result.Lat := 0;
          Result.Lon  := 0;
        end;

      'aachen':
        begin
          Result.Lat := 50.775346;
          Result.Lon := 6.0838870;
         end;
      'augsburg':
        begin
          Result.Lat := 48.370545;
          Result.Lon := 10.897790;
         end;
      'bamberg':
        begin
          Result.Lat := 49.898814;
          Result.Lon := 10.902764;
         end;
      'bergisch gladbach':
        begin
          Result.Lat := 50.992309;
          Result.Lon := 7.1286210;
         end;
      'berlin':
        begin
          Result.Lat := 52.520007;
          Result.Lon := 13.404954;
         end;
      'bielefeld':
        begin
          Result.Lat := 52.030228;
          Result.Lon := 8.5324710;
         end;
      'bochum':
        begin
          Result.Lat := 51.481845;
          Result.Lon := 7.2162360;
         end;
      'bonn':
        begin
          Result.Lat := 50.737430;
          Result.Lon := 7.0982070;
         end;
      'bottrop':
        begin
          Result.Lat := 51.529086;
          Result.Lon := 6.9446890;
         end;
      'brünn':
        begin
          Result.Lat := 49.195060;
          Result.Lon := 16.606837;
         end;
      'braunschweig':
        begin
          Result.Lat := 52.268874;
          Result.Lon := 10.526770;
         end;
      'bremen':
        begin
          Result.Lat := 53.079296;
          Result.Lon := 8.8016940;
         end;
      'bremerhaven':
        begin
          Result.Lat := 53.539584;
          Result.Lon := 8.5809420;
         end;
      'chemnitz':
        begin
          Result.Lat := 50.827845;
          Result.Lon := 12.921370;
         end;
      'cottbus':
        begin
          Result.Lat := 51.756311;
          Result.Lon := 14.332868;
         end;
      'düsseldorf':
        begin
          Result.Lat := 51.227741;
          Result.Lon := 6.7734560;
         end;
      'darmstadt':
        begin
          Result.Lat := 49.872825;
          Result.Lon := 8.6511930;
         end;
      'dessau-roßlau':
        begin
          Result.Lat := 51.842828;
          Result.Lon := 12.230393;
         end;
      'dortmund':
        begin
          Result.Lat := 51.513587;
          Result.Lon := 7.4652980;
         end;
      'dresden':
        begin
          Result.Lat := 51.050409;
          Result.Lon := 13.737262;
         end;
      'duisburg':
        begin
          Result.Lat := 51.434408;
          Result.Lon := 6.7623290;
         end;
      'erfurt':
        begin
          Result.Lat := 50.984768;
          Result.Lon := 11.029880;
         end;
      'erlangen':
        begin
          Result.Lat := 49.589674;
          Result.Lon := 11.011961;
         end;
      'essen':
        begin
          Result.Lat := 51.455643;
          Result.Lon := 7.0115550;
         end;
      'fürth':
        begin
          Result.Lat := 49.477117;
          Result.Lon := 10.988667;
         end;
      'flensburg':
        begin
          Result.Lat := 54.793743;
          Result.Lon := 9.4469960;
         end;
      'frankfurt (oder)':
        begin
          Result.Lat := 52.347224;
          Result.Lon := 14.550567;
         end;
      'frankfurt am main':
        begin
          Result.Lat := 50.110922;
          Result.Lon := 8.6821270;
         end;
      'freiburg im breisgau':
        begin
          Result.Lat := 47.999008;
          Result.Lon := 7.8421040;
         end;
      'görlitz':
        begin
          Result.Lat := 51.150627;
          Result.Lon := 14.968707;
         end;
      'göttingen':
        begin
          Result.Lat := 51.541280;
          Result.Lon := 9.9158040;
         end;
      'gütersloh':
        begin
          Result.Lat := 51.903238;
          Result.Lon := 8.3857530;
         end;
      'gelsenkirchen':
        begin
          Result.Lat := 51.517744;
          Result.Lon := 7.0857170;
         end;
      'gera':
        begin
          Result.Lat := 50.885071;
          Result.Lon := 12.080720;
         end;
      'graz':
        begin
          Result.Lat := 47.070714;
          Result.Lon := 15.439504;
         end;
      'hagen':
        begin
          Result.Lat := 51.367078;
          Result.Lon := 7.4632840;
         end;
      'halle (saale)':
        begin
          Result.Lat := 51.496980;
          Result.Lon := 11.968803;
         end;
      'hamburg':
        begin
          Result.Lat := 53.551085;
          Result.Lon := 9.9936820;
         end;
      'hamm':
        begin
          Result.Lat := 51.673858;
          Result.Lon := 7.8159820;
         end;
      'hannover':
        begin
          Result.Lat := 52.375892;
          Result.Lon := 9.7320100;
         end;
      'haunau':
        begin
          Result.Lat := 60.791660;
          Result.Lon := 22.903331;
         end;
      'heidelberg':
        begin
          Result.Lat := 49.398752;
          Result.Lon := 8.6724340;
         end;
      'heilbronn':
        begin
          Result.Lat := 49.142693;
          Result.Lon := 9.2108790;
         end;
      'herne':
        begin
          Result.Lat := 51.536895;
          Result.Lon := 7.2009150;
         end;
      'hildesheim':
        begin
          Result.Lat := 52.154778;
          Result.Lon := 9.9579650;
         end;
      'ingolstadt':
        begin
          Result.Lat := 48.766535;
          Result.Lon := 11.425754;
         end;
      'jena':
        begin
          Result.Lat := 50.927054;
          Result.Lon := 11.589237;
         end;
      'köln':
        begin
          Result.Lat := 50.937531;
          Result.Lon := 6.9602790;
         end;
      'königs wusterhausen':
        begin
          Result.Lat := 52.295891;
          Result.Lon := 13.622838;
         end;
      'kaiserslautern':
        begin
          Result.Lat := 49.440066;
          Result.Lon := 7.7491260;
         end;
      'karlsruhe':
        begin
          Result.Lat := 49.006890;
          Result.Lon := 8.4036530;
         end;
      'kassel':
        begin
          Result.Lat := 51.312711;
          Result.Lon := 9.4797460;
         end;
      'kiel':
        begin
          Result.Lat := 54.323293;
          Result.Lon := 10.122765;
         end;
      'koblenz':
        begin
          Result.Lat := 50.356943;
          Result.Lon := 7.5889960;
         end;
      'krefeld':
        begin
          Result.Lat := 51.338761;
          Result.Lon := 6.5853420;
         end;
      'lübeck':
        begin
          Result.Lat := 53.865467;
          Result.Lon := 10.686559;
         end;
      'leibzig':
        begin
          Result.Lat := 51.339695;
          Result.Lon := 12.373075;
         end;
      'leverkusen':
        begin
          Result.Lat := 51.045925;
          Result.Lon := 7.0192200;
         end;
      'linz':
        begin
          Result.Lat := 48.306940;
          Result.Lon := 14.285830;
         end;
      'ludwigsburg':
        begin
          Result.Lat := 48.894062;
          Result.Lon := 9.1954640;
         end;
      'ludwigshafen am rhein':
        begin
          Result.Lat := 49.477410;
          Result.Lon := 8.4451800;
         end;
      'mönchengladbach':
        begin
          Result.Lat := 51.180457;
          Result.Lon := 6.4428040;
         end;
      'mülheim an der ruhr':
        begin
          Result.Lat := 51.418568;
          Result.Lon := 6.8845230;
         end;
      'münchen':
        begin
          Result.Lat := 48.135125;
          Result.Lon := 11.581980;
         end;
      'münster':
        begin
          Result.Lat := 51.960665;
          Result.Lon := 7.6261350;
         end;
      'magdeburg':
        begin
          Result.Lat := 52.120533;
          Result.Lon := 11.627624;
        end;
      'mainz':
        begin
          Result.Lat := 49.992862;
          Result.Lon := 8.2472530;
         end;
      'mannheim':
        begin
          Result.Lat := 49.487459;
          Result.Lon := 8.4660390;
         end;
      'moers':
        begin
          Result.Lat := 51.451604;
          Result.Lon := 6.6408150;
         end;
      'nürnberg':
        begin
          Result.Lat := 49.452102;
          Result.Lon := 11.076665;
         end;
      'neuss':
        begin
          Result.Lat := 51.204197;
          Result.Lon := 6.6879510;
         end;
      'oberhausen':
        begin
          Result.Lat := 51.496334;
          Result.Lon := 6.8637760;
         end;
      'offenbach am main':
        begin
          Result.Lat := 50.095636;
          Result.Lon := 8.7760840;
         end;
      'oldenburg (oldb)':
        begin
          Result.Lat := 53.143450;
          Result.Lon := 8.2145520;
         end;
      'osnabrück':
        begin
          Result.Lat := 52.279911;
          Result.Lon := 8.0471790;
         end;
      'paderborn':
        begin
          Result.Lat := 51.718921;
          Result.Lon := 8.7575090;
         end;
      'pforzheim':
        begin
          Result.Lat := 48.892186;
          Result.Lon := 8.6946290;
         end;
      'pilsen':
        begin
          Result.Lat := 49.738431;
          Result.Lon := 13.373637;
         end;
      'plauen':
        begin
          Result.Lat := 50.497613;
          Result.Lon := 12.136868;
         end;
      'potsdam':
        begin
          Result.Lat := 52.390569;
          Result.Lon := 13.064473;
         end;
      'prag':
        begin
          Result.Lat := 50.075538;
          Result.Lon := 14.437800;
         end;
      'recklingshausen':
        begin
          Result.Lat := 51.614065;
          Result.Lon := 7.1979450;
         end;
      'regensburg':
        begin
          Result.Lat := 49.013430;
          Result.Lon := 12.101624;
         end;
      'remscheid':
        begin
          Result.Lat := 51.178742;
          Result.Lon := 7.1896960;
         end;
      'reutlingen':
        begin
          Result.Lat := 48.506939;
          Result.Lon := 9.2038040;
         end;
      'rostock':
        begin
          Result.Lat := 54.092441;
          Result.Lon := 12.099147;
         end;
      'saarbrücken':
        begin
          Result.Lat := 49.240157;
          Result.Lon := 6.9969330;
         end;
      'salzgitter':
        begin
          Result.Lat := 52.137866;
          Result.Lon := 10.389913;
         end;
      'schwerin':
        begin
          Result.Lat := 53.635502;
          Result.Lon := 11.401250;
         end;
      'siegen':
        begin
          Result.Lat := 50.883849;
          Result.Lon := 8.0209590;
         end;
      'solingen':
        begin
          Result.Lat := 51.165220;
          Result.Lon := 7.0671160;
         end;
      'stuttgart':
        begin
          Result.Lat := 48.775846;
          Result.Lon := 9.1829320;
         end;
      'ulm':
        begin
          Result.Lat := 48.401082;
          Result.Lon := 9.9876080;
         end;
      'würzburg':
        begin
          Result.Lat := 49.791304;
          Result.Lon := 9.9533550;
         end;
      'weimar':
        begin
          Result.Lat := 50.979493;
          Result.Lon := 11.323544;
         end;
      'wien':
        begin
          Result.Lat := 48.208174;
          Result.Lon := 16.373819;
         end;
      'wiesbaden':
        begin
          Result.Lat := 50.078218;
          Result.Lon := 8.2397610;
         end;
      'witten':
        begin
          Result.Lat := 51.443893;
          Result.Lon := 7.3531970;
         end;
      'wolfsburg':
        begin
          Result.Lat := 52.422650;
          Result.Lon := 10.786546;
         end;
      'wuppertal':
        begin
          Result.Lat := 51.256213;
          Result.Lon := 7.1507640;
         end;
      'zeuthen':
        begin
          Result.Lat := 52.347652;
          Result.Lon := 13.620762;
         end;
      'zwickau':
        begin
          Result.Lat := 50.710217;
          Result.Lon := 12.473372;
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

procedure TFrm_Config.Ed_HtKyEditingDone(Sender: TObject); //ToDo
  begin

  end;

procedure TFrm_Config.BitBtn_NwCnfgClick(Sender: TObject);
  var
    HK: String;
    PortableMode: boolean;

    OptName: TOptionNames;
  begin
    with Frm_Spori do
      begin
        HK     := Ed_Nr.Text;
        PortableMode := StrToBool(Options[ON_PortableMode]);

      //Set default Options
      for OptName := low(TOptionNames) to High(TOptionNames) do
        Options[OptName] := GetDefaultOption(OptName);

      //Remove old file
      if FileExists (OptionsPath)  then
        begin
          ForceDirectories (OldOptionsPath);
          RenameFile (OptionsPath, OldOptionsPath + PathDelim + 'Options'+formatdatetime('d.m.y-h;n;s;z', Now)+'.old');
        end;

        Sw_PortableMode.Checked := PortableMode;  //Since it would be changed if portableMode was active there is no need to call SetPortableMode(PortableMode);

        Ed_Nr.Text := HK;
        ProgressNumber ();
      end;
  end;

procedure TFrm_Config.Bt_ConfStarListClick(Sender: TObject); //ToDo
  begin

  end;

procedure TFrm_Config.Bt_LoadStarListClick(Sender: TObject);
  begin
    if (OpnD_StarList.Execute) then
      begin
        Frm_Spori.LV_List.Items.Clear;

        Frm_Spori.LoadStarList(OpnD_StarList.Files[0]);
      end;
  end;

procedure TFrm_Config.Bt_ResetStarListClick(Sender: TObject);
  begin
    with Frm_Spori do
      begin
        DefaultList ();

        LoadStarList (ListPath);
      end;
  end;

procedure TFrm_Config.Bt_HtKyClick(Sender: TObject);
  begin
    Frm_GetHotKey.ShowModal;
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

  //Frm_Spori.Angle ();

  Frm_Spori.Options[ON_Lat] := FloatToStr(FlSpEd_Lat.Value);
end;

procedure TFrm_Config.FlSpEd_LonEditingDone(Sender: TObject);
begin
  Frm_Spori.Lb_Lon_G.Caption  := FloatToStr(FlSpEd_Lon.Value);
  Frm_Spori.Lb_Lon_G1.Caption := FloatToStr(FlSpEd_Lon.Value);

  //Frm_Spori.Angle ();

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
      5: PgCont_Pnl.ActivePage := TbSht_StarList;
      6: PgCont_Pnl.ActivePage := TbSht_Info;
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

procedure TFrm_Config.Sw_HtKyChange(Sender: TObject);
    var
    IsActive: Boolean;
  begin
    IsActive := Sw_HtKy.Checked;

    Lbl_Sw_HtKy.Caption := BoolToStr(IsActive, 'Ein', 'Aus');

    Ed_HtKy.Enabled := IsActive;
    Bt_HtKy.Enabled := IsActive;

    Frm_Spori.Options[ON_UseHotkey] := BoolToStr(IsActive, 'True', 'False');
  end;

procedure TFrm_Config.Sw_ManWChange(Sender: TObject);
  var
    IsActive: Boolean;
  begin
    IsActive := Sw_ManW.Checked;

    Sw_ManW.Caption := BoolToStr(IsActive, 'Ein', 'Aus');

    Frm_Spori.Options[ON_AutoValueMode] := BoolToStr(not IsActive, 'True', 'False');
   end;

procedure TFrm_Config.Sw_PortableModeChange(Sender: TObject);
  begin
    Frm_Spori.Options[ON_PortableMode] := BoolToStr(Sw_PortableMode.Checked, 'True', 'False');
    Lbl_Sw_PortableMode.Caption := BoolToStr(Sw_PortableMode.Checked, 'Ein', 'Aus');

    Frm_Spori.SetPortableMode(Sw_PortableMode.Checked);
   end;

procedure TFrm_Config.Sw_AutoConChange(Sender: TObject); //ToDo: Don't connect if config wasn't loeaded
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

        Frm_Spori.Connect (true);
       end;
   end;

procedure TFrm_Config.Sw_RedoChange(Sender: TObject);
  begin
    if (Sw_Redo.Checked) then
      begin
        Lbl_Sw_Redo.Caption   := 'Ein';
        Frm_Spori.Options[ON_UpRetry] := 'True';
       end
     else
      begin
        Lbl_Sw_Redo.Caption   := 'Aus';
        Frm_Spori.Options[ON_UpRetry] := 'False';
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

