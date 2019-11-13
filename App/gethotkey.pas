unit GetHotkey;

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
   Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.}

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Buttons;

type

  { TFrm_GetHotKey }

  TFrm_GetHotKey = class(TForm)
    BtBtn_Ok: TBitBtn;
    BtBtn_Cancel: TBitBtn;
    Ed_shwHotkey: TEdit;
    Img_Info_GetHotkey: TImage;
    Lbl_GetHotkey: TLabel;
    {Saves changes}
    procedure BtBtn_OkClick(Sender: TObject);
    {Read a Key, if it's a new one add it to PressedHotKeys and
     Ed_shwHotkey}
    procedure FormKeyDown(Sender: TObject; var Key: Word; {%H-}Shift: TShiftState);
    {Resetts parameters}
    procedure FormShow(Sender: TObject);
  private
    {Set of all pressed keys}
    PressedHotKeys: Set of byte;
    OptionsHotkey: String;
  public

  end;

var
  Frm_GetHotKey: TFrm_GetHotKey;

implementation

uses
  Config, SpOri_Main;

{$R *.lfm}

{ TFrm_GetHotKey }

procedure TFrm_GetHotKey.FormKeyDown(Sender: TObject; var Key: Word; //Done
          Shift: TShiftState);     
  var
    KeyStr: String;
  begin
    //is it an new key?
    if not (Key in PressedHotKeys) then
      begin
        //Add it to the set
        Include(PressedHotKeys, Key);
        //Get string equivalent
        KeyStr := Frm_Config.KeyToStr (Key);

        //Add to showed Hotkeys and to (maybe) saved Hotkeys
        if (Ed_shwHotkey.Text = '') then
          begin
            Ed_shwHotkey.Text := KeyStr;
            OptionsHotkey := IntToStr(Key);
          end
        else
          begin
            Ed_shwHotkey.Text := Ed_shwHotkey.Text + ' + ' + KeyStr;
            OptionsHotkey += ', ' + IntToStr(Key);
          end;
      end;

  end;

procedure TFrm_GetHotKey.FormShow(Sender: TObject);  //Done
  begin
    //reset parameters
    Ed_shwHotkey.Text := '';
    OptionsHotkey := '';
    PressedHotKeys := [];
  end;

procedure TFrm_GetHotKey.BtBtn_OkClick(Sender: TObject); //Done
  begin
    //Set Text
    if (PressedHotKeys = []) then
      Frm_Config.Ed_HtKy.Text := 'none'
    else
      Frm_Config.Ed_HtKy.Text := Ed_shwHotkey.Text;

    //Set Hotkeys
    with Frm_Main do begin
      HotKey := PressedHotKeys;
      Options[ON_Hotkey] := OptionsHotkey;
    end;
  end;

end.

