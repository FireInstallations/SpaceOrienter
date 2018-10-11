unit SpOri_Main;

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
   Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
    }

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, ComCtrls, Buttons, Spin, ECImageMenu, LCLType, Math,
  Config;

type

  TShapeNums = (ShpN_EleNow, ShpN_EleCalc, ShpN_AziNow, ShpN_AziCalc);

  { TFrm_Main }

  TFrm_Main = class(TForm)
    BitBtn_Navigate_Main: TBitBtn;
    CmbBx_Mode: TComboBox;
    Ed_Search4Bdy_Main: TEdit;
    FltSpnEd_AziCalcManu: TFloatSpinEdit;
    FltSpnEd_EleCalcManu: TFloatSpinEdit;
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
    Lbl_EleChart_Title: TLabel;
    Lbl_AziChart_Title: TLabel;
    Lbl_HeightHelper: TLabel;
    Lbl_AziCalc_Val: TLabel;
    Lbl_AziCalc_Grd: TLabel;
    Lbl_AziCalc_Title: TLabel;
    Lbl_AziNow_Val: TLabel;
    Lbl_AziNow_Grd: TLabel;
    Lbl_AziNow_Title: TLabel;
    Lbl_EleCalc_Grd: TLabel;
    Lbl_EleCalc_Val: TLabel;
    Lbl_EleCalc_Title: TLabel;
    Lbl_EleNow_Grd: TLabel;
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
    TbSht_DashBord: TTabSheet;
    TbSht_StarList: TTabSheet;
    {tell the device to pilote to the body}
    procedure BitBtn_Navigate_MainClick(Sender: TObject);
    {calls SearchInputEdit}
    procedure Btn_Search4Bdy_MainClick(Sender: TObject);
    {A BodyMode was selecet, tell it}
    procedure CmbBx_ModeChange(Sender: TObject);
    {If just the default text is given clear it else Select all text (buggy)}
    procedure Ed_Search4Bdy_MainEnter(Sender: TObject);
    {If the Editfild is emty reset it's text to 'Search for...'}
    procedure Ed_Search4Bdy_MainExit(Sender: TObject);
    {If return (Enter) was pressed SearchInputEdit will be called}
    procedure Ed_Search4Bdy_MainKeyDown(Sender: TObject; var Key: Word;
      {%H-}Shift: TShiftState);
    procedure FltSpnEd_AziCalcManuChange(Sender: TObject);
    procedure FltSpnEd_EleCalcManuChange(Sender: TObject);
    {Use the default page}
    procedure FormCreate(Sender: TObject);
    {If the last key goes up (KeyCount = 0) then the Set KeysPressed, which
     containing all last pressed keys with the Hotkey set. If they are equal
     and UseHotkey is active SendData will be called.
     Therefore it decreases KeyCount ervytime FormKeyUp was called}
    procedure FormKeyDown(Sender: TObject; var Key: Word; {%H-}Shift: TShiftState);
    {Collect every ne pressed key and add them to the set KeysPressed.
     Also increases KeyCount, wich has a value above 0 as long as some keys are still pressed}
    procedure FormKeyUp(Sender: TObject; var {%H-}Key: Word; {%H-}Shift: TShiftState);
    procedure ImgMn_MenueSelectionChange(Sender: TObject; {%H-}User: boolean);
    {Get the user to the confing form}
    procedure Img_Settings_WClick(Sender: TObject);
    {cosmetic: set color of label and image to gray (leftklick)}
    procedure Img_Settings_WMouseDown(Sender: TObject; Button: TMouseButton;
      {%H-}Shift: TShiftState; {%H-}X, {%H-}Y: Integer);
    {cosmetic: set color of label and image back to white (leftklick)}
    procedure Img_Settings_WMouseUp(Sender: TObject; Button: TMouseButton;
      {%H-}Shift: TShiftState; {%H-}X, {%H-}Y: Integer);
  private
    var
      KeyCount: byte;
      PressedKeys: Set of byte;

    {If a Input was given search for it in LV_BodyList}
    procedure SearchInputEdit();
  public          
    {}
    procedure SetShapePos (const ShapeNum: TShapeNums; Angle: Real);

  end;

var
  Frm_Main: TFrm_Main;

  //Multi langue deffinitions
  Resourcestring
    EdSearch_Default = 'Suchen...';

implementation

uses
  spaceorienter_main;

{$R *.lfm}

{ TFrm_Main }

procedure TFrm_Main.SetShapePos (const ShapeNum: TShapeNums; Angle: Real); //ToDo: Comments
  var
    R: Real;
    CalcLeft, CalcTop: Integer;
    Shape_Height: Integer;
    TempShpeType: TShapeType;

    function FImod(const ValLeft: Real; const  ValRhight: Integer): Real; inline;
      begin
        FImod := ValLeft - ValRhight * Int(ValLeft / ValRhight);
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

        CalcTop  -= Round(R * cos(Angle * Pi/180));
        CalcLeft += Round(R * sin(Angle * Pi/180));

        case Round(Angle) of
          316..359, 0..45: TempShpeType := stTriangle;
          46..135:         TempShpeType := stTriangleRight;
          136..225:        TempShpeType := stTriangleDown;
          226..315:        TempShpeType := stTriangleLeft;
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
          Shape_AziCalc.Top   := CalcTop;
          Shape_AziCalc.Shape := TempShpeType;
        end;
      ShpN_AziCalc:
        begin
          Shape_AziCalc.Left  := CalcLeft;
          Shape_AziCalc.Top   := CalcTop;
          Shape_AziCalc.Shape := TempShpeType;
        end;
    end;
  end;

procedure TFrm_Main.Img_Settings_WClick(Sender: TObject); //Done
  begin
    //call the config form
    Frm_Main.Hide;
    Frm_Config.Show;
  end;

procedure TFrm_Main.BitBtn_Navigate_MainClick(Sender: TObject);  //Done
  begin
    //Send position data to ArduIno
    Frm_Spori.SendData ();
  end;

procedure TFrm_Main.SearchInputEdit ();  //ToDo: Error handeling (Item not found)
  var
    TempItem: TListItem;
  begin
    //if there was vailid input
    if not (Ed_Search4Bdy_Main.Text = EdSearch_Default) and not (Ed_Search4Bdy_Main.Text = '') then
      with Frm_Spori do
        begin
          TempItem := Search4Body (Trim(Ed_Search4Bdy_Main.Text)); //serch for the input

          if Assigned(TempItem) then
            begin
              ProgressList(TempItem);

              //If the user searched for a constellation, change Bodymode
              if (StrCompaire(Ed_Search4Bdy_Main.Text, TempItem.SubItems[2] , false) > 75) then
                ProgressBodyMode(5);
            end
          else
          ; //Item not found
        end;
  end;

procedure TFrm_Main.Btn_Search4Bdy_MainClick(Sender: TObject);  //done
  begin
    //search for given text in Ed_Search4Bdy_Main
    SearchInputEdit();
  end;

procedure TFrm_Main.CmbBx_ModeChange(Sender: TObject); //Done
  begin
    //Tell what Mode was selected
    Frm_Spori.ProgressBodyMode(CmbBx_Mode.ItemIndex);
  end;

procedure TFrm_Main.Ed_Search4Bdy_MainEnter(Sender: TObject);  //Buggy
  begin
    if Ed_Search4Bdy_Main.Text = EdSearch_Default then
      Ed_Search4Bdy_Main.Clear  //nothing was typed yet, so clear up the default value
     else
      begin
        //Ed_Search4Bdy_Main.SetFocus;
        Ed_Search4Bdy_Main.HideSelection := false;
        //should select the last typed text.. but it doesn't work. nether do the following ones, with or whithout autoselect
        Ed_Search4Bdy_Main.SelectAll;

        //Ed_Search4Bdy_Main.SelStart := 0;
        //Ed_Search4Bdy_Main.SelLength := 2;
        //Ed_Search4Bdy_Main.SelText := Ed_Such.Text;
      end;

  end;

procedure TFrm_Main.Ed_Search4Bdy_MainExit(Sender: TObject); //Done
  begin
    //Reset to default if no text was given
    if (Ed_Search4Bdy_Main.Text = '') then
      Ed_Search4Bdy_Main.Text  := EdSearch_Default;

  end;

procedure TFrm_Main.Ed_Search4Bdy_MainKeyDown(Sender: TObject; var Key: Word; //Done
  Shift: TShiftState);
  begin
    //If Enter was pressed search for the given text
    if Key = VK_RETURN then
      SearchInputEdit();
  end;

procedure TFrm_Main.FltSpnEd_AziCalcManuChange(Sender: TObject); //ToDo: Comments
  var
    Val: Real;
  begin
    Val := FltSpnEd_AziCalcManu.Value;

    SetShapePos(ShpN_AziCalc, Val);

    Lbl_AziCalc_Val.Caption := FloatToStrF(Val, ffFixed, 3, 2);

    //Support for old mainform
    Frm_Spori.Ed_Azi_Soll.Text := FloatToStr(Val);
  end;

procedure TFrm_Main.FltSpnEd_EleCalcManuChange(Sender: TObject);  //ToDo: Comments
  var
    Val: Real;
  begin
    Val := FltSpnEd_EleCalcManu.Value;

    SetShapePos(ShpN_EleCalc, Val);

    Lbl_EleCalc_Val.Caption := FloatToStrF(Val, ffFixed, 3, 2);

    //Support for old mainform
    Frm_Spori.Ed_Ele_Soll.Text := FloatToStr(Val);
  end;

procedure TFrm_Main.FormCreate(Sender: TObject); //Done
  begin
    //Just take the default page
    ImgMn_Menue.ItemIndex   := 0;
    PgCtrl_Menue.ActivePage := TbSht_DashBord;
  end;

procedure TFrm_Main.FormKeyDown(Sender: TObject; var Key: Word; //Done
  Shift: TShiftState);
  begin
    //If we ge a new key and Use Hotkey is active add it to the set.
    if StrToBool(Frm_Spori.Options[ON_UseHotkey]) and not (Key in PressedKeys) then
      begin
        //Counter to know how many keys are pressed
        Inc(KeyCount);

        Include(PressedKeys, Key);
      end;
  end;

procedure TFrm_Main.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState //Done
  );
  begin
        //If UseHotkey is active
    if StrToBool(Frm_Spori.Options[ON_UseHotkey]) then
      begin
        //one button less is pressed
        Dec(KeyCount);

        //if no button is pressed anymore compaire the list of pressed buttons with the hotkey
        if (KeyCount <= 0) then
          begin
            if (PressedKeys = Frm_Spori.HotKey) then //if they are the same, call Send Data
              Frm_Spori.SendData ();

            //reset the set, ready for next row
            PressedKeys := [];
          end;
      end;
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

end.

