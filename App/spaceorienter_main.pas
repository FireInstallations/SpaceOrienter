unit spaceorienter_main;

{$mode objfpc}{$H+}

interface

  {Copyright (C) <2018> <FireInstallations> <kettnerl [at] hu-berlin.de>

   This programm is free software; you can redistribute it and/or modify it
   under the terms of the GNU Library General Public License as published by
   the Free Software Foundation; either version 3 of the License, or (at your
   option) any later version.

  { TFrm_Spori }

  TFrm_Spori = class(TForm)
    AppProps: TApplicationProperties;
    BBt_Anfahren: TBitBtn;
    Bt_BebList: TButton;
    Bt_ResList: TButton;
    Bt_Start: TButton;
    Bt_LoList: TButton;
    Bt_Up: TButton;
    Bt_EinstZuRS: TButton;
    CB_HK: TComboBox;
    CkB_ManuAnSt: TCheckBox;
    CB_StrMode: TComboBox;
    CB_Ort: TComboBox;
    CB_StB: TComboBox;
    ChkB_TmMd: TCheckBox;
    ChkB_Up: TCheckBox;
    CkB_Port_Auto: TCheckBox;
    DE_Frhanf: TDateEdit;
    DE_Manu: TDateEdit;
    ED_Port: TEdit;
    Ed_Azi_Ist: TEdit;
    Ed_Azi_Soll: TEdit;
    Ed_Egstn: TEdit;
    Ed_Ele_Ist: TEdit;
    Ed_Ele_Soll: TEdit;
    Ed_Phi_G: TEdit;
    Ed_Lamda_G: TEdit;
    Ed_MgMswg: TEdit;
    Ed_Mswg: TEdit;
    Ed_Nr: TEdit;
    Ed_Such: TEdit;
    FndD: TFindDialog;
    Gb_Azi: TGroupBox;
    GB_Brg: TGroupBox;
    GB_Brnt: TGroupBox;
    Gb_FrPnk: TGroupBox;
    Gb_Ist: TGroupBox;
    GB_Lage: TGroupBox;
    Gb_Mswg: TGroupBox;
    GB_Soll: TGroupBox;
    Gb_Wink: TGroupBox;
    Gb_Wink1: TGroupBox;
    GB_Zeit: TGroupBox;
    GB_Zeit1: TGroupBox;
    GB_Zeit_: TGroupBox;
    GB_Ort: TGroupBox;
    GB_List: TGroupBox;
    GB_Up: TGroupBox;
    GB_Port: TGroupBox;
    GB_Weiteres: TGroupBox;
    Lb_SmrZ_1: TLabel;
    Lb_SmrZ1: TLabel;
    Lb_Min_: TLabel;
    Lb_Min: TLabel;
    Lb_Az_Grd1: TLabel;
    Lb_El_Grd_: TLabel;
    Lb_Hour_: TLabel;
    Lb_Hour: TLabel;
    Lb_Sek_: TLabel;
    Lb_Sek: TLabel;
    Lb_Frhanf: TLabel;
    Lb_TManu: TLabel;
    Lb_DManu: TLabel;
    Lb_Lam: TLabel;
    Lb_Gam: TLabel;
    Lb_MgMswg: TLabel;
    Lb_Port: TLabel;
    Lb_Grt: TLabel;
    LbAkFrPnk: TLabel;
    LbAkFrPnk_: TLabel;
    Lb_Az: TLabel;
    Lb_Az1: TLabel;
    Lb_Azi: TLabel;
    Lb_Az_: TLabel;
    Lb_Az_1: TLabel;
    Lb_Az_N: TLabel;
    Lb_Az_N_: TLabel;
    Lb_Az_Z: TLabel;
    Lb_Az_Z_: TLabel;
    Lb_Beta: TLabel;
    Lb_Beta_: TLabel;
    Lb_Dekli_: TLabel;
    Lb_Dekli_Grd: TLabel;
    Lb_Dekli_Rd: TLabel;
    Lb_Delt: TLabel;
    Lb_Delt_: TLabel;
    Lb_Diff: TLabel;
    Lb_Diff_: TLabel;
    Lb_Egnstn: TLabel;
    Lb_Ein: TLabel;
    Lb_El: TLabel;
    Lb_El1: TLabel;
    Lb_Ele: TLabel;
    Lb_El_: TLabel;
    Lb_El_1: TLabel;
    Lb_FrAnf: TLabel;
    Lb_FrAnf_: TLabel;
    Lb_FrPnk: TLabel;
    Lb_FrPnk_: TLabel;
    Lb_Phi: TLabel;
    Lb_Gamma1: TLabel;
    Lb_Phi_G: TLabel;
    Lb_Phi_G1: TLabel;
    Lb_Phi_R: TLabel;
    Lb_Phi_R1: TLabel;
    Lb_Gmt: TLabel;
    Lb_Gmt_: TLabel;
    Lb_Grd_1: TLabel;
    Lb_Grd_2: TLabel;
    Lb_Grd_3: TLabel;
    Lb_Grd_4: TLabel;
    Lb_Grd_5: TLabel;
    Lb_Grt_: TLabel;
    Lb_GSft: TLabel;
    Lb_GSft_: TLabel;
    Lb_HK: TLabel;
    Lb_Jhr: TLabel;
    Lb_Jhr_: TLabel;
    Lb_Lamda: TLabel;
    Lb_Lamda1: TLabel;
    Lb_Lam_G: TLabel;
    Lb_Lam_G1: TLabel;
    Lb_Lam_R: TLabel;
    Lb_Lam_R1: TLabel;
    Lb_MEZ: TLabel;
    Lb_MEZ_: TLabel;
    Lb_Min_1: TLabel;
    Lb_Min_2: TLabel;
    Lb_MngMswg: TLabel;
    Lb_MngMswg_: TLabel;
    Lb_Mon: TLabel;
    Lb_Mon_: TLabel;
    Lb_Mswg: TLabel;
    Lb_Mswg1: TLabel;
    Lb_Mswg1_: TLabel;
    Lb_Nr: TLabel;
    LB_OtZ: TLabel;
    Lb_OtZ_: TLabel;
    Lb_Rtzn_: TLabel;
    Lb_Rtzn_Grd: TLabel;
    Lb_Rtzn_Rd: TLabel;
    Lb_SK: TLabel;
    Lb_SmrZ: TLabel;
    Lb_SmrZ_: TLabel;
    Lb_StWk: TLabel;
    Lb_StWk_: TLabel;
    Lb_T: TLabel;
    Lb_Day: TLabel;
    Lb_Day_: TLabel;
    Lb_T_: TLabel;
    Lb_UTC1: TLabel;
    Lb_UTC1_: TLabel;
    Lb_UTC2: TLabel;
    Lb_UTC2_: TLabel;
    Lb_Zeit: TLabel;
    Lb_ZW: TLabel;
    Lb_ZW_: TLabel;
    LV_List: TListView;
    MI_DatSchutz: TMenuItem;
    MI_VerbEinst: TMenuItem;
    MI_Connect: TMenuItem;
    MI_Ueber: TMenuItem;
    MI_Such: TMenuItem;
    MI_Anfahren: TMenuItem;
    MI_Connection: TMenuItem;
    MI_StnList: TMenuItem;
    MI_StnList_Load: TMenuItem;
    MI_StnList_Chng: TMenuItem;
    MI_Stn_Rstt: TMenuItem;
    MI_Hilf_Up: TMenuItem;
    MI_Unbe2: TMenuItem;
    Mmo_Bsbg: TMemo;
    MI_Sicht_Exp: TMenuItem;
    MP_Hilf_Off: TMenuItem;
    MI_Hilf_On: TMenuItem;
    MI_Hilf_Feh: TMenuItem;
    M_Stern: TMenuItem;
    M_Sicht: TMenuItem;
    M_Hilf: TMenuItem;
    MnMe: TMainMenu;
    M_Dat: TMenuItem;
    MI_Dar_Quit: TMenuItem;
    MI_Unbek: TMenuItem;
    OpnD: TOpenDialog;
    PgC_Haupt: TPageControl;
    PpNt: TPopupNotifier;
    PpMe: TPopupMenu;
    PpMe2: TPopupMenu;
    SaD: TSaveDialog;
    TbS_Einst: TTabSheet;
    TbS_Inter: TTabSheet;
    TbS_Lag: TTabSheet;
    TbS_StLst: TTabSheet;
    TE_Manu: TTimeEdit;
    Tmr_Nach: TTimer;
    Tmr_Berech: TTimer;
    TgB_AutoWert: TToggleBox;
    Ts_Ephi: TTabSheet;
    procedure Bt_EinstZuRSClick(Sender: TObject);
    procedure Bt_LoListClick(Sender: TObject);
    procedure Bt_ResListClick(Sender: TObject);
    procedure Bt_BebListClick(Sender: TObject);
    procedure Bt_StartClick(Sender: TObject);
    procedure Bt_UpClick(Sender: TObject);
    procedure BBt_AnfahrenClick(Sender: TObject);
    procedure CB_HKEditingDone(Sender: TObject);
    procedure CkB_ManuAnStChange(Sender: TObject);
    procedure CB_StrModeChange(Sender: TObject);
    procedure CkB_Port_AutoChange(Sender: TObject);
    procedure CB_StBEditingDone(Sender: TObject);
    procedure ChkB_TmMdChange(Sender: TObject);
    procedure ChkB_UpChange(Sender: TObject);
    procedure DE_FrhanfAcceptDate(Sender: TObject; var ADate: TDateTime;
      var AcceptDate: Boolean);
    procedure DE_ManuAcceptDate(Sender: TObject; var ADate: TDateTime;
      var AcceptDate: Boolean);
    procedure Ed_Lamda_GEditingDone(Sender: TObject);
    procedure Ed_MgMswgEditingDone(Sender: TObject);
    procedure Ed_NrEditingDone(Sender: TObject);
    procedure Ed_Phi_GEditingDone(Sender: TObject);
    procedure ED_PortEditingDone(Sender: TObject);
    procedure Ed_SuchEditingDone(Sender: TObject);
    procedure Ed_SuchEnter(Sender: TObject);
    procedure Ed_SuchExit(Sender: TObject);
    procedure FndDFind(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LV_ListDblClick(Sender: TObject);
    procedure LV_ListItemChecked(Sender: TObject; Item: TListItem);
    procedure LV_ListKeyPress(Sender: TObject; var Key: char);
    procedure MI_DatSchutzClick(Sender: TObject);
    procedure MI_ConnectClick(Sender: TObject);
    procedure MI_Dar_QuitClick(Sender: TObject);
    procedure MI_Hilf_FehClick(Sender: TObject);
    procedure MI_SuchClick(Sender: TObject);
    procedure MI_UeberClick(Sender: TObject);
    procedure MI_VerbEinstClick(Sender: TObject);
    procedure MP_Hilf_OffClick(Sender: TObject);
    procedure MI_Hilf_OnClick(Sender: TObject);
    procedure MI_Sicht_ExpClick(Sender: TObject);
    procedure TE_ManuAcceptTime(Sender: TObject; var ATime: TDateTime;
      var AcceptTime: Boolean);
    procedure Tmr_BerechTimer(Sender: TObject);
    procedure Tmr_NachTimer(Sender: TObject);
    procedure TgB_AutoWertChange(Sender: TObject);

  {Why are some functions shifted and others are not?
    Well, the project started a longe time ago and had a big break.
    Many functions are basicly out of date and need a review. That are the shifted ones,
    While the none shifted ones are alredy partlay rewritten and mostly dokumented.
    However since the Project get's a new mainform, where these functions arn't needed,
    they will not get updated anymore.
    If you want to do somthing about take a look at the ToDoList (below)
   }

  //Make sure ser is closed and freed in any possible case --> make it a global varible, so finalization works or  use destructor of TFrm_Spori
  {ToDo List:
    Add Compas to charts in (new) main from, so it becomes more clear Up means Up / North and down mean Dorn / South
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

    TODO 02 -oFireInstall -cUser : Shortcuts
    TODO 02 -oFireInstall -cCode : Beschreibung hinzufügen bei Lizenz
    TODO 02 -oFireInstall -cFunc : Sternbildsuche - Liste}

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

    gettext, LazUTF8,
    Classes, SysUtils, FileUtil, Forms, Controls, Graphics, LCLType,
    Dialogs, Menus, StrUtils, StdCtrls, ComCtrls, ActnList, ExtCtrls,
    PopupNotifier, EditBtn, Buttons, math, Types, DateUtils, typinfo,
    LCLTranslator,  //Be carefull, since it adds all kind of number displaying stuff too --> makes messy .po files
    PlanEph, Utils, synaser, Config, SpOri_Main, MultiLangueStrings, GetHotkey;

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


    TArmConnect = class(TThread)
      private
          {Handel for the connecteion to the arduino (Synapser)}
          ser: TBlockSerial;

          {}
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

        procedure Connect ();
        function ReceiveData (): Boolean;

      protected
        procedure Execute; override;
        procedure ShowReceivedData ();

      public
        Constructor Create(const CreateSuspended : boolean = True);
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
        property SendAzimuth: Real read FSendAzimuth write FSendAzimuth;
        property SendElevation: Real read FSendElevation write FSendElevation;
      end;

      { TFrm_Spori }

    TFrm_Spori = class(TForm)
        Bt_Pilot: TBitBtn;
        Bt_LoList: TButton;
        Bt_Pilot_StrLst: TButton;
        BT_Opt_Temp: TButton;
        BT_Main_Temp: TButton;
        CB_HK: TComboBox;
        CB_StrMode: TComboBox;
        CB_StB: TComboBox;
        Ed_Azi_Ist: TEdit;
        Ed_Azi_Soll: TEdit;
        Ed_Egstn: TEdit;
        Ed_Ele_Ist: TEdit;
        Ed_Ele_Soll: TEdit;
        Ed_Mswg: TEdit;
        Ed_Nr: TEdit;
        Ed_Such: TEdit;
        FndD: TFindDialog;
        Gb_Azi: TGroupBox;
        GB_Brg: TGroupBox;
        GB_Brnt: TGroupBox;
        Gb_FrPnk: TGroupBox;
        Gb_Ist: TGroupBox;
        GB_Lage: TGroupBox;
        Gb_Mswg: TGroupBox;
        GB_Soll: TGroupBox;
        Gb_Wink: TGroupBox;
        Gb_Wink1: TGroupBox;
        GB_Zeit: TGroupBox;
        GB_Zeit1: TGroupBox;
        Lb_FrPnk: TLabel;
        Lb_SmrZ_1: TLabel;
        Lb_SmrZ1: TLabel;
        Lb_Min_: TLabel;
        Lb_Min: TLabel;
        Lb_Az_Grd1: TLabel;
        Lb_El_Grd_: TLabel;
        Lb_Hour_: TLabel;
        Lb_Hour: TLabel;
        Lb_Sek_: TLabel;
        Lb_Sek: TLabel;
        Lb_Grt: TLabel;
        Lb_AkFrPnk: TLabel;
        LbAkFrPnk_: TLabel;
        Lb_Az: TLabel;
        Lb_Az1: TLabel;
        Lb_Azi: TLabel;
        Lb_Az_: TLabel;
        Lb_Az_1: TLabel;
        Lb_Az_N: TLabel;
        Lb_Az_N_: TLabel;
        Lb_Az_Z: TLabel;
        Lb_Az_Z_: TLabel;
        Lb_Beta: TLabel;
        Lb_Beta_: TLabel;
        Lb_Dekli_: TLabel;
        Lb_Dekli_Grd: TLabel;
        Lb_Dekli_Rd: TLabel;
        Lb_Delt: TLabel;
        Lb_Delt_: TLabel;
        Lb_Diff: TLabel;
        Lb_Diff_: TLabel;
        Lb_Egnstn: TLabel;
        Lb_El: TLabel;
        Lb_El1: TLabel;
        Lb_Ele: TLabel;
        Lb_El_: TLabel;
        Lb_El_1: TLabel;
        Lb_FrAnf: TLabel;
        Lb_FrAnf_: TLabel;
        Lb_FrPnk_: TLabel;
        Lb_Lat: TLabel;
        Lb_Lat1: TLabel;
        Lb_Lat_G: TLabel;
        Lb_Lat_G1: TLabel;
        Lb_Lat_R: TLabel;
        Lb_Lat_R1: TLabel;
        Lb_Gmt: TLabel;
        Lb_Gmt_: TLabel;
        Lb_Grd_1: TLabel;
        Lb_Grd_2: TLabel;
        Lb_Grd_3: TLabel;
        Lb_Grd_4: TLabel;
        Lb_Grd_5: TLabel;
        Lb_Grt_: TLabel;
        Lb_GSft: TLabel;
        Lb_GSft_: TLabel;
        Lb_HK: TLabel;
        Lb_Jhr: TLabel;
        Lb_Jhr_: TLabel;
        Lb_Lon: TLabel;
        Lb_Lon1: TLabel;
        Lb_Lon_G: TLabel;
        Lb_Lon_G1: TLabel;
        Lb_Lon_R: TLabel;
        Lb_Lon_R1: TLabel;
        Lb_MEZ: TLabel;
        Lb_MEZ_: TLabel;
        Lb_Min_1: TLabel;
        Lb_Min_2: TLabel;
        Lb_Mon: TLabel;
        Lb_Mon_: TLabel;
        Lb_Mswg: TLabel;
        Lb_Mswg1: TLabel;
        Lb_Mswg1_: TLabel;
        Lb_Nr: TLabel;
        LB_OtZ: TLabel;
        Lb_OtZ_: TLabel;
        Lb_Rtzn_: TLabel;
        Lb_Rtzn_Grd: TLabel;
        Lb_Rtzn_Rd: TLabel;
        Lb_SK: TLabel;
        Lb_StWk: TLabel;
        Lb_StWk_: TLabel;
        Lb_T: TLabel;
        Lb_Day: TLabel;
        Lb_Day_: TLabel;
        Lb_T_: TLabel;
        Lb_UTC1_Val: TLabel;
        Lb_UTC1_Nam: TLabel;
        Lb_UTC2_val: TLabel;
        Lb_UTC2_Nam: TLabel;
        Lb_Zeit: TLabel;
        Lb_ZW: TLabel;
        Lb_ZW_: TLabel;
        LV_List: TListView;
        MI_DatSchutz: TMenuItem;
        MI_Ueber: TMenuItem;
        MI_Such: TMenuItem;
        MI_Anfahren: TMenuItem;
        MI_Connection: TMenuItem;
        MI_StnList: TMenuItem;
        MI_StnList_Load: TMenuItem;
        MI_StnList_Chng: TMenuItem;
        MI_Stn_Rstt: TMenuItem;
        MI_Hilf_Up: TMenuItem;
        MI_Unbe2: TMenuItem;
        Mmo_Bsbg: TMemo;
        MI_Sicht_Exp: TMenuItem;
        MP_Hilf_Off: TMenuItem;
        MI_Hilf_On: TMenuItem;
        MI_Hilf_Feh: TMenuItem;
        M_Stern: TMenuItem;
        M_Sicht: TMenuItem;
        M_Hilf: TMenuItem;
        MnMe: TMainMenu;
        M_Dat: TMenuItem;
        MI_Dar_Quit: TMenuItem;
        MI_Unbek: TMenuItem;
        PgC_Haupt: TPageControl;
        PpNt: TPopupNotifier;
        PpMe: TPopupMenu;
        PpMe2: TPopupMenu;
        TbS_Einst: TTabSheet;
        TbS_Inter: TTabSheet;
        TbS_Lag: TTabSheet;
        TbS_StLst: TTabSheet;
        Tmr_Nach: TTimer;
        Tmr_Berech: TTimer;
        TbS_Ephi: TTabSheet;
        {If this Button was clicked, data wil be sended to the arduino (SendData will be called),
        like Bt_PilotClick (below) but located on the Starlist tab.}
        procedure BT_Main_TempClick(Sender: TObject);
        {If this Button was clicked, data wil be sended to the arduino (SendData will be called)}
        procedure Bt_Pilot_StrLstClick(Sender: TObject);
        {If this Button was clicked, data wil be sended to the arduino (SendData will be called)}
        procedure Bt_PilotClick(Sender: TObject);
        {A new Body was selected, tell it (... will be called)}
        procedure CB_HKEditingDone(Sender: TObject);
        {If a new BodyMode was chosen, tell it everybody}
        procedure CB_StrModeChange(Sender: TObject);
        procedure CB_StBEditingDone(Sender: TObject);
        {If a vailed number was given, ProgressNumber will be called}
        procedure Ed_NrEditingDone(Sender: TObject);
        {If the Text of the Edit was not emty or the default value, search for it}
        procedure Ed_SuchEditingDone(Sender: TObject);
        {Clears the Edit, if the default value was given, should select all text if not}
        procedure Ed_SuchEnter(Sender: TObject);
        {Sets the defaultvalue 'Search for...' if the Edit was emty}
        procedure Ed_SuchExit(Sender: TObject);
        {Opens an FindDialog and searches for the given String in our StarList}
        procedure FndDFind(Sender: TObject);
        {Detect PortableMode and initialize importend global vairiables like the paths.
         And call LoadOptions}
        procedure FormCreate(Sender: TObject);
        {Save the configurations file and  clean up}
        procedure FormDestroy(Sender: TObject);
        {Collect every ne pressed key and add them to the set KeysPressed.
         Also increases KeyCount, wich has a value above 0 as long as some keys are still pressed}
        procedure FormKeyDown(Sender: TObject; var Key: Word; {%H-}Shift: TShiftState
          );
        {If the last key goes up (KeyCount = 0) then the Set KeysPressed, which
         containing all last pressed keys with the Hotkey set. If they are equal
         and UseHotkey is active SendData will be called.
         Therefore it decreases KeyCount ervytime FormKeyUp was called}
        procedure FormKeyUp(Sender: TObject; var {%H-}Key: Word; {%H-}Shift: TShiftState);
        {Just a temporary way to get to the Config form.}
        procedure Lb_ZeitClick(Sender: TObject);
        {If a vailed Item was seleceted tell it (call ProgressList)}
        procedure LV_ListDblClick(Sender: TObject);
        {A vailed Item was seleceted, tell it (call ProgressList)}
        procedure LV_ListItemChecked(Sender: TObject; Item: TListItem);
        {If Retun was pressed and a vailed Item was seleceted tellwhitch one (call ProgressList)}
        procedure LV_ListKeyPress(Sender: TObject; var Key: char);
        {Bring the user to the conncetion configuration page}
        procedure MI_ConnectionClick(Sender: TObject);
        {Get privacy informations}
        procedure MI_DatSchutzClick(Sender: TObject);
        {Halt the app}
        procedure MI_Dar_QuitClick(Sender: TObject);
        procedure MI_Hilf_FehClick(Sender: TObject);
        procedure MI_SuchClick(Sender: TObject);
        procedure MI_UeberClick(Sender: TObject);
        procedure MP_Hilf_OffClick(Sender: TObject);
        procedure MI_Hilf_OnClick(Sender: TObject);
        procedure MI_Sicht_ExpClick(Sender: TObject);
        {calculation Timer, Heart of SpaceOrienter,
         where Star, ehem location calculating is called}
        procedure Tmr_Calc_All(Sender: TObject);
        {Read incomming data from the ArduIno}
        //procedure Tmr_GetDataTimer(Sender: TObject);
        {Follow moving bodys}
        procedure Tmr_Follow(Sender: TObject);
      private
        {Find the Optionsname in a Sting, if there is none then nothig is returned}
        function  FindOptionName (const Line:String):String;
        {Transform the given OptionsName to a String and get rid of starting "ON_"}
        function OptionsEnumToStr(EnumVal: TOptionNames): String;
        {Find the optionsvalue, if there is none then nothig is returned}
        function  FindOptionValue (const Line:String):String;
        {Find the indx of a given option, even if it isn't excaly right.
         If nothing was found -1 is returned.}
        function  GetOptionIndex(const Str: String): ShortInt;
        {Resets the OptionsFile}
        procedure DefaultOptions ();
        {Load Saved Options, if there is no file, create default otions will be created.
         Warning: ervery New Option must loaded here!}
        function  LoadOptions (const LoadFromFile: Boolean = true): Boolean;
        {Looks for a choosen Constellation up, if it is valid}
        function  IsConstellation ():Boolean;
        {platform-independent method to read the language of the user interface
        Taken from: http://wiki.freepascal.org/Everything_else_about_translations
        This dunction limits the app to Linux, Mac and windows, it have to be possible to
        get it working for more OS. Until this was done, En will allways be retuned}
        function  GetOSLanguage (): string;
        {Transfer lon, lat to Rad}
        procedure Angle ();
        {calculate the First Point of Aries}
        procedure ProgressFirstPointOfAries ();
        {calculate the position of the selected star}
        procedure CalculateStarLoc();
        {calculate the position of the selected Ephemedides (PlanEpeh)}
        procedure CalculateEphemerisLoc ();
        {serches for an Item in the StarList}
        procedure searchStarList (SerchFor: String);

        {Try to find all possible ComPorts}
        procedure GetComPorts ();
        var
          {Importend pathes}
          DefaultPath,
          DefaultOptionsPath,
          DefaultOldOptionsPath,
          DefaultListPath,
          DefaultOldListPath: String;
          OwnDir: String;

          {Counts how many keys was pressed at ones.
           Used basicly to determine when the last key goes up}
          KeyCount: byte;
          {Contains the last Keys pressed in a row}
          PressedKeys: Set of byte;

          {boolean to determine if we loaded all Options correctly}
          OptionsLoaded: Boolean;
      public
        {path to the working area of the App, part of the imported pathes}
        property ListPath: String read DefaultListPath;
        property OptionsPath: String read DefaultOptionsPath;
        property OldOptionsPath: String read DefaultOldOptionsPath;

        var
          {importend cofigurations, saved in Options.Space at the end}
          Options: Array[TOptionNames] of String;

          {Diffrence between Now and the DateTime selected by the user
           Time goes on like expected but from point in time choosen by the user}
          DiffD:       TDate;
          DiffT:       System.TTime;  //Don't use Unix TTime
          {Don't save time while it is on change in Frm_config }
          NoEntry:     Boolean;

          {Contains the hotkey(s) as a set, will maybe removed in future}
          HotKey: Set of byte;

        {Does what it say, progress messages until the time is over}
        procedure Delay(Milliseconds: DWORD);

        {Result is the DefaultValue of the given OptionName.
         Warning: every new Option have to be listed here!}
        function  GetDefaultOption (const OptnName: TOptionNames): String;

        {Resets the StarListFile}
        procedure DefaultList ();
        {Load the Starlist by a given path}
        function  LoadStarList (const Path: String): Boolean;
        {Sets the pathes to ProtableMode and back}
        procedure SetPortableMode(IsActive: Boolean);

        {Try to connect to the Arduino via comport}
        function  Connect (TryAll: Boolean = false):Boolean;

        {Tell the forms, if ExpertMode was activated}
        procedure ProgressExpertMode (Save: Boolean = true);
        {Try to tell the Rest of the mainform what star was selecet by a given Number
        (Number is Stored in Ed_Nr)}
        procedure ProgressNumber (Normal:Boolean = true);

        {Update the App; work in progress}
        procedure Update_ ();

        {Sends Data to the Arduino}
        procedure SendData ();

        //Temporary public for new main form
        {Seaches for a given Body in Bodylist}
        function Search4Body (SerchFor: String): TListItem;
        {Try to tell the Rest of the mainform what star was selecet by a given Item}
        procedure ProgressList (const Item:TListItem);
        {Tell the mainform what BodyMode was selected}
        procedure ProgressBodyMode (const Mode: TBodyMode; Save: Boolean = true);
        {Compaires two strings and compute the sameness in percent
        The boolean  does that what it's name say: it determine if StrCompaire is casesensitive}
        function  StrCompaire(str1, str2: String; const CaseSensitive: Boolean = true): Real;
      end;

  var
    Frm_Spori: TFrm_Spori;
    ARMConnection: TArmConnect;

implementation

  {$R *.lfm}

  {TARMConnect}

Constructor TArmConnect.Create (const CreateSuspended : boolean);
  begin
    inherited Create (CreateSuspended); // because this is black box in OOP and can reset inherited to the opposite again...
    FreeOnTerminate := True;

    ser := TBlockSerial.Create;

    SendAzimuth       := -404;
    SendElevation     := -404;
    FReceiveAzimuth   := 0;
    FReceiveElevation := 0;
    Port              := '';
    BaudRate          := 9600;

    FConnectionStatus := false;
    NewConnect        := false;
  end;

Destructor TArmConnect.Destroy (); //Done
  begin
    if Assigned(ser) then
      begin
        //If the buffer was not emty
        if (ser.WaitingData > 0) or (ser.CanRead(0)) then
          //Clear buffer
          ser.Purge;

        //close conncetion and free memory (importend, without you can't connect again, until next restart)
        ser.CloseSocket;
        ser.Free;
      end;

    inherited Destroy ();
  end;

procedure TArmConnect.Connect (); //ToDo: Detect Arduinotype (and if it is the Spori)
  begin
    //Close Connection if there is one
    if (ser.InstanceActive) then
      begin
         ser.CloseSocket;

        //empty all buffers
        ser.Purge;
      end;

    //Try to connect
    ser.Connect(Port);
    Sleep(700);

    if ser.InstanceActive then
      begin
        //configure
        ser.config(BaudRate, 8, 'N', SB1, False, False); //Is this nessesaryfor ervery connection?
        Sleep(500);
      end
    else //Didn't worked
      ser.CloseSocket;
  end;

procedure TArmConnect.ShowReceivedData (); //Done
  var
    EleStr, AziStr: String;
  begin
    if IsConnected then
      begin
        //Get norm strings
        AziStr := FloatToStrF(FReceiveAzimuth, ffFixed, 3, 2);
        EleStr := FloatToStrF(FReceiveElevation, ffFixed, 3, 2);

        //Show the value on old Mainform
        with Frm_Spori do
          begin
            Ed_Azi_Ist.Text := AziStr;
            Ed_Ele_Ist.Text := EleStr;
          end;

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
  end;

function TArmConnect.ReceiveData (): Boolean; //Done
  var
    StrIn, StrVal: String;
    BeginPos, Endpos: Byte;
  begin
    //Clear buffer if too much ingoing Data is waiting
    //That are old values and wie don't need them.
    if (ser.WaitingDataEx > 3) then
      begin
        ser.Purge;
        Sleep(50);
      end;

    //If the Buffer was not emty in the next 100 milli secounds
    if ser.CanRead(100) then
      begin
        //Get new Data
        StrIn := ser.Recvstring (20);

        //Make sure we can find the given floats
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
      end;
  end;

procedure TArmConnect.Execute;
  begin
    if (not Terminated) and (NewConnect or (Reconnect and not IsConnected)) then
       Connect ();

    FConnectionStatus :=  ser.InstanceActive;

    if (not Terminated) and IsConnected then
      begin
        if (SendAzimuth <> -404) and (SendElevation <> -404) then
          ;

        //If we got vailid input
        if ReceiveData () then
          //Give the new Data to the main thread
          Synchronize(@ShowReceivedData);
      end;
  end;



  { Frm_Spori }

function  TFrm_Spori.StrCompaire (str1, str2: String; const CaseSensitive: Boolean = true): Real;  //ToDo: find offset of missing parts
  type
    TCharList = Record
      Chara: UniCodeChar;
      Count: Integer;
     end;

function TFrm_Spori.Gleiche (str1, str2: string): Real;  inline; //Fertig?
  var
     NumberofChar1, NumberofChar2: Array of TCharList;
     Index, Index2, variMin, variMax, variGleich,variGleich2: Integer;
     Found: Boolean;

  begin
    variMax:= Max(Length(str1), Length(str2));
    variMin:= Min(Length(str1), Length(str2));
    variGleich :=-1;
    variGleich2:=0;

    Maxlength   := Max(Length(str1), Length(str2));
    MinLength   := Min(Length(str1), Length(str2));

    if not CaseSensitive  then
      begin
       Str1 := AnsiLowerCase(Str1);
       Str2 := AnsiLowerCase(Str2);
      end;


    if (str1 <> '') and (str2 <> '') and (MinLength >= 3) then
      begin
        if Str1 = Str2 then
          begin
            result:=100;
            Exit;
           end;

        for Index := 0 to variMax do
          begin
            if Index > variMin then
               break;

             if str1[Index] = str2[Index] then
               Inc(variGleich)
           end;

        //look for same chararkters around of i
        //SameChar samechar will be diveded by 4 so if the char appiers 2 places away it's just 1/4 of the same place
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
            Found:=false;
            for Index:= 0 to length(NumberOfChar1)-1 do
              begin
                if Str1[1] = NumberofChar1[Index].Chara then
                  begin
                    Found:= true;
                    Inc(NumberOfChar1[Index].Count);
                   end;
                end;
            if not Found then
              begin
                setlength(NumberofChar1,length(NumberofChar1)+1);
                NumberOfChar1[length(NumberOfChar1)-1].Chara:=Str1[1];
                NumberOfChar1[length(NumberOfChar1)-1].Count:=1;
              end;
            Delete(Str1,1,1);
           end;

        //count number of different chars in Str2
        for j := low(Str2) to high(Str2) do
          begin
            Found:= false;
            for Index:= 0 to length(NumberOfChar2)-1 do
              begin
                if Str2[1] = NumberofChar2[Index].Chara then
                  begin
                    Found:= true;
                    Inc(NumberOfChar2[Index].Count);
                   end;
                end;

            if not Found then
              begin
                setlength(NumberofChar2,length(NumberofChar2)+1);
                NumberOfChar2[length(NumberOfChar2)-1].Chara:=Str2[1];
                NumberOfChar2[length(NumberOfChar2)-1].Count:=1;
              end;
            Delete(Str2,1,1);
           end;

        //Do the found chars appear as often as in both strings?
        for i := 0 to high(NumberofChar1) do
          for j := 0 to high(NumberofChar2) do
            if NumberOfChar1[i].Chara = NumberOfChar2[j].Chara then
              if NumberOfChar1[i].Count = NumberOfChar2[j].Count then
                Inc(SaneNrChr);

       VariMin:= Max(length(NumberOfChar1),length(NumberOfChar2));
       end;

    if SaneNrChr > 0 then
      Result := (((SameChar/(Maxlength*4)) * (2/5))  + ((SaneNrChr/MinLength) * (3/5))) * 100
     else
       Result := 0.00;

  end;

function  TFrm_Spori.FindOptionName (const Line: String): String; //Done
  var
    FirstIndx, Length: Integer;
  begin
    FirstIndx := succ(Pos('"', Line));
    Length    := PosEx('"', Line, FirstIndx) - FirstIndx;

function TFrm_Spori.SendData ():Boolean; //ToDo
  begin
    Result:=false;
   end;

function  TFrm_Spori.OptionsEnumToStr(EnumVal: TOptionNames): String; //Done
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

function  TFrm_Spori.FindOptionValue (const Line:String):String; //ToDo: Versioncheck
  var
     Index,Index2:Integer;
     Uebertrag:String;
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

function  TFrm_Spori.GetOptionIndex (const Str: String): ShortInt; //Done
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

procedure TFrm_Spori.GetComPorts (); //ToDo: look Up how Arduino IDE gets the ports
  var
    Ports: TStrings;
    i : integer;
  begin
    //initialize
    Ports := TStringList.create;
    Ports.Clear;
    Ports.Delimiter       := ',';
    Ports.StrictDelimiter := True; // Requires D2006 or newer

       for index:=0 to Stars.count-1 do
         if not (Trim(Stars[index])[1] = '#') or (Trim(Stars[index]) = '') then
           begin
             Help:=Pos(';',Stars[index]);
             Item:=LV_List.Items.Add;
             Item.caption:=Trim(copy(Stars[index],0,Help-1));

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

function  TFrm_Spori.Connect (TryAll: Boolean = false): Boolean; //ToDo: Synapser doesn't find right ports
  var
    Port: String;
    Baud: Integer;
  begin
    //to make sure everything was loaded
    if OptionsLoaded then
      begin
        //Tell the User, we are trying to connect
        with Frm_Config, Frm_Main do
          begin
            ImgLst_UsedPics.GetBitmap(1, Img_Conf_ComState.Picture.Bitmap);
            Lbl_ComMsg.Caption  := MLS_Connecting;

            PgsB_ComCon.Visible := true;
            Lbl_Ardo.Visible    := false;
            Img_UpStatus.AnchorSideTop.Control := PrgrssBr_ComPCon;
          end;

        with Frm_Main do
          begin
            ImgLst_UsedPics.GetBitmap(1, Img_ComState.Picture.Bitmap);
            Lbl_ComState.Caption := MLS_Connecting;

            PrgrssBr_ComPCon.Visible := true;
            Lbl_ArdoType.Visible     := false;
          end;

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
                //Try to connect
                ARMConnection.Port := Port;


               { if (ser.InstanceActive) then
                  begin
                    //We are connected, save the active port
                    Frm_Config.CmbBx_ComPort.Caption := Port;
                    Options[ON_ComPort] := Port;

                    break;
                  end
                else
                  //It didn't worked, try next
                  ser.CloseSocket; }
              end;
          end
        else
          begin
            //Connect to configured port
            //ser.Connect(Frm_Config.CmbBx_ComPort.Caption);
            Delay(700);
            //ser.config(Baud, 8, 'N', SB1, False, False);
            Delay(500);
          end;

        //Set Result to the connections state
        //Result := ser.InstanceActive;
        Result := false;

        with Frm_Config, Frm_Main do
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

         with Frm_Main do
          begin
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
          end;

         //give the forms time to update
         Application.ProcessMessages;

        //Read upcoming data from ArduIno, if connected
        //Tmr_GetData.Enabled := Result;
      end;
  end;

procedure TFrm_Spori.SendData (); //Done?
  var
    PointAsSep: TFormatSettings;
    EleStr, AzStr: String;
  begin
    //Make sure a point was used as decimal separator
    PointAsSep := DefaultFormatSettings;
    PointAsSep.DecimalSeparator := '.';

    //Get values to navigate to
    EleStr := FloatToStrF(Frm_Main.FltSpnEd_EleCalcManu.Value, ffFixed, 3, 5, PointAsSep);
    AzStr  := FloatToStrF(Frm_Main.FltSpnEd_AziCalcManu.Value, ffFixed, 3, 5, PointAsSep);

    //If a Connection is active and stable elevation and azimuth to the ArduIno.
    //if ser.InstanceActive and ser.CanWrite(200) then
    //    ser.SendString(EleStr + ';' + AzStr);

  end;

function  TFrm_Spori.IsConstellation (): Boolean; //Todo: Can get optimized
  var
     Options:TStrings;
     Help:Integer;
     Help_Zeit:TDateTime;
     Uebertrag:String;
     Pruef:Float;
  begin
    Options:=Tstringlist.Create;
    Result:=true;

    // if the choosen Constellation is a valid Constellation and can be found in the starlist
    if (CB_StB.Items.IndexOf(Constellation) >= 0) then
      for i := 0 to LV_List.Items.Count-1 do
        if (Constellation = AnsiLowerCase(LV_List.Items[i].SubItems[2])) then
            exit(true);

   end;

function  TFrm_Spori.LoadStarList (const Path: String): Boolean; //Todo: ErrorCheck; optimize, it takes way to long
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
	 Dec(Index_R);
       until Sortet;

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

    Frm_Main.LV_BodyList.BeginUpdate;
    LV_List.BeginUpdate;

    try
      if not FileExists (DefaultPfad) then
        DefaultOptions();

      //Sort the Numbers, start with the smallest and go to the biggest
      //dont worry about the result of exchange, it will always be true, except somthing goes wrong
      repeat
        Index_R := lengthList - counter - 1;
        Index_L := counter + 1;
        Sortet  := true;

      Assert((Options.Count >= 16),'Fehler in Ladevorgang:' + SlineBreak +
                               'Zu wenig Argumente');

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

      Frm_Main.LV_BodyList.Clear;
      LV_List.Clear;
      CB_HK.Clear;
      CB_StB.Clear;

      //Output of our sorted list into LV_List
      for index:= 0 to lengthList do
        if not ((Trim(Stars[index])[1] = '#') or (Trim(Stars[index]) = '')) then //not a command nor an emty line
          begin
            Beginpos := Pos(';',Stars[index]);
            Item     := LV_List.Items.Add;  //Here we give the pointer of a new item to our local item

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

                if Counter = 1 then     //Output of the Names to  Eintrag Name to Combobox at Mainpage
                  if CB_HK.Items.IndexOf(AnsiLowerCase(Tempproperty)) < 0 then  //if not already a member
                    CB_HK.Items.Add(AnsiLowerCase(Tempproperty));

                if Counter = 3 then  //Output special propertys (like constallation) to another Combobox at Mainpage
                  if CB_StB.Items.IndexOf(AnsiLowerCase(Tempproperty)) < 0 then
                    if (Tempproperty <> '-') and (AnsiLowerCase(Tempproperty) <> 'unsichtbar') and (Tempproperty <> '')then //dont progress meaningless propertys
                      CB_StB.Items.Add(AnsiLowerCase(Tempproperty));
              end;

            Frm_Main.LV_BodyList.Items.Add.Assign(Item);
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
    LV_List.EndUpdate;
    Frm_Main.LV_BodyList.EndUpdate;

    if Assigned(Stars)then
        FreeAndNil(Stars);
  end;

function  TFrm_Spori.GetDefaultOption (const OptnName: TOptionNames): String; //Done?
  begin
    case OptnName of
      ON_Version:       Result := '0.0.0.2';
      ON_PortableMode:  Result := MLS_False;
      ON_ExpertMode:    Result := MLS_False;
      ON_UpdateMode:    Result := '0';
      ON_UpdateRate:    Result := '1';
      ON_UpdateDay:     Result := '6';
      ON_UpdateTime:    Result := '00:00:00';
      ON_UpRetry:       Result := MLS_True;
      ON_Place:         Result := 'Berlin';
      ON_Lon:           Result := '52,345';
      ON_Lat:           Result := '13,604';
      ON_AutoTimeMode:  Result := MLS_True;
      ON_Date:          Result := formatdatetime('dd/mm/yyyy', Now);
      ON_Time:          Result := formatdatetime('hh:nn:ss', Now);
      ON_AutoComMode:   Result := MLS_False;
      ON_ComPort:       Result := 'Com0';
      ON_BaudRate:      Result := '9600';
      ON_AutoValueMode: Result := MLS_True;
      ON_UseHotkey:     Result := MLS_False;
      ON_HotKey:        Result :=  IntToStr(VK_Q);
      ON_BodyMode:      Result := '0';
      ON_Body:          Result := '0';
      ON_Langue:        Result := GetOSLanguage();
    else  //Hint: Forgotten to set a default?
     Result := '';
    end;

  end;

function  TFrm_Spori.LoadOptions (const LoadFromFile: Boolean  = true): Boolean; //ToDo: Version; Chack if Langue was loaded; Comments
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

     function MakeErrorMsg (const Where, Why: String): String; inline;
       begin
         Result :=  Where + '-' + MLS_Error_Loading + ': ' + Why;
       end;

     function ThrowError (const Name: TOptionNames): Boolean;
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

               Result := Result and LoadOptions(false);
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
              Result := ThrowError (On_Langue);
              exit;
            end;

          for j in TOptionNames do
            begin
              case j of
                ON_Version:;// Todo: Convert older Otions to new ones

                ON_PortableMode:
                  if TryStrToBool(Options[j], Tempbool) then
                    begin
                      Frm_Config.Sw_PortableMode.Checked := Tempbool;
                      SetPortableMode(Tempbool);
                    end
                  else
                    ErrorMessage := MakeErrorMsg (OptionsEnumToStr(j), MLS_Error_WrongType);

                ON_ExpertMode:
                  if TryStrToBool(Options[j], Tempbool) then
                    begin
                      MI_Sicht_Exp.Checked := Tempbool;
                      Frm_Config.Sw_Exprt.Checked := Tempbool;

                      ProgressExpertMode(Tempbool);
                    end
                  else
                    ErrorMessage := MakeErrorMsg (OptionsEnumToStr(j), MLS_Error_WrongType);

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
                          ErrorMessage := MakeErrorMsg (OptionsEnumToStr(j), MLS_Error_OutOFRange);
                      end;
                    end
                  else
                    ErrorMessage := MakeErrorMsg (OptionsEnumToStr(j), MLS_Error_WrongType);

                ON_UpdateRate:
                  if TryStrToInt (Options[j], TempInt) then
                    if (TempInt in [0..2]) then
                      Frm_Config.CBx_Rate.ItemIndex := TempInt
                    else
                      ErrorMessage := MakeErrorMsg (OptionsEnumToStr(j), MLS_Error_OutOFRange)
                  else
                    ErrorMessage := MakeErrorMsg (OptionsEnumToStr(j), MLS_Error_WrongType);

                ON_UpdateDay:
                  if TryStrToInt (Options[j], i) then
                    if (TempInt in [0..6]) then
                      Frm_Config.CBx_Tag.ItemIndex := TempInt
                    else
                      ErrorMessage := MakeErrorMsg (OptionsEnumToStr(j), MLS_Error_OutOFRange)
                  else
                    ErrorMessage := MakeErrorMsg (OptionsEnumToStr(j), MLS_Error_WrongType);

                ON_UpdateTime:
                  if TryStrToTime(Options[j], TempTime) then
                    Frm_Config.TE_Plan.Time := TempTime
                   else
                    ErrorMessage := MakeErrorMsg (OptionsEnumToStr(j), MLS_Error_WrongType);

                ON_UpRetry:
                  if TryStrToBool(Options[j], TempBool)then
                   Frm_Config.Sw_Redo.Checked := TempBool
                  else
                    ErrorMessage := MakeErrorMsg (OptionsEnumToStr(j), MLS_Error_WrongType);

                On_Place:
                  begin
                    if (Options[j] = AnsiLowerCase(MLS_None)) then
                      begin
                        //Inc(j);
                        if TryStrToFloat(Options[ON_Lon], TempFloat) then
                          begin
                            Frm_Config.FlSpEd_Lon.Value := TempFloat;
                            Lb_Lon_G.Caption            := Options[ON_Lon];
                            Lb_Lon_G1.Caption           := Options[ON_Lon];
                          end
                        else
                          ErrorMessage := MakeErrorMsg (OptionsEnumToStr(ON_Lon), MLS_Error_WrongType);

                        //Inc(j);
                        if TryStrToFloat(Options[ON_Lat], TempFloat) then
                           begin
                             Frm_Config.FlSpEd_Lat.Value := TempFloat;
                             Lb_Lat_G.Caption            := Options[ON_Lat];
                             Lb_Lat_G1.Caption           := Options[ON_Lat];
                           end
                        else
                          ErrorMessage := MakeErrorMsg (OptionsEnumToStr(ON_Lat), MLS_Error_WrongType);

                        Frm_Config.CbBx_Ort.Caption := MLS_Unknown;
                        Frm_Main.Lbl_Place_Name.Caption := '-';
                      end
                    else
                      begin
                        //If it is an invailed location an Error is reaised here (may change in future)
                        Temp_Koord                  := Frm_Config.Koordinaten (Options[j]);

                        Frm_Config.FlSpEd_Lon.Value := Temp_Koord.Lon;
                        Lb_Lon_G.Caption            := FloatToStr(Temp_Koord.Lon);
                        Lb_Lon_G1.Caption           := FloatToStr(Temp_Koord.Lon);

                        Frm_Config.FlSpEd_Lat.Value := Temp_Koord.Lat;
                        Lb_Lat_G.Caption            := FloatToStr(Temp_Koord.Lat);
                        Lb_Lat_G1.Caption           := FloatToStr(Temp_Koord.Lat);

                        Frm_Config.CbBx_Ort.Caption := Options[j];

                        //Make the first letter UpperCase
                        TempStr := AnsiUpperCase(String(Options[j][1])) +
                          Copy(Options[j], 2, pred(Length(Options[j])));
                        Frm_Main.Lbl_Place_Name.Caption := TempStr;
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
                  ErrorMessage := MakeErrorMsg (OptionsEnumToStr(j), MLS_Error_WrongType);

                ON_Date:
                  if TryStrToDate(Options[j], TempTime) then
                    begin
                      DiffD                  := TempTime - Date;
                      Frm_Config.DE_Day.Date := Date + DiffD;
                    end
                  else
                    ErrorMessage := MakeErrorMsg (OptionsEnumToStr(j), MLS_Error_WrongType);

                  ON_Time:
                    if TryStrToTime(Options[j], TempTime) then
                      begin
                        DiffT                   := TempTime - Time;
                        Frm_Config.TE_Time.Time := Time + DiffT
                       end
                     else
                      ErrorMessage := MakeErrorMsg (OptionsEnumToStr(j), MLS_Error_WrongType);

                  ON_AutoComMode:
                    if TryStrToBool(Options[j], Tempbool) then
                      begin
                        Frm_Config.Sw_AutoCon.checked :=  Tempbool;

                        if not Tempbool then
                          if TryStrToInt(Options[ON_ComPort], i) then
                            Frm_Config.CmbBx_ComPort.Caption := Options[ON_ComPort];
                        //Inc(j);
                      end
                    else
                      ErrorMessage := MakeErrorMsg (OptionsEnumToStr(j), MLS_Error_WrongType);

                  ON_BaudRate:
                    if TryStrToInt(Options[j], TempInt) then
                      if (Frm_Config.CmbBx_Baud.Items.IndexOf(Options[j]) >= 0) then
                          Frm_Config.CmbBx_Baud.Caption := Options[j]
                      else
                        ErrorMessage := MakeErrorMsg (OptionsEnumToStr(j), MLS_Error_OutOFRange)
                    else
                     ErrorMessage := MakeErrorMsg (OptionsEnumToStr(j), MLS_Error_WrongType);

                  ON_AutoValueMode:
                    if TryStrToBool(Options[j], Tempbool) then
                      Frm_Config.Sw_ManuVal.Checked := not Tempbool
                    else
                     ErrorMessage := MakeErrorMsg (OptionsEnumToStr(j), MLS_Error_WrongType);

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
                     ErrorMessage := MakeErrorMsg (OptionsEnumToStr(j), MLS_Error_WrongType);

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
                                ErrorMessage := MakeErrorMsg (OptionsEnumToStr(On_Hotkey), MLS_Error_OutOFRange);
                                break;
                              end;

                          until (i <= 0);
                        end
                      else
                        Frm_Config.Ed_HtKy.Text := MLS_None;
                    end;


                  ON_BodyMode:
                    if TryStrToInt(Options[j], i) then
                      if (i in [0..pred(Frm_Main.CmbBx_Mode.Items.Count)]) then
                        begin
                          Frm_Main.CmbBx_Mode.ItemIndex := i;

                          ProgressBodyMode(TBodyMode(i), false);
                        end
                      else
                        ErrorMessage := MakeErrorMsg (OptionsEnumToStr(j), MLS_Error_OutOFRange)
                    else
                       ErrorMessage := MakeErrorMsg (OptionsEnumToStr(j), MLS_Error_WrongType);

                  ON_Body:
                    if TryStrToInt (Options[j], i) then
                      begin
                        Ed_Nr.Text := Options[j];
                        Frm_Main.Lbl_Bdy_Nr.Caption := Options[j];
                       end
                     else
                      ErrorMessage := MakeErrorMsg (OptionsEnumToStr(j), MLS_Error_WrongType);
              end; //End case

              if (ErrorMessage <> '') then
                begin
                  Result := ThrowError (j);
                  exit;
                end;
           end;

          if Result then
            begin
              Result := LoadStarList(DefaultListPath);
              ProgressNumber(False);
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

procedure TFrm_Spori.SetPortableMode (IsActive: Boolean); //ToDo: CleanUp after Mode has changed
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
    DefaultOptionsPath    := DefaultPath + PathDelim + 'Options.Space';
    DefaultOldOptionsPath := DefaultPath + PathDelim + 'OldOptions';
    DefaultListPath       := DefaultPath + PathDelim + 'StarList.Space';
    DefaultOldListPath    := DefaultPath + PathDelim + 'OldLists';

    SetCurrentDir(DefaultPath);
  end;

procedure TFrm_Spori.Delay (Milliseconds: DWORD); //Done
  var
    Yet: QWord;
  begin
    //Get time
    Yet := GetTickCount64;

    //while not Milliseconds passed do erverything else
    while (GetTickCount64 < Yet + Milliseconds) and (not Application.Terminated) do//wait until Milliseconds is over
      Application.ProcessMessages; //do erverything else

   end;

procedure TFrm_Spori.DefaultOptions (); //ToDo: put this into it's own File; Multi langue header
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

procedure TFrm_Spori.DefaultList ();  //ToDo: put this into it's own File (english version) --> make versions for different langues
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
      List.Add('4;Alpha Phoenicis;;unsichtbar;Keine;353;13,8;-42;-13,0;');
      List.Add('5;Schedir;Schedir;Kassiopeia;Keine;349;38,1;56;37,6;');
      List.Add('6;Daneb Kaitos;;Walfisch;Keine;348;53,9;-17;-53,8;');
      List.Add('7;Tsi;Cih;Kassiopeia;Keine;345;34,1;60;48,3;');
      List.Add('8;Mirach;Mirach;Andromeda;Keine;342;20,1;35;42,4;');
      List.Add('9;Achernar;Achernar;unsichtbar;Keine;335;25,4;-57;-9,3;');
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
      List.Add('28;Canopus;Canopus;unsichtbar;Keine;263;55,2;52;42,5;');
      List.Add('29;Alena;Alphena;Zwillinge;Tierkreis;260;20,1;16;22,9;');
      List.Add('30;Sirius;Sirius;Grosser Hund;Keine;258;31,9;-16;-44,5;');
      List.Add('31;Adhara;Adora;Grosser Hund;Keine;255;10,9;-28;-59,9;');
      List.Add('32;Wezen;Vezen;Grosser Hund;Keine;252;44,1;-26;-25,4;');
      List.Add('33;Castor;Castor;Zwillinge;Tierkreis;246;5,4;31;50,9;');
      List.Add('34;Prokyon;Procyon;Kleiner Hund;Keine;244;57,6;5;10,8;');
      List.Add('35;Pollux;Pollux;Zwillinge;Tierkreis;243;25,3;27;59,0;');
      List.Add('36;Epsilon Carinae;Epsilon Carinae;unsichtbar;Keine;234;17,1;-59;-33,9;');
      List.Add('37;Lambda Velorum;Alsuhail;unsichtbar;Keine;222;50,9;-43;-30,1;');
      List.Add('38;Miaplacidus;Miaplacidus;unsichtbar;Keine;221;39,1;-69;-47,2;');
      List.Add('39;Alphard;Alphard;Wasserschlange;Keine;217;54,1;-8;-43,9;');
      List.Add('40;Regulus;Regulus;Loewe;Tierkreis;207;41,4;11;53,1;');
      List.Add('41;;Nue Carinae;unsichtbar;Keine;199;6,5;-64;-28,9;');
      List.Add('42;Dubhe;Dubhe;Grosser Wagen;Keine;193;49,3;61;39,7;');
      List.Add('43;Denebola;Denebola;Loewe;Tierkreis;182;31,6;14;28,8;');
      List.Add('44;Acrux;Acrux;unsichtbar;Keine;173;6,8;-63;-11,4;');
      List.Add('45;Gamma Crucis;Gamma Crucis;unsichtbar;Keine;171;58,5;-57;-12,3;');
      List.Add('46;Beta Crucis;Beta Crucis;unsichtbar;Keine;167;49,4;-59;-46,7;');
      List.Add('47;Alioth;Alioth;Grosser Wagen;Keine;166;19,0;55;52,3;');
      List.Add('48;Vindemiatrix;Vindemiatrix;Jungfrau;Tierkreis;164;15,1;10;52,3;');
      List.Add('49;Mizar;Mizar;Grosser Wagen;Keine;158;51,4;54;50,5;');
      List.Add('50;Spica;Spica;Jungfrau;Tierkreis;158;29,1;-11;-14,7; ');
      List.Add('51;Benetnash;Benetnasch;Grosser Wagen;Keine;152;57,4;49;14,0;');
      List.Add('52;Agena;Agena;unsichtbar;Keine;148;44,8;-60;-27,0;');
      List.Add('53;Nu Centauri;Nue Centauri;unsichtbar;Keine;148;5,1;-36;-26,9;');
      List.Add('54;Arktur;Arcturus;Baerenhueter;Keine;145;53,9;19;5,9;');
      List.Add('55;Toliman;Toliman;unsichtbar;Keine;139;48,8;-60;-54,0;');
      List.Add('56;Izar;Epsilon Bootis;Baerenhueter;Keine;138;34,5;27;0,5;');
      List.Add('57;Zuben-el-tschenubi;Zubeneigenubi;Waage;Tierkreis;137;3,1;-16;-6,4;');
      List.Add('58;Kochab;Kochab;Kleiner Wagen;Keine;137;20,3;74;5,4;');
      List.Add('59;Zuben-el-schemali;Zubeneschemali;Waage;Tierkreis;130;31,6;-9;-26,4;');
      List.Add('60;Gemma;Alphecca;Noerdliche Krone;Keine;126;9,3;26;39,7;');
      List.Add('61;Unukalhai;Unuk;Schlange;Keine;123;43,8;6;22,6;');
      List.Add('62;Antares;Antares;Skorpion;Tierkreis;112;23,7;-26;-27,9;');
      List.Add('63;Atria;Atria;unsichtbar;Keine;107;23,7;-69;-3,2;');
      List.Add('64;Eta Scorpii;Eta Scorpii;unsichtbar;Keine;107;11,6;-34;-19,1;');
      List.Add('65;Shaula;Shaula;Skorpion;Tierkreis;96;19,1;-37;-6,7;');
      List.Add('66;Ras Alhague;Ras Alhagus;Schlangentraeger;Keine;96;4,5;12;33,1;');
      List.Add('67;Jabbha;Nue Scorpii;Skorpion;Tierkreis;95;22,5;-43;-0,3;');
      List.Add('68;Eltanin;Eltanin;Drache;Keine;90;45,2;51;29,4;');
      List.Add('69;Kaus Australis;Kau Australis;Schuetze;Tierkreis;83;41,1;-34;-22,4;');
      List.Add('70;Wega;Wega;Leier;Keine;80;37,6;38;48,1;');
      List.Add('71;Nunki;Nunki;Schuetze;Tierkreis;75;55,8;-26;-16,4;');
      List.Add('72;Atair;Atair;Adler;Keine;62;6,2;8;54,9;');
      List.Add('73;Peacock;Peacock;unsichtbar;Keine;53;16,1;-56;-40,7;');
      List.Add('74;Deneb;Deneb;Schwan;Keine;49;30,0;45;20,5;');
      List.Add('75;Alderamin;Alderamin;Kepheus;Keine;40;15,2;62;39,4;');
      List.Add('76;Enif;Enif;Pegasus;Keine;33;45,1;9;57,1;');
      List.Add('77;Al Nair;Al Nair;unsichtbar;Keine;27;41,2;-46;-52,8;');
      List.Add('78;Beta Gruis;Beta Gruis;unsichtbar;Keine;19;5,5;-46;-47,9;');
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

procedure TFrm_Spori.ProgressBodyMode (const Mode: TBodyMode; Save: Boolean = true); //ToDo: implement search

  begin
    if Save then  //if a new Mode was seleced save it
      Options[ON_BodyMode] := IntToStr(Ord(Mode));

    CB_StrMode.ItemIndex := Ord(Mode);
    Frm_Main.CmbBx_Mode.ItemIndex := Ord(Mode);

    //Old; Multi langue will not be supported (but somewhere this information will still be placed...)
    case Mode of
      BMd_Normal:
        begin
          Mmo_Bsbg.Text    := 'Peilt den ausgewählten Himmelskörper / die ausgewählte Position an.';
          Tmr_Nach.Enabled := false;
         end;
      BMd_Follow:
        begin
          Mmo_Bsbg.Text    := 'Peilt den ausgewählten Himmelskörper an und verfolgt diesen auf dem Himmel';
          Tmr_Nach.Enabled := true;
         end;
      BMd_Scan:
        begin
          Mmo_Bsbg.Text    := 'Sobald ein Himmelsköper (manuell) angestuert wurde, wird er identifiziert.';
          Tmr_Nach.Enabled := false;
         end;
      BMd_Place:
        begin
          Mmo_Bsbg.Text    := 'Gibt den eigenen Ort aus. '+#10+'Hierzu muss ein Himmelskörper angesteuert und richtig benannt werden.';
          Tmr_Nach.Enabled := false;
         end;
      BMd_Time:
        begin
          Mmo_Bsbg.Text    := 'Gibt die aktuelle Zeit aus. '+#10+'Hierzu muss ein Himmelskörper angesteuert und richtig benannt werden.';
          Tmr_Nach.Enabled := false;
         end;
      BMd_Constellation:
        begin
          if IsConstellation () then
            begin
              Mmo_Bsbg.Text    := 'Fährt ein Sternbild nach und verfolgt dieses.';
              Tmr_Nach.Enabled := true;
             end
           else
             ProgressBodyMode(BMd_Normal);
        end;
      BMd_Search:
        ProgressBodyMode(BMd_Normal);
     else
      begin
        raise Exception.Create('Fehler in Change-Mode-Vorgang: Unbekannter Mode:' + IntToStr(Ord(Mode)));
        Mmo_Bsbg.Text := 'Error';
       end;
     end;
   end;

procedure TFrm_Spori.ProgressExpertMode (Save:Boolean = True); //ToDo: sepperate expert options in config; comments; dynamic width
  begin

    if Save then
      Options[ON_ExpertMode] := BoolToStr(MI_Sicht_Exp.checked, MLS_True, MLS_False);


    if  MI_Sicht_Exp.Checked then
      begin
        Frm_Config.Sw_Exprt.Checked := true;

        TbS_Lag.TabVisible          := true;
        TbS_Ephi.TabVisible         := true;

        LV_List.Column[0].Width     := 60;
        LV_List.Column[0].Caption   := MLS_NumberShort;
        LV_List.Column[1].Width     := 125;
        LV_List.Column[2].Width     := 110;
        LV_List.Column[3].Width     := 110;
        LV_List.Column[4].Width     := 120;
        LV_List.Column[5].Width     := 50;
        LV_List.Column[6].Width     := 70;
        LV_List.Column[7].Width     := 50;
        LV_List.Column[8].Width     := 70;

        LV_List.Column[5].Visible   := true;
        LV_List.Column[6].Visible   := true;
        LV_List.Column[7].Visible   := true;
        LV_List.Column[8].Visible   := true;
       end
     else
       begin
         Frm_Config.Sw_Exprt.Checked := false;

         TbS_Lag.TabVisible          := false;
         TbS_Ephi.TabVisible         := false;

         LV_List.Column[0].Width     := 110;
         LV_List.Column[0].Caption   := MLS_NumberLong;
         LV_List.Column[1].Width     := 180;
         LV_List.Column[2].Width     := 150;
         LV_List.Column[3].Width     := 160;
         LV_List.Column[4].Width     := 170;
         LV_List.Column[5].Visible   := false;
         LV_List.Column[6].Visible   := false;
         LV_List.Column[7].Visible   := false;
         LV_List.Column[8].Visible   := false;
        end;
   end;

procedure TFrm_Spori.ProgressList (const Item: TListItem); //ToDo: Test if the Item is vailed (mainpage); Commend what the subitems mean; Test for vailed Number
  var
     TestFloat: Float;
     i: Integer;

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
    Options[ON_Body] := Item.Caption; //Save the current item as seleced

    for i := 0 to LV_List.Items.Count-1 do  //Uncheck all the other items (remenber both Lists have to be exacly the same)
      if not (LV_List.Items[i] = Item) then
        begin
          LV_List.Items[i].Checked := false;
          Frm_Main.LV_BodyList.Items[i].Checked := false;
        end;
    //note: this should just check the Item of the  current used list
    Item.Checked   := true;  //and check the current one

    //Tell the mainpage what item was selected

    Ed_Nr.Text     := Item.Caption;
    CB_HK.caption  := Item.SubItems[0];
    CB_StB.caption := Item.SubItems[2];
    Ed_Egstn.Text  := Item.SubItems[3];
    with Frm_Main do
      begin
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
            if Lbl_BdyPrpty_Val1.Visible and (Item.SubItems[3] = 'Keine') then
              Visible := false
            else
              Visible := true;

            caption := Item.SubItems[3];
          end;
      end;


    if not (AnsiLowerCase(Item.SubItems[0]) = 'ruheposition') and  //Try to tell Star calculate page where to find the star
       not (AnsiLowerCase(Item.SubItems[3]) = 'ephemeride' ) then
      begin
        if TryStrToFloat (Item.SubItems[4], TestFloat) then
          Lb_Rtzn_Grd.Caption := Item.SubItems[4]
         else
          if ProgressError ('4', Item.SubItems[4]) then
            exit;

        if TryStrToFloat (Item.SubItems[5], TestFloat) then
          Lb_Rtzn_Rd.Caption := Item.SubItems[5]
         else
          if ProgressError ('5', Item.SubItems[5]) then
            exit;

        if TryStrToFloat (Item.SubItems[6], TestFloat) then
          Lb_Dekli_Grd.Caption := Item.SubItems[6]
         else
          if ProgressError ('6', Item.SubItems[6]) then
            exit;

        if TryStrToFloat (Item.SubItems[7], TestFloat) then
          Lb_Dekli_Rd.Caption := Item.SubItems[7]
         else
          if ProgressError ('7', Item.SubItems[7]) then
            exit;
      end
     else
      if (AnsiLowerCase(Item.SubItems[0]) = 'ruheposition') then //if it's not a star but the restposition set lon and lat to 89.
        begin
          Ed_Ele_Soll.Text := '89';
          Ed_Azi_Soll.Text := '89';

          with Frm_Main, DefaultFormatSettings do
            begin
              SetShapePos (ShpN_EleCalc, 89.999);
              SetShapePos (ShpN_AziCalc, 89.999);

              FltSpnEd_EleCalcManu.Value := 89.999;
              FltSpnEd_AziCalcManu.Value  := 89.999;

              Lbl_EleCalc_Val.Caption := '89' + DecimalSeparator + '99';
              Lbl_AziCalc_Val.Caption := '89' + DecimalSeparator + '99';
            end;
         end;
   end;

procedure TFrm_Spori.ProgressNumber (Normal: Boolean = true); //ToDo: Errorhandeling if the Item doesnt exits
  var
     Item: TListItem;
  begin
    // Find The the ithem that is conneceted with the Number of ED_Nr
    Item := LV_List.Items.FindCaption(0, IntToStr(StrToInt(Ed_Nr.Text)), false, false, true);

    if Ed_Nr.Text = '0' then //Somehow FindCaption doen't find the first Item.
      Item := LV_List.Items[0];

    if Assigned(Item) then // if a valid Item was found tell it
      begin
        //Saves also the number
        ProgressList (Item);

        if (CB_StrMode.ItemIndex = 5) and Normal then //reset BodyMode
          ProgressBodyMode (BMd_Normal);
      end
     else; //Errorhandeling
   end;

procedure TFrm_Spori.Update_ (); //ToDo
  begin

  end;

function  TFrm_Spori.GetOSLanguage (): string;
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
    GetLanguageIDs(l, fbl);
    {$ENDIF}
    Result := 'de';
    //Result := fbl;
  end;

procedure TFrm_Spori.Angle (); //ToDo: Comments
  var
     TempStr: String;
  begin
    TempStr           := FloatToStr(StrToFloat(Lb_Lon_G.Caption) * Pi /180);
    Lb_Lon_R.Caption  := TempStr;
    Lb_Lon_R1.Caption := TempStr;

    TempStr           := FloatToStr(StrToFloat(Lb_Lat_G.Caption) * Pi / 180);
    Lb_Lat_R.Caption  := TempStr;
    Lb_Lat_R1.Caption := TempStr;
  end;

procedure TFrm_Spori.ProgressFirstPointOfAries (); //Done
  var
     Void, Year, Hour, Minute, Second: word;
     TempTime: Real;
  begin
    //Begin of Spring at configurated time
    DecodeDate(StrToDateTime(Lb_MEZ.Caption), Year, Void, Void);
    Lb_FrAnf.caption := '22.03.' + IntToStr(Year);

    //Differenz between GMT and begin of Spring
    TempTime        := StrToDateTime(Lb_Gmt.caption) - StrToDateTime(Lb_FrAnf.caption); ;
    Lb_Diff.caption := FloatToStrF(TempTime, ffFixed, 4, 13);

    //Differenz in ° per year
    TempTime        *=  360/365.25;
    Lb_GSft.caption := FloatToStrF(TempTime, ffFixed, 4, 13);

    //calculate the position of the first point of Aries
    DecodeTime(StrToDateTime(Lb_Gmt.Caption), Hour, Minute, Second, Void);
    TempTime        := (Hour * 15) + TempTime + 179.928333;

    while (TempTime > 360) do
      TempTime -= 360;

    Lb_FrPnk.caption := FloatToStrF(TempTime, ffFixed, 4, 13);

    TempTime := Minute * 15/60 + Second * 15/3600 + StrToFloat(Lb_FrPnk.caption);
    while (TempTime > 360) do
      TempTime -= 360;

    Lb_AkFrPnk.caption := FloatToStrF(TempTime, ffFixed, 4, 13);

    //TimeAngle
    Lb_ZW.Caption    := FloatToStrF((Minute * 15/60 + Second * 15/3600), ffFixed, 4, 13);

  end;

procedure TFrm_Spori.CalculateStarLoc ();  //ToDo: comments
  var
    Lon_G: Real;
    Lat_R: Real;
    Rtzn_Grd, Rtzn_Rd: Real;
    Dekli_Grd, Dekli_Rd: Real;
    AkFrPnk: Real;
    StWk: Real;
    Beta, Delta: Real;
    Grt, T: Real;
    Ele, Azimuth: Real;
    Az_Z, Az_N: Real;
  begin     ;
    Lon_G     := StrToFloat(Lb_Lon_G.Caption);
    Lat_R     := StrToFloat(Lb_Lat_R.caption);

    Rtzn_Grd  := StrToFloat(Lb_Rtzn_Grd.Caption);
    Rtzn_Rd   := StrToFloat(Lb_Rtzn_Rd.caption);

    Dekli_Grd := StrToFloat(Lb_Dekli_Grd.caption);
    Dekli_Rd  := StrToFloat(Lb_Dekli_Rd.caption);

    AkFrPnk   := StrToFloat(Lb_AkFrPnk.caption);

    StWk      := Rtzn_Grd + Rtzn_Rd/60;

    Beta      := StWk * Pi/180;

    Delta     := (Dekli_Grd + Dekli_Rd/60) * Pi/180;

    Grt       := AkFrPnk + StWk;
    if (Grt > 360) then
      Grt -= 360;

    T := Grt + Lon_G;
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

    Lb_Beta.Caption := FloatToStrF(Beta, ffFixed, 4, 13);
    Lb_Delt.caption := FloatToStrF(Delta, ffFixed, 4, 13);
    Lb_StWk.caption := FloatToStrF(StWk, ffFixed, 4, 13);
    Lb_Grt.caption  := FloatToStrF(Grt, ffFixed, 4, 13);
    Lb_T.caption := FloatToStrF(T, ffFixed, 4, 13);

    Lb_Az_Z.Caption := FloatToStrF(Az_Z, ffFixed,4,13);
    Lb_Az_N.Caption := FloatToStrF(Az_N, ffFixed, 4, 13);

    Lb_El.caption := FloatToStrF(Ele, ffFixed, 4, 11);
    Lb_Az.caption:=FloatToStrF(Azimuth, ffFixed, 4, 11);


    if not (Frm_Config.Sw_ManuVal.Checked) and not (AnsiLowerCase(CB_HK.caption) = 'ruheposition') then
      begin
        Ed_Ele_Soll.text := FloatToStrF(Ele, ffFixed, 3, 3);
        Ed_Azi_Soll.text := FloatToStrF(Azimuth, ffFixed, 3, 3);

        with Frm_Main do
          begin
            SetShapePos (ShpN_EleCalc, Ele);
            SetShapePos (ShpN_AziCalc, Azimuth);

            FltSpnEd_EleCalcManu.Value := Ele;
            FltSpnEd_AziCalcManu.Value  := Azimuth;

            Lbl_EleCalc_Val.Caption := FloatToStrF(Ele, ffFixed, 3, 2);
            Lbl_AziCalc_Val.Caption := FloatToStrF(Azimuth, ffFixed, 3, 2);

          end;
      end;
  end;

procedure TFrm_Spori.CalculateEphemerisLoc (); //ToDo: Comments; clean up
  var
     Lon, Lat, TZ, xp, yp, dut1, hm, tc, pm, rh, wl: Real;
     ra, rb: Double;
     Body: Integer;
     UTC1, UTC2: Real;

     Ele, Azi: Real;
  begin
    TZ := GetLocalTimeOffset() div -60;

    Lon := Frm_Config.FlSpEd_Lon.Value; // Positive eastward
    Lat := Frm_Config.FlSpEd_Lat.Value; // Positive northward

    // better 50?
    hm := 100; // hight (meters) Used with topocentric frames to apply diurnal aberration.

    Tz  := GetLocalTimeOffset() div -60; //Difference beteween system time and UTC

    xp     := 0.20937;    // The x offset of the terrestrial pole. Used to apply polar motion. From www.iers.org bulletin service
    yp     := 0.34715;    // The y offset From www.iers.org bulletin service
    dut1   := 0.055836;   // Difference between UTC and UT1. It can only be obtained by a bulletin service From www.iers.org bulletin service

    tc  := 20.0;        // Temperature (celcius)
    pm  := 1000.0;      // Pressure (milibars)
    rh  := 0.5;         // Relative Humidity (percent [fractional])
    wl  := 0.55;        // Wavelength (micrometers)
    RefractionAB(pm, tc, rh, wl, ra{%H-}, rb{%H-}); //How athmosphare doese change the observation

    Case Trim(AnsiLowerCase(CB_HK.Caption)) of
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

    UTC1 := StrToFloat(Lb_UTC1_Val.Caption);
    UTC2 := StrToFloat(Lb_UTC2_Val.Caption);

    Ele := Ephem(0, FR_ICRS, Body, GV_ELEVATION, AD_LIGHTTIME, UTC1,  UTC2,
           Lon, Lat, TZ, xp, yp, dut1, hm, ra, rb);
    Azi := Ephem(0, FR_ICRS, Body, GV_AZIMUTH, AD_LIGHTTIME, UTC1,  UTC2,
           Lon, Lat, TZ, xp, yp, dut1, hm, ra, rb);

    Lb_El1.Caption   := FloatToStrF(Ele, ffFixed, 3, 5);
    Ed_Ele_Soll.Text := FloatToStrF(Ele, ffFixed, 3, 3);

    Lb_Az1.Caption   := FloatToStrF(Azi, ffFixed, 3, 5);
    Ed_Azi_Soll.Text := FloatToStrF(Azi, ffFixed, 3, 3);

    with Frm_Main do
      begin
        SetShapePos (ShpN_EleCalc, Ele);
        SetShapePos (ShpN_AziCalc, Azi);

        FltSpnEd_EleCalcManu.Value := Ele;
        FltSpnEd_AziCalcManu.Value := Azi;

        Lbl_EleCalc_Val.Caption := FloatToStrF(Ele, ffFixed, 3, 2);
        Lbl_AziCalc_Val.Caption := FloatToStrF(Azi, ffFixed, 3, 2);
      end;

   end;

function  TFrm_Spori.Search4Body (SerchFor: String): TListItem;  //ToDo: Comments; better error handleling
  var
    i, j: Integer;
    sameness: Real = -1;
    TempSameness: Real;
  begin
    Result := LV_List.Items.FindCaption(0, SerchFor, false, false, true);

    if Assigned (Result) then
        LV_List.Selected := Result
    else
      if SerchFor = '0' then
        begin
          LV_List.Selected := LV_List.Items[0];

         Result := LV_List.Items[0];
        end
    else
      for i := 0 to LV_List.Items.Count-1 do
        for j := 0 to Lv_List.Items[i].SubItems.Count-1 do
          begin
            TempSameness :=  StrCompaire (SerchFor, LV_List.Items[i].SubItems[j], false);

            if (TempSameness >= 60) and (TempSameness > Sameness) then
              begin
                LV_List.Selected := LV_List.Items[i];
                Result := LV_List.Items[i];

                //We got a 100% match, skip all the others
                if (TempSameness = 100) then
                  exit;

                Sameness := TempSameness;
              end;
          end;

  end;

procedure TFrm_Spori.searchStarList (SerchFor: String); //ToDo: Comments; ErrorHandeling(Item not Found)
  var
    FoundBody: TListItem;
  begin
    FoundBody := Search4Body(SerchFor);

    if Assigned (FoundBody) then
      begin
        LV_List.Selected := FoundBody;
        PgC_Haupt.TabIndex := 1;
        LV_List.SetFocus;
        LV_List.ItemFocused := FoundBody;
        LV_List.Items[FoundBody.Index].MakeVisible(false);
       end
    else
     ;
  end;

procedure TFrm_Spori.Ed_NrEditingDone (Sender: TObject); //Done
  var
    Void: integer;
  begin
    {$IfNDef Window} //Since NumbersOnly is not working on my Kubuntu, I have to test this condition on my own, but on Win 7 it acts as expected
    Ed_Nr.Text := Trim(Ed_Nr.Text);

    if TryStrToInt(Ed_Nr.Text, Void) then
    {$ENDIF Window}
      ProgressNumber (); //We got a new body, tell it erverbody else
  end;

procedure TFrm_Spori.Ed_SuchEditingDone (Sender: TObject); //Done
  begin
    if not (Ed_Such.Text = MLS_Search_Default) and not (Ed_Such.Text = '') then //if there was input and the input was not empty
      searchStarList (Trim(Ed_Such.Text)) //serch for the input
  end;

procedure TFrm_Spori.Ed_SuchEnter (Sender: TObject);  //Bug SelectAll does not work?
  begin
    if Ed_Such.Text = MLS_Search_Default then
      Ed_Such.Clear  //nothing was typed yet, so clear up the default value
     else
      begin
        Ed_Such.SetFocus;
        Ed_Such.HideSelection := false;
        Ed_Such.SelectAll;  //should select the last typed text.. but it doesn't work. nether do the following ones, with or whithout autoselect

        //Ed_Such.SelStart := 0;
        //Ed_Such.SelLength := 2;
        //Ed_Such.SelText := Ed_Such.Text;
      end;
  end;

procedure TFrm_Spori.Ed_SuchExit (Sender: TObject);  //Done
  begin
    if (Ed_Such.Text = '') then
      Ed_Such.Text  := MLS_Search_Default;
  end;

procedure TFrm_Spori.FndDFind (Sender: TObject); //ToDo: move Connect to LoadOptions and use Connact to all just if no vailid port was found; Update
  var
     SearchForStr: String;
  begin
    //Opens FindDialog ang get String that was searched for
    SearchForStr := FndD.FindText;

    //make sure case matters as much as the user wants
    if (frDisableMatchCase in FndD.Options) then
      SearchForStr := AnsiLowerCase(SearchForStr);

    //clean up
    FndD.CloseDialog;

    //serch for the given string
    searchStarList(SearchForStr);
  end;

procedure TFrm_Spori.FormCreate (Sender: TObject); //Done?
  begin
    //initialize
    OwnDir :=  ExtractFilePath(ParamStrUTF8(0));
    //old way:
    //OwnDir := GetCurrentDir();

    //initialize Hotkey
    KeyCount    := 0;
    PressedKeys := [];
    HotKey      := [];

    //Make sure these Forms are already created when LoadOptions was called
    Application.CreateForm(TFrm_Config, Frm_Config);
    Application.CreateForm(TFrm_Main, Frm_Main);
    Application.CreateForm(TFrm_GetHotKey, Frm_GetHotKey);

    //Display everything in the OS langue until a choosen langue was loaded
    SetDefaultLang(GetOSLanguage());

    //Tell LoadOptions to try to load from portable file if it exits
    SetPortableMode(FileExists(GetCurrentDir + PathDelim + 'Options.Space'));

    //Load config file
    OptionsLoaded := LoadOptions();

    if not OptionsLoaded then //was not able to load the config flie -> clean up
      Halt;

    //Search for commports and try to connect
    GetComPorts ();
    Connect (true);

    //Search for commports and try to connect
    GetComPorts ();
    Connect (true);

    { if ChkB_Up.Checked then
      Update_ (); }

    //after erverything was loaded fine we can start to calculate star/Ehemedides positions
    Tmr_Berech.Enabled := true;

    PgC_Haupt.TabIndex := 0; //Well basicky this is a line for development versions, if the form was compiled with open mainpage, as it should in realese versions, we can make it a comment
  end;

procedure TFrm_Spori.FormDestroy (Sender: TObject);   //Version Dynamic; Comments
  var
     NotGottenOptions: set of byte = [0..Ord(high(ToptionNames))];
     Line: String;
     OptionName: TOptionNames;
     TempValue: String;

     Index: Integer;
     SaveStrings, LoadStrings: TStringList;
  begin
    EndPlanetEphem();

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
               if not (Trim(Line)[1] = '#') or (Trim(Line) = '')  then  //Skip comments and free lines
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

procedure TFrm_Spori.FormKeyDown(Sender: TObject; var Key: Word; //Done
          Shift: TShiftState);
  begin
    //If we ge a new key and Use Hotkey is active add it to the set.
    if StrToBool(Options[ON_UseHotkey]) and not (Key in PressedKeys) then
      begin
        //Counter to know how many keys are pressed
        Inc(KeyCount);

        Include(PressedKeys, Key);
      end;
  end;

procedure TFrm_Spori.FormKeyUp(Sender: TObject; var Key: Word; //Done
          Shift: TShiftState);
  begin
    //If UseHotkey is active
    if StrToBool(Options[ON_UseHotkey]) then
      begin
        //one button less is pressed
        Dec(KeyCount);

        //if no button is pressed anymore compaire the list of pressed buttons with the hotkey
        if (KeyCount <= 0) then
          begin
            if (PressedKeys = HotKey) then //if they are the same, call Send Data
              SendData ();

            //reset the set, ready for next row
            PressedKeys := [];
          end;
      end;
  end;

procedure TFrm_Spori.Lb_ZeitClick (Sender: TObject); //This is just Temporary!
  begin
    Frm_Spori.Hide;
    Frm_Config.Show;
   end;

procedure TFrm_Spori.LV_ListDblClick (Sender: TObject); //Done?
  begin
    //if an Item was selected, tell it
    if LV_List.SelCount <> 0 then
      ProgressList (LV_List.Selected);
  end;

procedure TFrm_Spori.LV_ListItemChecked (Sender: TObject; Item: TListItem); //Done?
  begin
    // Tell what Item was selected
    ProgressList(Item);
  end;

procedure TFrm_Spori.LV_ListKeyPress (Sender: TObject; var Key: char); //ToDo: Replace with Keydown
  begin
    if ((LV_List.SelCount <> 0) and (Ord(Key) = VK_RETURN)) then
      ProgressList (LV_List.Selected);
  end;

procedure TFrm_Spori.MI_ConnectionClick(Sender: TObject); //ToDo: Remove if new desine is near
  begin
    Frm_Spori.Hide;

    Frm_Config.PgCont_Pnl.ActivePage := Frm_Config.TbSht_Con;
    Frm_Config.Show;
  end;

    procedure TFrm_Spori.MI_DatSchutzClick (Sender: TObject); //ToDo
      begin
        //https://xkcd.com/1998/
        Showmessage('Wir von  FireInstallations möchten der gesammten ' +
                    'Datensammelwut etwas entgegensetzen. ' + //sLineBreak +
                    'Daher sind all unsere Produkte Open Source und nutzen nur ' +
                    'Daten, welche zwingend zur Bereitstellung ' + //sLineBreak +
                    'unserer Dienste notwendig sind. Der Großteil dieser Daten ' +
                    'verbleibt auf deinen Computer und können unter: ' + //sLineBreak +
                    'C:\ProgramData\FireInstallations eingesehen werden. Ein Teil ' +
                    'wird jehdoch zur Bereitstellung unser Onlinedienste ' + //sLineBreak +
                    'an uns übermittelt. Darunter zählt die jehweilige ' +
                    'Versionsnummer der Software und die Einstellungen zu den ' +
                    'Livediesnten.' + sLineBreak +
                    'Keine dieser Daten kann und wird von uns zu anderen Zwecken ' +
                    'eingesehen, editiert oder an dritte weitergegeben werden.' +
                    sLineBreak + sLineBreak +
                    'Wir behalten jehdoch uns vor, diese Richtlinie in Zukunft zu ' +
                    'aktualisieren und gegebendenfalls gesetzlichen Bestimmungen ' +
                    'anzupassen.' + sLineBreak +
                    'In diesem Fall werden wir dich frühzeitig davon in Kenntnis ' +
                    'setzen.');
       end;
      if TgB_AutoWert.Checked then
        SendData ();
   end;

procedure TFrm_Spori.MI_Dar_QuitClick  (Sender: TObject);  //Done
  begin
    //Halt the app
    Halt;
   end;

procedure TFrm_Spori.MI_Hilf_FehClick (Sender: TObject);  //toDo
  begin

   end;

procedure TFrm_Spori.MI_SuchClick (Sender: TObject); //ToDo: Test if there was no Error
  begin
    FndD.FindText := CB_HK.Text;
    FndD.Execute;
   end;

    procedure TFrm_Spori.MI_UeberClick (Sender: TObject); //ToDo
      begin
        Showmessage('Sobald ein Astronom versucht, seinen Zuschauern den ' +
                    'Sternenhimmel zu erklären, hat er die Möglichkeit auf die ' +
                    'einzelnen Sterneinbilder und Sterne zu zeigen. Doch nicht ' +
                    'jedes Mitglied wird der gezeigten Richtung folgen können. ' +
                    'Folglich kommt es immer wieder zu Unklarheiten und Irrtümern. ' +
                    'Zeigt der Astronom, bei aller Vorsicht, Blendungen zu  ' +
                    'vermeiden, mit einem Laserpointer auf die entsprechenden ' +
                    'Objekte, sieht man diesen Strahl über mehrere Kilometer weit ' +
                    'und die Parallaxe, also die Verschiebung des eigenen Winkels ' +
                    'zum Stern, ist nahezu ausgeschlossen. Ziel unserer Arbeit war ' +
                    'es das gleiche in automatisierter Form zu bewirken.');
        Showmessage('Es ist dabei nicht notwendig, den Space Orienter genau ' +
                    'auszurichten, da diese Aufgabe von zwei Sensoren übernommen ' +
                    'wird, ein Beschleunigungssensor und ein Magnetfeldsensor. ' +
                    'Der Betrieb des Space Orienters erfordert keine weiteren ' +
                    'Hilfsmittel oder Netzteile als den USB Port eines Laptops.');
       end;

procedure TFrm_Spori.MP_Hilf_OffClick (Sender: TObject);  //toDo
  begin

   end;

procedure TFrm_Spori.MI_Hilf_OnClick (Sender: TObject);   //toDo
  begin

   end;

procedure TFrm_Spori.MI_Sicht_ExpClick (Sender: TObject); //ToDo: Comments
  begin
    ProgressExpertMode ();
   end;

procedure TFrm_Spori.Tmr_Calc_All (Sender: TObject);   //ToDo: comments; Lb_Gmt = UTC!
  var
     TimeToUse: TDateTime;
     TZ: integer;

     TempMagDvtn: Real;
     Year, Month, Day, Hour, Minute, Second, MilliSecond: Word; //Millisec is unused
  begin
    if Frm_Config.Sw_AutoTime.Checked then
      TimeToUse := now
    else
      TimeToUse := now + DiffD + DiffT;

    Frm_Main.Lbl_Date.Caption := DateToStr(TimeToUse);
    Frm_Main.Lbl_Time.Caption := TimeToStr(TimeToUse);
    Lb_Zeit.Caption := DateTimeToStr(TimeToUse);
    Lb_MEZ.Caption  := DateTimeToStr(TimeToUse);

    DecodeTime(TimeToUse, Hour, Minute, Second, MilliSecond);
    DecodeDate(TimeToUse, Year, Month, Day);

    if not NoEntry then
      begin
        Frm_Config.TE_Time.Time := (Time + DiffT);
        Frm_Config.DE_Day.Date  := (Date + DiffD);
        Options[ON_Date] := DateToStr(Frm_Config.DE_Day.Date);
        Options[ON_Time] := TimeToStr(Frm_Config.TE_Time.Time);
       end;

    Lb_Sek.Caption  := IntToStr(Second);
    Lb_Min.Caption  := IntToStr(Minute);
    Lb_Hour.Caption := IntToStr(Hour);
    Lb_Day.Caption  := IntToStr(Day);
    Lb_Mon.Caption  := IntToStr(Month);
    Lb_Jhr.Caption  := IntToStr(Year);

    TZ              := GetLocalTimeOffset() div -60;
    Lb_Gmt.Caption  := DateTimeToStr(StrToDateTime(Lb_MEZ.Caption)- TZ /24);

    LB_OtZ.Caption  := DateTimeToStr(StrToDateTime(Lb_Gmt.Caption) + StrToFloat(Lb_Lat_G.Caption)/360);

    ProgressFirstPointOfAries();

    Lb_UTC1_Val.Caption := FloatToStr(Julian(Year, Month, Day, 0, 0, 0));

    Lb_UTC2_val.Caption := FloatToStrF(
                           (Hour + Minute/60 + Second/3600)/24,
                           ffFixed, 4, 13);

    TempMagDvtn :=  wmmGeomag(1, StrToInt(Lb_Jhr.caption), Month, Day,
                    Frm_Config.FlSpEd_Lon.Value, Frm_Config.FlSpEd_Lat.Value, 0);

    Lb_Mswg1.Caption:= FloatToStrF(TempMagDvtn, ffFixed, 3, 14);
    Ed_Mswg.Text    := FloatToStrF(TempMagDvtn, ffFixed, 3, 14);
    Frm_Main.Lbl_MagDvtn_Val.Caption := FloatToStrF(TempMagDvtn, ffFixed, 3, 4);


    if (AnsiLowerCase(Ed_Egstn.Text) = 'ephemeride') then
      CalculateEphemerisLoc ()
    else
      CalculateStarLoc () ;
   end;

procedure TFrm_Spori.Tmr_Follow (Sender: TObject); //Done?
  var
     EleNow, EleCalk: Real;
     AziNow, AziCalk: Real;

     Index: Integer;
     InConstellation: Boolean;
     Constellation: Array of TListItem;
  begin
    //If Mode was set to Constellation
    if CB_StrMode.Text = 'Sternbild' then
      begin
        // initialize
        Setlength(Constellation, 0);
        InConstellation  := false;

        //Find all stars in the given Constellation
        for Index := 0 to LV_List.Items.Count-1 do
          if AnsiLowerCase(Trim(CB_StB.Text)) = AnsiLowerCase(LV_List.Items[Index].SubItems[2]) then
            begin
              setlength(Constellation, length(Constellation)+1);
              Constellation[high(Constellation)] := LV_List.Items[Index];
             end;

        //Find the Index of the selected star
        for Index := 0 to high(Constellation) do
          if Ed_Nr.Text = Constellation[Index].Caption then
            begin
              //Get informations about own and starposition
              EleNow  := StrToFloat(Ed_Ele_Ist.Text);
              EleCalk := StrToFloat(Ed_Ele_Soll.Text);
              AziNow  := StrToFloat(Ed_Azi_Ist.Text);
              AziCalk := StrToFloat(Ed_Azi_Soll.Text);

              //if the own position is near of the postion of the star get next one
              if ((EleNow - EleCalk  < 5) and (EleNow - EleCalk  > -5) and
                  (AziNow - AziCalk  < 5) and (AziNow - AziCalk  > -5)) then
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

    procedure TFrm_Spori.CB_HKEditingDone (Sender: TObject); //In own function?
      var
         Gefunden:Boolean;
         Index,Index2:Integer;
         Uebertrag:String;
      begin
        Tmr_Nach.Enabled:=true;
        CB_StrMode.Text:='Sternbild';
        Mmo_Bsbg.Text:='Fährt ein Sternbild nach und verfolgt dieses.';
       end
     else
      EintragNummer ();
   end;

        for Index := 0 to (CB_HK.Items.Count-1) do
          if (Uebertrag = CB_HK.Items[Index]) then
            begin
              for Index2 := 0 to LV_List.Items.Count-1 do
                begin
                  if Uebertrag = AnsiLowerCase(LV_List.Items[Index2].SubItems[0]) then
                    begin
                      ProgressList (LV_List.Items[Index2]);
                      Gefunden := true;

                      if (CB_StrMode.Caption = 'Sternbild') then
                        begin
                          Tmr_Nach.Enabled := false;
                          CB_StrMode.Text  := 'Normal';
                          Mmo_Bsbg.Text    := 'Peilt den ausgewählten Himmelskörper / die ausgewählte Position an.';
                         end;
                    end;
                 end;
            end;
        if not Gefunden then
          ProgressNumber ();
       end;

procedure TFrm_Spori.Bt_PilotClick (Sender: TObject); //Comments
  begin
    SendData ();
   end;

procedure TFrm_Spori.Bt_Pilot_StrLstClick (Sender: TObject); //Comments
  begin
    if (LV_List.SelCount <> 0) then
      ProgressList (LV_List.Selected);

    SendData ();
   end;

procedure TFrm_Spori.BT_Main_TempClick(Sender: TObject); //Temp
  begin
    Frm_Main.Show;
  end;

procedure TFrm_Spori.CB_StrModeChange (Sender: TObject); //Done
  begin
    //We got a now mode, tell it everything else
    ProgressBodyMode(TBodyMode(CB_StrMode.ItemIndex));
   end;

procedure TFrm_Spori.CB_StBEditingDone (Sender: TObject); //ToDo: Comments
  begin
    if IsConstellation () then
      ProgressBodyMode(BMd_Constellation)
     else
      ProgressNumber ();
   end;

end.
