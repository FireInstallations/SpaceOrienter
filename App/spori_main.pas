unit SpOri_Main;

{Copyright (C) <2019> <FireInstallations> <kettnerl [at] hu-berlin.de>

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
   Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
    }

  //Store StarList in own Array and supply it using OnData event ?
  //phases of the moon
  //Correct UT (leap secounds)
  //Online dienst für Höhe, lage, Offset einer stadt
  //Onlinedienst wetter
  //set StarCalc values to 0 wihle Eph is calculated
  //initalisiere werte auf 0 bei start
  //Bug report
  //Help Off / OnLine
  //PopUpMenus
  //Shortcut Ctrl+f doesn't work becourse TCustomListBox (please use Alt+f instead)
  //Make navigate shortcut work
  //SearchInputEdit umbauen, so dass es für alle nützlich ist
  //DiffD und DiffT können zu einer DateTime zusemmengefasst werden. Siehe replace time functionen
  //Schreibe berechnete zahlen nur auf pages die gereade gezeigt werden
  //Try to load mo file befor trying to load po file
  //Fix Comport loading /saving
  //Eph calculation seems unaccurate
  //Error handeling in wmmm  --> decimalsep in wmm or is  format settings in delphi supported?
  //DefaultFormat is not Delphi friendly
  //Body list search is broken
  //handeling error in clac timer

{ToDo List:
    Range check while reading from config file (is it greater then a possible string / memory?
    Keep in mind: http://wiki.freepascal.org/Secure_programming
    Use http://wiki.freepascal.org/TTaskDialog for custom buttons
    Maby using ready made Api for config file (http://wiki.freepascal.org/Using_INI_Files or /xmlconf)
     - Pro: should shorten the program; Well known structure; could working faster
     - Con  Doesn't uses StrCopmpaire - > not as stable as  the solution now
    If new mainform was rezised the shapes doesn't stay on thair charts
    High DPI awareness http://wiki.freepascal.org/High_DPI/de
    Remove number labels from po files
    Finish to change all text to Resourcestring
    Rename Resourcestrings so it isn't that difficult anymore o figure out what they are
    Add langue pick setting to config form
    Change config form buttons (etc) to autosize
    Progressbar (Main / Config) for Update
    Use System DecimalSepperators for (default) StarList
    Move Ele/Azi charts up/down if ManuVal mode toggles
    Integrate follow timer in Calc timer
    Cut Ele chart in half since Values > 90° doesn't make sence
    StrCompaire: find offset of missing parts so searching for a near char makes more sanse
    Clean ArduIno code
    Use Out in PlanEph and Sofa
    rename (kleiner) wagen -> (kleiner) Bär
    Warn if more then one inctance is runnig
    Lon /Lat to Timezone offset
    Build up own Planetarium, to show where is what located, to find and choose bodys on a graphicle way
    Better handeling of globale variables (property)
    Throw a warning msg if config resett
    Make default WMM.COF, so the User doesn't have to install it
    Finish PlanEph translation & remove everything unessesary in used lib
    Put DefaultList/Options/WMM in own Unit
    If Resett StarList / WMM / Options don't Save and load from file, just save and load from default
    Make Starlist and WMM loading as robost as config loading
    Add Hight to places list
    Use Heigt of Config form
    Add more contrys to places list
    Make places list customizable
    Use http://maia.usno.navy.mil/ for automatic values (x, y offset dut1)
    PlanEph: Test on WMM.COF exitense; finalization automaticly calls EndPlanEph
    Make order of procedures and functions more relatable
    Starlist configurator
    Make Hotkey Editfield working
    Add Resett Button on GetHotkey form
    FnD --> use defaultpath as default path
    Replace summertime whit time offzeit
    ExpertMode have to hide: <-- (release unused space)
     - Lat, Lon
     - Comport (just automatic connecting)
     - Baudrate (see above)
     - hole time configurations
     - both calculating tabs (works)
    Identify place name if lon / lat is near
    Use threads for timers
    Load images from ImageList (like update ones)
    Try to reconnect to ArduIno when lost
    Make temperatur, atmospheric pressure, humidity customizable and get them automatic online
      --> let the user decide if we get anything automatic online
    Add wave lengths in starlist
    Updates via Github
    Add ISS and other space stations
    Add Hints (for Questionmark images)
    Finish rdesine main form
      - Shortcuts like Str f
      - Starlist
      - Calculate Tabs
    Make anchors work
    Make popup menues work
    Make an own Installer
    Format code to english and component names too
    Finde next in StarList serch
    Make an Installer with importend lists and custom paths
     - Make custom paths happen
    Version check while load / save options
    Detect Arduinotype (and if it is the Spori); Synapser dosn't find right ports
    Function IsConstellation could be optimized
    There seems to be an error in LoadStarList, but I coudn't figure out what goes wrong yet
    If portable mode was switched, clear at the old place up and move all files to the new location
    Make OlsOptions / Lists optional
    In ProgressList: test if the Item is vailed (mainpage)
    In ProgressNumber: Errorhandeling if the Item doesnt exits
    Are there cases where GetCurrentDir is not the own dir at beginning?
    In FormShow: move Connect to LoadOptions and use Connact to all just if no vailid port was found or
      autoconncet is turned on
    Errorhandeling when Connect doesn't work (see MI_ConnectClick)
    In MI_SuchClick: Error handeling
    Remove unessesary units from uses list

    convert "legal" file to md

    Add proritys and kinds to this ToDoList like in examble below

    ToDo 02 -oFireInstall -cUser : Shortcuts
    ToDo 02 -oFireInstall -cCode : Beschreibung hinzufügen bei Lizenz
    ToDo 02 -oFireInstall -cFunc : Sternbildsuche - Liste}


{$mode objfpc}{$H+}

interface

uses
  {$IfDef Windows}
  JwaWindows, {windows, ShellApi,}
  {$Else}
  clocale, process, {Unix,}
  //baseunix,
  //lclintf,
    {$IFDEF LCLCarbon}
  MacOSAll,
    {$ENDIF}
  {$EndIf}
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, ComCtrls, Buttons, Spin, ECImageMenu, ECTabCtrl, LCLType, Menus,
  Math, StrUtils, Types, typinfo, gettext, LazUTF8, DateTimePicker,   //DateUtils,
  LCLTranslator,  //Be carefull, since it adds all kind of number displaying stuff too --> makes messy .po files
  synaser, PlanEph, Utils, Config, GetHotkey, MultiLangueStrings;

type

  {Lists all possible Option (config) names
   Warning: EVERY new option must be listed here! }
  TOptionNames = (
    ON_Version,
    ON_PortableMode,
    ON_ExpertMode,
    ON_UpdateMode,
    ON_UpdateRate,
    ON_UpdateDay,
    ON_UpdateTime,
    ON_UpRetry,
    ON_Place,
    ON_Lon,
    ON_Lat,
    ON_AutoTimeMode,
    ON_Date,
    ON_Time,
    ON_AutoComMode,
    ON_ComPort,
    ON_BaudRate,
    ON_AutoValueMode,
    ON_UseHotkey,
    ON_HotKey,
    ON_BodyMode,
    ON_Body,
    ON_Langue
    );

  {Determines how the App will act}
  TBodyMode = (
    BMd_Normal,
    //Follow a Body
    BMd_Follow,
    BMd_Scan,
    BMd_Place,
    BMd_Time,
    //Navigate to all stars of a given constellation
    BMd_Constellation,
    BMd_Search
    );

  TShapeNums = (
    ShpN_EleNow,
    ShpN_EleCalc,
    ShpN_AziNow,
    ShpN_AziCalc
    );

  { TArmConnect }

  TArmConnect = class(TThread)
    //General: Using a Delay is pritty importend, the app would lag if sleep was used
    private
        {Handel for the connecteion to the arduino (Synapser)}
        ser: TBlockSerial;

        {Connection Info}
        FConnectionStatus: Boolean;
        FReconnectStatus: Boolean;
        FPort: String;
        FBaudRate: Word;
        FNewConnect: Boolean;

        {In / Out data}
        FSendAzimuth: Real;
        FSendElevation: Real;
        FReceiveAzimuth: Real;
        FReceiveElevation: Real;

        Loop: TTimer;

      {Try to connect to the ArduIno}
      procedure Connect ();
      {Send Azimuth and Elevation to ARM (ArduIno)}
      procedure SendData ();
      {Receive Azimuth and Elevation from ARM (ArduIno)}
      function  ReceiveData (): Boolean;

      {Like a While not Terminated loop but cleaner in code terms}
      procedure OnLoopTimer (Sender: TObject);

    protected
      procedure Execute; override;
      {Give the received data to the (main) form}
      procedure ShowReceivedData ();

    public
      Constructor Create(const CreateSuspended : boolean);
      Destructor  Destroy();  override;

      {The port we are trying t connect to, in windows it's called ComPort.}
      property Port: String read FPort write FPort;
      {Determines how fast the state of the Bits can change per secound.
      However, setting the value higher doesn't mean automaticly the connection is also faster}
      property BaudRate: Word read FBaudRate write FBaudRate;

      property NewConnect: Boolean read FNewConnect write FNewConnect;
      {stores ser.InstanceActive status.
      that means it is true as long as we are connected}
      property IsConnected: Boolean read FConnectionStatus;
      {If we should try to automaticly reconnect if we lost the connection}
      property Reconnect: Boolean read FReconnectStatus write FReconnectStatus;
      {The new Outgoing Data}
      property SendAzimuth: Real read FSendAzimuth  write FSendAzimuth;
      property SendElevation: Real read FSendAzimuth write FSendElevation;
    end;

  { TFrm_Main }

  TFrm_Main = class(TForm)
    BitBtn_Navigate_Main: TBitBtn;
    CmbBx_Mode: TComboBox;
    ECTabCtrl_CalcSections: TECTabCtrl;
    Ed_Search4Bdy_Main: TEdit;
    Ed_Search4Bdy_List: TEdit;
    FltSpnEd_AziCalcManu: TFloatSpinEdit;
    FltSpnEd_EleCalcManu: TFloatSpinEdit;
    FndD: TFindDialog;
    Img_Compas_Ele: TImage;
    Img_Compas_Azi: TImage;
    Image6: TImage;
    Img_ChartEle: TImage;
    Img_ChartAzi: TImage;
    Img_Info_DateTime: TImage;
    Img_Info_ConStatus: TImage;
    Img_Info_Azi: TImage;
    Img_Info_Ele: TImage;
    Img_Info_UpStatus: TImage;
    Img_Info_Place: TImage;
    Img_Info_MagDvtn: TImage;
    Img_UpStatus: TImage;
    Img_ComState: TImage;
    ImgLst_UsedPics: TImageList;
    ImgMn_Menue: TECImageMenu;
    Img_Settings_W: TImage;
    ImgLst_Menue: TImageList;
    Img_Settings_G: TImage;
    Img_ShootingStar: TImage;
    Lbl_Compas_UpTitle: TLabel;
    Lbl_Compas_NorthTitle: TLabel;
    Lbl_Compas_DownTitle: TLabel;
    Lbl_Compas_SouthTitle: TLabel;
    Lbl_Compas_EastTitle: TLabel;
    Lbl_Compas_WestTitle: TLabel;
    Lbl_MagDvtn_Deg: TLabel;
    Lbl_Aries1P_Title: TLabel;
    Lbl_Aries1P_Val: TLabel;
    Lbl_Beta_Deg: TLabel;
    Lbl_Beta_Title: TLabel;
    Lbl_Beta_Val: TLabel;
    Lbl_CET_Title: TLabel;
    Lbl_CET_Val: TLabel;
    Lbl_Decli_Deg: TLabel;
    Lbl_Decli_Min: TLabel;
    Lbl_Decli_Title: TLabel;
    Lbl_Decli_ValDeg: TLabel;
    Lbl_Decli_ValMin: TLabel;
    Lbl_DegShift_Title: TLabel;
    Lbl_DegShift_Val: TLabel;
    Lbl_Delta_Deg: TLabel;
    Lbl_Delta_Title: TLabel;
    Lbl_Delta_Val: TLabel;
    Lbl_Diff_Title: TLabel;
    Lbl_Diff_Val: TLabel;
    Lbl_GMT_Title: TLabel;
    Lbl_GMT_Val: TLabel;
    Lbl_GrT_Title: TLabel;
    Lbl_GrT_Val: TLabel;
    Lbl_HourAngle_Title: TLabel;
    Lbl_HourAngle_Val: TLabel;
    Lbl_LocalUT_Title: TLabel;
    Lbl_LocalUT_Val: TLabel;
    Lbl_Azi_Deg: TLabel;
    Lbl_Ele_Deg: TLabel;
    Lbl_RightAc_Deg: TLabel;
    Lbl_RightAc_Min: TLabel;
    Lbl_RightAc_Title: TLabel;
    Lbl_RightAc_ValDeg: TLabel;
    Lbl_RightAc_ValMin: TLabel;
    Lbl_StarAngle_Deg: TLabel;
    Lbl_StarAngle_Title: TLabel;
    Lbl_StarAngle_Val: TLabel;
    Lbl_TZ_Title: TLabel;
    Lbl_TZ_Val: TLabel;
    Lbl_Azi_Val: TLabel;
    Lbl_Ele_Val: TLabel;
    Lbl_T_Title: TLabel;
    Lbl_T_Val: TLabel;
    Lbl_UTC1_Title: TLabel;
    Lbl_UTC1_Val: TLabel;
    Lbl_UTC2_Title: TLabel;
    Lbl_UTC2_Val: TLabel;
    Lbl_AziNum_Val: TLabel;
    Lbl_AziDeNom_Val: TLabel;
    Lbl_Lat_Rad: TLabel;
    Lbl_Lat_Deg: TLabel;
    Lbl_Long_Rad: TLabel;
    Lbl_Long_Deg: TLabel;
    Lbl_Lat_ValRad: TLabel;
    Lbl_Long_ValDeg: TLabel;
    Lbl_Long_ValRad: TLabel;
    Lbl_Lat_ValDeg: TLabel;
    Lbl_Long_Title: TLabel;
    Lbl_Lat_Title: TLabel;
    Lbl_AziNum_Title: TLabel;
    Lbl_AziDeNom_Title: TLabel;
    Lbl_Azi_Title: TLabel;
    Lbl_Ele_Title: TLabel;
    Lbl_EleChart_Title: TLabel;
    Lbl_AziChart_Title: TLabel;
    Lbl_AziCalc_Val: TLabel;
    Lbl_AziCalc_Deg: TLabel;
    Lbl_AziCalc_Title: TLabel;
    Lbl_AziNow_Val: TLabel;
    Lbl_AziNow_Deg: TLabel;
    Lbl_AziNow_Title: TLabel;
    Lbl_EleCalc_Deg: TLabel;
    Lbl_EleCalc_Val: TLabel;
    Lbl_EleCalc_Title: TLabel;
    Lbl_EleNow_Deg: TLabel;
    Lbl_EleNow_Title: TLabel;
    Lbl_EleNow_Val: TLabel;
    Lbl_Place_Name: TLabel;
    Lbl_Bdy_NameLatain: TLabel;
    Lbl_Bdy_Split: TLabel;
    Lbl_MagDvtn_Val: TLabel;
    Lbl_Settings: TLabel;
    Lbl_ArdoType: TLabel;
    Lbl_Date: TLabel;
    Lbl_BdyPrpty_Val1: TLabel;
    Lbl_BdyPrpty_Val2: TLabel;
    Lbl_ComState: TLabel;
    Lbl_Update_Title: TLabel;
    Lbl_Place_Title: TLabel;
    Lbl_MagDvtn_Title: TLabel;
    Lbl_Bdy_Title: TLabel;
    Lbl_Bdy_Nr: TLabel;
    Lbl_Bdy_Name: TLabel;
    Lbl_BdyPrpty_Title: TLabel;
    Lbl_Time: TLabel;
    Lbl_VernalPNow_Title: TLabel;
    Lbl_VernalPNow_Val: TLabel;
    Lbl_VernalP_Title: TLabel;
    Lbl_VernalP_Val: TLabel;
    LV_BodyList: TListView;
    PgCtrl_CalcSections: TPageControl;
    Pnl_Line_Status: TPanel;
    Pnl_Line: TPanel;
    Pnl_Status: TPanel;
    PgCtrl_Menue: TPageControl;
    Pnl_Header: TPanel;
    PrgrssBr_ComPCon: TProgressBar;
    Shape_AziCalc1: TShape;
    Shape_AziNow1: TShape;
    Shape_EleCalc: TShape;
    Shape_AziCalc: TShape;
    Shape_EleCalc1: TShape;
    Shape_AziNow: TShape;
    Shape_EleNow: TShape;
    Shape_EleNow1: TShape;
    TabSht_Time: TTabSheet;
    TabSht_VernalP: TTabSheet;
    TabSht_StarCalc: TTabSheet;
    TabSht_Calculation: TTabSheet;
    TabSht_DashBord: TTabSheet;
    TabSht_BodyList: TTabSheet;
    Tmr_CalcAll: TTimer;
    Tmr_Follow: TTimer;
    {tell the device to pilote to the body}
    procedure BitBtn_Navigate_MainClick(Sender: TObject);
    {A BodyMode was selecet, tell it}
    procedure CmbBx_ModeChange(Sender: TObject);
    {take the selected Item from the fancyer ECTapCtrl and
    show the right tab of PgCtrl_CalcSections}
    procedure ECTabCtrl_CalcSectionsChange(Sender: TObject);
    {If just the default text is given clear it else Select all text (buggy)}
    procedure Ed_Search4Bdy_Enter(Sender: TObject);
    {If the Editfild is emty reset it's text to 'Search for...'}
    procedure Ed_Search4Bdy_Exit(Sender: TObject);
    {If return (Enter) was pressed SearchInputEdit will be called}
    procedure Ed_Search4Bdy_KeyDown(Sender: TObject; var Key: Word;
      {%H-}Shift: TShiftState);
    {Manuel azimut / elevation from the user}
    procedure FltSpnEd_AziCalcManuChange(Sender: TObject);
    procedure FltSpnEd_EleCalcManuChange(Sender: TObject);
    {Opens a FindDialog and searches for the given String in our StarList}
    procedure FndDFind(Sender: TObject);
    {Detect PortableMode and initialize importend global vairiables like the paths.
    And call LoadOptions, also show the default pages}
    procedure FormCreate(Sender: TObject);
    {Save the configurations file and  clean up}
    procedure FormDestroy(Sender: TObject);
    {If the last key goes up (KeyCount = 0) then the Set KeysPressed, which
     containing all last pressed keys with the Hotkey set. If they are equal
     and UseHotkey is active SendData will be called.
     Therefore it decreases KeyCount ervytime FormKeyUp was called}
    procedure FormKeyDown(Sender: TObject; var Key: Word; {%H-}Shift: TShiftState);
    {Collect every ne pressed key and add them to the set KeysPressed.
     Also increases KeyCount, wich has a value above 0 as long as some keys are still pressed}
    procedure FormKeyUp(Sender: TObject; var {%H-}Key: Word; {%H-}Shift: TShiftState);
    //set the shapes at the right positions again.
    procedure FormResize(Sender: TObject);
    {Main Menue change --> show a different page}
    procedure ImgMn_MenueSelectionChange(Sender: TObject; {%H-}User: boolean);
    {Get the user to the confing form}
    procedure Img_Settings_WClick(Sender: TObject);
    {cosmetic: set color of label and image to gray (leftklick)}
    procedure Img_Settings_WMouseDown(Sender: TObject; Button: TMouseButton;
      {%H-}Shift: TShiftState; {%H-}X, {%H-}Y: Integer);
    {cosmetic: set color of label and image back to white (leftklick)}
    procedure Img_Settings_WMouseUp(Sender: TObject; Button: TMouseButton;
      {%H-}Shift: TShiftState; {%H-}X, {%H-}Y: Integer);
    {If a vailed Item was seleceted tell it (call ProgressList)}
    procedure LV_BodyListDblClick(Sender: TObject);
    {A vailed Item was seleceted, tell it (call ProgressList)}
    procedure LV_BodyListItemChecked(Sender: TObject; Item: TListItem);
    {A vailed Item was seleceted, tell it (call ProgressList)}
    procedure LV_BodyListKeyPress(Sender: TObject; var Key: char);
    {sets the width of the colums of the LV_BodyLst fittig to the
    avaible Space}
    procedure LV_BodyListResize(Sender: TObject);
    {calculation Timer, Heart of SpaceOrienter,
     where Star, ehem location calculating is called}
    procedure Tmr_CalcAllOnTimer(Sender: TObject);
    {Follow moving bodys}
    procedure Tmr_FollowOnTimer(Sender: TObject);
  private
    var
      {boolean to determine if we loaded all Options correctly}
      FOptionsLoaded: Boolean;
      {Counts how many keys was pressed at ones.
       Used basicly to determine when the last key goes up}
      KeyCount: byte;
      {Contains the last in a row pressed Keys}
      PressedKeys: Set of byte;
      {Importend pathes}
      DefaultPath,
      DefaultOptionsPath,
      DefaultOldOptionsPath,
      DefaultListPath,
      DefaultOldListPath: String;
      OwnDir: String;
      {Don't save time while it is on change in Frm_config }
      FNoEntry:     Boolean;
      {Diffrence between Now and the DateTime selected by the user
      Time goes on like expected but from point in time choosen by the user}
      FDiffD:       System.TDate;
      FDiffT:       System.TTime;  //Don't use Unix TTime

    {Resets the OptionsFile}
    procedure DefaultOptions ();
    {Find the Optionsname in a Sting, if there is none then nothig is returned}
    function  FindOptionName (const Line:String): String;
    {Find the optionsvalue, if there is none then nothig is returned}
    function  FindOptionValue (const Line:String): String;
    {platform-independent method to read the language of the user interface
    Taken from: http://wiki.freepascal.org/Everything_else_about_translations }
    function  GetOSLanguage (): string;
    {Try to find all possible ComPorts}
    procedure GetComPorts ();
    {Load Saved Options, if there is no file, create default otions will be created.
     Warning: ervery New Option must loaded here!}
    function  LoadOptions (const LoadFromFile: Boolean = true): Boolean;
    {Find the indx of a given option, even if it isn't excaly right.
     If nothing was found -1 is returned.}
    function  GetOptionIndex(const Str: String): ShortInt;
    {Transform the given OptionsName to a String and get rid of starting "ON_"}
    function OptionsEnumToStr(EnumVal: TOptionNames): String;
    {Tell the mainform what BodyMode was selected}
    procedure ProgressBodyMode (const Mode: TBodyMode; Save: Boolean = true);
    {Try to tell the Rest of the mainform what star was selecet by a given Item}
    procedure ProgressList (const Item:TListItem);
    {Seaches for a given Body in Bodylist}
    function Search4Body (SerchFor: String): TListItem;
    {Set the  pos of shape nr. at the  main page to the right angle on the chart}
    procedure SetShapePos (const ShapeNum: TShapeNums; Angle: Real);
    {Sends Data to the Arduino}
    procedure SendData ();
    {If a Input was given search for it in LV_BodyList}
    procedure SearchInputEdit(Sender:TObject);
    {Compaires two strings and compute the sameness in percent
    The boolean  does that what it's name say: it determine if StrCompaire is casesensitive}
    function  StrCompaire(str1, str2: String; const CaseSensitive: Boolean = true): Real;
  public
    {boolean to determine if we loaded all Options correctly}
    property OptionsLoaded: Boolean Read FOptionsLoaded;
    {path to the working area of the App, part of the imported pathes}
    property ListPath: String read DefaultListPath;
    property OptionsPath: String read DefaultOptionsPath;
    property OldOptionsPath: String read DefaultOldOptionsPath;
    {Don't save time while it is on change in Frm_config }
    property NoEntry: Boolean read FNoEntry write FNoEntry;
    {Diffrence between Now and the DateTime selected by the user
     Time goes on like expected but from point in time choosen by the user}
    property DiffD: System.TDate read FDiffD write FDiffD;
    property DiffT: System.TTime read FDiffT write FDiffT;  //Don't use Unix TTime

    var
      {importend cofigurations, saved in Options.Space at the end}
      Options: Array[TOptionNames] of String;
      {Contains the hotkey(s) as a set, will maybe removed in future}
      HotKey: Set of byte;

    {Transfer lon, lat to Rad}
    procedure Angle ();
    {Try to connect to the Arduino via comport}
    function  Connect (TryAll: Boolean = false):Boolean;
    {Resets the StarListFile}
    procedure DefaultList ();
    {Does what it say, progress messages until the time is over}
    procedure Delay(Milliseconds: DWORD);
    {Result is the DefaultValue of the given OptionName.
     Warning: every new Option have to be listed here!}
    function  GetDefaultOption (const OptnName: TOptionNames): String;
    {Load the Starlist by a given path}
    function  LoadStarList (const Path: String): Boolean;
    {Tell the forms, if ExpertMode was activated}
    procedure ProgressExpertMode (Save: Boolean = true);
    {Sets the pathes to ProtableMode and back}
    procedure SetPortableMode(IsActive: Boolean);
    {Update the App; work in progress}
    procedure Update_ ();

  end;

var
  Frm_Main: TFrm_Main;
  ARMConnection: TArmConnect;

implementation

{$R *.lfm}

  {TARMConnect}

Constructor TArmConnect.Create (const CreateSuspended : boolean); //Done?
  begin
    inherited Create (CreateSuspended); // because this is black box in OOP and can reset inherited to the opposite again...
    FreeOnTerminate := False;

    //New serial handel
    ser := TBlockSerial.Create;

    //Setup intern used variables
    FReceiveAzimuth   := 0;
    FReceiveElevation := 0;
    Port := '';
    BaudRate := 9600;
    SendAzimuth := -404;
    SendElevation := -404;

    //Set Up timer (with no owner)
    Loop := TTimer.Create(nil);
    Loop.Interval := 500;  //The ArduIno sends itself with a rate of 500 ms. (Defaultly)
    Loop.enabled  := false;
    Loop.OnTimer  := @OnLoopTimer;

    //Setup conncetion status
    FConnectionStatus := true;
    NewConnect := false;
    Reconnect  := false;
  end;

Destructor TArmConnect.Destroy (); //Done?
  begin
    //Stop Timer if not already done and free it
    Loop.Enabled := false;
    FreeAndNil(Loop);

    if Assigned(ser) then
      begin
        //If the buffer was not emty
        if (ser.WaitingData > 0) or (ser.CanRead(0)) then

        //close conncetion and free memory (importend, without you can't connect again, until next restart)
        ser.CloseSocket;
        ser.Free;
      end;

    inherited Destroy ();
  end;

procedure TArmConnect.Connect (); //ToDo: Detect Arduinotype (and if it is the SpOri)
  begin
    //Close Connection if there is one
    if (ser.InstanceActive and (not Terminated)) then
         ser.CloseSocket;

    //Try to connect
    if (not Terminated) then
      begin
        ser.Connect(Port);
        Frm_Main.Delay(700);
      end;

    if ser.InstanceActive then
      begin
        //configure
        ser.config(BaudRate, 8, 'N', SB1, False, False); //Is this nessesaryfor ervery connection?
        Frm_Main.Delay(500);
      end
    else //Didn't worked
      ser.CloseSocket;

    NewConnect := false;
  end;

procedure TArmConnect.ShowReceivedData (); //Done
  var
    EleStr, AziStr: String;
  begin
    //Get norm strings
    AziStr := FloatToStrF(FReceiveAzimuth, ffFixed, 3, 2);
    EleStr := FloatToStrF(FReceiveElevation, ffFixed, 3, 2);

      with Frm_Main do
        begin
          //Shows the new Data on new MainFrom too
          Lbl_AziNow_Val.Caption := AziStr;
          Lbl_EleNow_Val.Caption := EleStr;

          //Set the Position of the charts to the new value
          SetShapePos(ShpN_AziNow, FReceiveAzimuth);
          SetShapePos(ShpN_EleNow, FReceiveElevation);
        end;
  end;

function TArmConnect.ReceiveData (): Boolean; //Done
  var
    StrIn, StrVal: String;
    BeginPos, Endpos: Byte;
  begin
    //Clear buffer if too much in going Data is waiting
    //That are old values and wie don't need them.
    if (ser.WaitingDataEx > 5) then
      begin
        ser.Purge;
        Frm_Main.Delay(5);
      end;

    //If the Buffer was not emty in the next 100 milli secounds
    if ser.CanRead(100) then
      begin
        //Get new Data
        StrIn := ser.Recvstring (20);

        //Make sure we can find the given floats
        if ('.' <> DefaultFormatSettings.DecimalSeparator) then
           StrIn := StringReplace (StrIn, '.', DefaultFormatSettings.DecimalSeparator, [rfReplaceAll]);

        //Message from ArduIno: >>ElevationNow;AzimuthNow;<<
        //Get Elevation (Altitude)
        Endpos := Pos(';', StrIn);
        StrVal := Copy(StrIn, 1, pred(Endpos));
        Result := TryStrToFloat(StrVal, FReceiveElevation);

        //Get Azimuth
        BeginPos := succ(Endpos);
        Endpos   := PosEx(';', StrIn, BeginPos);
        StrVal   := Copy(StrIn, BeginPos, Endpos-BeginPos);

        //Result is only true, if we got both: elevation and azimuth
        //So we will know if we got valid data
        Result := Result and TryStrToFloat(StrVal, FReceiveAzimuth);
      end
    else
      Result := false;
  end;

procedure TArmConnect.SendData (); //Point
  var
    PointAsSep: TFormatSettings;
    EleStr, AzStr: String;
  begin
    if (SendAzimuth <> -404) and (SendElevation <> -404) then
      begin
        //Clear buffer if too much out going Data is waiting
        //That are old values and wie don't need them.
        if (ser.SendingData > 5) then
          begin
            ser.Purge;
            Frm_Main.Delay(5);
          end;


        //Make sure a point was used as decimal separator
        PointAsSep := DefaultFormatSettings;
        PointAsSep.DecimalSeparator := '.';

        //Get values to navigate to
        EleStr := FloatToStrF(SendElevation, ffFixed, 3, 5, PointAsSep);
        AzStr  := FloatToStrF(SendAzimuth,   ffFixed, 3, 5, PointAsSep);

        //If a Connection is active and stable, send elevation and azimuth to the ArduIno.
        if IsConnected and ser.CanWrite(200) then
          ser.SendString(EleStr + ';' + AzStr);

        //signalize that we sended it
        SendElevation := -404;
        SendAzimuth   := -404;
      end;
  end;

procedure TArmConnect.OnLoopTimer (Sender: TObject); //Done
  begin
    if (not Terminated) then
      begin
        if (NewConnect or (Reconnect and not IsConnected)) then
          Connect ();

        //Get Connection status
        FConnectionStatus := ser.InstanceActive;

        if IsConnected and (not Terminated) then
          begin
            //Send Azimuth and Elevation to the ARM (ArduIno)
            SendData ();

            //If we got vailid input
            if ReceiveData () and (not Terminated) then
              //Give the new Data to the main thread
              Synchronize(@ShowReceivedData);
          end;
      end;
  end;

procedure TArmConnect.Execute; //Done?
  begin
    //Start Timer
    Loop.Enabled := true;
  end;


{ TFrm_Main }

procedure TFrm_Main.Angle (); //ToDo: Comments; just calc this if changed; integrate in timer / Sub function
  begin
    with Frm_Config do
      begin
        Lbl_Long_ValRad.Caption := FloatToStrF(FlSpEd_Lon.Value * Pi /180, ffFixed, 3, 4);

        Lbl_Lat_ValRad.Caption  := FloatToStrF(FlSpEd_Lat.Value * Pi /180, ffFixed, 3, 4);
      end;
  end;

function  TFrm_Main.Connect (TryAll: Boolean = false): Boolean; //ToDo: Waiting for a thread should be changed; Synapser doesn't find the right ports
  var
    Port: String;
    Baud: Integer;
  begin
    //to make sure everything was loaded
    if OptionsLoaded then
      begin
        //Tell the User, we are trying to connect
        with Frm_Config do
          begin
            ImgLst_UsedPics.GetBitmap(1, Img_Conf_ComState.Picture.Bitmap);
            Lbl_ComMsg.Caption  := MLS_Connecting;

            PgsB_ComCon.Visible := true;
            Lbl_Ardo.Visible    := false;
            Img_UpStatus.AnchorSideTop.Control := PrgrssBr_ComPCon;
          end;

        ImgLst_UsedPics.GetBitmap(1, Img_ComState.Picture.Bitmap);
        Lbl_ComState.Caption := MLS_Connecting;

        PrgrssBr_ComPCon.Visible := true;
        Lbl_ArdoType.Visible     := false;

        //give the forms time to update
        Application.ProcessMessages;

        if not TryStrToInt(Frm_Config.CmbBx_Baud.Caption, Baud) then
          Baud := 9600; //DefaultValue, should work, if there was no change at the Arduino

        ARMConnection.BaudRate := Baud;

        //Try to connect to all found ports
        if TryAll then
          begin
            for Port in Frm_Config.CmbBx_ComPort.Items do
              begin
                //SetUp Port
                ARMConnection.Port := Port;

                //Try to connect
                with ARMConnection do
                  begin
                    NewConnect := true;

                    //Wait for conncetion status
                    While NewConnect do
                      Application.ProcessMessages;
                  end;
              end;
          end
        else
          begin
            //Connect to configured port
            with ARMConnection do
              begin
                Port := Frm_Config.CmbBx_ComPort.Caption;

                //Wait for conncetion status
                While NewConnect do
                  Application.ProcessMessages;
              end;
          end;

        //Set Result to the connections state
        Result := ARMConnection.IsConnected;

        with Frm_Config do
          begin
            if Result then
              begin
                //Tell the user we are connected
                ImgLst_UsedPics.GetBitmap(0, Img_Conf_ComState.Picture.Bitmap);
                Lbl_ComMsg.Caption  := MLS_ConnectedWith;
                Lbl_Ardo.Caption    := 'Arduino Leonardo'; //Defaultvalue
              end
            else  //Tell the user we are not connected
              begin
                ImgLst_UsedPics.GetBitmap(2, Img_Conf_ComState.Picture.Bitmap);
                Lbl_ComMsg.Caption    := MLS_NotConnected;
              end;

            Lbl_Ardo.Visible    := Result;
            PgsB_ComCon.Visible := false;
          end;

        if Result then
          begin
            ImgLst_UsedPics.GetBitmap(0, Img_ComState.Picture.Bitmap);
            Lbl_ComState.Caption := MLS_ConnectedWith;
            Lbl_ArdoType.Caption := 'Arduino Leonardo'; //Defaultvalue

            Img_UpStatus.AnchorSideTop.Control := Lbl_ArdoType;
          end
        else
          begin
            ImgLst_UsedPics.GetBitmap(2, Img_ComState.Picture.Bitmap);
            Lbl_ComState.Caption   := MLS_NotConnected;

            Img_UpStatus.AnchorSideTop.Control := Img_ComState;
          end;

        Lbl_ArdoType.Visible     := Result;
        PrgrssBr_ComPCon.Visible := false;

        //give the forms time to update
        Application.ProcessMessages;
      end;
  end;

procedure TFrm_Main.DefaultOptions (); //ToDo: put this into it's own File; Multi langue header
  var
    Option: TOptionNames;

    TempName: String;
    SaveStrings:TStringList;
  begin
      SaveStrings := TStringList.create;

      // Add a header with information
      SaveStrings.Add('#*-+-~-+-\*/-+-~-{ Spaceorienter Options }-~-+-\*/-+-~-~+-*');
      SaveStrings.Add('#|Please change only, if you know what you are doing!     |');
      SaveStrings.Add('#|                                                        |');
      SaveStrings.Add('#|Timeformat: DD.MM.YYYY or SS:NN:HH                      |');
      SaveStrings.Add('#|                                                        |');
      SaveStrings.Add('#|Note: If you make changes to this file while the        |');
      SaveStrings.Add('#|application is running, the changes will be overwritten |');
      SaveStrings.Add('#|when the application exits.                             |');
      SaveStrings.Add('#*--------------------------------------------------------*');
      SaveStrings.Add('#');

      //find and add default Options
      for Option := low(TOptionNames) to High(TOptionNames) do
        begin
          TempName := GetEnumName(TypeInfo(TOptionNames), Ord(Option));
          TempName := Copy(TempName, 4, length(TempName) - 3);

          SaveStrings.Add('"'+TempName+'": "'+GetDefaultOption(Option)+'"');
        end;

    try  //Save them
      if FileExists (DefaultOptionsPath)  then    //if a file already exits move it
        begin
          ForceDirectories (DefaultOldOptionsPath);
          RenameFile (DefaultOptionsPath, DefaultOldOptionsPath + PathDelim + 'Options'+formatdatetime('d.m.y-h;n;s;z', Now)+'.old');
        end
      else
        ForceDirectories (DefaultPath);

      SaveStrings.SaveToFile (DefaultOptionsPath);
    finally
      FreeAndNil(SaveStrings);
    end;
  end;

procedure TFrm_Main.DefaultList ();  //ToDo: put this into it's own File (english version) --> make versions for different langues
  var
     List:TStringList;
  begin

    List := TstringList.create;

    try  //Add given default stars

      List.Add('#*------------------{SpaceOrienter SternenListe}---------------------*');
      List.Add('#|                                                                   |');
      List.Add('#|Bitte schaue in die Anweisungen, um HimmelsKoerper hinzuzufuegen.  |');
      List.Add('#|Aufbau:                                                            |');
      List.Add('#|Nummer;Name;Latain;Sternbild;Eigenschaft;DekliG;DekliR;ReziG;ReziR;|');
      List.Add('#*-------------------------------------------------------------------*');
      List.Add('#');
      List.Add('0;Ruheposition;-;-;Keine;-;-;-;-;-;');
      List.Add('1;Fruehlingspunkt;-;-;Keine;0;0;0;0;');
      List.Add('2;Sirrah;Alpheratz;Pegasus;Keine;357;41,3;29;10,9;');
      List.Add('3;Algenib;Algenib;Pegasus;Keine;356;28,7;15;16,5;');
      List.Add('4;Alpha Phoenicis;;-;unsichtbar;353;13,8;-42;-13,0;');
      List.Add('5;Schedir;Schedir;Kassiopeia;Keine;349;38,1;56;37,6;');
      List.Add('6;Daneb Kaitos;;Walfisch;Keine;348;53,9;-17;-53,8;');
      List.Add('7;Tsi;Cih;Kassiopeia;Keine;345;34,1;60;48,3;');
      List.Add('8;Mirach;Mirach;Andromeda;Keine;342;20,1;35;42,4;');
      List.Add('9;Achernar;Achernar;-;unsichtbar;335;25,4;-57;-9,3;');
      List.Add('10;Polarstern;Polaris;Kleiner Wagen;Keine;316;48,7;89;19,9;');
      List.Add('11;Alamak;;Andromeda;Keine;328;46,2;42;24,4;');
      List.Add('12;Hamal;Hamal;Widder;Tierkreis;327;58,4;23;32,3;');
      List.Add('13;Menkar;Menkar;Walfisch;Keine;314;12,9;4;9,1;');
      List.Add('14;Algol;Algol;Perseus;Keine;312;41,3;41;1,0;');
      List.Add('15;Marfik;Mirfak;Herkules;Keine;308;37,4;49;55,0;');
      List.Add('16;Alkione;Alcyone;Stier;Tierkreis;302;53,0;24;9,2;');
      List.Add('17;Aldebaran;Aldebaran;Stier;Tierkreis;290;47,0;16;32,3;');
      List.Add('18;Rigel;Rigel;Orion;Keine;281;10,1;-8;-11,2;');
      List.Add('19;Capella;Capella;Fuhrmann;Keine;280;31,4;46;0,6;');
      List.Add('20;Bellatrix;Bellatrix;Orion;Keine;278;29,8;6;21,7;');
      List.Add('21;Elnath;Nath;Stier;Tierkreis;278;10,0;28;37,0;');
      List.Add('22;Alnilam;Alnilam;Orion;Keine;275;44,3;-1;-11,7;');
      List.Add('23;Alnitak;Zeta Orionis;Orion;Keine;274;36,2;-1;-56,3;');
      List.Add('24;Saiph;Saiph;Orion;Keine;272;52,0;9;40,0;');
      List.Add('25;Beteigeuze;Beteigeuze;Orion;Keine;270;59,1;7;24,4;');
      List.Add('26;Menkalinan;Menkalinan;Fuhrmann;Keine;269;49,0;44;56,7;');
      List.Add('27;Murzim;Mirzam;Grosser Hund;Keine;264;8,7;-17;-58,1;');
      List.Add('28;Canopus;Canopus;-;unsichtbar;263;55,2;52;42,5;');
      List.Add('29;Alena;Alphena;Zwillinge;Tierkreis;260;20,1;16;22,9;');
      List.Add('30;Sirius;Sirius;Grosser Hund;Keine;258;31,9;-16;-44,5;');
      List.Add('31;Adhara;Adora;Grosser Hund;Keine;255;10,9;-28;-59,9;');
      List.Add('32;Wezen;Vezen;Grosser Hund;Keine;252;44,1;-26;-25,4;');
      List.Add('33;Castor;Castor;Zwillinge;Tierkreis;246;5,4;31;50,9;');
      List.Add('34;Prokyon;Procyon;Kleiner Hund;Keine;244;57,6;5;10,8;');
      List.Add('35;Pollux;Pollux;Zwillinge;Tierkreis;243;25,3;27;59,0;');
      List.Add('36;Epsilon Carinae;Epsilon Carinae;-;unsichtbar;234;17,1;-59;-33,9;');
      List.Add('37;Lambda Velorum;Alsuhail;-;unsichtbar;222;50,9;-43;-30,1;');
      List.Add('38;Miaplacidus;Miaplacidus;-;unsichtbar;221;39,1;-69;-47,2;');
      List.Add('39;Alphard;Alphard;Wasserschlange;Keine;217;54,1;-8;-43,9;');
      List.Add('40;Regulus;Regulus;Loewe;Tierkreis;207;41,4;11;53,1;');
      List.Add('41;;Nue Carinae;-;unsichtbar;199;6,5;-64;-28,9;');
      List.Add('42;Dubhe;Dubhe;Grosser Wagen;Keine;193;49,3;61;39,7;');
      List.Add('43;Denebola;Denebola;Loewe;Tierkreis;182;31,6;14;28,8;');
      List.Add('44;Acrux;Acrux;-;unsichtbar;173;6,8;-63;-11,4;');
      List.Add('45;Gamma Crucis;Gamma Crucis;-;unsichtbar;171;58,5;-57;-12,3;');
      List.Add('46;Beta Crucis;Beta Crucis;-;unsichtbar;167;49,4;-59;-46,7;');
      List.Add('47;Alioth;Alioth;Grosser Wagen;Keine;166;19,0;55;52,3;');
      List.Add('48;Vindemiatrix;Vindemiatrix;Jungfrau;Tierkreis;164;15,1;10;52,3;');
      List.Add('49;Mizar;Mizar;Grosser Wagen;Keine;158;51,4;54;50,5;');
      List.Add('50;Spica;Spica;Jungfrau;Tierkreis;158;29,1;-11;-14,7; ');
      List.Add('51;Benetnash;Benetnasch;Grosser Wagen;Keine;152;57,4;49;14,0;');
      List.Add('52;Agena;Agena;-;unsichtbar;148;44,8;-60;-27,0;');
      List.Add('53;Nu Centauri;Nue Centauri;-;unsichtbar;148;5,1;-36;-26,9;');
      List.Add('54;Arktur;Arcturus;Baerenhueter;Keine;145;53,9;19;5,9;');
      List.Add('55;Toliman;Toliman;-;unsichtbar;139;48,8;-60;-54,0;');
      List.Add('56;Izar;Epsilon Bootis;Baerenhueter;Keine;138;34,5;27;0,5;');
      List.Add('57;Zuben-el-tschenubi;Zubeneigenubi;Waage;Tierkreis;137;3,1;-16;-6,4;');
      List.Add('58;Kochab;Kochab;Kleiner Wagen;Keine;137;20,3;74;5,4;');
      List.Add('59;Zuben-el-schemali;Zubeneschemali;Waage;Tierkreis;130;31,6;-9;-26,4;');
      List.Add('60;Gemma;Alphecca;Noerdliche Krone;Keine;126;9,3;26;39,7;');
      List.Add('61;Unukalhai;Unuk;Schlange;Keine;123;43,8;6;22,6;');
      List.Add('62;Antares;Antares;Skorpion;Tierkreis;112;23,7;-26;-27,9;');
      List.Add('63;Atria;Atria;-;unsichtbar;107;23,7;-69;-3,2;');
      List.Add('64;Eta Scorpii;Eta Scorpii;-;unsichtbar;107;11,6;-34;-19,1;');
      List.Add('65;Shaula;Shaula;Skorpion;Tierkreis;96;19,1;-37;-6,7;');
      List.Add('66;Ras Alhague;Ras Alhagus;Schlangentraeger;Keine;96;4,5;12;33,1;');
      List.Add('67;Jabbha;Nue Scorpii;Skorpion;Tierkreis;95;22,5;-43;-0,3;');
      List.Add('68;Eltanin;Eltanin;Drache;Keine;90;45,2;51;29,4;');
      List.Add('69;Kaus Australis;Kau Australis;Schuetze;Tierkreis;83;41,1;-34;-22,4;');
      List.Add('70;Wega;Wega;Leier;Keine;80;37,6;38;48,1;');
      List.Add('71;Nunki;Nunki;Schuetze;Tierkreis;75;55,8;-26;-16,4;');
      List.Add('72;Atair;Atair;Adler;Keine;62;6,2;8;54,9;');
      List.Add('73;Peacock;Peacock;-;unsichtbar;53;16,1;-56;-40,7;');
      List.Add('74;Deneb;Deneb;Schwan;Keine;49;30,0;45;20,5;');
      List.Add('75;Alderamin;Alderamin;Kepheus;Keine;40;15,2;62;39,4;');
      List.Add('76;Enif;Enif;Pegasus;Keine;33;45,1;9;57,1;');
      List.Add('77;Al Nair;Al Nair;-;unsichtbar;27;41,2;-46;-52,8;');
      List.Add('78;Beta Gruis;Beta Gruis;-;unsichtbar;19;5,5;-46;-47,9;');
      List.Add('79;Fomalhaut;Fomalhaut;Suedlicher Fisch;Keine;15;21,8;-29;-32,1;');
      List.Add('80;Scheat;Scheat;Pegasus;Keine;13;51,4;28;10,4;');
      List.Add('81;Markab;Markab;Pegasus;Keine;13;36,3;15;17,7;');
      List.Add('82;Altarf;Altarf;Krebs;Tierkreis;235;52,5;9;11,1;');
      List.Add('83;Daneb Algedi;Daneb Algedi;Steinbock;Tierkreis;326;45,8;-16;-7,6;');
      List.Add('84;Sadalsuud;Sadalsuud;Wassermann;Tierkreis;322;53,5;-5;-34,3;');
      List.Add('85;Eta Piscium;Eta Piscium;Fische;Tierkreis;22;52,3;15;20,8;');
      List.Add('86;Achird;Achird;Kassiopeia;Dollystern;347;45,0;57;49,0;*');
      List.Add('87;Merkur;Mercurius;-;Ephemeride;-;-;-;-;');
      List.Add('88;Venus;Venus;-;Ephemeride;-;-;-;-;');
      List.Add('89;Erde;Terra;-;Ephemeride;-;-;-;-;');
      List.Add('90;Mars;Mars;-;Ephemeride;-;-;-;-;'); //macht mobiel
      List.Add('91;Jupiter;Jupiter;-;Ephemeride;-;-;-;-;');
      List.Add('92;Saturn;Saturnus;-;Ephemeride;-;-;-;-;');
      List.Add('93;Uranus;Uranus;-;Ephemeride;-;-;-;-;');
      List.Add('94;Neptun;Neptunus;-;Ephemeride;-;-;-;-;');
      List.Add('95;Pluto;Pluto;-;Ephemeride;-;-;-;-;');
      List.Add('96;Mond;Luna;-;Ephemeride;-;-;-;-;');
      List.Add('97;Sonne;Sol;-;Ephemeride;-;-;-;-;');


      if FileExists(DefaultListPath) then  //remove old ones
        begin
          ForceDirectories (DefaultOldListPath);
          RenameFile (DefaultListPath, DefaultOldListPath + PathDelim + 'StarList'+formatdatetime('d.m.y-h;n;s;z',Now)+'.old');
        end
      else
        ForceDirectories (DefaultPath);

      List.SaveToFile (DefaultListPath); // and save them

    finally
      List.Free;
     end;
   end;

procedure TFrm_Main.Delay (Milliseconds: DWORD); //Done
  var
    Yet: QWord;
  begin
    //Get time
    Yet := GetTickCount64;

    //while not Milliseconds passed do erverything else
    while (GetTickCount64 < Yet + Milliseconds) and (not Application.Terminated) do//wait until Milliseconds is over
      Application.ProcessMessages; //do erverything else

   end;

function  TFrm_Main.FindOptionName (const Line: String): String; //Done
  var
    FirstIndx, Length: Integer;
  begin
    FirstIndx := succ(Pos('"', Line));
    Length    := PosEx('"', Line, FirstIndx) - FirstIndx;

    if (Length > 0) then
      Result := Trim(AnsiLowerCase(copy(Line, FirstIndx, Length)))
    else
      Result := '';
   end;

function  TFrm_Main.FindOptionValue (const Line:String):String; //ToDo: Versioncheck
  var
     FirstIndx, Length: Integer;
  begin
    //Find the 3rd "
    FirstIndx    := succ(Pos('"',Line));
    FirstIndx    := succ(PosEx('"', Line, FirstIndx));
    FirstIndx    := succ(PosEx('"', Line, FirstIndx));

    length    := PosEx('"', Line, FirstIndx) - FirstIndx;

    if (length > 0) then
      Result    := Trim(AnsiLowerCase(copy(Line, FirstIndx, length)))
    else
      Result := '';
   end;

procedure TFrm_Main.GetComPorts (); //ToDo: look Up how Arduino IDE gets the ports
  var
    Ports: TStrings;
    i : integer;
  begin
    //initialize
    Ports := TStringList.create;
    Ports.Clear;
    Ports.Delimiter       := ',';
    Ports.StrictDelimiter := True; // Requires D2006 or newer

    Ports.DelimitedText   := GetSerialPortNames();

    {$IFDEF Unix} // Well, since GetSerialPortNames dosn't find it on my kubuntu I have to do it my own. I dont know, how it acts on other OS.
    if (Ports.count = 0) then
      for i := 0 to 10 do
        Ports.Add('/dev/ttyACM' + IntToStr(i));
    {$Else IfDef Windows} //Backfall if no ports where found
    if (Ports.count = 0) then
      for i := 0 to 10 do
        Ports.Add('COM' + IntToStr(i));
    {$ENDIF}

    // if ports where found, put then into the ComboBox list
    if (Ports.Count > 0) then
      with Frm_Config.CmbBx_ComPort.Items do
        begin
          BeginUpdate;
          try
             AddStrings(Ports, true);

          finally
            EndUpdate;
          end;
        end;

    Frm_Config.CmbBx_ComPort.ItemIndex := 0;

    FreeAndNil(Ports);
  end;

function  TFrm_Main.GetDefaultOption (const OptnName: TOptionNames): String; //Done?
  begin
    case OptnName of
      ON_Version:       Result := '0.0.0.2';
      ON_PortableMode:  Result := 'False';
      ON_ExpertMode:    Result := 'False';
      ON_UpdateMode:    Result := '0';
      ON_UpdateRate:    Result := '1';
      ON_UpdateDay:     Result := '6';
      ON_UpdateTime:    Result := '00:00:00';
      ON_UpRetry:       Result := 'True';
      ON_Place:         Result := 'Berlin';
      ON_Lon:           Result := '52,345';
      ON_Lat:           Result := '13,604';
      ON_AutoTimeMode:  Result := 'True';
      ON_Date:          Result := formatdatetime('dd/mm/yyyy', Now);
      ON_Time:          Result := formatdatetime('hh:nn:ss', Now);
      ON_AutoComMode:   Result := 'False';
      ON_ComPort:       Result := '0';
      ON_BaudRate:      Result := '9600';
      ON_AutoValueMode: Result := 'True';
      ON_UseHotkey:     Result := 'False';
      ON_HotKey:        Result :=  IntToStr(VK_Q);
      ON_BodyMode:      Result := '0';
      ON_Body:          Result := '0';
      ON_Langue:        Result := GetOSLanguage();
    else  //Hint: Forgotten to set a default?
     Result := '';
    end;
  end;

function  TFrm_Main.GetOptionIndex (const Str: String): ShortInt; //Done
  var
     OptionName: String;

     equality: Real = 0;
     Tempequality: Real;
     i: TOptionNames;
  begin
    Result := -1;

    for i := low(TOptionNames) to high(TOptionNames) do
      begin
        OptionName := GetEnumName(TypeInfo(TOptionNames), Ord(i));//Get the Name of an Option
        OptionName := copy(OptionName, 4, length(OptionName)-3); // Get rid ot "ON_" of every OptionName
        Tempequality := StrCompaire(Str, OptionName, false); //Compaire it caseinsensitive with Str

        if (equality < Tempequality) and  (Tempequality > 60) then //if the match was over 60% use the greater equality
          begin
            Result := Ord(i);

            //We got a 100% match, skip all the others
            if (Tempequality = 100) then
              exit;

            equality := Tempequality;
          end;
      end;
  end;

function  TFrm_Main.GetOSLanguage (): string; //Done
  var
    l, fbl: string;
    {$IFDEF LCLCarbon}
    theLocaleRef: CFLocaleRef;
    locale: CFStringRef;
    buffer: StringPtr;
    bufferSize: CFIndex;
    encoding: CFStringEncoding;
    success: boolean;
    {$ENDIF}
  begin
    {$IFDEF LCLCarbon}
    theLocaleRef := CFLocaleCopyCurrent;
    locale := CFLocaleGetIdentifier(theLocaleRef);
    encoding := 0;
    bufferSize := 256;
    buffer := new(StringPtr);

    success := CFStringGetPascalString(locale, buffer, bufferSize, encoding);
    if success then
      l := string(buffer^)
    else
      l := '';

    fbl := Copy(l, 1, 2);
    dispose(buffer);

    {$ELSE}
    //Removed Linux extra since GetLangueIDs does exacly the same
    GetLanguageIDs(l{%H-}, fbl{%H-});
    {$ENDIF}
    //Result := 'de';
    Result := fbl;
  end;

function  TFrm_Main.LoadOptions (const LoadFromFile: Boolean  = true): Boolean; //ToDo: Version; Chack if Langue was loaded; comma as dec; Comments; Errorhandeling if the Item doesnt exits; first Item doesn't have to be 0!
  var
    i: integer;
    Index: Shortint;
    NotGottenOptions: set of ToptionNames = [low(ToptionNames)..high(ToptionNames)];
    j: TOptionNames;

    TempStr, TempOption: String;
    TempInt: Integer;
    TempKey: Integer;
    TempBool: Boolean;
    TempTime: TDateTime;
    Temp_Koord: TCoord;
    TempFloat: Real;
    TempItem: TListItem;

    ErrorMessage: String = '';

    { ------------------------- }

     procedure LoadAndList ();
       var
          //just Because we can't use the orginal i
          i: integer;

          LoadList: Tstringlist;
       begin
         LoadList := Tstringlist.Create;

         if not FileExists (DefaultOptionsPath) then
           DefaultOptions();

           try
             LoadList.LoadFromFile(DefaultOptionsPath);

             for i := pred(LoadList.count) downto 0 do //Ignore commants and empty lines
               if (LoadList[i] = '') or (Trim(LoadList[i])[1] = '#') then
                 LoadList.Delete(i);

             for i := 0 to pred(LoadList.count) do
               begin
                 Index := GetOptionIndex(FindOptionName(LoadList[i])); //Find the Index of a possible Optionname

                 if (Index >= 0) then  // if no valid name was fond, -1 was returned
                   begin
                     Options[ToptionNames(Index)] := FindOptionValue(LoadList[i]);
                     Exclude(NotGottenOptions, ToptionNames(Index));  //we want to test, if every Option got min. one time a value.
                   end;
               end;

          finally
            FreeAndNil(LoadList);
          end;
       end;

     function RightPath (): Boolean; inline;
       begin
         //If a portable Optionsfile was found
        if (OwnDir = Defaultpath) then
          begin
            //If portablemode is not set to active or a unknown vlue was given
            //Set Portablemode fo false
            //Else use the already loaded Options
            if not TryStrToBool(Options[ON_PortableMode], Result) then
              Result := false;
          end
        else
          //No portablemode was found, just use the loaded Options
          Result := true;
    end;

     function MakeErrorMsg (const Where: TOptionNames; const Why: String): String; inline;
       begin

         Result :=  OptionsEnumToStr(Where) + '-' + MLS_Error_Loading + ': ' + Why;
       end;

     function ThrowError (const Name: TOptionNames; const LastResult: Boolean): Boolean;
       begin
        // Let the User decide if we retry, reset or abort
         case MessageDlg(MLS_Error_Caption, MLS_Error_MsgCaption + Slinebreak +
                         '  ' + MLS_Error_ErrorWhile  + ErrorMessage + ' (' + Options[Name] + ')' + slinebreak +
                         MLS_Error_AskResetThis + SlineBreak +
                         MLS_Error_NoIsReset,
                         mtError, mbYesNoCancel, 0, mbYes) of
           mrYes:
             begin
               Options[Name] := GetDefaultOption(Name);
               Result := LoadOptions(false);
             end;
           mrNo:
             begin
              DefaultOptions();

               Result := LastResult and LoadOptions(false);
             end;
           mrCancel:
             Result := false;
         end; //End case
       end; //End procedure

  begin
    //initialize
    Result      := true;

    if LoadFromFile then //switch, to not load from file, if one special Option was set to default (see below)
      LoadAndList ()
    else
      NotGottenOptions := []; // clear set, if we are not loading from file means that we already got ervything

    if RightPath() then
      begin
        //Test if we got everything
        if not (NotGottenOptions = []) then
          // Let the User decide if we set the option to default, reset all options or abort
          case MessageDlg(MLS_Error_Caption, MLS_Error_MsgCaption + Slinebreak +
                               MLS_Error_FoundNotAll + slinebreak +
                               MLS_Error_AskDefault + SlineBreak +
                               MLS_Error_NoIsReset,
                               mtError, mbYesNoCancel, 0, mbYes) of
            mrYes:   //set the missing Options to default
              begin
                for j in NotGottenOptions do
                  begin
                    Options[j] := GetDefaultOption(j);

                    Exclude(NotGottenOptions, j);
                  end;

                Result := LoadOptions(false);
              end;
            mrNo: //reset all Options
              begin
                DefaultOptions();

                Result := LoadOptions(false);
              end;
            mrCancel: //Chanels loading Options (who had ever thougt of this?)
              exit(false);
          end;

        try
          //Load On_Langue fist, sice it could mess all the other settings up
          if (length(Options[On_Langue]) = 2) then
            begin
              SetDefaultLang(Options[On_Langue]);
            end
          else
            begin
              Result := ThrowError (On_Langue, Result);
              exit;
            end;

          for j in TOptionNames do
            begin
              case j of
                ON_Version:;// ToDo: Convert older Otions to new ones

                ON_PortableMode:
                  if TryStrToBool(Options[j], Tempbool) then
                    begin
                      Frm_Config.Sw_PortableMode.Checked := Tempbool;
                      SetPortableMode(Tempbool);
                    end
                  else
                    ErrorMessage := MakeErrorMsg (j, MLS_Error_WrongType);

                ON_ExpertMode:
                  if TryStrToBool(Options[j], Tempbool) then
                    begin
                      Frm_Config.Sw_Exprt.Checked := Tempbool;

                      ProgressExpertMode(Tempbool);
                    end
                  else
                    ErrorMessage := MakeErrorMsg (j, MLS_Error_WrongType);

                ON_UpdateMode:
                  if TryStrToInt (Options[j], TempInt) then
                    begin
                      Case TempInt of
                        0:
                          begin
                            Frm_Config.AllUpOff ();
                            Frm_Config.Img_Auto.Picture    := Frm_Config.Img_On.Picture;
                            Update_ ();
                          end;
                        1:
                          begin
                            Frm_Config.AllUpOff ();
                            Frm_Config.Img_Msg.Picture     := Frm_Config.Img_On.Picture;
                          end;
                        2:
                          begin
                            Frm_Config.AllUpOff ();
                            Frm_Config.Img_tm.Picture      := Frm_Config.Img_On.Picture;

                            Frm_Config.Te_plan.Time        := Time;

                            Frm_Config.Lbl_Plan.Enabled    := true;
                            Frm_Config.Lbl_am_Plan.Enabled := true;
                            Frm_Config.Lbl_um_Plan.Enabled := true;
                            Frm_Config.CBx_Rate.Enabled    := true;
                            Frm_Config.CBx_Tag.Enabled     := true;
                            Frm_Config.Sw_Redo.Enabled     := true;
                            Frm_Config.Lbl_Redo.Enabled    := true;
                            Frm_Config.Lbl_Sw_Redo.Enabled := true;
                            Frm_Config.TE_Plan.Enabled     := true;
                          end;
                        3:
                          begin
                            Frm_Config.AllUpOff ();
                            Frm_Config.Img_Non.Picture     := Frm_Config.Img_On.Picture;
                          end;
                        else
                          ErrorMessage := MakeErrorMsg (j, MLS_Error_OutOFRange);
                      end;
                    end
                  else
                    ErrorMessage := MakeErrorMsg (j, MLS_Error_WrongType);

                ON_UpdateRate:
                  if TryStrToInt (Options[j], TempInt) then
                    if (TempInt in [0..2]) then
                      Frm_Config.CBx_Rate.ItemIndex := TempInt
                    else
                      ErrorMessage := MakeErrorMsg (j, MLS_Error_OutOFRange)
                  else
                    ErrorMessage := MakeErrorMsg (j, MLS_Error_WrongType);

                ON_UpdateDay:
                  if TryStrToInt (Options[j], i) then
                    if (TempInt in [0..6]) then
                      Frm_Config.CBx_Tag.ItemIndex := TempInt
                    else
                      ErrorMessage := MakeErrorMsg (j, MLS_Error_OutOFRange)
                  else
                    ErrorMessage := MakeErrorMsg (j, MLS_Error_WrongType);

                ON_UpdateTime:
                  if TryStrToTime(Options[j], TempTime) then
                    Frm_Config.TE_Plan.Time := TempTime
                   else
                    ErrorMessage := MakeErrorMsg (j, MLS_Error_WrongType);

                ON_UpRetry:
                  if TryStrToBool(Options[j], TempBool)then
                   Frm_Config.Sw_Redo.Checked := TempBool
                  else
                    ErrorMessage := MakeErrorMsg (j, MLS_Error_WrongType);

                On_Place:
                  begin
                    if (Options[j] = AnsiLowerCase(MLS_None)) then
                      begin
                        //Inc(j);
                        if TryStrToFloat(Options[ON_Lon], TempFloat) then
                          begin
                            Frm_Config.FlSpEd_Lon.Value := TempFloat;

                            Lbl_Long_ValDeg.Caption := FloatToStrF(TempFloat, ffFixed, 3, 4);
                          end
                        else
                          ErrorMessage := MakeErrorMsg (ON_Lon, MLS_Error_WrongType);

                        //Inc(j);
                        if TryStrToFloat(Options[ON_Lat], TempFloat) then
                           begin
                             Frm_Config.FlSpEd_Lat.Value := TempFloat;

                             Lbl_Lat_ValDeg.Caption := FloatToStrF(TempFloat, ffFixed, 3, 4);
                           end
                        else
                          ErrorMessage := MakeErrorMsg (ON_Lat, MLS_Error_WrongType);

                        Frm_Config.CbBx_Ort.Caption := MLS_Unknown;
                        Lbl_Place_Name.Caption := '-';
                      end
                    else
                      begin
                        //If it is an invailed location an Error is reaised here (may change in future)
                        Temp_Koord                  := Frm_Config.Koordinaten (Options[j]);

                        Frm_Config.FlSpEd_Lon.Value := Temp_Koord.Lon;
                        Frm_Config.FlSpEd_Lat.Value := Temp_Koord.Lat;

                        Lbl_Long_ValDeg.Caption := FloatToStrF(Temp_Koord.Lon, ffFixed, 3, 4);
                        Lbl_Lat_ValDeg.Caption := FloatToStrF(Temp_Koord.Lat, ffFixed, 3, 4);

                        Frm_Config.CbBx_Ort.Caption := Options[j];

                        //Make the first letter UpperCase
                        TempStr := AnsiUpperCase(String(Options[j][1])) +
                          Copy(Options[j], 2, pred(Length(Options[j])));
                        Lbl_Place_Name.Caption := TempStr;
                        //Inc(j);
                        //Inc(j);
                      end;

                    Angle ();
                  end;

                ON_AutoTimeMode:
                 if TryStrToBool(Options[j], Tempbool) then
                  begin
                    Frm_Config.Sw_AutoTime.checked := Tempbool;
                    Frm_Config.TE_Time.enabled     := not Tempbool;
                    Frm_Config.DE_Day.enabled      := not Tempbool;
                  end
                else
                  ErrorMessage := MakeErrorMsg (j, MLS_Error_WrongType);

                ON_Date:
                  if TryStrToDate(Options[j], TempTime) then
                    begin
                      DiffD                  := TempTime - Date;
                      Frm_Config.DE_Day.Date := Date + DiffD;
                    end
                  else
                    ErrorMessage := MakeErrorMsg (j, MLS_Error_WrongType);

                  ON_Time:
                    if TryStrToTime(Options[j], TempTime) then
                      begin
                        DiffT                   := TempTime - Time;
                        Frm_Config.TE_Time.Time := Time + DiffT
                       end
                     else
                      ErrorMessage := MakeErrorMsg (j, MLS_Error_WrongType);

                  ON_AutoComMode:
                    if TryStrToBool(Options[j], Tempbool) then
                      begin
                        Frm_Config.Sw_AutoCon.checked :=  Tempbool;

                        //If we should automatily reconnect
                        ARMConnection.Reconnect := Tempbool;

                        if not Tempbool then      //[length(Options[ON_ComPort]) -1]
                          if TryStrToInt(Options[ON_ComPort] , i) then
                            Frm_Config.CmbBx_ComPort.Caption := Options[ON_ComPort]
                          else
                            ErrorMessage := MakeErrorMsg (ON_ComPort, MLS_Error_WrongType);
                        //Inc(j);
                      end
                    else
                      ErrorMessage := MakeErrorMsg (ON_ComPort, MLS_Error_WrongType);

                  ON_BaudRate:
                    if TryStrToInt(Options[j], TempInt) then
                      if (Frm_Config.CmbBx_Baud.Items.IndexOf(Options[j]) >= 0) then
                          Frm_Config.CmbBx_Baud.Caption := Options[j]
                      else
                        ErrorMessage := MakeErrorMsg (j, MLS_Error_OutOFRange)
                    else
                     ErrorMessage := MakeErrorMsg (j, MLS_Error_WrongType);

                  ON_AutoValueMode:
                    if TryStrToBool(Options[j], Tempbool) then
                      Frm_Config.Sw_ManuVal.Checked := not Tempbool
                    else
                     ErrorMessage := MakeErrorMsg (j, MLS_Error_WrongType);

                  ON_UseHotkey:
                    if TryStrToBool(Options[j], Tempbool) then
                      begin
                        with Frm_Config do begin
                          Sw_HtKy.Checked := Tempbool;
                          Ed_HtKy.Enabled := TempBool;
                          Bt_HtKy.Enabled := TempBool;

                          Lbl_Sw_HtKy.Caption := BoolToStr(Tempbool, MLS_Turnd_On, MLS_Turnd_Off);
                        end;
                      end
                    else
                     ErrorMessage := MakeErrorMsg (j, MLS_Error_WrongType);

                  ON_HotKey:
                    begin
                      if (length(Options[j]) > 0) then
                        begin
                          Frm_Config.Ed_HtKy.Text := '';
                          TempOption :=  Options[j];

                          repeat
                            i := Pos(',', TempOption);

                            if (i > 0) then
                              begin
                                TempStr := copy (TempOption, 1, pred(i));
                                TempStr := Trim(TempStr);

                                TempOption := TempOption.Remove(0, i);
                              end
                            else
                              TempStr := TempOption;

                            if TryStrToInt(TempStr, TempKey) then
                              begin
                                TempKey := abs(TempKey);
                                Include(HotKey, TempKey);

                                with Frm_Config do
                                  begin
                                    if (length(Ed_HtKy.Text) > 0) then
                                      begin
                                        TempStr := Ed_HtKy.Text + ' + ' + Frm_Config.KeyToStr(TempKey);
                                        Ed_HtKy.Text := TempStr;
                                      end
                                    else
                                      Ed_HtKy.Text := KeyToStr(TempKey);
                                  end;
                              end
                            else
                              begin
                                ErrorMessage := MakeErrorMsg (On_Hotkey, MLS_Error_OutOFRange);
                                break;
                              end;

                          until (i <= 0);
                        end
                      else
                        Frm_Config.Ed_HtKy.Text := MLS_None;
                    end;

                  ON_BodyMode:
                    if TryStrToInt(Options[j], i) then
                      if (i in [0..pred(CmbBx_Mode.Items.Count)]) then
                        begin
                          CmbBx_Mode.ItemIndex := i;

                          ProgressBodyMode(TBodyMode(i), false);
                        end
                      else
                        ErrorMessage := MakeErrorMsg (j, MLS_Error_OutOFRange)
                    else
                       ErrorMessage := MakeErrorMsg (j, MLS_Error_WrongType);

                  ON_Body:
                    if TryStrToInt (Options[j], i) then
                      Lbl_Bdy_Nr.Caption := Options[j]
                    else
                      ErrorMessage := MakeErrorMsg (j, MLS_Error_WrongType);
              end; //End case

              if (ErrorMessage <> '') then
                begin
                  Result := ThrowError (j, Result);
                  exit;
                end;
           end; //End for-loop

          if Result then
            begin
              Result := LoadStarList(DefaultListPath);

               TempItem := Search4Body (Options[ON_Body]);

              if Assigned(TempItem) then // if a valid Item was found tell it
                ProgressList (TempItem)
              else
                ; //Errorhandeling
            end;

        except   //Unkown Error
          on E: Exception do
            case MessageDlg(MLS_Error_Caption, MLS_Error_MsgCaption + Slinebreak +   // Let the User decide if we reset or abort
                            ' ' + E.Message + slinebreak +
                            MLS_Error_AskResetAll,
                            mtError, [mbYes, mbCancel], 0, mbYes) of
              mrYes:
                begin
                  DefaultOptions();
                  Result := LoadOptions ();
                end;
              mrCancel:
                Result := false;
            end;
        end;
      end
    else  //RightPath returned false, turn portable mode off and retry
      begin
        SetPortableMode(false);
        Result := LoadOptions();
      end;

  end;

function  TFrm_Main.LoadStarList (const Path: String): Boolean; //ToDo: ErrorCheck; optimize, it takes way to long
  var
     index, Beginpos, Index_L, Index_R, Counter, lengthList: Integer;
     Stars:  TStringlist;
     Item:   TListItem;
     Sortet: Boolean;
     TempProperty:  String;
     BtChoosen: integer = 0;

     {If there is no command or emty line and the left Number is bigger swap then.
     Has Errorhandeling if there is somthing fishy}
     function Exchange (Left, Right:Integer): boolean; // if there is an Error, we could delete the line or Reset the starlist
       var
          TempStrLeft, TempStrRight: String;
          ValLeft, ValRight: Integer;
       begin
         Result := true;

         TempStrLeft := Trim(copy(Stars[Left],  0, Pos(';', Stars[Left])  -1 ));
    	 TempStrRight := Trim(copy(Stars[Right], 0, Pos(';', Stars[Right]) -1 ));

    	 if TryStrToInt (TempStrLeft, ValLeft) and TryStrToInt (TempStrRight, ValRight) then
           begin
    	     if ValLeft > ValRight then
    	       begin
    		 TempStrLeft  := Stars[Left];
    		 Stars[Left]  := Stars[Right];
    		 Stars[Right] := TempStrLeft;
                 Sortet       := false;

                 exit (true); //Everthing is fine skip the errorchecking
             	end
              else  //Doubble definition?
               if (ValLeft = ValRight) then
                   BTChoosen := MessageDlg(MLS_Warning + Slinebreak +
                                           MLS_Warning_MultiLine + ' ' + TempStrLeft + ' ' + MLS_WasFound + slinebreak +
                                           MLS_Error_AskAbortLoad,
                                           mtWarning, mbAbortRetryIgnore, 0, mbIgnore);
            end
         else //Somthing dosent got turned into an integer, is it a comment?
           begin
             if not ((Trim(Stars[Left])[1] = '#') or (Trim(Stars[Left]) = '') or TryStrToInt (TempStrLeft, ValLeft)) then
                 BTChoosen := MessageDlg(MLS_Error_Caption, MLS_Error_MsgCaption + Slinebreak +
                                         MLS_Error_InvalidLine + ' ' + IntToStr(succ(Left)) + slinebreak +
                                         Stars[Left] + SlineBreak +
                                         MLS_Error_AskAbortLoad,
                                         mtError, mbAbortRetryIgnore, 0, mbCancel)
             else
               if not ((Trim(Stars[Right])[1] = '#') or (Trim(Stars[Right]) = '') or TryStrToInt (TempStrRight, ValRight))then
                 BTChoosen := MessageDlg(MLS_Error_Caption, MLS_Error_MsgCaption + Slinebreak +
                                         MLS_Error_InvalidLine + ' ' + IntToStr(succ(Right)) + slinebreak +
                                         Stars[Right] + SlineBreak +
                                         MLS_Error_AskAbortLoad,
                                         mtError, mbAbortRetryIgnore, 0, mbCancel)
               else
                 exit (true); // it's just a command or an empty line
            end;

          case BTChoosen of
            mrRetry:
              begin
                FreeAndNil(Stars);
                LoadStarList (Path);
                Result := false;
              end;
            mrAbort:
              begin
                FreeAndNil(Stars);
                Result := false;
              end;
            mrIgnore:
              Result := true;
          end;
        end;

  begin
    //initialize
    Result  := true;
    counter := 0;
    Stars   := TStringlist.create;

    if (Path = DefaultListPath) and not FileExists(DefaultListPath) then
      DefaultList ();

    LV_BodyList.BeginUpdate;
    try
      Stars.LoadFromFile(Path);
      lengthList  := pred(Stars.count);

      //Sort the Numbers, start with the smallest and go to the biggest
      //dont worry about the result of exchange, it will always be true, except somthing goes wrong
      repeat
        Index_R := lengthList - counter - 1;
        Index_L := counter + 1;
        Sortet  := true;

        if (counter <> lengthList - counter) then
           if not exchange (counter, lengthList - counter) then
             exit (false);

        while (Index_L < Index_R) do
          begin

            if not exchange(Index_L, lengthList-counter)then
              exit (false);
            if not exchange(counter, Index_R) then
              exit (false);
            if not exchange(Index_L, Index_R) then
              exit (false);

    	    Inc (Index_L);
            Dec (Index_R);
           end;
        Inc (counter);
      until Sortet;

      LV_BodyList.Clear;

      //Output of our sorted list into LV_BodyList
      for index:= 0 to lengthList do
        if not ((Trim(Stars[index])[1] = '#') or (Trim(Stars[index]) = '')) then //not a command nor an emty line
          begin
            Beginpos := Pos(';',Stars[index]);
            Item     := LV_BodyList.Items.Add;  //Here we give the pointer of a new item to our local item

            Item.caption := Trim(copy(Stars[index], 0, Beginpos-1)); //Number of the stars

            Inc(Beginpos);
            Index_R := Beginpos;

            for Counter := 1 to 8 do //Propertys of the stars
              begin
                Index_R      := PosEx(';', Stars[index], Index_R);
                Tempproperty := Trim(copy(Stars[index], Beginpos, Index_R - Beginpos));

                Inc(Index_R);
                Beginpos := Index_R;

                Item.SubItems.Add(Tempproperty);
              end;
          end;

      if (Path <> DefaultListPath) then  //Save it, if it doesnt come forme the defaultpath
            begin
              BTChoosen := 0;

              repeat
                try
                  if FileExists(DefaultListPath) then
                    begin
                      ForceDirectories (DefaultOldListPath);
                      RenameFile (DefaultListPath, DefaultOldListPath + PathDelim + ' StarList'+formatdatetime('d.m.y-h;n;s;z',Now)+'.old');
                    end;

                  Stars.SaveToFile(DefaultListPath);
                except
                  BTChoosen := MessageDlg(MLS_Error_Caption, MLS_Error_MsgCaption + Slinebreak +   // Let the User decide if we retry or not
                                          MLS_Error_StarWrite + slinebreak +
                                          MLS_AskRetry,
                                          mtError, mbAbortRetryIgnore, 0, mbRetry);
                end;
              until (BTChoosen <> mrRetry);
            end;

      case BTChoosen of
        mrIgnore: Result := true;
        mrAbort:  Result := false;
      end;

    except //UnnownError
      On E: Exception do
        Case MessageDlg(MLS_Error_Caption, MLS_Error_MsgCaption + Slinebreak +   // Let the User decide if we reset the Starlist or
                                            ' ' + E.Message + slinebreak +
                                            MLS_Error_AskResetStar,
                                            mtError, [mbOk, mbAbort], 0, mbOk) of
          mrOk:
            begin
              if FileExists(DefaultListPath) then
                begin
                  ForceDirectories (DefaultOldListPath);
                  RenameFile (DefaultListPath, DefaultOldListPath + PathDelim + ' StarList'+formatdatetime('d.m.y-h;n;s;z',Now)+'.old');
                end;
              Result := LoadStarList(DefaultListPath); //it will create a defaultfile by its own
            end;
          mrAbort:
            Result := false;
          mrRetry:
            Result := LoadStarList(Path);
        end;
    end;
    LV_BodyList.EndUpdate;

    if Assigned(Stars)then
        FreeAndNil(Stars);
  end;

function  TFrm_Main.OptionsEnumToStr(EnumVal: TOptionNames): String; //Done
  var
    Index: Byte;
  begin
    //Transform the Name to it's index inside of TOptionNames
    Index := Ord(EnumVal);

    //Now get the sing transformation of Index
    Result := GetEnumName(TypeInfo(TOptionNames), Index);

    //Get rid of "ON_" of ervery name
    Result := Copy(Result, 4, length(Result) -3);
  end;

procedure TFrm_Main.ProgressBodyMode (const Mode: TBodyMode; Save: Boolean = true); //ToDo: implement search; ErrorMessage

  begin
    if Save then  //if a new Mode was seleced save it
      Options[ON_BodyMode] := IntToStr(Ord(Mode));

    CmbBx_Mode.ItemIndex := Ord(Mode);

    //Old; Multi langue will not be supported (but somewhere this information will still be placed...)
    case Mode of
      BMd_Normal:
        begin
         //'Peilt den ausgewählten Himmelskörper / die ausgewählte Position an.';
          Tmr_Follow.Enabled := false;
         end;
      BMd_Follow:
        begin
          //'Peilt den ausgewählten Himmelskörper an und verfolgt diesen auf dem Himmel';
          Tmr_Follow.Enabled := true;
         end;
      BMd_Scan:
        begin
          //'Sobald ein Himmelsköper (manuell) angestuert wurde, wird er identifiziert.';
          Tmr_Follow.Enabled := false;
         end;
      BMd_Place:
        begin
          //'Gibt den eigenen Ort aus. '+#10+'Hierzu muss ein Himmelskörper angesteuert und richtig benannt werden.';
          Tmr_Follow.Enabled := false;
         end;
      BMd_Time:
        begin
          //'Gibt die aktuelle Zeit aus. '+#10+'Hierzu muss ein Himmelskörper angesteuert und richtig benannt werden.';
          Tmr_Follow.Enabled := false;
         end;
      BMd_Constellation:
        begin
          //'Fährt ein Sternbild nach und verfolgt dieses.';
          if ((Trim(Lbl_BdyPrpty_Val1.Caption) <> '-') and (Trim(Lbl_BdyPrpty_Val1.Caption) <> '')) then
             Tmr_Follow.Enabled := true
          else
            ProgressBodyMode(BMd_Normal, Save);
        end;
      BMd_Search:
        ProgressBodyMode(BMd_Normal, Save);
     else
      begin
        raise Exception.Create('Fehler in Change-Mode-Vorgang: Unbekannter Mode:' + IntToStr(Ord(Mode)));
        //'Error';
       end;
     end;
   end;

procedure TFrm_Main.ProgressExpertMode (Save:Boolean = True); //ToDo: sepperate expert options in config; comments; dynamic width
  var
    IsActive: Boolean;
  begin
    IsActive := Frm_Config.Sw_Exprt.Checked;

    if Save then
      Options[ON_ExpertMode] := BoolToStr(IsActive, 'True', 'False');

    with LV_BodyList do
      begin
        Column[5].Visible   := IsActive;
        Column[6].Visible   := IsActive;
        Column[7].Visible   := IsActive;
        Column[8].Visible   := IsActive;
      end;

    //TbS_Lag.TabVisible          := IsActive;
    //TbS_Ephi.TabVisible         := IsActive;

    if IsActive then
      LV_BodyList.Column[0].Caption := MLS_NumberShort
    else
      LV_BodyList.Column[0].Caption := MLS_NumberLong;
   end;

procedure TFrm_Main.ProgressList (const Item: TListItem); //ToDo: Test if the Item is vailed (mainpage); Commend what the subitems mean; Test for vailed Number
  var
     TestFloat: Float;
     i: Integer;
     CammaAsSep: TFormatSettings;

    {Ask the User if we shoud reset the StarList}
    function ProgressError (const Number, SubItem: String): boolean;
      begin
        Result := true;

        // Let the User decide if we reset the Starlist or
        case MessageDlg(MLS_Error_Caption, MLS_Error_MsgCaption + slinebreak +
                                      ' ' + MLS_Error_WrongType + ' ' + MLS_Error_AtSubItem + ' ' + Number + ' (' + SubItem + ') ' + MLS_WasFound + slinebreak +
                                      MLS_Error_AskResetStar,
                                      mtError, [mbOk, mbIgnore], 0, mbRetry) of
          mrOk:
            begin
              if FileExists(DefaultListPath) then
                begin
                  ForceDirectories (DefaultOldListPath);
                  RenameFile (DefaultListPath, DefaultOldListPath + PathDelim + 'StarList'+formatdatetime('d.m.y-h;n;s;z', Now)+'.old');
                end;

               LoadStarList(DefaultListPath); //it will create a defaultfile by its own
            end;
          mrIgnore:
            Result := false;
        end;
     end;

  begin
     //Bodylist uses ',' as Separator.
    CammaAsSep := DefaultFormatSettings;
    CammaAsSep.DecimalSeparator := ',';

    Options[ON_Body] := Item.Caption; //Save the current item as seleced

    for i := 0 to LV_BodyList.Items.Count-1 do  //Uncheck all the other items
      if not (LV_BodyList.Items[i] = Item) then
        LV_BodyList.Items[i].Checked := false;
    //Check the current Item
    Item.Checked   := true;  //and check the current one

    //Tell the mainpage what item was selected
    Lbl_Bdy_Nr.caption         := Item.Caption;
    Lbl_Bdy_Name.caption       := Item.SubItems[0];
    Lbl_Bdy_NameLatain.caption := Item.SubItems[1];

    //Toggle visibility if useful information was given or not
    with Lbl_BdyPrpty_Val1 do
      begin
        if (Item.SubItems[2] = '-') then
          Visible := false
        else
          Visible := true;

        caption := Item.SubItems[2];
      end;
   //Toggle visibility if useful information was given or not
   //But show it anyway if body property 1 wasn't useful
    with Lbl_BdyPrpty_Val2 do
      begin
        if (Lbl_BdyPrpty_Val1.Visible and (Item.SubItems[3] = 'Keine')) then
          Visible := false
        else
          Visible := true;

        caption := Item.SubItems[3];
      end;

    if not (AnsiLowerCase(Item.SubItems[0]) = 'ruheposition') and  //Try to tell Star calculate page where to find the star
       not (AnsiLowerCase(Item.SubItems[3]) = 'ephemeride' ) then
      begin
        if TryStrToFloat (Item.SubItems[4], TestFloat, CammaAsSep) then
          Lbl_RightAc_ValDeg.Caption := Item.SubItems[4]
         else
          if ProgressError ('4', Item.SubItems[4]) then
            exit;

        if TryStrToFloat (Item.SubItems[5], TestFloat, CammaAsSep) then
          Lbl_RightAc_ValMin.Caption := Item.SubItems[5]
         else
          if ProgressError ('5', Item.SubItems[5]) then
            exit;

        if TryStrToFloat (Item.SubItems[6], TestFloat, CammaAsSep) then
            Lbl_Decli_ValDeg.Caption := Item.SubItems[6]
         else
          if ProgressError ('6', Item.SubItems[6]) then
            exit;

        if TryStrToFloat (Item.SubItems[7], TestFloat, CammaAsSep) then
            Lbl_Decli_ValMin.Caption := Item.SubItems[7]
         else
          if ProgressError ('7', Item.SubItems[7]) then
            exit;
      end
     else
      if (AnsiLowerCase(Item.SubItems[0]) = 'ruheposition') then //if it's not a star but the restposition set lon and lat to 89.
        begin
          with DefaultFormatSettings do
            begin
              SetShapePos (ShpN_EleCalc, 89.999);
              SetShapePos (ShpN_AziCalc, 89.999);

              FltSpnEd_EleCalcManu.Value := 89.999;
              FltSpnEd_AziCalcManu.Value  := 89.999;

              Lbl_EleCalc_Val.Caption := '89' + DecimalSeparator + '99';
              Lbl_AziCalc_Val.Caption := '89' + DecimalSeparator + '99';

              Lbl_Ele_Val.Caption := '89' + DecimalSeparator + '9999';
              Lbl_Azi_Val.Caption := '89' + DecimalSeparator + '9999';
            end;
         end;
   end;

procedure TFrm_Main.SearchInputEdit (Sender: TObject);  //ToDo: Error handeling (Item not found)
  var
    TempItem: TListItem;
  begin
    //if there was vailid input
    with Sender as TEdit do
      if not (Text = MLS_Search_Default) and not (Text = '') then
        begin
          TempItem := Search4Body (Trim(Text)); //serch for the input

          if Assigned(TempItem) then
            begin
              ProgressList(TempItem);

              //If the user searched for a constellation, change Bodymode
              if ((Trim(Text) <> '-') and (StrCompaire(Text, TempItem.SubItems[2] , false) > 75)) then
                ProgressBodyMode(BMd_Constellation);
            end
          else
          ; //Item not found
        end;
  end;

function  TFrm_Main.Search4Body (SerchFor: String): TListItem;  //ToDo: Comments; better error handleling
  var
    i, j: Integer;
    sameness: Real = -1;
    TempSameness: Real;
  begin
    Result := LV_BodyList.Items.FindCaption(0, SerchFor, false, false, true);

    if Assigned (Result) then
        LV_BodyList.Selected := Result
    else
      if SerchFor = '0' then
        begin
          LV_BodyList.Selected := LV_BodyList.Items[0];

         Result := LV_BodyList.Items[0];
        end
    else
      for i := 0 to LV_BodyList.Items.Count-1 do
        for j := 0 to LV_BodyList.Items[i].SubItems.Count-1 do
          begin
            TempSameness :=  StrCompaire (SerchFor, LV_BodyList.Items[i].SubItems[j], false);

            if (TempSameness >= 60) and (TempSameness > Sameness) then
              begin
                LV_BodyList.Selected := LV_BodyList.Items[i];
                Result := LV_BodyList.Items[i];

                //We got a 100% match, skip all the others
                if (TempSameness = 100) then
                  exit;

                Sameness := TempSameness;
              end;
          end;

  end;

procedure TFrm_Main.SendData (); //Done?
  begin
    //Get values to navigate to
    with ARMConnection do
      begin
        SendElevation := FltSpnEd_EleCalcManu.Value;
        SendAzimuth   := FltSpnEd_AziCalcManu.Value;
      end;
  end;

procedure TFrm_Main.SetPortableMode (IsActive: Boolean); //ToDo: CleanUp after Mode has changed
  {$IfDef Windows}
  var
    FileName: String;
    H: THandle;
  {$EndIf}
  begin
    if IsActive then //PortableMode uses just the dir where the binary is located
      DefaultPath := OwnDir
    else     //while non PortableMode uses a different path, to hide files
      {$IfDef Windows}
        begin
          //Works like the windows global path
          DefaultPath := 'C:\ProgramData\FireInstallations\SpaceOrienter';

          //Test if we have access, else we use the system local path
          if not ForceDirectories(DefaultPath) then
             DefaultPath := GetAppConfigDir(false)
          else
            begin
              FileName := IncludeTrailingPathDelimiter(DefaultPath) + 'chk.tmp';
              H := CreateFileW(PWideChar(FileName), GENERIC_READ or GENERIC_WRITE, 0, nil,
                CREATE_NEW, FILE_ATTRIBUTE_TEMPORARY or FILE_FLAG_DELETE_ON_CLOSE, 0);

              if H <> INVALID_HANDLE_VALUE then
                 DefaultPath := GetAppConfigDir(false);
              CloseHandle(H);
            end;


        end;
      {$Else}
         DefaultPath := GetAppConfigDir(false);
      {$EndIf Windows}

    {Sets all the pathes where DefaultPath is used}
    //ConfigExtension

    if (DefaultPath[DefaultPath.length] = PathDelim) then
       DefaultPath := Copy(DefaultPath, 1, length(DefaultPath)-1);

    DefaultOptionsPath    := DefaultPath + PathDelim + 'Options.Space';
    DefaultOldOptionsPath := DefaultPath + PathDelim + 'OldOptions';
    DefaultListPath       := DefaultPath + PathDelim + 'StarList.Space';
    DefaultOldListPath    := DefaultPath + PathDelim + 'OldLists';

    SetCurrentDir(DefaultPath);
  end;

procedure TFrm_Main.SetShapePos (const ShapeNum: TShapeNums; Angle: Real); //ToDo: Comments
  var
    R: Real;
    CalcLeft, CalcTop: Integer;
    Shape_Height: Integer;
    TempShpeType: TShapeType;

    function FImod(const ValLeft,  ValRhight: Real): Real; inline;
      begin
        FImod := ValLeft - ValRhight * trunc(ValLeft / ValRhight);
      end;

    function Sign_custom (const Value: Real): ShortInt; inline;
      begin
        if (Value = 0) then
          Result := 1
        else
          Result := Sign(Value);
      end;

    procedure CalcAziPosAndShape ();
      begin
        Angle := FImod(Angle, 360);

        CalcTop  := Img_ChartAzi.Top  + round(R) - Shape_Height;
        CalcLeft := Img_ChartAzi.Left + round(R) - Shape_Height;

        CalcTop  += Round(-R * cos(Angle * Pi/180));
        CalcLeft += Round(-R * sin(Angle * Pi/180));

        case Round(Angle) of
          226..315:        TempShpeType := stTriangleRight;
          316..359, 0..45: TempShpeType := stTriangle;
          46..135:         TempShpeType := stTriangleLeft;
          136..225:        TempShpeType := stTriangleDown;
        end;
      end;

    procedure CalcElePosAndShape ();
      var
        Signum: ShortInt;
      begin
        Angle := FImod(Angle, 181);

        case Round(Angle) of
          -45..0, 1..45:        TempShpeType := stTriangleRight;
          46..135:              TempShpeType := stTriangle;
          -135..-46:            TempShpeType := stTriangleDown;
          136..180, -180..-136: TempShpeType := stTriangleLeft;
        end;

        CalcTop  := Img_ChartEle.Top  + round(R) - Shape_Height;
        CalcLeft := Img_ChartEle.Left + round(R) - Shape_Height;

        Signum   := Sign_custom(Angle);
        Angle    := abs(Angle);

        CalcTop  -= Round(R * sin(Angle * Pi/180)) * Signum;
        CalcLeft += Round(R * cos(Angle * Pi/180));
      end;

  begin
    //these Images are supposed to be 2 equel circles
    R := Img_ChartEle.Height / 2;
    Shape_Height := Shape_EleNow.Height div 2;

    if (ShapeNum <= ShpN_EleCalc) then
      CalcElePosAndShape ()
    else
      CalcAziPosAndShape ();

    case ShapeNum of
      ShpN_EleNow:
        begin
          Shape_EleNow.Left  := CalcLeft;
          Shape_EleNow.Top   := CalcTop;
          Shape_EleNow.Shape := TempShpeType;
        end;
      ShpN_EleCalc:
        begin
          Shape_EleCalc.Left  := CalcLeft;
          Shape_EleCalc.Top   := CalcTop;
          Shape_EleCalc.Shape := TempShpeType;
        end;
      ShpN_AziNow:
        begin
          Shape_AziNow.Left   := CalcLeft;
          Shape_AziNow.Top   := CalcTop;
          Shape_AziNow.Shape := TempShpeType;
        end;
      ShpN_AziCalc:
        begin
          Shape_AziCalc.Left  := CalcLeft;
          Shape_AziCalc.Top   := CalcTop;
          Shape_AziCalc.Shape := TempShpeType;
        end;
    end;
  end;

function  TFrm_Main.StrCompaire (str1, str2: String; const CaseSensitive: Boolean = true): Real;  //ToDo: find offset of missing parts
  type
    TCharList = Record
      Chara: UniCodeChar;
      Count: Integer;
     end;

  var
     NumberofChar1, NumberofChar2: Array of TCharList;
     i, j: Integer;
     MinLength, Maxlength: integer;
     SameNrChr: Integer = 0;
     SameChar: integer = -1;
     Found: Boolean;
  begin
    //initialize
    Setlength(NumberofChar1{%H-}, 0);
    Setlength(NumberofChar2{%H-}, 0);

    Maxlength   := Max(Length(str1), Length(str2));
    MinLength   := Min(Length(str1), Length(str2));

    if not CaseSensitive then
      begin
       Str1 := AnsiLowerCase(Str1);
       Str2 := AnsiLowerCase(Str2);
      end;


    if (str1 <> '') and (str2 <> '') and (MinLength >= 3) then
      begin
        if Str1 = Str2 then  //they are exacly the same, so the sameness IS 100%
          begin
            FreeAndNil(NumberofChar1);
            FreeAndNil(NumberofChar2);

            exit (100);
           end;

        //look for same chararkters around of i
        //SameChar will be diveded by 4 so if the char appiers 2 places away it's just 1/4 of the same place
        for i := low(str1) to pred(MinLength) do
          if (str1[i] = str2[i]) then
            Inc(SameChar, 4)
           else if ((Length(str2) - 1 >= i + 1) and (str1[i] = str2[i + 1])) then
             Inc(SameChar, 2)
           else if ((Length(str2) - 1 >= i + 2) and (str1[i] = str2[i + 2])) then
             Inc(SameChar,1)
           else if ((Length(str1) - 1 >= i + 1) and (str1[i + 1] = str2[i])) then
             Inc(SameChar, 2)
           else if ((Length(str1) - 1 >= i + 2) and (str1[i + 2] = str2[i])) then
             Inc(SameChar, 1);

        //count number of different chars in Str1
        for j := low(Str1) to high(Str1) do //while (length(str1) > 0) do
          begin
            Found := false;

            //was this char already found? if yes Inc the count
            for i := 0 to high(NumberOfChar1) do
              begin
                if (str1[j] = NumberofChar1[i].Chara) then
                  begin
                    Found := true;
                    Inc(NumberOfChar1[i].Count);
                   end;
                end;

            //a new Char appiered?
            if not Found then
              begin
                setlength(NumberofChar1, length(NumberofChar1)+1);
                NumberOfChar1[high(NumberOfChar1)].Chara := str1[j];
                NumberOfChar1[high(NumberOfChar1)].Count := 1;
              end;
            //Delete(str1, 1, 1);
           end;

        //count number of different chars in Str2
        for j := low(Str2) to high(Str2) do
          begin
            Found := false;

            //was this char already found? if yes Inc the count
            for i := 0 to (length(NumberOfChar2)-1) do
              begin
                if str2[j] = NumberofChar2[i].Chara then
                  begin
                    Found := true;
                    Inc(NumberOfChar2[i].Count);
                   end;
                end;

            //a new Char appiered?
            if not Found then
              begin
                setlength(NumberofChar2,length(NumberofChar2)+1);
                NumberOfChar2[high(NumberOfChar2)].Chara := str2[j];
                NumberOfChar2[high(NumberOfChar2)].Count := 1;
              end;
           end;

        //Do the found chars appear as often as in both strings?
        for i := 0 to high(NumberofChar1) do
          for j := 0 to high(NumberofChar2) do
            if NumberOfChar1[i].Chara = NumberOfChar2[j].Chara then
              if NumberOfChar1[i].Count = NumberOfChar2[j].Count then
                Inc(SameNrChr);

        MinLength := Max(length(NumberOfChar1), length(NumberOfChar2));
       end;

    if SameNrChr > 0 then
      Result := (((SameChar/(Maxlength*4)) * (2/5))  + ((SameNrChr/MinLength) * (3/5))) * 100
     else
      Result := 0.00;

  end;

procedure TFrm_Main.Update_ (); //ToDo
  begin

  end;

{------------------------------------------------------------------------------}

procedure TFrm_Main.Img_Settings_WClick(Sender: TObject); //Done
  begin
    //call the config form
    Frm_Main.Hide;
    Frm_Config.Show;
  end;

procedure TFrm_Main.BitBtn_Navigate_MainClick(Sender: TObject);  //Done
  begin
    //Send position data to ArduIno
    SendData ();
  end;

procedure TFrm_Main.CmbBx_ModeChange(Sender: TObject); //Done
  begin
    //Tell what Mode was selected
    ProgressBodyMode(TBodyMode(CmbBx_Mode.ItemIndex));
  end;

procedure TFrm_Main.ECTabCtrl_CalcSectionsChange(Sender: TObject); //Done
  begin
    //Somehow a change occours even befor the form was created
    //So ignore all changes until Options where loaded correctly
    if OptionsLoaded then
      PgCtrl_CalcSections.TabIndex := ECTabCtrl_CalcSections.TabIndex;
  end;

procedure TFrm_Main.Ed_Search4Bdy_Enter(Sender: TObject);  //Buggy
  begin

    With Sender as TEdit do
      if Text = MLS_Search_Default then
        Clear  //nothing was typed yet, so clear up the default value
       else
        begin
          //Ed_Search4Bdy_Main.SetFocus;
          HideSelection := false;
          //should select the last typed text.. but it doesn't work. nether do the following ones, with or whithout autoselect
          SelectAll;

          //Ed_Search4Bdy_Main.SelStart := 0;
          //Ed_Search4Bdy_Main.SelLength := 2;
          //Ed_Search4Bdy_Main.SelText := Ed_Such.Text;
        end;

  end;

procedure TFrm_Main.Ed_Search4Bdy_Exit(Sender: TObject); //Done
  begin

    With Sender as TEdit do
    //Reset to default if no text was given
    if (Text = '') then
      Text  := MLS_Search_Default;

    //Reset the other one
    if (Sender = Ed_Search4Bdy_List) then
      Ed_Search4Bdy_Main.Text := MLS_Search_Default
     else
      Ed_Search4Bdy_List.Text := MLS_Search_Default;

  end;

procedure TFrm_Main.Ed_Search4Bdy_KeyDown(Sender: TObject; var Key: Word; //Done
  Shift: TShiftState);
  begin
    //If Enter was pressed search for the given text
    if Key = VK_RETURN then
      SearchInputEdit(Sender)
  end;

procedure TFrm_Main.FltSpnEd_AziCalcManuChange(Sender: TObject); //ToDo: Comments
  var
    Val: Real;
  begin
    Val := FltSpnEd_AziCalcManu.Value;

    SetShapePos(ShpN_AziCalc, Val);

    Lbl_AziCalc_Val.Caption := FloatToStrF(Val, ffFixed, 3, 2);
  end;

procedure TFrm_Main.FltSpnEd_EleCalcManuChange(Sender: TObject);  //ToDo: Comments
  var
    Val: Real;
  begin
    Val := FltSpnEd_EleCalcManu.Value;

    SetShapePos(ShpN_EleCalc, Val);

    Lbl_EleCalc_Val.Caption := FloatToStrF(Val, ffFixed, 3, 2);
  end;

procedure TFrm_Main.FndDFind (Sender: TObject); //ToDo: Comments; ErrorHandeling(Item not Found)
  var
    SearchForStr: String;
    FoundBody: TListItem;
  begin
    //Opens FindDialog ang get String that was searched for
    SearchForStr := FndD.FindText;

    //make sure case matters as much as the user wants
    if (frDisableMatchCase in FndD.Options) then
      SearchForStr := AnsiLowerCase(SearchForStr);

    //clean up
    FndD.CloseDialog;

    //serch for the given string
    FoundBody := Search4Body(SearchForStr);

    if Assigned(FoundBody) then
      begin
        ProgressList(FoundBody);

        //If the user searched for a constellation, change Bodymode
        if (StrCompaire(Ed_Search4Bdy_Main.Text, FoundBody.SubItems[2] , false) > 75) then
          ProgressBodyMode(BMd_Constellation);
      end
    else
    ; //Item not found

  end;

procedure TFrm_Main.FormCreate(Sender: TObject); //ToDo: use seeparator in Loadoptions; move Connect to LoadOptions and use Connact to all just if no vailid port was found; Update; get defaultvalues from last points
  begin

    //initialize Own path
    OwnDir :=  ExtractFilePath(ParamStrUTF8(0));
    //old way:
    //OwnDir := GetCurrentDir();

    //Create thread
    ARMConnection := TArmConnect.Create(True);

    //initialize Hotkey
    KeyCount    := 0;
    PressedKeys := [];
    HotKey      := [];

    //set default vaulues
    Lbl_AziNow_Val.Caption := FloatToStrF(0, ffFixed, 2, 2);
    Lbl_EleNow_Val.Caption := FloatToStrF(0, ffFixed, 2, 2);

    Lbl_AziCalc_Val.Caption := FloatToStrF(89.99, ffFixed, 2, 2);
    Lbl_EleCalc_Val.Caption := FloatToStrF(89.99, ffFixed, 2, 2);

    //Display everything in the OS langue until a choosen langue was loaded
    SetDefaultLang(GetOSLanguage());

    //Make sure these Forms are already created when LoadOptions was called
    Application.CreateForm(TFrm_Config, Frm_Config);
    Application.CreateForm(TFrm_GetHotKey, Frm_GetHotKey);

    //Tell LoadOptions to try to load from portable file if it exits
    SetPortableMode(FileExists(GetCurrentDir + PathDelim + 'Options.Space'));

    //Load config file
    FOptionsLoaded := LoadOptions();

    if not OptionsLoaded then //was not able to load the config flie -> clean up
      Halt;

    //Search for commports
    GetComPorts ();

    //start thread
    ARMConnection.Start;

    //Get last Error in thread
    if Assigned(ARMConnection.FatalException) then
       raise ARMConnection.FatalException;

    //Try to connect
    Connect (StrToBool(Options[ON_AutoComMode]));

    { if ChkB_Up.Checked then
      Update_ (); }


    //Just show the default page
    //Basicly this is a line for development versions, if the form was compiled with open mainpage, as it should in realese versions, we can make it a comment
    ImgMn_Menue.ItemIndex := 0;
    PgCtrl_Menue.TabIndex := 0;

    PgCtrl_CalcSections.TabIndex    := 0;
    ECTabCtrl_CalcSections.TabIndex := 0;

    //after erverything was loaded fine we can start to calculate star/Ehemedides positions
    Tmr_CalcAll.Enabled := true;
  end;

procedure TFrm_Main.FormDestroy(Sender: TObject);   //Version Dynamic; Comments
  var
     NotGottenOptions: set of byte = [0..Ord(high(ToptionNames))];
     Line: String;
     OptionName: TOptionNames;
     TempValue: String;
     TempLine: String;

     Index: Integer;
     SaveStrings, LoadStrings: TStringList;
  begin
    EndPlanetEphem();

    Tmr_CalcAll.Enabled := false;
    Tmr_Follow.Enabled := false;

    SaveStrings := TStringlist.create;

    if not FileExists (DefaultOptionsPath) then  //make a new clean file
      begin

        SaveStrings.Add('#*-+-~-+-\*/-+-~-{ Spaceorienter Options }-~-+-\*/-+-~-~+-*');
        SaveStrings.Add('#|Please change only, if you know what you are doing!     |');
        SaveStrings.Add('#|                                                        |');
        SaveStrings.Add('#|Timeformat: DD.MM.YYYY or SS:NN:HH                      |');
        SaveStrings.Add('#|                                                        |');
        SaveStrings.Add('#|Note: If you make changes to this file while the        |');
        SaveStrings.Add('#|application is running, the changes will be overwritten |');
        SaveStrings.Add('#|when the application exits.                             |');
        SaveStrings.Add('#*--------------------------------------------------------*');
        SaveStrings.Add('#');
        for OptionName := low(TOptionNames) to High(TOptionNames) do
          begin
            //get OptionNames
            Line := GetEnumName(TypeInfo(TOptionNames), Ord(OptionName));
            Line := Copy(Line, 4, length(Line) -3);

            //glue OptionNames and values together
            SaveStrings.Add('"'+ Line +'": "'+Options[OptionName]+'"');
          end;

        //Save the file
        try
          ForceDirectories (DefaultPath);
          SaveStrings.SaveToFile (DefaultOptionsPath);
        finally
          SaveStrings.free;
        end;
       end
     else //there is already an options file
      begin
        LoadStrings := TStringList.create;

          //load the file
         try
           LoadStrings.LoadFromFile(DefaultOptionsPath);

           //scan the file for  given Options and replace the old values
           for Line in LoadStrings do
             begin
               Index := 0;
               TempLine := Trim(Line);

               if not ((TempLine = '') or (TempLine[1] = '#'))  then  //Skip comments and free lines
                 begin
                   Index := GetOptionIndex(FindOptionName(Line));

                   //if we got an vailid OptionName replace the old value
                   if (Index >= 0) then
                     begin
                       TempValue := FindOptionValue(Line);

                       //If everything stayed the same, leave it like it was
                       //Should simply be faster than replacing a string whith the same one
                       if (TempValue = Options[TOptionNames(Index)]) then
                         begin
                           SaveStrings.Add(Line);
                           NotGottenOptions -= [Index];
                         end
                       else
                         //If there is no vaild value we ignore this line and
                         //will add a new line at the end, if it doesn't appear
                         //some where else. Since we don't know what else is in this line
                         //please note: On_Hotkey can be emty if no Hotkey was choosen
                         if (TempValue <> '') or (TOptionNames(Index) = ON_Hotkey) then
                           begin
                             SaveStrings.Add(StringReplace(Line, TempValue, Options[TOptionNames(Index)], [rfIgnoreCase]));
                             NotGottenOptions -= [Index];
                         end;
                     end;
                 end
               else
               SaveStrings.Add(Line);
             end;

           if NotGottenOptions <> [] then
             for Index in NotGottenOptions do
               begin
                 Line := GetEnumName(TypeInfo(TOptionNames), Index);
                 Line := Copy(Line, 4, length(Line) -3);

                 SaveStrings.Add('"'+ Line +'":   "'+Options[TOptionNames(Index)]+'"');

                 Exclude(NotGottenOptions, Index);
               end;

           SaveStrings.SaveToFile (DefaultOptionsPath);
         finally
            FreeAndNil(LoadStrings);
            FreeAndNil(SaveStrings);
         end;
       end;

      //OptionsLoaded := false;
  end;

procedure TFrm_Main.FormKeyDown(Sender: TObject; var Key: Word; //Done
  Shift: TShiftState);
  begin
    //If we ge a new key and Use Hotkey is active add it to the set.
    if {StrToBool(Frm_Spori.Options[ON_UseHotkey]) and} not (Key in PressedKeys) then
      begin
        //Counter to know how many keys are pressed
        Inc(KeyCount);

        Include(PressedKeys, Key);
      end;
  end;

procedure TFrm_Main.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState ); //Done?
  begin
    //If UseHotkey is active
    if StrToBool(Options[ON_UseHotkey]) then
      begin
        //one button less is pressed
        Dec(KeyCount);

        //if no button is pressed anymore compaire the list of pressed buttons with the hotkey
        if (KeyCount <= 0) then
          begin
            if StrToBool(Options[ON_UseHotkey]) then
              if (PressedKeys = HotKey) then //if they are the same, call Send Data
                SendData ();

            if (PressedKeys = [VK_MENU, VK_F]) then
              begin
                FndD.FindText := Lbl_Bdy_Name.Caption;
                FndD.Execute;
              end;

            //reset the set, ready for next row
            PressedKeys := [];
          end;
      end;
  end;

procedure TFrm_Main.FormResize(Sender: TObject);  //ToDo
  begin
    //set the shapes to the right position after resizing the form

    SetShapePos (ShpN_AziNow, StrToFloat(Lbl_AziNow_Val.Caption) );
    SetShapePos (ShpN_EleNow, StrToFloat(Lbl_EleNow_Val.Caption) );

    SetShapePos (ShpN_AziCalc, StrToFloat(Lbl_AziCalc_Val.Caption) );
    SetShapePos (ShpN_EleCalc, StrToFloat(Lbl_EleCalc_Val.Caption) );
  end;

procedure TFrm_Main.ImgMn_MenueSelectionChange(Sender: TObject; User: boolean); //Done
  begin
    //if the User selects
    PgCtrl_Menue.ActivePageIndex := ImgMn_Menue.itemIndex;
  end;

procedure TFrm_Main.Img_Settings_WMouseDown(Sender: TObject; //Done
Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  begin
    //If the Image or the Label was left clicked color them gray
    if (Button = mbLeft) then
      begin
         Img_Settings_W.Visible := false;
         Img_Settings_G.Visible := true;
         Lbl_Settings.Font.Color := $a5a5a5;
      end;
  end;

procedure TFrm_Main.Img_Settings_WMouseUp(Sender: TObject; Button: TMouseButton; //Done
  Shift: TShiftState; X, Y: Integer);
  begin
    //If the life mouse button goes up color them back white
    if (Button = mbLeft) then
      begin
        Img_Settings_W.Visible := true;
        Img_Settings_G.Visible := false;
        Lbl_Settings.Font.Color := $00DFDFDF;
      end;
  end;

procedure TFrm_Main.LV_BodyListDblClick(Sender: TObject); //Done
  begin
    //if an Item was selected, tell it
    if (LV_BodyList.SelCount = 1) then
      ProgressList (LV_BodyList.Selected);
  end;

procedure TFrm_Main.LV_BodyListItemChecked(Sender: TObject; Item: TListItem);  //Done
  begin
    //tell everybody that a new Body was choosen
    ProgressList(Item);
  end;

procedure TFrm_Main.LV_BodyListKeyPress(Sender: TObject; var Key: char); //Done
  begin
    //tell everybody that a new Body was choosen, if Enter was pressed
    if ((LV_BodyList.SelCount = 1) and (Ord(Key) = VK_RETURN)) then
      ProgressList (LV_BodyList.Selected);
  end;

procedure TFrm_Main.LV_BodyListResize(Sender: TObject); //Done
  var
    i: Integer;
    WidthOfAll: Integer = 0;
  begin
    //Get the width of all captions together
    for i := 0 to pred(LV_BodyList.Columns.Count) do
      with LV_BodyList.Column[i] do
        if Visible then
          WidthOfAll += length(Caption);

    //the new width is percent of overall width * avaible Space (the -20 stand for a possible Scrollbar)
    for i := 0 to pred(LV_BodyList.Columns.Count) do
       with LV_BodyList.Column[i] do
          Width := Trunc((length(Caption) / WidthOfAll) * (LV_BodyList.Width -20));
  end;

procedure TFrm_Main.Tmr_CalcAllOnTimer (Sender: TObject);   //ToDo: better Error handeling; comments; Lb_Gmt = UTC0; CET Summertime; LocalTime in UT is false!; Reset static values like "ruhelage" if manu mode was active
  var
    TimeToUse: TDateTime;
    TZ: integer;
    UTC0: TDateTime;

    TempMagDvtn: Real;
    Year, Month, Day, Hour, Minute, Second, MilliSecond: Word; //Millisec is unused
    VernalPointNow : Real;

    procedure ThrowError(Id: Real; IsEph: boolean = True); //don't use hardcodet name
      var
        TempListItem: TListItem;
      begin
        // halt Timer to let the User react.
        // If we didn't the timer would thow more Errors.
        Tmr_CalcAll.Enabled := false;

        If (IsEph) then
          begin
            MessageDlg(MLS_Error_Caption, MLS_Error_MsgCaption + Slinebreak +
                             '  ' + MLS_Error_PlanEpeh  + slinebreak +
                             '  ' + MLS_Error_Id + ' ' + FloatToStr(Id) + slinebreak +
                             '  ' + MLS_Error_TurnEphOff,
                             mtError, [mbOK], 0, mbOK);


            //resett Body + mode
            TempListItem := Search4Body ('Ruheposition'); //serch for the input

            if Assigned(TempListItem) then
              begin
                ProgressList(TempListItem);
                ProgressBodyMode(BMd_Normal);
              end
            else
            ; //Item not found
          end
        else
          MessageDlg(MLS_Error_Caption, MLS_Error_MsgCaption + Slinebreak +
                             '  ' + MLS_Error_PlanEpeh  + slinebreak +
                             '  ' + MLS_Error_Id + ' ' + FloatToStr(Id),
                             mtError, [mbOK], 0, mbOK);

        // reenable timer
        Tmr_CalcAll.Enabled := true;

        //possible error codes
        {PLERR_NOFILE = -10000;
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
        PLERR_ATAN2ERROR = -10100;}

      end;

    procedure CalcFirstPointOfAries ();
      var
         Void: word;
         TempTime: Real;
      begin
        //Begin of Spring at configurated time
        DecodeDate(UTC0 + 2 / 24, Year, Void, Void);
        Lbl_Aries1P_Val.Caption := '22.03.' + IntToStr(Year);

        //Differenz between GMT and begin of Spring
        TempTime        := UTC0 - StrToDateTime(Lbl_Aries1P_Val.Caption);
        Lbl_Diff_Val.Caption := FloatToStrF(TempTime, ffFixed, 4, 4);

        //Differenz in degree per year
        TempTime        *=  360 / 365.25;
        Lbl_DegShift_Val.Caption := FloatToStrF(TempTime, ffFixed, 4, 4);

        //calculate the position of the first point of Aries
        DecodeTime(StrToDateTime(Lbl_GMT_Val.Caption), Hour, Minute, Second, Void);
        TempTime        := (Hour * 15) + TempTime + 179.928333;

        while (TempTime > 360) do
          TempTime -= 360;

        Lbl_VernalP_Val.caption := FloatToStrF(TempTime, ffFixed, 4, 4);

        TempTime += Minute * 15/60 + Second * 15/3600;
        while (TempTime > 360) do
          TempTime -= 360;

        VernalPointNow := TempTime;

        Lbl_VernalPNow_Val.caption := FloatToStrF(TempTime, ffFixed, 4, 4);

        //TimeAngle
        Lbl_HourAngle_Val.caption := FloatToStrF((Minute * 15/60 + Second * 15/3600), ffFixed, 4, 4);

      end;

    procedure CalculateStarLoc ();  //ToDo: Errorhandeling; comments; Rename StWk, AkFrPnk, Dekli_Grd, Lat_R, Ele, Az_Z, Az_N; get  Values from global variables instad of Labels
      var
        Lon_Deg: Real;
        Lat_R: Real;
        Rtzn_Grd, Rtzn_Rd: Real;
        Dekli_Grd, Dekli_Rd: Real;
        StWk: Real;
        Beta, Delta: Real;
        Grt, T: Real;
        Ele, Azimuth: Real;
        Az_Z, Az_N: Real;
      begin
        Lon_Deg   := Frm_Config.FlSpEd_Lon.Value;
        Lat_R     := Frm_Config.FlSpEd_Lat.Value * Pi /180;

        Rtzn_Grd  := StrToFloat(Lbl_RightAc_ValDeg.Caption);
        Rtzn_Rd   := StrToFloat(Lbl_RightAc_ValMin.Caption);

        Dekli_Grd := StrToFloat(Lbl_Decli_ValDeg.Caption);
        Dekli_Rd  := StrToFloat(Lbl_Decli_ValMin.Caption);

        StWk      := Rtzn_Grd + Rtzn_Rd/60;

        Beta      := StWk * Pi/180;

        Delta     := (Dekli_Grd + Dekli_Rd/60) * Pi/180;

        Grt       := VernalPointNow + StWk;
        if (Grt > 360) then
          Grt -= 360;

        T := Grt + Lon_Deg;
        if (T > 360) then
          T -= 360;
         T *= (Pi/180);

        Ele := ArcSin(Sin(Lat_R)*Sin(Delta) + Cos(Lat_R)*Cos(Delta)*Cos(T));
        Ele *= 180/Pi;

        Az_Z := Sin(-T);
        Az_N := tan(Delta) * cos(Lat_R) - sin(Lat_R) * cos(T);

        Azimuth := ArcTan2(Az_Z, Az_N) * 180/PI();
        if (Azimuth <= 0) then
          Azimuth += 360;

        Lbl_Beta_Val.Caption      := FloatToStrF(Beta, ffFixed, 4, 4);
        Lbl_Delta_Val.caption     := FloatToStrF(Delta, ffFixed, 4, 4);
        Lbl_StarAngle_val.caption := FloatToStrF(StWk, ffFixed, 4, 4);
        Lbl_GrT_Val.caption       := FloatToStrF(Grt, ffFixed, 4, 4);
        Lbl_T_Val.caption         := FloatToStrF(T, ffFixed, 4, 4);

        Lbl_AziNum_Val.Caption    := FloatToStrF(Az_Z, ffFixed, 4, 4);
        Lbl_AziDenom_Val.Caption  := FloatToStrF(Az_N, ffFixed, 4, 4);

        Lbl_Ele_Val.caption       := FloatToStrF(Ele, ffFixed, 4, 4);
        Lbl_Azi_Val.caption       := FloatToStrF(Azimuth, ffFixed, 4, 4);

        if not (Frm_Config.Sw_ManuVal.Checked) and not (AnsiLowerCase(Lbl_Bdy_Name.Caption) = 'ruheposition') then
          begin
            SetShapePos (ShpN_EleCalc, Ele);
            SetShapePos (ShpN_AziCalc, Azimuth);

            FltSpnEd_EleCalcManu.Value  := Ele;
            FltSpnEd_AziCalcManu.Value  := Azimuth;

            Lbl_EleCalc_Val.Caption := FloatToStrF(Ele, ffFixed, 3, 2);
            Lbl_AziCalc_Val.Caption := FloatToStrF(Azimuth, ffFixed, 3, 2);
          end;
      end;

    procedure CalculateEphemerisLoc (); //ToDo: Comments; clean up; better offset; not hardcoded names
      var
         Lon, Lat, xp, yp, dut1, hm, tc, pm, rh, wl: Real;
         ra, rb: Double;
         Body: Integer;
         UTC1, UTC2: Real;

         Ele, Azi: Real;
      begin
        Lon := Frm_Config.FlSpEd_Lon.Value; // Positive eastward
        Lat := Frm_Config.FlSpEd_Lat.Value; // Positive northward
        hm := Frm_Config.FlSpEd_Height.Value; // hight (meters) Used with topocentric frames to apply diurnal aberration.

        xp     := 0.20937;    // The x offset of the terrestrial pole. Used to apply polar motion. From www.iers.org bulletin service
        yp     := 0.34715;    // The y offset From www.iers.org bulletin service
        dut1   := 0.055836;   // Difference between UTC and UT1. It can only be obtained by a bulletin service From www.iers.org bulletin service

        tc  := 20.0;        // Temperature (celcius)
        pm  := 1000.0;      // Pressure (milibars)
        rh  := 0.5;         // Relative Humidity (percent [fractional])
        wl  := 0.55;        // Wavelength (micrometers)
        RefractionAB(pm, tc, rh, wl, ra{%H-}, rb{%H-}); //How athmosphare doese change the observation

        Case Trim(AnsiLowerCase(Lbl_Bdy_Name.Caption)) of
          'merkur':  Body := BN_MERCURY;
          'venus':   Body := BN_VENUS;
          'erde':    Body := BN_EARTH ;
          'mars':    Body := BN_MARS;
          'jupiter': Body := BN_JUPITER;
          'saturn':  Body := BN_SATURN;
          'uranus':  Body := BN_URANUS;
          'neptun':  Body := BN_NEPTUNE;
          'pluto':   Body := BN_PLUTO;
          'mond':    Body := BN_MOON;
          'sonne':   Body := BN_SUN;
         else
                     Body := BN_EARTH;  //Error
         end;

        UTC1 := StrToFloat(Lbl_UTC1_Val.Caption);
        UTC2 := StrToFloat(Lbl_UTC2_Val.Caption);

        if(Body = BN_EARTH) then
          Ele := -90
         else
          Ele := Ephem(0, FR_ICRS, Body, GV_ELEVATION, AD_LIGHTTIME, UTC1,  UTC2,
                       Lon, Lat, TZ, xp, yp, dut1, hm, ra, rb);


       if (InRange(Ele, PLERR_ATAN2ERROR, PLERR_NOFILE)) then
         ThrowError(Ele)  //Errorhandeling
        else
          begin
            if(Body = BN_EARTH) then
              Azi := 0
             else
              Azi := Ephem(0, FR_ICRS, Body, GV_AZIMUTH, AD_LIGHTTIME, UTC1,  UTC2,
                           Lon, Lat, TZ, xp, yp, dut1, hm, ra, rb);


            if (InRange(Azi, PLERR_ATAN2ERROR, PLERR_NOFILE)) then
              ThrowError(Azi)
            else
             begin
               //values seem to be good

               SetShapePos (ShpN_EleCalc, Ele);
               SetShapePos (ShpN_AziCalc, Azi);

               FltSpnEd_EleCalcManu.Value := Ele;
               FltSpnEd_AziCalcManu.Value := Azi;

               Lbl_EleCalc_Val.Caption := FloatToStrF(Ele, ffFixed, 3, 2);
               Lbl_AziCalc_Val.Caption := FloatToStrF(Azi, ffFixed, 3, 2);

               Lbl_Ele_Val.Caption := FloatToStrF(Ele, ffFixed, 4, 4);
               Lbl_Azi_Val.Caption := FloatToStrF(Azi, ffFixed, 4, 4);
             end;
           end;
       end;


  begin
    if Frm_Config.Sw_AutoTime.Checked then
      TimeToUse := now
    else
      TimeToUse := now + DiffD + DiffT;

    TZ          := GetLocalTimeOffset() div -60;
    UTC0        := TimeToUse - TZ / 24;

    Lbl_TZ_Val.caption := IntToStr(TZ);
    Lbl_Date.Caption    := DateToStr(TimeToUse);
    Lbl_Time.Caption    := TimeToStr(TimeToUse);
    Lbl_CET_Val.Caption := DateTimeToStr(UTC0 + 2 / 24);

    DecodeTime(TimeToUse, Hour, Minute, Second, MilliSecond);
    DecodeDate(TimeToUse, Year, Month, Day);

    if not NoEntry then
      begin
        Frm_Config.TE_Time.Time := (Time + DiffT);
        Frm_Config.DE_Day.Date  := (Date + DiffD);
        Options[ON_Date] := DateToStr(Frm_Config.DE_Day.Date);
        Options[ON_Time] := TimeToStr(Frm_Config.TE_Time.Time);
       end;

    Lbl_GMT_Val.Caption := DateTimeToStr(UTC0);
    Lbl_LocalUT_Val.Caption := DateTimeToStr(UTC0 + Frm_Config.FlSpEd_Lon.Value / 360);

    CalcFirstPointOfAries();

    Lbl_UTC1_Val.Caption := FloatToStrF(Julian(Year, Month, Day, 0, 0, 0), ffFixed, 4, 4);

    Lbl_UTC2_Val.Caption := FloatToStrF(
                           (Hour + Minute/60 + Second/3600)/24, ffFixed, 4, 4);

    TempMagDvtn :=  wmmGeomag(1, Year, Month, Day,   //ToDo: don't change DefaultFormatsettings here! //var in function header doesnt work!
                    Frm_Config.FlSpEd_Lon.Value, Frm_Config.FlSpEd_Lat.Value, 0);

    if (InRange(TempMagDvtn, PLERR_ATAN2ERROR, PLERR_NOFILE)) then
      ThrowError(TempMagDvtn, False)
     else
       Lbl_MagDvtn_Val.Caption := FloatToStrF(TempMagDvtn, ffFixed, 3, 4);

    if (AnsiLowerCase(Lbl_BdyPrpty_Val2.Caption) = 'ephemeride') then
      CalculateEphemerisLoc ()
    else
     if not (AnsiLowerCase(Lbl_Bdy_Name.Caption) = 'ruheposition') then
      CalculateStarLoc () ;

   end;

procedure TFrm_Main.Tmr_FollowOnTimer (Sender: TObject); //Don't use hardcoded "Sternbild" (= constellation)
  var
     EleNow, EleCalk: Real;
     AziNow, AziCalk: Real;

     Index: Integer;
     InConstellation: Boolean;
     Constellation: Array of TListItem;
  begin
    //If Mode was set to Constellation
    if ((CmbBx_Mode.Text = 'Sternbild') and (Trim(Lbl_BdyPrpty_Val1.Caption) <> '-') and
         (Trim(Lbl_BdyPrpty_Val1.Caption) <> '')) then
      begin
        // initialize
        Setlength(Constellation{%H-}, 0);
        InConstellation  := false;

        //Find all stars in the given Constellation
        for Index := 0 to LV_BodyList.Items.Count-1 do
          if AnsiLowerCase(Trim(Lbl_BdyPrpty_Val1.Caption)) = AnsiLowerCase(LV_BodyList.Items[Index].SubItems[2]) then
            begin
              setlength(Constellation, length(Constellation)+1);
              Constellation[high(Constellation)] := LV_BodyList.Items[Index];
             end;


        //Find the Index of the selected star
        for Index := 0 to high(Constellation) do
          if Lbl_Bdy_Nr.Caption = Constellation[Index].Caption then
            begin
              //Get informations about own and starposition
              EleNow  := StrToFloat(Lbl_EleNow_Val.Caption);
              EleCalk := FltSpnEd_EleCalcManu.Value;
              AziNow  := StrToFloat(Lbl_AziNow_Val.Caption);
              AziCalk := FltSpnEd_AziCalcManu.Value;

              //if the own position is near of the postion of the star get next one
              if ((EleNow - EleCalk  < 3) and (EleNow - EleCalk  > -3) and
                  (AziNow - AziCalk  < 3) and (AziNow - AziCalk  > -3)) then
                ProgressList (Constellation[succ(Index) mod high(Constellation)])
              else
               ProgressList (Constellation[0]);

              //We found it!
              InConstellation := true;
              break;
            end;

        //if no Item was found (strange case) use the first Item on the list
        if not InConstellation then
         ProgressList (Constellation[0]);
       end;

    //If the user doesn't want to to send the data on his/her/it/whatever own
    //Test if we can send data will be done by the function itself
      if not Frm_Config.Sw_HtKy.Checked then
        SendData ();
  end;

//Exists just for compatibility
initialization

finalization
  begin  //No Matter what, we have to clean Up!
    if Assigned(ARMConnection) then
      begin
        if not ARMConnection.Terminated then
           ARMConnection.Terminate;

        FreeAndNil(ARMConnection);
      end;

    //I know, it's already called in FormDestroy but you realy can't do anything wrong
    //calling it again.
    //Futhermore that way PlanEph will be freed in any given case correctly
    EndPlanetEphem();
  end;
end.
