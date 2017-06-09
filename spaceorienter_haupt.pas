unit SpaceOrienter_Haupt;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, RTTICtrls, Forms, Controls, Graphics, Dialogs,
  Menus, StrUtils, StdCtrls, ComCtrls, ActnList, ExtCtrls, PopupNotifier,
  EditBtn, Buttons, math, windows{,
  PlanEph32};

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

  private
    function  Gleiche(str1, str2: string): Real;
    function  Connect ():Boolean;
    function  SendData ():Boolean;
    function  IstSternBild ():Boolean;
    function  LoadStarList (pfad:String; i: Integer = 0):Boolean;
    function  LoadOptions (i:integer = 0):Boolean;
    function  OptionsChange (index:Integer; Change:String; i:Integer = 0):Boolean;
    procedure DefaultOptions ();
    procedure DefaultList ();
    procedure EintragMode (Mode:String);
    procedure Exp (Save:Boolean = true);
    procedure EintragList (Item:TListItem);
    procedure EintragNummer (Normal:Boolean = true);
    procedure Update_ ();
    procedure Winkel ();
    procedure Fruehpunkt ();
    procedure SternLage();
    procedure Ephemeriden ();
    procedure Suchen (SuchStr:String);

  public
    { public declarations }
  end;

var
  Frm_Spori: TFrm_Spori;
  DiffD:TDate;
  DiffT:TTime;
  Sternbild:Array of TListItem;

implementation

{$R *.lfm}

{ TFrm_Spori }

//function Julian(Year, Month, Day, Hour, Minute, Second: Integer): Double; stdcall; external 'PlanEph32.dll';
//function Ephem(Version, Frame, Body, Value, Adjust: Integer; utc1, utc2, Lon, Lat, TZ, xp, yp, dut1, hm, ra, rb: Double): Double; stdcall; external 'PlanEph32.dll';
//function wmmGeomag(Value, Year, Month, Day: Integer; Lon, Lat, Height: Double): Double; stdcall; external 'PlanEph32.dll';
//function sgp4Eph(value, satnum, datum, epochyr: Integer; epochdays, bstar, i, n, e, w, mo, no, utc1, utc2, dut1, glo, gla: Double): Double; stdcall; external 'PlanEph32.dll';

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

    if (str1 <> '') and (str2 <> '') then
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

function TFrm_Spori.Connect ():Boolean; //ToDo
  begin
    result:=false;
  end;

function TFrm_Spori.SendData ():Boolean; //ToDo
  begin
    Result:=false;
   end;

function TFrm_Spori.IstSternBild ():Boolean; //Fertig
  var
     Index,Index2:Integer;
     Uebertrag:String;
  begin
    Result:=false;
    Uebertrag:=AnsiLowerCase(Trim(CB_StB.Caption));

    for Index:=0 to CB_StB.Items.Count-1 do
      if Uebertrag = CB_StB.Items[Index] then
        for Index2:=0 to LV_List.Items.Count-1 do
          if Uebertrag = AnsilowerCase(LV_List.Items[Index2].SubItems[2]) then
            Result:=true;
   end;

function TFrm_Spori.LoadStarList (pfad:String; i:Integer = 0):Boolean; //SQL verwenden
  const
     Defaultpfad = 'C:\ProgramData\FireInstallations\SpaceOrienter\StarList.Space' ;
  var
     index, Help, Index_L, Index_R:Integer;
     Stars:TStringlist;
     Item:TListItem;
     Tausch, Merke:String;
     Sortet:Boolean;
  begin
     result:=True;
     Stars:=TStringlist.create;

     if (pfad = Defaultpfad) then
       if not FileExists(Defaultpfad) then
         DefaultList ();

     try

       Stars.LoadFromFile(pfad);
       Index_R:=Stars.count-1;

       repeat
         Index_L:=0;
         Sortet:=true;
         while (Index_L < Index_R) do
           begin
	     Tausch:=Trim(copy(Stars[Index_L],0,Pos(';',Stars[Index_L])-1));
	     Merke:=Trim(copy(Stars[Index_R],0,Pos(';',Stars[Index_R])-1));

	     if TryStrToInt (Tausch, Help) and TryStrToInt (Merke, Help) then
	       if StrToInt (Tausch) > StrToInt (Merke) then
	         begin
		   Tausch:=Stars[Index_L];
		   Stars[Index_L]:=Stars[Index_R];
		   Stars[Index_R]:=Tausch;
                   Sortet:=false;
         	  end;
	     Inc (Index_L);
            end;
	 Dec(Index_R);
       until Sortet;

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

                 if Index_R = 1 then
                   if CB_HK.Items.IndexOf(AnsiLowerCase(Merke)) < 0 then
                     CB_HK.Items.Add(AnsiLowerCase(Merke));

                 if Index_R = 3 then
                   if CB_StB.Items.IndexOf(AnsiLowerCase(Merke)) < 0 then
                     if (Merke <> '-') and (AnsiLowerCase(Merke) <> 'unsichtbar') and (Merke <> '')then
                       CB_StB.Items.Add(AnsiLowerCase(Merke));

                 Help:=Index_L;
                end;
            end;

       if not (pfad = Defaultpfad) then
         begin
           ForceDirectories ('C:\ProgramData\FireInstallations\SpaceOrienter\OldLists');
           RenameFile (Defaultpfad,'C:\ProgramData\FireInstallations\SpaceOrienter\OldLists\StarList'+formatdatetime('d.m.y-h;n;s;z',Now)+'.old');
           Stars.SaveToFile(Defaultpfad);
          end;

     except
       Stars.Free;
       showmessage('Fehler aufgetreten: Fehler bei SternenListe.'+
                     slinebreak+'Bitte kontaktieren Sie FireInstallations!'+
                     slinebreak+'SternenListe wird zurückgesetzt.');

        ForceDirectories ('C:\ProgramData\FireInstallations\SpaceOrienter\OldLists');
        RenameFile (Defaultpfad,'C:\ProgramData\FireInstallations\SpaceOrienter\OldLists\StarList'+formatdatetime('d.m.y-h;n;s;z',Now)+'.old');

        if i <= 2 then
          begin
            LoadStarList (pfad, i+1);
           end else
            result:=false;
      end;
     Stars.Free;
  end;

function TFrm_Spori.LoadOptions (i:integer = 0):Boolean; //Sql verwenden + Mode In Procedur auslagern?
  const
     DefaultPfad = 'C:\ProgramData\FireInstallations\SpaceOrienter\Options.Space';
  var
     Options:TStrings;
     Help:Integer;
     Help_Zeit:TDateTime;
     Uebertrag:String;
     Pruef:Float;
  begin
    Options:=Tstringlist.Create;
    Result:=true;

    try
      if not FileExists (DefaultPfad) then
        DefaultOptions();

      Options.LoadFromFile(DefaultPfad);

      Assert((Options.Count >= 16),'Fehler in Ladevorgang:' + SlineBreak +
                               'Zu wenig Argumente');

      for Help:= Options.count-1 downto 0 do
        if (Options[Help] = '') or (Trim(Options[Help])[1] = '#') then
          Options.Delete(Help);

      if Pos('true',AnsiLowerCase(Options[0])) <> 0 then
        begin
          MI_Sicht_Exp.Checked:=true;
          Exp(false);
         end
       else
        if Pos('false',AnsiLowerCase(Options[0])) <> 0 then
          MI_Sicht_Exp.Checked:=false
         else
          raise Exception.Create('Fehler in ExpertenMode-Ladevorgang');

      if Pos('true',AnsiLowerCase(Options[1])) <> 0 then
        begin
          ChkB_Up.Checked:=true;
          Update_ ();
        end
       else
        if Pos('false',AnsiLowerCase(Options[1])) <> 0 then
          ChkB_Up.Checked:=false
         else
          raise Exception.Create('Fehler in UpdateMode-Ladevorgang');

      Help:=Pos('"',Options[2]);
      CB_StrMode.Text:=copy(Options[2],Help+1,PosEx('"',Options[2],Help+1)-1-Help);

      if Pos('manuell',AnsiLowerCase(Options[3])) <> 0 then
        begin
          TE_Manu.enabled:=true;
          DE_Manu.enabled:=true;
          DE_Frhanf.enabled:=true;

          Help:=Pos('"',Options[4]);
          Uebertrag:=Copy(Options[4],Help+1,PosEx('"',Options[4],Help+1)-1-Help);
          if TryStrToDate(Uebertrag,Help_Zeit) then
            begin
              DiffD:=StrToDate(Uebertrag)-Date;
              DE_Manu.Date:=Date + DiffD;
             end
           else
            raise Exception.Create('Fehler in Tag-Ladevorgang');

          Help:=Pos('"',Options[6]);
          Uebertrag:=Copy(Options[6],Help+1,PosEx('"',Options[6],Help+1)-1-Help);
          if TryStrToTime(Uebertrag,Help_Zeit) then
            begin
              DiffT:=StrToTime(Uebertrag)-Time;
              TE_Manu.Time:=Time + DiffT
            end;

          ChkB_TmMd.checked:=false;
         end
       else
        if Pos('auto',AnsiLowerCase(Options[3])) <> 0 then
          begin
            ChkB_TmMd.checked:=true;
            TE_Manu.enabled:=false;
            DE_Manu.enabled:=false;
            DE_Frhanf.enabled:=false;
           end
         else
          raise Exception.Create('Fehler in TimeMode-Ladevorgang');

      Help:=Pos('"',Options[7]);
      Uebertrag:=Copy(Options[7],Help+1,PosEx('"',Options[7],Help+1)-1-Help);
      if TryStrToDateTime(Uebertrag,Help_Zeit) then
        begin
          Lb_FrAnf.caption:=Uebertrag;
          DE_Frhanf.Date:=StrToDateTime(Uebertrag);
         end
       else
        raise Exception.Create('Fehler in FrühjahrsPunkt-Ladevorgang');

      Help:=Pos('"',Options[8]);
      Uebertrag:=copy(Options[8],Help+1,PosEx('"',Options[8],Help+1)-1-Help);
      if TryStrToFloat (Uebertrag, Pruef) then
        begin
          Lb_Phi_G.Caption:=Uebertrag;
          Ed_Phi_G.Text:=Uebertrag;
          Lb_Phi_G1.Caption:=Uebertrag;
         end
       else
        raise Exception.Create('Fehler in LamdaR-Ladevorgang');

      Help:=Pos('"',Options[9]);
      Uebertrag:=copy(Options[9],Help+1,PosEx('"',Options[9],Help+1)-1-Help);
      if TryStrToFloat (Uebertrag, Pruef) then
        begin
          LB_Lam_G.Caption:=Uebertrag;
          Ed_Lamda_G.Text:=Uebertrag;
          Lb_Lam_G1.Caption:=Uebertrag;
         end
       else
        raise Exception.Create('Fehler in PhiG-Ladevorgang');

      Winkel ();

      Help:=Pos('"',Options[10]);
      Uebertrag:=copy(Options[10],Help+1,PosEx('"',Options[10],Help+1)-1-Help);
      if TryStrToInt (Uebertrag, Help) then
        begin
          Lb_MngMswg.Caption:=Uebertrag;
          Ed_MgMswg.Text:=Uebertrag;
        end
       else
        raise Exception.Create('Fehler in Missweisung-Ladevorgang');

      if Pos('manuell',AnsiLowerCase(Options[11])) <> 0 then
        begin
          CkB_Port_Auto.checked:=false;
          ED_Port.enabled:=true;

          Help:=Pos('"',Options[12]);
          Uebertrag:=copy(Options[12],Help+1,PosEx('"',Options[12],Help+1)-1-Help);
          if TryStrToInt (Uebertrag,Help) then
            ED_Port.Text:=Uebertrag
           else
            raise Exception.Create('Fehler in Port-Ladevorgang');
         end
       else
        if Pos('auto',AnsiLowerCase(Options[11])) <> 0 then
          begin
            CkB_Port_Auto.checked:=true;
            ED_Port.enabled:=false;
           end
         else
          raise Exception.Create('Fehler in PortMode-Ladevorgang');

      if Pos('manuell',AnsiLowerCase(Options[13])) <> 0 then
        CkB_ManuAnSt.Checked:=true
       else
        if Pos('auto',AnsiLowerCase(Options[13])) <> 0 then
          CkB_ManuAnSt.Checked:=false
         else
          raise Exception.Create('Fehler in Manuelle Werte-Ladevorgang');

      if Pos('auto',AnsiLowerCase(Options[14])) <> 0 then
        begin
          TgB_AutoWert.Checked:=true;
          TgB_AutoWert.Caption:='Verwende Hotkey';
         end
       else
        if Pos('manuell',AnsiLowerCase(Options[14])) <> 0 then
          begin
            TgB_AutoWert.Checked:=false;
            TgB_AutoWert.Caption:='Automatische Wertübergabe';
           end
         else
          raise Exception.Create('Fehler in Auto-Ansteuerung-Ladevorgang');

      Help:=Pos('"',Options[15]);
      Uebertrag:=copy(Options[15],Help+1,PosEx('"',Options[15],Help+1)-1-Help);
      if TryStrToInt (Uebertrag,Help) then
        begin
          Ed_Nr.Text:=Uebertrag;
         end
       else
        raise Exception.Create('Fehler in Nummer-Ladevorgang');

       Result:=LoadStarList('C:\ProgramData\FireInstallations\SpaceOrienter\StarList.Space');
       EintragNummer (False);

       Help:=Pos('"',Options[16]);
       EintragMode(copy(Options[16],Help+1,PosEx('"',Options[16],Help+1)-1-Help));

    except
      Options.free;
      showmessage('Fehler aufgetreten: Fehler in den OptionsLoad.'+
                   slinebreak+'Bitte kontaktieren Sie FireInstallations!'+
                   slinebreak+'Einstellungen werden zurückgesetzt.');

      ForceDirectories ('C:\ProgramData\FireInstallations\SpaceOrienter\OldOptions');
      RenameFile (DefaultPfad,'C:\ProgramData\FireInstallations\SpaceOrienter\OldOptions\Options'+formatdatetime('d.m.y-h;n;s;z',Now)+'.old');

      if i <= 2 then
        LoadOptions (i+1)
       else
        result:=false;
     end;
       Options.free;
   end;

function TFrm_Spori.OptionsChange (Index:Integer; Change:String; i:Integer = 0):Boolean; //Fertig
  var
     Help:Integer;
     HelpIndex:Array of Integer;
     Loesch:String;
     Options:TStrings;
  begin

    Options:=TStringlist.create;
    Result:=True;

    try
      if not FileExists ('C:\ProgramData\FireInstallations\SpaceOrienter\Options.Space') then
        DefaultOptions();

      Options.LoadFromFile('C:\ProgramData\FireInstallations\SpaceOrienter\Options.Space');

      for Help:= 0 to Options.count-1 do
        if Options[Help] <> '' then
          begin
            if Trim(Options[Help])[1] = '#' then
              begin
                SetLength(HelpIndex,length(HelpIndex)+1);
                HelpIndex[length(HelpIndex)-1]:=Help;
               end;
           end
         else
          begin
            SetLength(HelpIndex,length(HelpIndex)+1);
            HelpIndex[length(HelpIndex)-1]:=Help;
           end;
      for Help:=1 to length(HelpIndex) do
        if HelpIndex[Help-1] <= Index then
          inc(Index);

      Help:=Pos('"',Options[index]);
      Loesch:=copy(Options[index],Help+1,PosEx('"',Options[index],Help+1)-1-Help);
      Options[index]:=StringReplace(Options[index],Loesch,change,[]);

      Options.SaveToFile('C:\ProgramData\FireInstallations\SpaceOrienter\Options.Space');
    except
        Options.free;
        result:=false;
        showmessage('Fehler aufgetreten: Fehler in OptionsChange.'+
                     slinebreak+'Bitte kontaktieren Sie FireInstallations!'+
                     slinebreak+'Einstellungen werden zurückgesetzt.');

        ForceDirectories ('C:\ProgramData\FireInstallations\SpaceOrienter\OldOptions');
        RenameFile ('C:\ProgramData\FireInstallations\SpaceOrienter\Options.Space','C:\ProgramData\FireInstallations\SpaceOrienter\OldOptions\Options'+formatdatetime('d.m.y-h;n;s;z',Now)+'.old');

        if i <= 2 then
          begin
            LoadOptions ();
            OptionsChange (Index, Change,i+1);
           end else
            halt (219);
      end;
       Options.free;
  end;

procedure TFrm_Spori.DefaultOptions (); //Fertig?
  var
     Options:TStrings;
  begin
    try
      Options:=TStringList.create;

      Options.Add('#*-+-~-+-*-+-~-{Spaceorienter Einstellungen}-~-+-*-+-~-~-*');
      Options.Add('#|Bitte Editiere nur, wenn du weisst, was du tust!       |');
      Options.Add('#|                                                       |');
      Options.Add('#|Zeitvormat bei Time: DD.MM.YYYY SS:NN:HH               |');
      Options.Add('#*-------------------------------------------------------*');
      Options.Add('#');
      Options.Add('ExpertenMode:  "False"');
      Options.Add('AutoUpdates:   "True"');
      Options.Add('Place:         "Zeuthen"');
      Options.Add('TimeMode:      "Auto"');
      Options.Add('Day:           "01.01.2017"');
      Options.Add('TimeBackward:  "eslaf"');
      Options.Add('Time:          "01:01:01"');
      Options.Add('Frührjahr:     "20.03.2017 00:00:00"');
      Options.Add('Phi:           "52,345"');
      Options.Add('Lamda:         "13,604"');
      Options.Add('MagMissweisung:"100"');
      Options.Add('ComMode:       "Manuell"');
      Options.Add('Com:           "0"');
      Options.Add('WerteMode:     "Auto"');
      Options.Add('Ansteuerung:   "Manuell"');
      Options.Add('HimmelsKörper: "0"');
      Options.Add('StarMode:      "Normal"');

      ForceDirectories ('C:\ProgramData\FireInstallations\SpaceOrienter');
      Options.SaveToFile ('C:\ProgramData\FireInstallations\SpaceOrienter\Options.Space');
    finally
      Options.free;
    end;
  end;

procedure TFrm_Spori.DefaultList ();  //Fertig
  var
     List:Tstrings;
  begin

    List:=TstringList.create;

    try

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

      ForceDirectories ('C:\ProgramData\FireInstallations\SpaceOrienter');
      List.SaveToFile ('C:\ProgramData\FireInstallations\SpaceOrienter\StarList.Space');

    finally
      List.Free;
     end;
   end;

procedure TFrm_Spori.EintragMode (Mode:String); //Fertig
  begin
    case AnsiLowerCase(Mode) of
      'normal':
        begin
          CB_StrMode.Text:='Normal';
          Mmo_Bsbg.Text:='Peilt den ausgewählten Himmelskörper / die ausgewählte Position an.';
          OptionsChange(16,'Normal');
          Tmr_Nach.Enabled:=false;
         end;
      'nachführen':
        begin
          CB_StrMode.Text:='Nachführen';
          Mmo_Bsbg.Text:='Peilt den ausgewählten Himmelskörper an und verfolgt diesen auf dem Himmel';
          OptionsChange(16,'Nachfuehren');
          Tmr_Nach.Enabled:=true;
         end;
      'position':
        begin
          CB_StrMode.Text:='Normal';
          Mmo_Bsbg.Text:='Sobald ein Himmelsköper (manuell) angestuert wurde, wird der Name ausgegeben.';
          OptionsChange(16,'Position');
          Tmr_Nach.Enabled:=false;
         end;
      'ort':
        begin
          CB_StrMode.Text:='Normal';
          Mmo_Bsbg.Text:='Gibt den eigenen Ort aus. '+#10+'Hierzu muss ein Himmelskörper angesteuert und richtig benannt werden.';
          OptionsChange(16,'Ort');
          Tmr_Nach.Enabled:=false;
         end;
      'zeit':
        begin
          CB_StrMode.Text:='Normal';
          Mmo_Bsbg.Text:='Gibt die aktuelle Zeit aus. '+#10+'Hierzu muss ein Himmelskörper angesteuert und richtig benannt werden.';
          OptionsChange(16,'Zeit');
          Tmr_Nach.Enabled:=false;
         end;
      'sternbild':
        begin
          if IstSternBild () then
            begin
              CB_StrMode.Text:='Sternbild';
              Mmo_Bsbg.Text:='Fährt ein Sternbild nach und verfolgt dieses.';
              OptionsChange(16,'SternBild');
              Tmr_Nach.Enabled:=true;
             end
           else
            begin
              CB_StrMode.Text:='Normal';
              Mmo_Bsbg.Text:='Peilt den ausgewählten Himmelskörper / die ausgewählte Position an.';
              OptionsChange(16,'Normal');
              Tmr_Nach.Enabled:=false;
            end;
        end;
     else
      begin
        raise Exception.Create('Fehler in Change-Mode-Vorgang');
        Mmo_Bsbg.Text:='Error';
       end;
     end;
   end;

procedure TFrm_Spori.Exp (Save:Boolean = True); //Experten Eintstellungen trennen
  begin
    if  MI_Sicht_Exp.Checked then
      begin

        if Save then
          OptionsChange (0, 'True');

        TbS_Lag.TabVisible:=true;
        TbS_Einst.TabVisible:=true;
        Ts_Ephi.TabVisible:=true;

        LV_List.Column[0].Width:=60;
        LV_List.Column[0].Caption:='Nr.';
        LV_List.Column[1].Width:=125;
        LV_List.Column[2].Width:=110;
        LV_List.Column[3].Width:=110;
        LV_List.Column[4].Width:=120;
        LV_List.Column[5].Width:=50;
        LV_List.Column[6].Width:=70;
        LV_List.Column[7].Width:=50;
        LV_List.Column[8].Width:=70;

        LV_List.Column[5].Visible:=true;
        LV_List.Column[6].Visible:=true;
        LV_List.Column[7].Visible:=true;
        LV_List.Column[8].Visible:=true;
       end else
        begin
          if Save then
            OptionsChange (0, 'False');

          TbS_Lag.TabVisible:=false;
          TbS_Einst.TabVisible:=false;
          Ts_Ephi.TabVisible:=false;
          LV_List.Column[0].Width:=110;
          LV_List.Column[0].Caption:='Nummer';
          LV_List.Column[1].Width:=180;
          LV_List.Column[2].Width:=150;
          LV_List.Column[3].Width:=160;
          LV_List.Column[4].Width:=170;
          LV_List.Column[5].Visible:=false;
          LV_List.Column[6].Visible:=false;
          LV_List.Column[7].Visible:=false;
          LV_List.Column[8].Visible:=false;
         end;
   end;

procedure TFrm_Spori.EintragList (Item:TListItem); //Fertig?
  var
     Hilf:Float;
     i:Integer;
  procedure Neu ();
    begin
      showmessage('Fehler aufgetreten: Fehler bei SternenListe.'+
                     slinebreak+'Bitte kontaktieren Sie FireInstallations!'+
                     slinebreak+'SternenListe wird zurückgesetzt.');

      ForceDirectories ('C:\ProgramData\FireInstallations\SpaceOrienter\OldLists');
      RenameFile ('C:\ProgramData\FireInstallations\SpaceOrienter\StarList.Space','C:\ProgramData\FireInstallations\SpaceOrienter\OldLists\StarList'+formatdatetime('d.m.y-h;n;s;z',Now)+'.old');
      LoadStarList ('C:\ProgramData\FireInstallations\SpaceOrienter\StarList.Space');
     end;

  begin
    OptionsChange (15, Item.Caption);

    for i:= 0 to LV_List.Items.Count-1 do
      if not (LV_List.Items[i] = Item) then
        LV_List.Items[i].Checked:=false;
    Item.Checked:=true;

    Ed_Nr.Text:=Item.Caption;
    CB_HK.caption:=Item.SubItems[0];
    CB_StB.caption:=Item.SubItems[2];
    Ed_Egstn.Text:=Item.SubItems[3];

    if not (Ansilowercase(Item.SubItems[0]) = 'ruheposition') and
       not (Ansilowercase(Item.SubItems[3]) = 'ephemeride' ) then
      begin
        if TryStrToFloat (Item.SubItems[4],Hilf) then
          Lb_Rtzn_Grd.Caption:=Item.SubItems[4]
         else
          Neu ();
        if TryStrToFloat (Item.SubItems[5],Hilf) then
          Lb_Rtzn_Rd.Caption:=Item.SubItems[5]
         else
          Neu ();
        if TryStrToFloat (Item.SubItems[6],Hilf) then
          Lb_Dekli_Grd.Caption:=Item.SubItems[6]
         else
          Neu ();
        if TryStrToFloat (Item.SubItems[7],Hilf) then
          Lb_Dekli_Rd.Caption:=Item.SubItems[7]
         else
          Neu ();
      end
     else
      if (Ansilowercase(Item.SubItems[0]) = 'ruheposition') then
        begin
          Ed_Ele_Soll.Text:='89';
          Ed_Azi_Soll.Text:='89';
         end;
   end;

procedure TFrm_Spori.EintragNummer (Normal:Boolean = true);   //Reaktion auf nicht exestenz
  var
     Item:TListItem;
  begin
    Item:=LV_List.Items.FindCaption(0, IntToStr(StrToInt(Ed_Nr.Text)), false, false, true);
    if Assigned(Item) then
      begin
        EintragList (Item);
        if (CB_StrMode.Caption = 'Sternbild') and Normal then
          begin
            Tmr_Nach.Enabled:=false;
            CB_StrMode.Text:='Normal';
            Mmo_Bsbg.Text:='Peilt den ausgewählten Himmelskörper / die ausgewählte Position an.';
           end;
      end
     else
      if Ed_Nr.Text = '0' then
        begin
          Item:=LV_List.Items[0];
          EintragList (Item);

          if (CB_StrMode.Caption = 'Sternbild') and Normal then
            begin
              Tmr_Nach.Enabled:=false;
              CB_StrMode.Text:='Normal';
              Mmo_Bsbg.Text:='Peilt den ausgewählten Himmelskörper / die ausgewählte Position an.';
             end;
        end;
   end;

procedure TFrm_Spori.Update_ (); //ToDo
  begin
    showmessage ('Updatefunction noch nicht implementiert!');
  end;

procedure TFrm_Spori.Winkel ();
  var
     Uebertrag:String;
  begin
    Uebertrag:=FloatToStr(StrToFloat(Lb_Lam_G.Caption)*Pi/180);
    Lb_Lam_R.Caption:= Uebertrag;
    Lb_Lam_R1.Caption:=Uebertrag;

    Uebertrag:=FloatToStr(StrToFloat(Lb_Phi_G.Caption)*Pi/180);
    Lb_Phi_R.Caption:= Uebertrag;
    Lb_Phi_R1.Caption:=Uebertrag;
  end;

procedure TFrm_Spori.Fruehpunkt ();  //Fertig
  var
     Void,Hour,Minute,Sekunde:Word;
     Hilf_:Real;
  begin
    Hilf_:=StrToDateTime(Lb_Gmt.caption)-StrToDateTime(Lb_FrAnf.caption);
    Lb_Diff.caption:=FloatToStrF(Hilf_,ffFixed,4,13);
    Hilf_:=Hilf_*360/365;
    Lb_GSft.caption:=FloatToStrF(Hilf_,ffFixed,4,13);

    DecodeTime(StrToDateTime(Lb_Gmt.Caption),Hour,Minute,Sekunde,Void);
    Hilf_:=(Hour*15)+Hilf_+179.928333;

    if (Hilf_>360) then
      Hilf_-=360;

    Lb_FrPnk.caption:=FloatToStrF(Hilf_,ffFixed,4,13);

    Lb_ZW.Caption:=FloatToStrF((Minute*15/60+Sekunde*15/3600),ffFixed,4,13);

    Hilf_:=Minute*15/60+Sekunde*15/3600+StrToFloat(Lb_FrPnk.caption);
    if Hilf_>360 then
      Hilf_-=360;

      LbAkFrPnk.caption:=FloatToStrF(Hilf_,ffFixed,4,13);

  end;

procedure TFrm_Spori.SternLage ();  //Fertig
  var
     Hilf:Float;
  begin

    Hilf:=StrToFloat(Lb_Rtzn_Grd.Caption)+(StrToFloat(Lb_Rtzn_Rd.caption)/60);
    Lb_StWk.caption:=FloatToStrF(Hilf,ffFixed,4,13);

    Hilf:=StrToFloat(Lb_Rtzn_Grd.caption)+StrToFloat(Lb_Rtzn_Rd.caption)/60;
    Lb_Beta.Caption:=FloatToStrF((Hilf*Pi/180),ffFixed,4,13);

    Hilf:=StrToFloat(Lb_Dekli_Grd.caption)+StrToFloat(Lb_Dekli_Rd.caption)/60;
    Lb_Delt.caption:=FloatToStrF((Hilf*Pi/180),ffFixed,4,13);

    Hilf:=StrToFloat(LbAkFrPnk.caption)+StrToFloat(Lb_StWk.Caption);
    if (Hilf > 360) then
      Hilf-=360;
    Lb_Grt.caption:=FloatToStrF(Hilf,ffFixed,4,13);

    Hilf+=StrToFloat(Lb_Lam_G.Caption);
    if (Hilf > 360) then
      Hilf-=360;
     Hilf*=(Pi/180);
    Lb_T.caption:=FloatToStrF(Hilf,ffFixed,4,13);

    Hilf:=ArcSin(Sin(StrToFloat(Lb_Phi_R.caption))*Sin(StrToFloat(Lb_Delt.caption))+Cos(StrToFloat(Lb_Phi_R.caption))*Cos(StrToFloat(Lb_Delt.caption))*Cos(Hilf));
    Hilf:=Hilf*180/Pi;
    Lb_El.caption:=FloatToStrF(Hilf,ffFixed,4,11);
    if not CkB_ManuAnSt.Checked and not (Ansilowercase(CB_HK.caption) = 'ruheposition') then
      Ed_Ele_Soll.text:=FloatToStrF(Hilf,ffFixed,4,12);

    Lb_Az_Z.Caption:=FloatToStrF(Sin(-StrToFloat(Lb_T.caption)),ffFixed,4,13);

    Hilf:=Sin(StrToFloat(Lb_Phi_R.caption))*Cos(StrToFloat(Lb_T.caption));
    Hilf:=Tan(StrToFloat(Lb_Delt.caption))*Cos(StrToFloat(Lb_Phi_R.caption))-Hilf;
    Lb_Az_N.Caption:=FloatToStrF(Hilf,ffFixed,4,13);

    Hilf:=ArcTan2(StrToFloat(Lb_Az_Z.Caption),Hilf)*180/PI();
    if (Hilf <= 0) then
      Hilf+=360;

    Lb_Az.caption:=FloatToStrF(Hilf,ffFixed,4,11);
    if not CkB_ManuAnSt.Checked and not (Ansilowercase(CB_HK.caption) = 'ruheposition') then
      Ed_Azi_Soll.text:=FloatToStrF(Hilf,ffFixed,4,12);

    Ed_Mswg.Text:='-';
  end;

procedure TFrm_Spori.Ephemeriden ();  //ToFix
  var
     Lon, Lat, TZ, xp, yp, dut1, hm, ra, rb:Double;
     HKToNr:Integer;
     Uebertrag:String;
  begin
    if Trim(AnsiLowerCase(Lb_SmrZ1.Caption)) = 'wahr' then
      TZ:=2
     else
      TZ:=1;

    Case Trim(AnsiLowerCase(CB_HK.Caption)) of
      'merkur': HKToNr:=1;
      'venus': HKToNr:=2;
      'erde': HKToNr:=3;
      'mars': HKToNr:=4;
      'jupiter': HKToNr:=5;
      'saturn': HKToNr:=6;
      'uranus': HKToNr:=7;
      'neptun': HKToNr:=8;
      'pluto': HKToNr:=9;
      'mond': HKToNr:=10;
      'sonne': HKToNr:=11;
     else
      HKToNr:=3;  //Error
     end;

    //Uebertrag:=FloatToStrF(Ephem(0, 1, HKToNr, 17, 1,
    //           StrToFloat(Lb_UTC1.Caption),  StrToFloat(Lb_UTC2.Caption),
    //           Lon, Lat, TZ, xp, yp, dut1, hm, ra, rb),ffFixed, 4, 13); //TZ richtig? + Was bedeuten sie?

    Lb_El1.Caption:=Uebertrag;
    Ed_Ele_Soll.Text:=Uebertrag;

    //Uebertrag:=FloatToStrF(Ephem(0, 1, HKToNr, 18, 1,
    //           StrToFloat(Lb_UTC1.Caption),  StrToFloat(Lb_UTC2.Caption),
    //           Lon, Lat, TZ, xp, yp, dut1, hm, ra, rb)); //TZ richtig? + Was bedeuten sie?

    Lb_Az1.Caption:=Uebertrag;
    Ed_Azi_Soll.Text:=Uebertrag;

    //Uebertrag:=FloatToStrF(wmmGeomag(1, StrToInt(Lb_Jhr.caption),
    //           StrToInt(Lb_Mon.caption), StrToInt(Lb_Day.caption),
    //           Lon, Lat, Height), ffFixed, 4, 14);       //Was sind die 3 Werte?

    Lb_Mswg1.Caption:=Uebertrag;
    Ed_Mswg.Text:=Uebertrag;
   end;

procedure TFrm_Spori.Suchen (SuchStr:String); //Fertig
  var
     Index,Index2:Integer;
     Item:TListItem;
  begin
    Item:= LV_List.Items.FindCaption(0,SuchStr,false, false, true);

    if Assigned(Item) then
      begin
        LV_List.Selected:=Item;
        PgC_Haupt.TabIndex:=1;
        LV_List.SetFocus;
        LV_List.ItemFocused:=LV_List.Items[0];
        LV_List.Items[Item.Index].MakeVisible(false);
       end
     else
      if SuchStr = '0' then
        begin
          LV_List.Selected:=LV_List.Items[0];
          PgC_Haupt.TabIndex:=1;
          LV_List.SetFocus;
          LV_List.ItemFocused:=LV_List.Items[0];
          LV_List.Items[0].MakeVisible(false);
         end
       else
         for Index:=0 to LV_List.Items.Count-1 do
           for Index2:=0 to Lv_List.Items[Index].SubItems.Count-1 do
             if Gleiche (SuchStr, AnsilowerCase(LV_List.Items[Index].SubItems[Index2]))>= 60 then
               begin
                 LV_List.Selected:=LV_List.Items[Index];
                 PgC_Haupt.TabIndex:=1;
                 LV_List.SetFocus;
                 LV_List.ItemFocused:=LV_List.Items[Index];
                 LV_List.Items[Index].MakeVisible(false);
                end;
   end;

procedure TFrm_Spori.Ed_NrEditingDone(Sender: TObject); //Fertig?
  begin
    EintragNummer ();
   end;

procedure TFrm_Spori.Ed_Phi_GEditingDone(Sender: TObject); //Fertig
  begin
    Lb_Phi_G.Caption:=Ed_Phi_G.Text;
    Lb_Phi_G1.Caption:=Ed_Phi_G.Text;

    Winkel ();

    OptionsChange(9, Ed_Phi_G.Text);
   end;

procedure TFrm_Spori.ED_PortEditingDone(Sender: TObject); //Connectinfo verarbeiten
  begin
    Connect ();
    OptionsChange (12, ED_Port.Text);
   end;

procedure TFrm_Spori.Ed_SuchEditingDone(Sender: TObject); //Fertig
  begin
    if not (Ed_Such.Text = 'Suchen...') and not ( Ed_Such.Text = '') then
      Suchen (Trim(Ed_Such.Text));
   end;

procedure TFrm_Spori.Ed_SuchEnter(Sender: TObject);  //Fertig
  begin
    if Ed_Such.Text = 'Suchen...' then
      Ed_Such.Text:=''
     else
      Ed_Such.SelectAll;
   end;

procedure TFrm_Spori.Ed_SuchExit(Sender: TObject);  //Fertig
  begin
    if Ed_Such.Text = '' then
      Ed_Such.Text:='Suchen...';
   end;

procedure TFrm_Spori.FndDFind(Sender: TObject); //Fertig
  var
     Uebertrag:String;
  begin
    Uebertrag:=FndD.FindText;
    if frMatchCase in FndD.Options then
      Uebertrag:=AnsiLowerCase(Uebertrag);

    FndD.CloseDialog;

   Suchen(Uebertrag);
   end;

procedure TFrm_Spori.FormCreate(Sender: TObject);   //Connectinfo verarbeiten + ISS mit aufnehmen  + Orte in eigende Liste + Hinweise + ApplicationPropperties + PopupMenues + Shortcuts + Portable Version + auf Dll prüfen + Installer
  begin
    if not LoadOptions() then
      showmessage('Entschuldigung.' + slinebreak +
                  'Ich war NICHT Erfolgreich den Fehler zu beheben. :(' +
                  slinebreak + slinebreak +
                  'Beende Programm. Bitte kontaktiere FireInstallations');

    Connect ();
    Tmr_Berech.Enabled:=true;

    PgC_Haupt.TabIndex:=0;
   end;

procedure TFrm_Spori.LV_ListDblClick(Sender: TObject); //Fertig?
  begin
    if LV_List.SelCount <> 0 then
      EintragList (LV_List.Selected);
   end;

procedure TFrm_Spori.LV_ListItemChecked(Sender: TObject; Item: TListItem); //Fertig?
  begin
    EintragList(Item);
   end;

procedure TFrm_Spori.LV_ListKeyPress(Sender: TObject; var Key: char); //Fertig
  begin
    if (LV_List.SelCount <> 0) and (Key = #13) then
      EintragList (LV_List.Selected);
   end;

procedure TFrm_Spori.MI_DatSchutzClick(Sender: TObject); //ToDo
  begin
    Showmessage('Wir von  FireInstallations & Co möchten der gesammten ' +
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

procedure TFrm_Spori.MI_ConnectClick(Sender: TObject);  //ToDo
  begin

   end;

procedure TFrm_Spori.MI_Dar_QuitClick(Sender: TObject);  //Fertig
  begin
    Halt;
   end;

procedure TFrm_Spori.MI_Hilf_FehClick(Sender: TObject);  //toDo
  begin

   end;

procedure TFrm_Spori.MI_SuchClick(Sender: TObject); //Wenn nicht Last error
  begin
    FndD.FindText:=CB_HK.Text;
    FndD.Execute;
   end;

procedure TFrm_Spori.MI_UeberClick(Sender: TObject); //ToDo
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

procedure TFrm_Spori.MI_VerbEinstClick(Sender: TObject); //ToDo
  begin

   end;

procedure TFrm_Spori.MP_Hilf_OffClick(Sender: TObject);  //toDo
  begin

   end;

procedure TFrm_Spori.MI_Hilf_OnClick(Sender: TObject);   //toDo
  begin

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

        Lb_Sek.Caption:= IntToStr(Sekunden);
        Lb_Min.Caption:= IntToStr(Minuten);
        Lb_Hour.Caption:=IntToStr(Stunden);
        Lb_Day.Caption:= IntToStr(Tage);
        Lb_Mon.Caption:= IntToStr(Monat);
        Lb_Jhr.Caption:= IntToStr(Jahr);

       end
     else
      begin
        Lb_Zeit.Caption:=DateTimeToStr(Now+DiffD+DiffT);
        Lb_MEZ.Caption:=DateTimeToStr(Now+DiffD+DiffT);

        DecodeTime(now+DiffD+DiffT, Stunden, Minuten, Sekunden, Millisek);
        DecodeDate(now+DiffD+DiffT, Jahr, Monat, Tage);

        Lb_Sek.Caption:= IntToStr(Sekunden);
        Lb_Min.Caption:= IntToStr(Minuten);
        Lb_Hour.Caption:=IntToStr(Stunden);
        Lb_Day.Caption:=IntToStr(Tage);
        Lb_Mon.Caption:=IntToStr(Monat);
        Lb_Jhr.Caption:=IntToStr(Jahr);

        TE_Manu.Time:=(Time+DiffT);
        DE_Manu.Date:=(Date+DiffD);
        OptionsChange(4,DateToStr(DE_Manu.Date));
        OptionsChange(6,TimeToStr(TE_Manu.Time));
       end;

    case GetTimeZoneInformation(ZoneInfo{%H-}) of
      TIME_ZONE_ID_STANDARD: //Winterzeit
        begin
          Lb_Gmt.Caption:=DateTimeToStr(StrToDateTime(Lb_MEZ.Caption)-1/24);
          Lb_SmrZ.Caption:='Falsch';
          Lb_Smrz.Font.Color:=clMaroon;
          Lb_SmrZ1.Caption:='Falsch';
          Lb_Smrz1.Font.Color:=clMaroon;
        end;
      TIME_ZONE_ID_DAYLIGHT: //SommerZeit
        begin
          Lb_Gmt.Caption:=DateTimeToStr(StrToDateTime(Lb_MEZ.Caption)-2/24);
          Lb_SmrZ.Caption:='Wahr';
          Lb_Smrz.Font.Color:=clGreen;
          Lb_SmrZ1.Caption:='Wahr';
          Lb_Smrz1.Font.Color:=clGreen;
        end;
      TIME_ZONE_ID_UNKNOWN: //Unbekannt
        begin
          Lb_Gmt.Caption:=DateTimeToStr(StrToDateTime(Lb_MEZ.Caption)-1/24);
          Lb_SmrZ.Caption:='Falsch';
          Lb_Smrz.Font.Color:=clMaroon;
          Lb_SmrZ1.Caption:='Falsch';
          Lb_Smrz1.Font.Color:=clMaroon;
        end;
     end;

    LB_OtZ.Caption:=DateTimeToStr(StrToDateTime(Lb_Gmt.Caption)+StrToFloat(Lb_Phi_G.Caption)/360);
    FruehPunkt();

    //Lb_UTC1.Caption:=FloatToStr(Julian(StrToInt(Lb_Jhr.Caption),
    //                 StrToInt(Lb_Mon.Caption), StrToInt(Lb_Day.Caption),
    //                 StrToInt(Lb_Hour.Caption), StrToInt(Lb_Min.Caption),
    //                 StrToInt(Lb_Sek.Caption)));

    Lb_UTC2.Caption:=FloatToStrF(((StrToInt(Lb_Hour.Caption) +
                     StrToInt(Lb_Min.Caption)/60 +
                     StrToInt(Lb_Sek.Caption)/3600)/24),ffFixed,4,13);

    if not (Ansilowercase(Ed_Egstn.Text) = 'ephemeride') then
      SternLage ()
    else
     Ephemeriden ();
   end;

procedure TFrm_Spori.Tmr_NachTimer(Sender: TObject); //Fertig
  var
     Index:Integer;
     InStBild:Boolean;
  begin

    if CB_StrMode.Text = 'Sternbild' then
      begin
       Setlength(Sternbild,0);
       InStBild:=false;

       for Index:= 0 to LV_List.Items.Count-1 do
         if AnsilowerCase(Trim(CB_StB.Text)) = AnsilowerCase(LV_List.Items[Index].SubItems[2]) then
           begin
             setlength(SternBild, length(SternBild)+1);
             SternBild[length(SternBild)-1]:=LV_List.Items[Index];
            end;

            for Index:= 0 to length(SternBild)-1 do
              if Ed_Nr.Text = SternBild[Index].Caption then
                begin
                  if ((StrToFloat(Ed_Ele_Ist.Text) - StrToFloat(Ed_Ele_Soll.Text) < 5) and
                      (StrToFloat(Ed_Ele_Ist.Text) - StrToFloat(Ed_Ele_Soll.Text)  > -5) and
                      (StrToFloat(Ed_Azi_Ist.Text) - StrToFloat(Ed_Azi_Soll.Text) < 5) and
                      (StrToFloat(Ed_Azi_Ist.Text) - StrToFloat(Ed_Azi_Soll.Text)  > -5)) then
                    begin
                      if Index < length(SternBild)-1 then
                        EintragList (SternBild[Index+1])
                       else
                        EintragList (SternBild[0]);
                     end;
                  InStBild:=true;
                  break;
                end;
        if not InStBild then
         EintragList (SternBild[0]);

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

    ForceDirectories ('C:\ProgramData\FireInstallations\SpaceOrienter\OldOptions');
    RenameFile ('C:\ProgramData\FireInstallations\SpaceOrienter\Options.Space',
                'C:\ProgramData\FireInstallations\SpaceOrienter\OldOptions\Options'
                +formatdatetime('d.m.y-h;n;s;z',Now)+'.old');
    LoadOptions ();

    MI_Sicht_Exp.Checked:=true;
    Exp ();

    EintragMode(StMode);

    Ed_Nr.Text:=HK;
    OptionsChange(15, HK);
   end;

procedure TFrm_Spori.Bt_ResListClick(Sender: TObject); //Fertig
  begin
    ForceDirectories ('C:\ProgramData\FireInstallations\SpaceOrienter\OldLists');
    RenameFile ('C:\ProgramData\FireInstallations\SpaceOrienter\StarList.Space','C:\ProgramData\FireInstallations\SpaceOrienter\OldLists\StarList'+formatdatetime('d.m.y-h;n;s;z',Now)+'.old');
    LoadStarList ('C:\ProgramData\FireInstallations\SpaceOrienter\StarList.Space');
   end;

procedure TFrm_Spori.Bt_BebListClick(Sender: TObject);  //ToDO
  begin

   end;

procedure TFrm_Spori.Bt_StartClick(Sender: TObject); //Fertig?
  begin
    if LV_List.SelCount <> 0 then
      EintragList (LV_List.Selected);
   end;

procedure TFrm_Spori.CB_StrModeChange(Sender: TObject); //Fertig
  begin
    EintragMode(CB_StrMode.Text);
   end;

procedure TFrm_Spori.CkB_Port_AutoChange(Sender: TObject);  //Fertig?
  begin
    if  CkB_Port_Auto.Checked then
      begin
        OptionsChange(11,'Auto');
        ED_Port.Enabled:=false;
      end
     else
      begin
        OptionsChange(11,'Manuell');
        ED_Port.Enabled:=true;
      end;
    Connect ();
   end;

procedure TFrm_Spori.CB_StBEditingDone(Sender: TObject); //In Procedure Auslagern?
  begin
    if IstSternBild () then
      begin
        Tmr_Nach.Enabled:=true;
        CB_StrMode.Text:='Sternbild';
        Mmo_Bsbg.Text:='Fährt ein Sternbild nach und verfolgt dieses.';
       end
     else
      EintragNummer ();
   end;

procedure TFrm_Spori.ChkB_TmMdChange(Sender: TObject);  //Fertig?
  begin
   if ChkB_TmMd.Checked then
     begin
       TE_Manu.Enabled:=false;
       DE_Manu.Enabled:=false;
       DE_Frhanf.Enabled:=false;
       OptionsChange(3,'Auto');
     end
    else
     begin
       TE_Manu.Enabled:=true;
       DE_Manu.Enabled:=true;
       DE_Frhanf.Enabled:=true;
       OptionsChange(3,'Manuell');

       DiffD:=DE_Manu.Date-Date;
       DiffT:=StrToTime(TimeToStr(TE_Manu.Time))-Time;
      end;
   end;

procedure TFrm_Spori.ChkB_UpChange(Sender: TObject);  //Fertig
  begin
    if ChkB_Up.Checked then
      begin
        OptionsChange(1,'True');
        Update_();
       end
     else
      OptionsChange(1,'False');
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

procedure TFrm_Spori.DE_ManuAcceptDate(Sender: TObject; var ADate: TDateTime; var AcceptDate: Boolean); //Fertig
  begin
    if AcceptDate then
      begin
        DiffD:=ADate-Date;
        OptionsChange(4, DateToStr(ADate));
       end;
   end;

procedure TFrm_Spori.Ed_Lamda_GEditingDone(Sender: TObject); //Fertig
  begin
    Lb_Lam_G.Caption:=Ed_Lamda_G.Text;
    Lb_Lam_G1.Caption:=Ed_Lamda_G.Text;

    Winkel ();

    OptionsChange(8, Ed_Lamda_G.Text);
   end;

procedure TFrm_Spori.Ed_MgMswgEditingDone(Sender: TObject); //Fertig
  begin
    Lb_MngMswg.Caption:=Ed_MgMswg.Text;
    OptionsChange(10, Ed_MgMswg.Text);
   end;

end.
