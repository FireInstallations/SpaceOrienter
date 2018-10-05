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
  StdCtrls, ComCtrls, Buttons, ECImageMenu,
  Config;

type

  { TFrm_Main }

  TFrm_Main = class(TForm)
    BitBtn_Navigate: TBitBtn;
    Img_ComState: TImage;
    ImgLst_UsedPics: TImageList;
    ImgMn_Menue: TECImageMenu;
    Img_Settings_W: TImage;
    ImgLst_Menue: TImageList;
    Img_Settings_G: TImage;
    Img_ShootingStar: TImage;
    Lbl_Place_Name: TLabel;
    Lbl_Bdy_NameLat: TLabel;
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
    Pnl_Status: TPanel;
    PgCtrl_Menue: TPageControl;
    Pnl_Header: TPanel;
    PrgrssBr_ComPCon: TProgressBar;
    TbSht_DashBord: TTabSheet;
    TbSht_StarList: TTabSheet;
    {tell the device to pilote to the body}
    procedure BitBtn_NavigateClick(Sender: TObject);
    {Get the user to the confing form}
    procedure Img_Settings_WClick(Sender: TObject);
    {cosmetic: set color of label and image to gray (leftklick)}
    procedure Img_Settings_WMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    {cosmetic: set color of label and image back to white (leftklick)}
    procedure Img_Settings_WMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; {%H-}X, {%H-}Y: Integer);
  private

  public

  end;

var
  Frm_Main: TFrm_Main;

implementation

uses
  spaceorienter_main;


{$R *.lfm}

{ TFrm_Main }

procedure TFrm_Main.Img_Settings_WClick(Sender: TObject);
  begin
    Frm_Main.Hide;
    Frm_Config.Show;
  end;

procedure TFrm_Main.BitBtn_NavigateClick(Sender: TObject);
  begin
    Frm_Spori.SendData ();
  end;

procedure TFrm_Main.Img_Settings_WMouseDown(Sender: TObject;
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

procedure TFrm_Main.Img_Settings_WMouseUp(Sender: TObject; Button: TMouseButton;
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

