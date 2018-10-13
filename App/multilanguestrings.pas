unit MultiLangueStrings;
//MLS

{$mode objfpc}{$H+}

interface

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


//Multi langue definitions
Resourcestring
  MLS_Connecting         = 'Verbinde...';
  MLS_ConnectedWith      = 'Verbunden mit: ';
  MLS_NotConnected       = 'Nicht verbunden';

  //Saved in Config file, as long as long as latin letters are used thex shuold stay english
  MLS_True               = 'True';
  MLS_False              = 'False';

  MLS_NumberLong         = 'Nummer';
  MLS_NumberShort        = 'Nr.';

  MLS_Unknown            = 'Unbekannt';
  MLS_None               = 'None';
  MLS_Search_Default     = 'Suchen...';
  MLS_Turnd_On           = 'Ein';
  MLS_Turnd_Off          = 'Aus';

  MLS_Warning            = 'Warnung:';
  MLS_Warning_MultiLine  = ' Doppelte Sternendeklaration Nr.';
  MLS_WasFound           = 'gefunden';
  MLS_AskRetry           = ' Erneut versuchen?';

  MLS_Error_Caption      = 'ERROR';
  MLS_Error_MsgCaption   = 'Error:';
  MLS_Error_ErrorWhile   = 'Fehler in';
  MLS_Error_Loading      = 'Ladevorgang';
  MLS_Error_AtSubItem    = 'während laden von SupItem';
  MLS_Error_StarWrite    = ' Fehler beim schreiben der SternenListe!';
  MLS_Error_NoIsReset    = ' (Nein = Einstellungen zurücksetzen)';
  MLS_Error_AskResetAll  = ' Optionen zurücksetzen?';
  MLS_Error_AskResetThis = ' Die fehlerhafte Option durch Defaultwert ersetzen?';
  MLS_Error_AskResetStar = ' Sternenliste zurücksetzen und neu Laden?';
  MLS_Error_AskDefault   = ' Die fehlerhafte(n) Option(en) durch Defaultwert(e) ersetzen?';
  MLS_Error_StarSubItem  = ' Laden des Sterns gescheitert bei SubItem:';
  MLS_Error_AskAbortLoad = ' Laden abbrechen?';
  MLS_Error_InvalidLine  = ' Ungültige Zeile in SternenListe gefunden Nr:';
  MLS_Error_FoundNotAll  = ' Konnte nicht alle Optionen finden.';
  MLS_Error_WrongType    = 'Falscher Datentyp';
  MLS_Error_OutOFRange   = 'Out of range';
  MLS_Error_UnnownFormat = 'Unbekanntes Format';

implementation

end.

