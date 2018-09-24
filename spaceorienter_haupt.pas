unit SpaceOrienter_Haupt;

{$mode objfpc}{$H+}

interface

  //Fixed lon / Lat
  //PortableMode
  //Fixed calculation of the stars
  //Removed unessesary Sringbegin from options
  //missing Options will now get a default value instad of pushing an error message


  { <description>

type
  { TCharList }

  TCharList = Record
    Chara: Char;
    Count: Integer;
  end;

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

    { TODO 02 -oFireInstall -cStar : ISS mit aufnehmen
      TODO 03 -oFireInstall -cList : Orte in eigende Liste
      TODO 02 -oFireInstall -cUser : Hinweise
      TODO 04 -oFireInstall -cUser : ApplicationPropperties
      TODO 03 -oFireInstall -cUser : PopupMenues
      TODO 02 -oFireInstall -cUser : Shortcuts
      TODO 03 -oFireInstall -cFunc : Installer
      TODO 02 -oFireInstall -cUser : Sprache
      TODO 05 -oFireInstall -cFunc : Siehe unten
      TODO 01 -oFireInstall -cCode : Auf Englisch Formatieren
      TODO 02 -oFireInstall -cCode : Beschreibung hinzufügen bei Lizenz
      TODO 01 -oFireInstall -cUser : Bilder
      TODO 03 -oFireInstall -cFunc : weitersuchen einstellen
      TODO 02 -oFireInstall -cFunc : Sternbildsuche - Liste
    }
    // Diese Punkte richtig aufnehmen
    // Die Zeit immer richtig setzen auch mit Auto und nicht immer nur 00:00:00
    // Die Missweisung immer richtig berechnen, auch wenn kein Eph. ausgewählt ist
    //RECONNECTION; WENN LOST
    //Ardo Bild aus ImgList
    //Daten lauschen in thread

  uses
    Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
    Menus, StrUtils, StdCtrls, ComCtrls, ActnList, ExtCtrls, PopupNotifier,
    EditBtn, Buttons, math, Types, process,  DateUtils,
    Config, PlanEph, Utils, synaser, typinfo
   {$IfDEF Windows}
     //, windows, ShellApi;
   {$ELSE IFDEF UNIX}
    , clocale
     //,unix,baseunix
     //,lclintf
    ;
  {$ENDIF}

var
  Frm_Spori: TFrm_Spori;
  DiffD:TDate;
  DiffT:TTime;
  Sternbild:Array of TListItem;

    {Warning: EVERY new option must be listed here! }
    TOptionNames = (
      ON_Version,
      ON_PortableMode,
      ON_ExpertMode,
      ON_UpdateMode,
      ON_UpdateRate,
      ON_UpdateDay,
      ON_UpdateTime,
      ON_ReDo,
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
      ON_StarMode,
      ON_Body,
      ON_Langue
      );

      { TFrm_Spori }

    TFrm_Spori = class(TForm)
        BBt_Anfahren: TBitBtn;
        Bt_BebList: TButton;
        Bt_LoList: TButton;
        Bt_ResList: TButton;
        Bt_Start: TButton;
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
        GB_List: TGroupBox;
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
        Tmr_GetData: TTimer;
        Tmr_Nach: TTimer;
        Tmr_Berech: TTimer;
        TbS_Ephi: TTabSheet;
        procedure Bt_LoListClick(Sender: TObject);
        procedure Bt_ResListClick(Sender: TObject);
        procedure Bt_BebListClick(Sender: TObject);
        procedure Bt_StartClick(Sender: TObject);
        procedure BBt_AnfahrenClick(Sender: TObject);
        procedure CB_HKEditingDone(Sender: TObject);
        procedure CB_StrModeChange(Sender: TObject);
        procedure CB_StBEditingDone(Sender: TObject);
        procedure Ed_NrEditingDone(Sender: TObject);
        procedure ED_PortEditingDone(Sender: TObject);
        procedure Ed_SuchEditingDone(Sender: TObject);
        procedure Ed_SuchEnter(Sender: TObject);
        procedure Ed_SuchExit(Sender: TObject);
        procedure FndDFind(Sender: TObject);
        {Detect PortableMode and initialize importend global vairiables like the paths.
         The reaon why we can't load the options here is that Frm_Config has to be created first}
        procedure FormCreate(Sender: TObject);
        procedure FormDestroy(Sender: TObject);
        procedure FormShow(Sender: TObject);
        procedure Lb_ZeitClick(Sender: TObject);
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
        procedure Tmr_BerechTimer(Sender: TObject);
        procedure Tmr_GetDataTimer(Sender: TObject);
        procedure Tmr_NachTimer(Sender: TObject);
      private
        {Compaires two strings and compute the sameness in percent
        The boolean  does that what it's name say: it determine if StrCompaire is casesensitive}
        function  StrCompaire(str1, str2: string; const CaseSensitive: Boolean = true): Real;
        {Find the Optionsname in a Sting, if there is none then nothig is returned}
        function  FindOptionName (const Line:String):String; 
        {Find the optionsvalue, if there is none then nothig is returned}
        function  FindOptionValue (const Line:String):String;
        {Find the indx of a given option, even if it isn't excaly right.
         If nothing was found -1 is returned.}
        function  FindOption(const Str: String): ShortInt;
        {Looks for a choosen constellation up, if it is valid}
        function  IsConstellation ():Boolean;
        {Load the Starlist by a given path}
        function  LoadStarList (const Path: String): Boolean;
        {Result is the DefaultValue of the given OptionName.
         Warning: every new Option have to be listed here!}
        function  GetDefaultOption (const OptnName: TOptionNames): String;
        {Try to tell the Rest of the mainform what star was selecet by a given Item}
        procedure ProgressList (const Item:TListItem);
        {calculate the First Point of Aries}
        procedure ProgressFirstPointOfAries ();
        procedure SternLage();
        procedure Ephemeriden ();
        {serches for an Item in the StarList}
        procedure searchStarList (SerchFor: String);


        var
          DefaultPath,
          DefaultOptionsPath,
          DefaultOldOptionsPath,
          DefaultListPath,
          DefaultOldListPath: String;
          OwnDir: String;

          ser: TBlockSerial;
          FirstRun: Boolean;
      public
        Options: Array[TOptionNames] of String;
        DiffD:       TDate;
        DiffT:       TTime;
        NoEntry:     Boolean;

        {Does what it say, progress messages until the time is over}
        procedure Delay(Milliseconds: DWORD);

        {Resets the StarListFile}
        procedure DefaultList ();
        {Tell the mainform what starmode was selected}
        procedure ProgressStarMode (const Mode: byte; Save: Boolean = true);

        {Resets the OptionsFile}
        procedure DefaultOptions ();
        {Load Saved Options, if there is no file, create default otions will be created.
         Warning: ervery New Option must loaded here!}
        function  LoadOptions (const LoadFromFile: Boolean = true): Boolean;
        {Sets the pathes to ProtableMode and back}
        procedure SetPortableMode(IsActive: Boolean);

        {Try to find all possible ComPorts}
        procedure GetComPorts ();
        {Try to connect to the Arduino via comport}
        function  Connect (TryAll: Boolean = false):Boolean;

        {Tell the forms, if ExpertMode was activated}
        procedure ProgressExpertMode (Save: Boolean = true);
        {Try to tell the Rest of the mainform what star was selecet by a given Number}
        procedure ProgressNumber (Normal:Boolean = true);

        {Update the App; work in progress}
        procedure Update_ ();
        {Transfer lon, lat to Rad}
        procedure Angle ();

        {Sends Data to the Arduino}
        procedure SendData ();
      end;

  var
    Frm_Spori: TFrm_Spori;

implementation

{$R *.lfm}

  { Frm_Spori }

function  TFrm_Spori.StrCompaire (str1, str2: string; const CaseSensitive: Boolean = true): Real;  //Done?
  type
    TCharList = Record
      Chara: Char;
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
       Str1 := AnsiLowercase(Str1);
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

        while length(Str1) > 0 do
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

        while length(Str2) > 0 do
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

       for Index := 0 to length(NumberofChar1)-1 do
         for Index2 := 0 to length(NumberofChar2)-1 do
           if NumberOfChar1[Index].Chara = NumberOfChar2[Index2].Chara then
             if NumberOfChar1[Index].Count = NumberOfChar2[Index2].Count then
               Inc(VariGleich2);

       VariMin:= Max(length(NumberOfChar1),length(NumberOfChar2));
       end;

    if variGleich2 > 0 then
      Result := (((variGleich/VariMax)+((variGleich2/VariMin))*2)/3)*100
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

function  TFrm_Spori.FindOption(const Str: String): ShortInt; //Done
  var
     OptionName: String;

     equality: Real = 0;
     Tempequality: Real; //: Array [TOptionNames] of Real;
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
            equality := Tempequality;
            Result := Ord(i);
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

             for Index_R:=1 to 8 do
               begin
                 Index_L:=PosEx(';',Stars[index],Help+1);
                 Merke:=Trim(copy(Stars[index],Help+1,Index_L-1-Help));
                 Item.SubItems.Add(Merke);

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

                 if Index_R = 3 then
                   if CB_StB.Items.IndexOf(AnsiLowerCase(Merke)) < 0 then
                     if (Merke <> '-') and (AnsiLowerCase(Merke) <> 'unsichtbar') and (Merke <> '')then
                       CB_StB.Items.Add(AnsiLowerCase(Merke));

function  TFrm_Spori.Connect (TryAll: Boolean = false): Boolean; //ToDo: Detect Arduinotype (and if it is the Spori); Test TryAll
  var
    Port: String;
    Baud: integer;
  begin
    //Tell the User, we are trying to connect
    with Frm_Config do
        begin
          Lbl_ComMsg.Caption  := 'Verbinde...';
          PgsB_ComCon.Visible := true;
          Img_ComCon.Visible  := false;
          Img_ComInfo.Visible := true;
          Img_ComWarn.Visible := false;
          Lbl_Ardo.Visible    := false;
        end;
    Application.ProcessMessages;

    //Close Connection if there is one
    if (ser.InstanceActive) then
      begin
        ser.CloseSocket;
        //empty all buffers
        ser.Purge;
      end;

    if not TryStrToInt(Frm_Config.CmbBx_Baud.Caption, Baud) then
      Baud := 9600; //DefaultValue, shoud work, if there was no change at the Arduino

    if TryAll then
      begin
        //ser := TBlockSerial.Create;

        for Port in Frm_Config.CmbBx_ComPort.Items do
          begin
            ser.Connect(Port);
            //ShowMessage(Port);

            Delay(700);
            ser.config(Baud, 8, 'N', SB1, False, False);
            Delay(500);

            if (ser.InstanceActive) then
              begin
                Frm_Config.CmbBx_ComPort.Caption := Port;
                break;
              end
            else
              begin
                ser.CloseSocket;
                //ShowMessage('Error: ' + ser.LastErrorDesc +' '+ Inttostr(ser.LastError));
              end;
          end;
      end
    else
      begin
        ser.Connect(Frm_Config.CmbBx_ComPort.Caption);
        //ser.Connect('/dev/ttyACM0');
        Delay(700);
        ser.config(Baud, 8, 'N', SB1, False, False);
        Delay(500);
      end;

    Result := ser.InstanceActive;

    with Frm_Config do
      if Result then
        begin
          Lbl_ComMsg.Caption  := 'Verbnden mit: ';
          PgsB_ComCon.Visible := false;
          Img_ComCon.Visible  := true;
          Img_ComInfo.Visible := false;
          Img_ComWarn.Visible := false;
          Lbl_Ardo.Visible    := true;
          Lbl_Ardo.Caption     := 'Arduino Leonardo'; //Defaultvalue
        end
      else
        begin
          Lbl_ComMsg.Caption  := 'Nicht Verbunden';
          PgsB_ComCon.Visible := false;
          Img_ComCon.Visible  := false;
          Img_ComInfo.Visible := false;
          Img_ComWarn.Visible := true;
          Lbl_Ardo.Visible    := false;
          ser.CloseSocket;
        end;
    Application.ProcessMessages;
  end;

procedure TFrm_Spori.SendData ();
  begin

    if ser.InstanceActive and ser.CanWrite(200) then
        ser.SendString(StringReplace((Ed_Ele_Soll.Text + ';' + Ed_Azi_Soll.Text), ',', '.', [rfReplaceAll]));

  end;

function  TFrm_Spori.IsConstellation (): Boolean; //Can be optimized
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
        if (Constellation = AnsilowerCase(LV_List.Items[i].SubItems[2])) then
            exit(true);

   end;

function  TFrm_Spori.LoadStarList (const Path: String): Boolean; //Error!
  var
     index, Beginpos, Index_L, Index_R, Counter, lengthList: Integer;
     Stars:  TStringlist;
     Item:   TListItem;
     Sortet: Boolean;
     Tempproperty:  String;
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

             	end
              else  //Doubble definition
               if (ValLeft = ValRight) then
                   BTChoosen := MessageDlg('Warnung:' + Slinebreak +
                                           '  Doppelte Sternendeklaration Nr. ' + TempStrLeft + 'gefunden!'+ slinebreak +
                                           '  Laden abbrechen?',
                                           mtWarning, mbAbortRetryIgnore, 0, mbIgnore);

              exit (true); //Everthing is fine skip the errorchecking
            end
         else //Somthing dosent get turned into an integer, is it a commend?
           begin
             if not ((Trim(Stars[Left])[1] = '#') or (Trim(Stars[Left]) = '') or TryStrToInt (TempStrLeft, ValLeft)) then
                 BTChoosen := MessageDlg('Error:' + Slinebreak +
                                         '  Ungültige Zeile in SternenListe gefunden Nr: ' + IntToStr(succ(Left)) + slinebreak +
                                         Stars[Left] + SlineBreak +
                                         '  Laden abbrechen?',
                                         mtError, mbAbortRetryIgnore, 0, mbCancel)
             else
               if not ((Trim(Stars[Right])[1] = '#') or (Trim(Stars[Right]) = '') or TryStrToInt (TempStrRight, ValRight))then
                 BTChoosen := MessageDlg('Error:' + Slinebreak +
                                         '  Ungültige Zeile in SternenListe gefunden Nr: ' + IntToStr(succ(Right)) + slinebreak +
                                         Stars[Right] + SlineBreak +
                                         '  Laden abbrechen?',
                                         mtError, mbAbortRetryIgnore, 0, mbCancel)
               else
                 exit (true); // it's just a command or a empty line
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

    try
      if not FileExists (DefaultPfad) then
        DefaultOptions();

      Options.LoadFromFile(DefaultPfad);

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

      LV_List.Clear;
      CB_HK.Clear;
      CB_StB.Clear;

      //Outputof our sorted list into LV_List
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

                //ShowMessage(Tempproperty + ' ' + IntToStr(Beginpos) + ' ' + IntToStr(Index_R));
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
                  BTChoosen := MessageDlg('Error:' + Slinebreak +   // Let the User decide if we retry or not
                                          ' Fehler beim schreiben der SternenListe!' + slinebreak +
                                          '  Erneut versuchen?',
                                          mtError, mbAbortRetryIgnore, 0, mbRetry);
                end;
              until (BTChoosen <> mrRetry);
            end;

      case BTChoosen of
        mrIgnore: Result := true;
        mrAbort:  Result := false;
      end;

    except //UnnownError
      if Assigned(Stars)then
        FreeAndNil(Stars);

      BTChoosen := MessageDlg('Error:' + Slinebreak +   // Let the User decide if we reesett the Starlist or
                                          ' Unbekannter Fehler aufgetrenten.' + Slinebreak +
                                          ' Laden der Sternenliste geschreitert.' + slinebreak +
                                          ' Sternenliste zurücksetzen und erneut versuchen?' + Slinebreak +
                                          ' (Okay = Resett, Abbrechen = Laden Abbrechen)',
                                          mtError, [mbOk, mbAbort, mbRetry], 0, mbRetry);

      Case BTChoosen of
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

    if Assigned(Stars)then
        FreeAndNil(Stars);
  end;

function  TFrm_Spori.GetDefaultOption (const OptnName: TOptionNames): String; //Done?
  begin
    case OptnName of
      ON_Version:       Result := '0.0.0.2';
      ON_PortableMode:  Result := 'False';
      ON_ExpertMode:    Result := 'False';
      ON_UpdateMode:    Result := '0';
      ON_UpdateRate:    Result := '1';
      ON_UpdateDay:     Result := '6';
      ON_UpdateTime:    Result := '00:00:00';
      ON_ReDo:          Result := 'True';
      ON_Place:         Result := 'Zeuthen';
      ON_Lon:           Result := '52,345';
      ON_Lat:           Result := '13,604';
      ON_AutoTimeMode:  Result := 'True';
      ON_Date:          Result := formatdatetime('dd/mm/yyyy', Now);
      ON_Time:          Result := formatdatetime('hh:nn:ss', Now);
      ON_AutoComMode:   Result := 'False';
      ON_ComPort:       Result := 'Com0';
      ON_BaudRate:      Result := '9600';
      ON_AutoValueMode: Result := 'True';
      ON_UseHotkey:     Result := 'False';
      ON_HotKey:        Result := 'Q';
      ON_StarMode:      Result := '0';
      ON_Body:          Result := '0';
      ON_Langue:        Result := 'German';
    end;

  end;
       //Options doesn't save the names correctly
function  TFrm_Spori.LoadOptions (const LoadFromFile: Boolean  = true): Boolean; //ToDo: Version; Langue; Comments
  var
     LoadList: Tstringlist;

     i: integer;
     Index: Shortint;
     NotGottenOptions: set of byte = [0..Ord(high(ToptionNames))];
     j: TOptionNames;

     TempBool: Boolean;
     TempTime: TDateTime;
     Temp_Koord: TKoord;
     TempFloat: Real;

     ErrorMessage:String = '';
  begin
    //initialize

    LoadList := Tstringlist.Create;
    Result      := true;

    if LoadFromFile then //switch, to not load from file, if one special Option was set to default (see below)
      begin
        if not FileExists (DefaultOptionsPath) then
            DefaultOptions();

        try
          LoadList.LoadFromFile(DefaultOptionsPath);

          for i := LoadList.count -1 downto 0 do //Ignore commants and empty lines
            if (LoadList[i] = '') or (Trim(LoadList[i])[1] = '#') then
              LoadList.Delete(i);

          for i := 0 to pred(LoadList.count) do
            begin
              Index := FindOption(FindOptionName(LoadList[i])); //Find the Index of a possible Optionname

              if (Index >= 0) then  // if no valid name was fond, -1 was returned
                begin
                  Options[ToptionNames(Index)] := FindOptionValue(LoadList[i]);
                  NotGottenOptions := NotGottenOptions - [Index];  //we want to test, if every Option got min. one time a value.
                end;
            end;

        finally
          FreeAndNil(LoadList);
        end;
      end;

      if not (NotGottenOptions = []) then //Test if we got everything
       case MessageDlg('ERROR', 'Error:' + Slinebreak +   // Let the User decide if we set the option to default, resett all options or abort
                             ' Konnte nocht alle Optionen finden.' + slinebreak +
                             ' Die fehlerhafte(n) Option(en) durch Defaultwert(e) ersetzen?' + SlineBreak +
                             ' (Nein = Einstellungen zurücksetzen)',
                             mtError, [mbYes, mbNo, mbAbort], 0, mbYes) of
         mrYes:   //set the missing Options to default
           begin
             while (NotGottenOptions <> []) do
               begin
                 i := low(NotGottenOptions);
                 NotGottenOptions := NotGottenOptions - [i];

                 j := TOptionNames(i);
                 Options[j] := GetDefaultOption(j);
               end;

             Result := LoadOptions(false);
           end;
         mrNo: //Resett all Options
           begin
             DefaultOptions();

             Result := LoadOptions(false);
           end;
         mrAbort:
           Result := false;
       end;

    try
      for j := low(TOptionNames) to high(TOptionNames) do
        begin
          case j of
            ON_Version:;// Todo: Convert older Otions to new ones

            ON_PortableMode:
              if TryStrToBool(Options[j], Tempbool) then
                Frm_Config.Sw_PortableMode.Checked := Tempbool
              else
                ErrorMessage := 'Fehler in PortableMode-Ladevorgang: Falscher Datentyp' + sLineBreak +
                                Options[j];

            ON_ExpertMode:
              if TryStrToBool(Options[j], Tempbool) then
                begin
                  MI_Sicht_Exp.Checked := Tempbool;
                  Frm_Config.Sw_Exprt.Checked := Tempbool;

                  ProgressExpertMode(Tempbool);
                end
              else
                ErrorMessage := 'Fehler in ExpertenMode-Ladevorgang: Falscher Datentyp'   ;

            ON_UpdateMode:
              if TryStrToInt (Options[j], i) then
                begin
                  Case i of
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
                      ErrorMessage := 'Fehler in UpdateMode-Ladevorgang: Unbekannter Wert';
                  end;
                end
              else
                ErrorMessage := 'Fehler in UpdateMode-Ladevorgang: Falscher Datentyp';

            ON_UpdateRate:
              if TryStrToInt (Options[j], i) then
               begin
                 Case i of
                   0: Frm_Config.CBx_Rate.ItemIndex := 0;
                   1: Frm_Config.CBx_Rate.ItemIndex := 1;
                   2: Frm_Config.CBx_Rate.ItemIndex := 2;
                   else
                     ErrorMessage := 'Fehler in UpdateRate-Ladevorgang: Unbekannter Wert';
                  end;
                end
              else
                ErrorMessage := 'Fehler in UpdateRate-Ladevorgang: Falscher Datentyp';

            ON_UpdateDay:
              if TryStrToInt (Options[j], i) then
                begin
                  Case i of
                    0: Frm_Config.CBx_Tag.ItemIndex := 0;
                    1: Frm_Config.CBx_Tag.ItemIndex := 1;
                    2: Frm_Config.CBx_Tag.ItemIndex := 2;
                    3: Frm_Config.CBx_Tag.ItemIndex := 3;
                    4: Frm_Config.CBx_Tag.ItemIndex := 4;
                    5: Frm_Config.CBx_Tag.ItemIndex := 5;
                    6: Frm_Config.CBx_Tag.ItemIndex := 6;
                    else
                      ErrorMessage := 'Fehler in UpdateTag-Ladevorgang: Unbekannter Wert';
                  end;
                end
              else
                ErrorMessage := 'Fehler in UpdateTag-Ladevorgang: Falscher Datentyp';

            ON_UpdateTime:
              if TryStrToTime(Options[j], TempTime) then
                Frm_Config.TE_Plan.Time := TempTime 
               else
                ErrorMessage := 'Fehler in UpdateZeit-Ladevorgang: Falscher Datentyp' ;

            ON_ReDo:
              if TryStrToBool(Options[j], TempBool)then
               Frm_Config.Sw_Redo.Checked := TempBool     
              else
                ErrorMessage := 'Fehler in UpdateWiederholen-Ladevorgang: Falscher Datentyp';

            On_Place:
              begin
                if (Options[j] = 'none') then
                  begin
                    //Inc(j);
                    if TryStrToFloat(Options[ON_Lon], TempFloat) then
                      begin
                        Frm_Config.FlSpEd_Lon.Value := TempFloat;
                        Lb_Lon_G.Caption            := Options[ON_Lon];
                        Lb_Lon_G1.Caption           := Options[ON_Lon];
                      end
                    else
                      ErrorMessage := 'Fehler in Longitude Ladevorgang: Falscher DatenTyp';

                    //Inc(j);
                    if TryStrToFloat(Options[ON_Lat], TempFloat) then
                       begin
                         Frm_Config.FlSpEd_Lat.Value := TempFloat;
                         Lb_Lat_G.Caption            := Options[ON_Lat];
                         Lb_Lat_G1.Caption           := Options[ON_Lat];
                       end
                    else
                      ErrorMessage := 'Fehler in Longitude Ladevorgang: Falscher DatenTyp';

                    Frm_Config.CbBx_Ort.Caption := 'Keine';
                  end
                else
                  begin
                    Temp_Koord                  := Frm_Config.Koordinaten (Options[j]); //If it is an invailed place an Error is reaised here (may change in future)

                    Frm_Config.FlSpEd_Lon.Value := Temp_Koord.Lon;

                    Frm_Config.FlSpEd_Lat.Value := Temp_Koord.Lat;
                    Lb_Lat_G.Caption            := FloatToStr(Temp_Koord.Lat);
                    Lb_Lat_G1.Caption           := FloatToStr(Temp_Koord.Lat);

                    Frm_Config.CbBx_Ort.Caption := Options[j];
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
              ErrorMessage := 'Fehler in TimeMode-Ladevorgang: Falscher DatenTyp';

            ON_Date:
              if TryStrToDate(Options[j], TempTime) then
                begin
                  DiffD                  := TempTime - Date;
                  Frm_Config.DE_Day.Date := Date + DiffD;
                end
              else
                ErrorMessage := 'Fehler in Tag-Ladevorgang: Falscher DatenTyp oder Format';

              ON_Time:
                if TryStrToTime(Options[j], TempTime) then
                  begin
                    DiffT                   := TempTime - Time;
                    Frm_Config.TE_Time.Time := Time + DiffT
                   end
                 else
                  ErrorMessage := 'Fehler in Zeit-Ladevorgang';

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
                  ErrorMessage := 'Fehler in ComMode-Ladevorgang: Falscher DatenTyp';

              ON_BaudRate:
                if TryStrToInt(Options[j], i) then
                  if (Frm_Config.CmbBx_Baud.Items.IndexOf(Options[j]) >= 0) then
                      Frm_Config.CmbBx_Baud.Caption := Options[j]
                  else
                    ErrorMessage := 'Fehler in BaudRate-Ladevorgang: Unzulässige Baudrate'
                else
                 ErrorMessage := 'Fehler in BaudRate-Ladevorgang: Falscher DatenTyp';

              ON_AutoValueMode:
                if TryStrToBool(Options[j], Tempbool) then
                  Frm_Config.Sw_ManW.Checked := not Tempbool
                else
                 ErrorMessage := 'Fehler in WerteMode-Ladevorgang: Falscher DatenTyp';

              ON_UseHotkey:
                if TryStrToBool(Options[j], Tempbool) then
                  begin
                    Frm_Config.Sw_HtKy.Checked := Tempbool;

                    if TempBool then
                      begin
                        Frm_Config.Lbl_Sw_HtKy.Caption := 'Ein';
                        Frm_Config.Ed_HtKy.Enabled := true;
                        Frm_Config.Bt_HtKy.Enabled := true;
                      end
                    else
                      begin
                        Frm_Config.Lbl_Sw_HtKy.Caption := 'Aus';
                        Frm_Config.Ed_HtKy.Enabled := false;
                        Frm_Config.Bt_HtKy.Enabled := false;
                      end;
                  end
                else
                 ErrorMessage := 'Fehler in AnsteuerungMode-Ladevorgang: Falscher DatenTyp';

              ON_HotKey:
               if (length(Options[j]) > 0) then
                 Frm_Config.Ed_HtKy.Text := Options[j]
               else
                 Frm_Config.Ed_HtKy.Text := 'None';

              ON_StarMode:
                if TryStrToInt(Options[j], i) then
                  begin
                    CB_StrMode.ItemIndex := i;
                    ProgressStarMode(i, false);
                  end
                else
                  ErrorMessage := 'Fehler in StarMode-Ladevorgang: Falscher DatenTyp';

              ON_Body:
                if TryStrToInt (Options[j], i) then
                  begin
                    Ed_Nr.Text := Options[j];
                   end
                 else
                  ErrorMessage := 'Fehler in HimmelsKörper-Ladevorgang: Falscher DatenTyp';

              ON_Langue:;
          end;

         if ErrorMessage <> '' then
           begin
             case MessageDlg('ERROR', 'Error:' + Slinebreak +   // Let the User decide if we retry, resett or abort
                             ' ' + ErrorMessage + ' (' + Options[j] + ')' + slinebreak +
                             ' Die fehlerhafte Option durch Defaultwert ersetzen?' + SlineBreak +
                             ' (Nein = Einstellungen zurücksetzen)',
                             mtError, [mbYes, mbNo, mbAbort], 0, mbYes) of
               mrYes:
                 begin
                   Options[j] := GetDefaultOption(j);
                   Result := LoadOptions(false);
                 end;
               mrNo:
                 begin
                  DefaultOptions();

                   Result := Result and LoadOptions(false);
                 end;
               mrAbort:
                 Result := false;
             end;

             Break;
           end;
       end;

       if Result then
         begin
           Result := LoadStarList(DefaultListPath);
           ProgressNumber(False);
         end;

    except   //Unkown Error
      case MessageDlg('ERROR', 'Error:' + Slinebreak +   // Let the User decide if we, resett or abort
                      ' Unbekannter Fehler in Optionen-Ladevorgang.' + slinebreak +
                      ' Optionen zurücksetzen?' + SlineBreak +
                      ' (Nein = Einstellungen zurücksetzen)',
                      mtError, [mbYes, mbAbort], 0, mbYes) of
        mrYes:
          begin
            DefaultOptions();
            Result := LoadOptions ();
          end;
        mrAbort:
          Result := false;
      end;
     end;
   end;

procedure TFrm_Spori.SetPortableMode (IsActive: Boolean); //ToDo: CleanUp after Mode has changed
  begin
    if IsActive then //PortableMode uses just the dir where the binary is located
      DefaultPath := OwnDir
    else     //while non PortableMode uses a different path, to hide files
      {$IfDef Windows}
        DefaultPath := 'C:\ProgramData\FireInstallations\SpaceOrienter';
      {$Else}
         DefaultPath := GetAppConfigDir(false);
      {$EndIf Windows}

    {Sets all the pathes where DefaultPath is used}
    DefaultOptionsPath    := DefaultPath + PathDelim + 'Options.Space';
    DefaultOldOptionsPath := DefaultPath + PathDelim + 'OldOptions';
    DefaultListPath       := DefaultPath + PathDelim + 'StarList.Space';
    DefaultOldListPath    := DefaultPath + PathDelim + 'OldLists';

    SetCurrentDir(DefaultPath);
  end;

procedure TFrm_Spori.Delay(Milliseconds: DWORD); //Done
  var
    Yet: DWORD;
  begin
    Yet := GetTickCount64;

    while (GetTickCount64 < Yet + Milliseconds) and (not Application.Terminated) do//wait until Milliseconds is over
      Application.ProcessMessages; //do erverything else

   end;

procedure TFrm_Spori.DefaultOptions (); //Done
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

procedure TFrm_Spori.DefaultList ();  //ToDo: put this into it's own File
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
      List.Add('79;Fomalhaut;Fomalhaut;Suedlicher Fisch;Keine;15;21,8;-29;-32,1');
      List.Add('80;Scheat;Scheat;Pegasus;Keine;13;51,4;28;10,4;');
      List.Add('81;Markab;Markab;Pegasus;Keine;13;36,3;15;17,7;');
      List.Add('82;Altarf;Altarf;Krebs;Tierkreis;235;52,5;9;11,1;');
      List.Add('83;Daneb Algedi;Daneb Algedi;Steinbock;Tierkreis;326;45,8;-16;-7,6;');
      List.Add('84;Sadalsuud;Sadalsuud;Wassermann;Tierkreis;322;53,5;-5;-34,3;');
      List.Add('85;Eta Piscium;Eta Piscium;Fische;Tierkreis;22;52,3;15;20,8;');
      List.Add('86;Achird;Achird;Kassiopeia;Dollystern;347;45,0;57;49,0;*');
      List.Add('87;Merkur;-;-;Ephemeride;-;-;-;-;');
      List.Add('88;Venus;-;-;Ephemeride;-;-;-;-;');
      List.Add('89;Erde;-;-;Ephemeride;-;-;-;-;');
      List.Add('90;Mars;-;-;Ephemeride;-;-;-;-;');
      List.Add('91;Jupiter;-;-;Ephemeride;-;-;-;-;');
      List.Add('92;Saturn;-;-;Ephemeride;-;-;-;-;');
      List.Add('93;Uranus;-;-;Ephemeride;-;-;-;-;');
      List.Add('94;Neptun;-;-;Ephemeride;-;-;-;-;');
      List.Add('95;Pluto;-;-;Ephemeride;-;-;-;-;');
      List.Add('96;Mond;-;-;Ephemeride;-;-;-;-;');
      List.Add('97;Sonne;-;-;Ephemeride;-;-;-;-;');


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

procedure TFrm_Spori.ProgressStarMode (const Mode: byte; Save: Boolean = true); //TODO: implement searchStarList
begin
  if Save then  //if a new Mode is seleced save it
    Options[ON_StarMode] := IntToStr(Mode);

  case Mode of
    0: //normal
      begin
        CB_StrMode.Text  := 'Normal';
        Mmo_Bsbg.Text    := 'Peilt den ausgewählten Himmelskörper / die ausgewählte Position an.';
        Tmr_Nach.Enabled := false;
       end;
    1: // follow
      begin
        CB_StrMode.Text  := 'Nachführen';
        Mmo_Bsbg.Text    := 'Peilt den ausgewählten Himmelskörper an und verfolgt diesen auf dem Himmel';
        Tmr_Nach.Enabled := true;
       end;
    2: //scan
      begin
        CB_StrMode.Text  := 'Erkennen';
        Mmo_Bsbg.Text    := 'Sobald ein Himmelsköper (manuell) angestuert wurde, wird er identifiziert.';
        Tmr_Nach.Enabled := false;
       end;
    4: //place
      begin
        CB_StrMode.Text  := 'Ort';
        Mmo_Bsbg.Text    := 'Gibt den eigenen Ort aus. '+#10+'Hierzu muss ein Himmelskörper angesteuert und richtig benannt werden.';
        Tmr_Nach.Enabled := false;
       end;
    5: //time
      begin
        CB_StrMode.Text  := 'Zeit';
        Mmo_Bsbg.Text    := 'Gibt die aktuelle Zeit aus. '+#10+'Hierzu muss ein Himmelskörper angesteuert und richtig benannt werden.';
        Tmr_Nach.Enabled := false;
       end;
    6:  //collection
      begin
        if IsConstellation () then
          begin
            CB_StrMode.Text  := 'Sternbild';
            Mmo_Bsbg.Text    :='Fährt ein Sternbild nach und verfolgt dieses.';
            Tmr_Nach.Enabled :=true;
           end
         else
          begin
            CB_StrMode.Text  := 'Normal';
            Mmo_Bsbg.Text    := 'Peilt den ausgewählten Himmelskörper / die ausgewählte Position an.';
            Tmr_Nach.Enabled := false;
          end;
      end;
    7: //'suche'
      begin
        CB_StrMode.Text  :='Normal';
        Mmo_Bsbg.Text    :='Peilt den ausgewählten Himmelskörper / die ausgewählte Position an.';
        Tmr_Nach.Enabled :=false;
      end;
   else
    begin
      raise Exception.Create('Fehler in Change-Mode-Vorgang: Unbekannter Mode');
      Mmo_Bsbg.Text := 'Error';
     end;
   end;
 end;

procedure TFrm_Spori.ProgressExpertMode (Save:Boolean = True); //ToDo: sepperate expert options
  begin
    if  MI_Sicht_Exp.Checked then
      begin

        if Save then
          Options[ON_ExpertMode] := 'true';

        Frm_Config.Sw_Exprt.Checked := true;

        TbS_Lag.TabVisible          := true;
        TbS_Einst.TabVisible        := true;
        TbS_Ephi.TabVisible         := true;

        LV_List.Column[0].Width     := 60;
        LV_List.Column[0].Caption   := 'Nr.';
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
         if Save then
           Options[ON_ExpertMode] := 'false';

         Frm_Config.Sw_Exprt.Checked := false;

         TbS_Lag.TabVisible          := false;
         TbS_Einst.TabVisible        := false;
         TbS_Ephi.TabVisible         := false;
         LV_List.Column[0].Width     := 110;
         LV_List.Column[0].Caption   := 'Nummer';
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

procedure TFrm_Spori.ProgressList (const Item: TListItem); //ToDo: Test if the Item is vailed (mainpage); Commend what the subitems mean
  var
     TestFloat: Float;
     i: Integer;

    {Ask the User if we shoud resett the StarList}
    function ProgressError (SubItem: String): boolean;
      begin
        Result := true;

        case MessageDlg('ERROR', 'Error:' + Slinebreak +   // Let the User decide if we resett the Starlist or
                                      ' Unbekannter Fehler aufgetrenten.' + Slinebreak +
                                      ' Laden des Sterns gescheitert bei SubItem: ' + SubItem + slinebreak +
                                      ' Sternenliste zurücksetzen und neu Laden?' + Slinebreak +
                                      ' (Okay = Resett, Abbrechen = Laden Abbrechen)',
                                      mtError, [mbOk, mbIgnore], 0, mbRetry) of
          mrOk:
            begin
              if FileExists(DefaultListPath) then
                begin
                  ForceDirectories (DefaultOldListPath);
                  RenameFile (DefaultListPath, DefaultOldListPath + PathDelim + ' StarList'+formatdatetime('d.m.y-h;n;s;z',Now)+'.old');
                end;

               LoadStarList(DefaultListPath); //it will create a defaultfile by its own
            end;
          mrIgnore:
            Result := false;
        end;


     end;

  begin
    Options[ON_Body] := Item.Caption; //Save the current item as seleced

    for i := 0 to LV_List.Items.Count-1 do  //Uncheck all the other items
      if not (LV_List.Items[i] = Item) then
        LV_List.Items[i].Checked := false;
    Item.Checked   := true;  //and check the current one

    //Tell the mainpage what item was selected
    Ed_Nr.Text     := Item.Caption;
    CB_HK.caption  := Item.SubItems[0];
    CB_StB.caption := Item.SubItems[2];
    Ed_Egstn.Text  := Item.SubItems[3];

    if not (Ansilowercase(Item.SubItems[0]) = 'ruheposition') and  //Try to tell Star calculate page where to find the star
       not (Ansilowercase(Item.SubItems[3]) = 'ephemeride' ) then
      begin
        if TryStrToFloat (Item.SubItems[4], TestFloat) then
          Lb_Rtzn_Grd.Caption := Item.SubItems[4]
         else
          if ProgressError ('4') then
            exit;

        if TryStrToFloat (Item.SubItems[5], TestFloat) then
          Lb_Rtzn_Rd.Caption := Item.SubItems[5]
         else
          if ProgressError ('5') then
            exit;

        if TryStrToFloat (Item.SubItems[6], TestFloat) then
          Lb_Dekli_Grd.Caption := Item.SubItems[6]
         else
          if ProgressError ('6') then
            exit;

        if TryStrToFloat (Item.SubItems[7], TestFloat) then
          Lb_Dekli_Rd.Caption := Item.SubItems[7]
         else
          if ProgressError ('7') then
            exit;
      end
     else
      if (Ansilowercase(Item.SubItems[0]) = 'ruheposition') then //if it's not a star but the restposition set lon and lat to 89.
        begin
          Ed_Ele_Soll.Text := '89';
          Ed_Azi_Soll.Text := '89';
         end;
   end;

procedure TFrm_Spori.ProgressNumber (Normal:Boolean = true); //ToDo: Errorhandeling if the Item doesnt exits
  var
     Item:TListItem;
  begin
    // Find The the ithem that is conneceted with the Number of ED_Nr
    Item := LV_List.Items.FindCaption(0, IntToStr(StrToInt(Ed_Nr.Text)), false, false, true);

    if Ed_Nr.Text = '0' then //Somehow FindCaption doen't find the first Item.
      Item := LV_List.Items[0];

    if Assigned(Item) then // if a valid Item was found tell it
      begin
        ProgressList (Item);

        if (CB_StrMode.Caption = 'Sternbild') and Normal then //Resett StarMode
          begin
            Tmr_Nach.Enabled := false;
            CB_StrMode.Text  := 'Normal';
            Mmo_Bsbg.Text    := 'Peilt den ausgewählten Himmelskörper / die ausgewählte Position an.';
           end;
      end
     else; //Errorhandeling
   end;

//Portable Version give just the link to Github ?
procedure TFrm_Spori.Update_ (); //ToDo
  begin

  end;

procedure TFrm_Spori.Angle (); //Done
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

procedure TFrm_Spori.SternLage ();  //ToDo: comments
  var
    Lat_G: Real;
    Lon_R: Real;
    Rtzn_Grd, Rtzn_Rd: Real;
    Dekli_Grd, Dekli_Rd: Real;
    AkFrPnk: Real;
    StWk: Real;
    Beta, Delta: Real;
    Grt, T: Real;
    Ele, Azimut: Real;
    Az_Z, Az_N: Real;
  begin     ;
    Lat_G := StrToFloat(Lb_Lat_G.Caption);
    Lon_R := StrToFloat(Lb_Lon_R.caption);

    Rtzn_Grd  := StrToFloat(Lb_Rtzn_Grd.Caption);
    Rtzn_Rd   := StrToFloat(Lb_Rtzn_Rd.caption);

    Dekli_Grd := StrToFloat(Lb_Dekli_Grd.caption);
    Dekli_Rd  := StrToFloat(Lb_Dekli_Rd.caption);

    AkFrPnk   := StrToFloat(Lb_AkFrPnk.caption);

    StWk            := Rtzn_Grd + Rtzn_Rd/60;

    Beta            := StWk * Pi/180;

    Delta           := (Dekli_Grd + Dekli_Rd/60) * Pi/180;

    Grt             := AkFrPnk + StWk;
    if (Grt > 360) then
      Grt -= 360;

    T := Grt + Lat_G;
    if (T > 360) then
      T -= 360;
     T *= (Pi/180);

    Ele := ArcSin(Sin(Lon_R)*Sin(Delta) + Cos(Lon_R)*Cos(Delta)*Cos(T));
    Ele *= 180/Pi;

    Az_Z := Sin(-T);
    Az_N := tan(Delta) * cos(Lon_R) - sin(Lon_R) * cos(T);

    Azimut := ArcTan2(Az_Z, Az_N) * 180/PI();
    if (Azimut <= 0) then
      Azimut += 360;

    Lb_Beta.Caption := FloatToStrF(Beta, ffFixed, 4, 13);
    Lb_Delt.caption := FloatToStrF(Delta, ffFixed, 4, 13);
    Lb_StWk.caption := FloatToStrF(StWk, ffFixed, 4, 13);
    Lb_Grt.caption  := FloatToStrF(Grt, ffFixed, 4, 13);
    Lb_T.caption := FloatToStrF(T, ffFixed, 4, 13);

    Lb_Az_Z.Caption := FloatToStrF(Az_Z, ffFixed,4,13);
    Lb_Az_N.Caption := FloatToStrF(Az_N, ffFixed, 4, 13);

    Lb_El.caption := FloatToStrF(Ele, ffFixed, 4, 11);
    if not (Frm_Config.Sw_ManW.Checked) and not (Ansilowercase(CB_HK.caption) = 'ruheposition') then
      Ed_Ele_Soll.text := FloatToStrF(Ele, ffFixed, 4, 13);

    Lb_Az.caption:=FloatToStrF(Azimut, ffFixed, 4, 11);
    if not (Frm_Config.Sw_ManW.Checked) and not (Ansilowercase(CB_HK.caption) = 'ruheposition') then
      Ed_Azi_Soll.text:=FloatToStrF(Azimut, ffFixed, 4, 13);

    Ed_Mswg.Text:='-';
  end;

    procedure TFrm_Spori.Ephemeriden ();  //Bugfix
      var
         Lon, Lat, TZ, xp, yp, dut1, hm, tc, pm, rh, wl: Real;
         ra, rb: Double;
         Body: Integer;
         Uebertrag: String;
      begin
        TZ := GetLocalTimeOffset() div -60;

        Lon := Frm_Config.FlSpEd_Lon.Value; // Positive eastward
        Lat := Frm_Config.FlSpEd_Lat.Value; // Positive northward

        // better 50?
        hm := 100; // hight (meters) Used with topocentric frames to apply diurnal aberration.

        Tz  := GetLocalTimeOffset() div -60; //(Zeitverschiebung)

        xp     := 0.182698;    // The x offset of the terrestrial pole. Used to apply polar motion. From www.iers.org bulletin service
        yp     := 0.401681;    // The y offset From www.iers.org bulletin service
        dut1   := -0.307649;   // Difference between UTC and UT1. It can only be obtained by a bulletin service From www.iers.org bulletin service

        tc  := 24.0;        // Temperature (celcius)
        pm  := 1021.0;      // Pressure (milibars)
        rh  := 0.5;         // Relative Humidity (percent [fractional])
        wl  := 0.55;        // Wavelength (micrometers)
        RefractionAB(pm, tc, rh, wl, ra{%H-}, rb{%H-}); // spuckt die beiden konstanten aus, die angeben, wie die Athmosphäre die beobachtung beinflusst

procedure TFrm_Spori.MI_ConnectClick(Sender: TObject);  //ToDo
  begin

        Uebertrag := FloatToStrF(Ephem(0, FR_ICRS, Body, GV_ELEVATION, AD_LIGHTTIME,
                   StrToFloat(Lb_UTC1.Caption),  StrToFloat(Lb_UTC2.Caption),
                   Lon, Lat, TZ, xp, yp, dut1, hm, ra, rb),ffFixed, 4, 13); //TZ richtig?

procedure TFrm_Spori.MI_Hilf_FehClick(Sender: TObject);  //toDo
  begin

        Uebertrag := FloatToStrF(Ephem(0, FR_ICRS, Body, GV_AZIMUTH, AD_LIGHTTIME,
                   StrToFloat(Lb_UTC1.Caption),  StrToFloat(Lb_UTC2.Caption),
                   Lon, Lat, TZ, xp, yp, dut1, hm, ra, rb),ffFixed, 4, 13); //TZ richtig?

procedure TFrm_Spori.MI_SuchClick(Sender: TObject); //Wenn nicht Last error
  begin
    FndD.FindText:=CB_HK.Text;
    FndD.Execute;
   end;

       end;

procedure TFrm_Spori.searchStarList (SerchFor: String); //Done
  var
     i, j: Integer;
     Item: TListItem;
  begin
    Item := LV_List.Items.FindCaption(0, SerchFor, false, false, true);

    if Assigned (Item) then
      begin
        LV_List.Selected := Item;
        PgC_Haupt.TabIndex := 1;
        LV_List.SetFocus;
        LV_List.ItemFocused := LV_List.Items[0];
        LV_List.Items[Item.Index].MakeVisible(false);
       end
    else
      if SerchFor = '0' then
        begin
          LV_List.Selected := LV_List.Items[0];
          PgC_Haupt.TabIndex := 1;
          LV_List.SetFocus;
          LV_List.ItemFocused := LV_List.Items[0];
          LV_List.Items[0].MakeVisible(false);
        end
    else
      for i := 0 to LV_List.Items.Count-1 do
        for j := 0 to Lv_List.Items[i].SubItems.Count-1 do
          if (StrCompaire (SerchFor, AnsilowerCase(LV_List.Items[i].SubItems[j])) >= 60) then
            begin
              LV_List.Selected := LV_List.Items[i];
              PgC_Haupt.TabIndex := 1;
              LV_List.SetFocus;
              LV_List.ItemFocused := LV_List.Items[i];
              LV_List.Items[i].MakeVisible(false);
            end;
   end;

procedure TFrm_Spori.Ed_NrEditingDone(Sender: TObject); //Done?
  begin
    //We got a new body, tell it erverbody else
    ProgressNumber ();
  end;

    procedure TFrm_Spori.ED_PortEditingDone(Sender: TObject); //Zu neuer Form Connectinfo verarbeiten
      begin
        //OptionsChange ('comport', ED_Port.Text);
       end;

    procedure TFrm_Spori.Ed_SuchEditingDone(Sender: TObject); //Fertig
      begin
        if not (Ed_Such.Text = 'Suchen...') and not ( Ed_Such.Text = '') then
          searchStarList (Trim(Ed_Such.Text));
       end;

procedure TFrm_Spori.MI_Sicht_ExpClick(Sender: TObject); //Fertig
  begin
    Exp ();
   end;

procedure TFrm_Spori.TE_ManuAcceptTime(Sender: TObject; var ATime: TDateTime; var AcceptTime: Boolean); //Fertig
  begin
    if AcceptTime then
      begin
        DiffT:=StrToTime(TimeToStr(ATime))-Time;
        OptionsChange(6, TimeToStr(ATime));
      end;
  end;

procedure TFrm_Spori.Tmr_BerechTimer(Sender: TObject);   //Reaktion auf manuelle Zeit bei Sommerzeit + Utc1 fixen
  var
     Jahr, Monat, Tage, Stunden, Minuten, Sekunden, Millisek:Word;
     ZoneInfo: TTimeZoneInformation;
  begin
    if ChkB_TmMd.Checked then
      begin
        Lb_Zeit.Caption:=DateTimeToStr(Now);
        Lb_MEZ.Caption:=DateTimeToStr(Now);

        DecodeTime(now, Stunden, Minuten, Sekunden, Millisek);
        DecodeDate(now, Jahr, Monat, Tage);

       searchStarList(Uebertrag);
       end;

procedure TFrm_Spori.FormCreate(Sender: TObject); //ToDo: are there cases where GetCurrentDir is not the own dir at beginnig?
  var
    i: word;
    OptionsIndex: shortint;
    TempOptions: TStringList;
    PortableModeActive: Boolean;
  begin
    ser := TBlockSerial.Create;
    FirstRun := true;
    OwnDir :=  GetCurrentDir();

    //if an optionsfile in the same dictionary exits load it and try to find a value for PortableMode
    if FileExists(GetCurrentDir + PathDelim + 'Options.Space') then
      begin
        TempOptions := TStringList.create;

        Try
          TempOptions.LoadFromFile(GetCurrentDir + PathDelim + 'Options.Space');

          for i := 0 to pred(TempOptions.count) do
            begin
              OptionsIndex := FindOption(FindOptionName(TempOptions[i]));

              if (OptionsIndex >= 0) and (TOptionNames(OptionsIndex) = ON_PortableMode) then   //if OptionName = 'PortableMode' (but this way should be more robust, but slower though...)
                begin
                  if not TryStrToBool(FindOptionValue(TempOptions[i]), PortableModeActive) then
                    PortableModeActive := false;      //default value;

                  break;
                end;
            end
        finally
          FreeAndNil(TempOptions);
        end;
      end;

    SetPortableMode(PortableModeActive);

  end;

    procedure TFrm_Spori.FormDestroy(Sender: TObject);   //Version Dynamic; Check if all Options where saved
      var
         //Help:Integer;
         Line: String;
         OptionName: TOptionNames;

         Index: Integer;
         SaveStrings, LoadStrings: TStringList;
      begin
        ser.Purge;
        ser.CloseSocket;
        if Assigned(ser) then
          FreeAndNil(ser);

        SaveStrings := TStringlist.create;

        if not FileExists (DefaultOptionsPath) then  //Default Options
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
            //
            for OptionName := low(TOptionNames) to High(TOptionNames) do
              begin
                Line := GetEnumName(TypeInfo(TOptionNames), Ord(OptionName));
                Line := Copy(Line, 4, length(Line) -3);

                SaveStrings.Add('"'+ Line +'":   "'+Options[OptionName]+'"');
              end;


            try
              ForceDirectories (DefaultPath);
              SaveStrings.SaveToFile (DefaultOptionsPath);
            finally
              SaveStrings.free;
            end;
           end
         else
          begin
            LoadStrings := TStringList.create;
            SaveStrings.clear;

             try
               LoadStrings.LoadFromFile(DefaultOptionsPath);

               for Line in LoadStrings do
                 begin
                   Index := 0;
                   if not (Trim(Line)[1] = '#') or (Trim(Line) = '')  then  //Skip comments and free lines
                     begin
                       Index := FindOption(FindOptionName(Line));

                       if (Index >= 0) then
                         SaveStrings.Add(StringReplace(Line, FindOptionValue(Line), Options[TOptionNames(Index)], [rfIgnoreCase]));
                     end
                   else
                   SaveStrings.Add(Line);
                 end;

               FreeAndNil(LoadStrings);

               SaveStrings.SaveToFile (DefaultOptionsPath);
             finally
                FreeAndNil(SaveStrings);
             end;
           end;
      end;

    procedure TFrm_Spori.FormShow(Sender: TObject);
      begin
        if FirstRun then
          begin
            FirstRun := false;

           if not LoadOptions() then
              begin
                showmessage('Entschuldigung.' + slinebreak +
                            'Ich war NICHT Erfolgreich den Fehler zu beheben. :(' +
                            slinebreak + slinebreak +
                            'Beende Programm. Bitte kontaktiere FireInstallations');

                ser.Purge;
                ser.CloseSocket;
                if Assigned(ser) then
                  FreeAndNil(ser);

                halt;
              end;

            GetComPorts ();
            Connect (true);

            {if ChkB_Up.Checked then
              Update_ (); }

    Lb_UTC2.Caption:=FloatToStrF(((StrToInt(Lb_Hour.Caption) +
                     StrToInt(Lb_Min.Caption)/60 +
                     StrToInt(Lb_Sek.Caption)/3600)/24),ffFixed,4,13);

            Tmr_Berech.Enabled := true;

            PgC_Haupt.TabIndex := 0;

          end;
       end;

procedure TFrm_Spori.Tmr_NachTimer(Sender: TObject); //Fertig
  var
     Index:Integer;
     InStBild:Boolean;
  begin

    if CB_StrMode.Text = 'Sternbild' then
      begin
        if LV_List.SelCount <> 0 then
          ProgressList (LV_List.Selected);
       end;

    procedure TFrm_Spori.LV_ListItemChecked(Sender: TObject; Item: TListItem); //Fertig?
      begin
        ProgressList(Item);
       end;

    procedure TFrm_Spori.LV_ListKeyPress(Sender: TObject; var Key: char); //Fertig
      begin
        if ((LV_List.SelCount <> 0) and (Key = #13)) then
          ProgressList (LV_List.Selected);
       end;

       end;
      if TgB_AutoWert.Checked then
        SendData ();
   end;

procedure TFrm_Spori.TgB_AutoWertChange(Sender: TObject); //Fertig
  begin
    if TgB_AutoWert.Checked then
      begin
        OptionsChange(14,'Auto');
        TgB_AutoWert.Caption:='Verwende Hotkey';
       end
     else
      begin
        OptionsChange(14,'Manuell');
        TgB_AutoWert.Caption:='Automatische Wertübergabe';
      end;
   end;

procedure TFrm_Spori.CB_HKEditingDone(Sender: TObject); //In function auslagern?
  var
     Gefunden:Boolean;
     Index,Index2:Integer;
     Uebertrag:String;
  begin
    Gefunden:=false;
    Uebertrag:=AnsiLowerCase(Trim(CB_HK.Caption));

    for Index:=0 to CB_HK.Items.Count-1 do
      if Uebertrag = CB_HK.Items[Index] then
        begin
          for Index2:=0 to LV_List.Items.Count-1 do
            begin
              if Uebertrag = AnsilowerCase(LV_List.Items[Index2].SubItems[0]) then
                begin
                  EintragList (LV_List.Items[Index2]);
                  Gefunden:=true;

                  if CB_StrMode.Caption = 'Sternbild' then
                    begin
                      Tmr_Nach.Enabled:=false;
                      CB_StrMode.Text:='Normal';
                      Mmo_Bsbg.Text:='Peilt den ausgewählten Himmelskörper / die ausgewählte Position an.';
                     end;
                end;
             end;
        end;
    if not Gefunden then
      EintragNummer ();
   end;

procedure TFrm_Spori.CkB_ManuAnStChange(Sender: TObject); //Fertig
  begin
    if CkB_ManuAnSt.Checked then
      begin
        Optionschange(13,'Manuell');
      end
     else
      begin
        Optionschange(13,'Auto');
       end;
  end;

procedure TFrm_Spori.Bt_UpClick(Sender: TObject); //Fertig
  begin
    Update_ ();
   end;

procedure TFrm_Spori.BBt_AnfahrenClick(Sender: TObject); //Fertig?
  begin
    SendData ();
   end;

procedure TFrm_Spori.Bt_LoListClick(Sender: TObject); //Fertig
  begin
    if OpnD.Execute then
     LoadStarList(OpnD.Files[0]);
   end;

procedure TFrm_Spori.Bt_EinstZuRSClick(Sender: TObject); //Fertig
  var
     StMode,HK:String;
  begin
    StMode:=CB_StrMode.Text;
    HK:=Ed_Nr.Text;

    procedure TFrm_Spori.MI_Sicht_ExpClick(Sender: TObject); //Fertig
      begin
        ProgressExpertMode ();
       end;

    procedure TFrm_Spori.Tmr_BerechTimer(Sender: TObject);   //Done
      var
         TZ: integer;
         TempDeviation: String;
         Jahr, Monat, Tage, Stunden, Minuten, Sekunden, Millisek:Word;
      begin
        if Frm_Config.Sw_AutoTime.Checked then
          begin
            Lb_Zeit.Caption := DateTimeToStr(Now);
            Lb_MEZ.Caption  := DateTimeToStr(Now);

    EintragMode(StMode);

    Ed_Nr.Text:=HK;
    OptionsChange(15, HK);
   end;

           end
         else
          begin
            Lb_Zeit.Caption := DateTimeToStr(Now + DiffD+DiffT);
            Lb_MEZ.Caption  := DateTimeToStr(Now + DiffD+DiffT);

procedure TFrm_Spori.Bt_BebListClick(Sender: TObject);  //ToDO
  begin

   end;

            if( not NoEntry) then
              begin
                Frm_Config.TE_Time.Time := (Time + DiffT);
                Frm_Config.DE_Day.Date  := (Date + DiffD);
                Options[ON_Date] := DateToStr(Frm_Config.DE_Day.Date);
                Options[ON_Time] := TimeToStr(Frm_Config.TE_Time.Time);
               end;
           end;

procedure TFrm_Spori.CB_StrModeChange(Sender: TObject); //Fertig
  begin
    EintragMode(CB_StrMode.Text);
   end;

        TZ := GetLocalTimeOffset() div -60;
        Lb_Gmt.Caption      := DateTimeToStr(StrToDateTime(Lb_MEZ.Caption)- TZ /24);

        LB_OtZ.Caption := DateTimeToStr(StrToDateTime(Lb_Gmt.Caption) + StrToFloat(Lb_Lat_G.Caption)/360)

        ProgressFirstPointOfAries();

        Lb_UTC1.Caption := FloatToStr(Julian(StrToInt(Lb_Jhr.Caption),
                           StrToInt(Lb_Mon.Caption), StrToInt(Lb_Day.Caption),
                           StrToInt(Lb_Hour.Caption), StrToInt(Lb_Min.Caption),
                           StrToInt(Lb_Sek.Caption)));

        //UTC1 := Julian(2018, 9, 18, 0, 0, 0);  // or UTC1 : Julian( Jahr, Monat, Tag, Stunde, Minute, Sekunde)

        Lb_UTC2.Caption := FloatToStrF(((StrToInt(Lb_Hour.Caption) +
                           StrToInt(Lb_Min.Caption)/60 +
                           StrToInt(Lb_Sek.Caption)/3600)/24),ffFixed,4,13);

        // UTC2 := (i + 00/60 + 0/3600)/24; //UTC2 : (Stunde + Minute/60 + Sekunde/3600)/24

        TempDeviation := FloatToStrF(
                           wmmGeomag(1, StrToInt(Lb_Jhr.caption),
                             StrToInt(Lb_Mon.caption), StrToInt(Lb_Day.caption),
                             Frm_Config.FlSpEd_Lon.Value, Frm_Config.FlSpEd_Lat.Value, 0),
                           ffFixed, 4, 14);

        Lb_Mswg1.Caption:= TempDeviation;
        Ed_Mswg.Text    := TempDeviation;


        if not (Ansilowercase(Ed_Egstn.Text) = 'ephemeride') then
          SternLage ()
        else
         Ephemeriden ();
       end;

procedure TFrm_Spori.Tmr_GetDataTimer(Sender: TObject);
  var
     TestFloat: Real;
     StrIn, StrOut: String;
     Beginpos, Endpos: byte;
  begin

    if (ser.WaitingData > 3) then
      begin
        Delay(50);
        ser.Purge;
        Delay(50);
      end;

    if ser.InstanceActive and ser.CanRead(100) then
      begin
       StrIn := ser.Recvstring(20); //EleIst;AziIst;RohEleIst;RohAziIst

      StrIn := StringReplace(StrIn, '.', DefaultFormatSettings.DecimalSeparator, [rfReplaceAll]);

      Endpos := Pos(';', StrIn);
      StrOut := Copy(StrIn, 1, pred(Endpos));

      if TryStrToFloat(StrOut, TestFloat) then
        Ed_Ele_Ist.Text := StrOut;

      BeginPos := succ(Endpos);
      Endpos := PosEx(';', StrIn, succ(Endpos));
      StrOut := Copy(StrIn, BeginPos, Endpos-BeginPos);

      if TryStrToFloat(StrOut, TestFloat) then
        Ed_Azi_Ist.Text := StrOut;

      end;

  end;

    procedure TFrm_Spori.Tmr_NachTimer(Sender: TObject); //Fertig
      var
         Index:Integer;
         InStBild:Boolean;
         Sternbild:Array of TListItem;
      begin

        if CB_StrMode.Text = 'Sternbild' then
          begin
           Setlength(Sternbild,0);
           InStBild  := false;

           for Index := 0 to LV_List.Items.Count-1 do
             if AnsilowerCase(Trim(CB_StB.Text)) = AnsilowerCase(LV_List.Items[Index].SubItems[2]) then
               begin
                 setlength(SternBild, length(SternBild)+1);
                 SternBild[length(SternBild)-1] := LV_List.Items[Index];
                end;

                for Index := 0 to (length(SternBild)-1) do
                  if Ed_Nr.Text = SternBild[Index].Caption then
                    begin
                      if ((StrToFloat(Ed_Ele_Ist.Text) - StrToFloat(Ed_Ele_Soll.Text) < 5) and
                          (StrToFloat(Ed_Ele_Ist.Text) - StrToFloat(Ed_Ele_Soll.Text)  > -5) and
                          (StrToFloat(Ed_Azi_Ist.Text) - StrToFloat(Ed_Azi_Soll.Text) < 5) and
                          (StrToFloat(Ed_Azi_Ist.Text) - StrToFloat(Ed_Azi_Soll.Text)  > -5)) then
                        begin
                          if Index < length(SternBild)-1 then
                            ProgressList (SternBild[Index+1])
                           else
                            ProgressList (SternBild[0]);
                         end;
                      InStBild := true;
                      break;
                    end;
            if (not InStBild) then
             ProgressList (SternBild[0]);

           end;
          if not Frm_Config.Sw_HtKy.Checked then
            SendData ();
       end;

    procedure TFrm_Spori.CB_HKEditingDone(Sender: TObject); //In function auslagern?
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
                  if Uebertrag = AnsilowerCase(LV_List.Items[Index2].SubItems[0]) then
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

procedure TFrm_Spori.ChkB_UpChange(Sender: TObject);  //Fertig
  begin
    if ChkB_Up.Checked then
      begin
        SendData ();
       end;

procedure TFrm_Spori.DE_FrhanfAcceptDate(Sender: TObject; var ADate: TDateTime; var AcceptDate: Boolean);  //Fertig
  var
     Uebertrag:String;
  begin
    if AcceptDate then
      begin
        Uebertrag:=DateTimeToStr(ADate)+' 00:00:00';
        Lb_FrAnf.caption:=Uebertrag;
        OptionsChange(7, Uebertrag);
      end;
   end;

    procedure TFrm_Spori.Bt_ResListClick(Sender: TObject); //Fertig
      begin
        DefaultList ();
        LoadStarList (DefaultListPath);
       end;

    Winkel ();

    OptionsChange(8, Ed_Lamda_G.Text);
   end;

    procedure TFrm_Spori.Bt_StartClick(Sender: TObject); //Fertig?
      begin
        if (LV_List.SelCount <> 0) then
          ProgressList (LV_List.Selected);
       end;

    procedure TFrm_Spori.CB_StrModeChange(Sender: TObject); //Fertig
      begin
        ProgressStarMode(CB_StrMode.ItemIndex);
       end;

    procedure TFrm_Spori.CB_StBEditingDone(Sender: TObject); //In Procedure Auslagern?
      begin
        if IsConstellation () then
          begin
            Tmr_Nach.Enabled := true;
            CB_StrMode.Text  := 'Sternbild';
            Mmo_Bsbg.Text    := 'Fährt ein Sternbild nach und verfolgt dieses.';
           end
         else
          ProgressNumber ();
       end;

    end.
