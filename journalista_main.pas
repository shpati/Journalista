// Main program unit

unit journalista_main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Menus, ShellApi, StrUtils, Printers, inifiles,
  Grids, ExtCtrls;

type
  TRichTextMeasurements = (rtmNone, rtmInches, rtmCentimetres);
  TForm1 = class(TForm)
    MonthCalendar1: TMonthCalendar;
    ListView1: TListView;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    About1: TMenuItem;
    New1: TMenuItem;
    Label1: TLabel;
    Edit1: TMenuItem;
    Settings1: TMenuItem;
    About2: TMenuItem;
    Open1: TMenuItem;
    Close1: TMenuItem;
    Save1: TMenuItem;
    SaveAs1: TMenuItem;
    N1: TMenuItem;
    Delete1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    Exit1: TMenuItem;
    Addfiletofavorites1: TMenuItem;
    Removefilefromfavorites1: TMenuItem;
    Encrypt1: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    StatusBar1: TStatusBar;
    CheckBox1: TCheckBox;
    PrintDialog1: TPrintDialog;
    FindDialog1: TFindDialog;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    cut1: TMenuItem;
    Undo1: TMenuItem;
    N4: TMenuItem;
    Delete2: TMenuItem;
    N5: TMenuItem;
    SelectAll1: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    Find1: TMenuItem;
    N8: TMenuItem;
    ConvertfromUTF81: TMenuItem;
    sendtoprinter: TMenuItem;
    RichEdit1: TRichEdit;
    PopupMenu1: TPopupMenu;
    Undo3: TMenuItem;
    N11: TMenuItem;
    Cut3: TMenuItem;
    Copy3: TMenuItem;
    Paste3: TMenuItem;
    DeleteSelection3: TMenuItem;
    N12: TMenuItem;
    SelectAll3: TMenuItem;
    CheckBox2: TCheckBox;
    Label2: TLabel;
    Edit2: TEdit;
    StaticText1: TStaticText;
    procedure formCreate(Sender: TObject);
    procedure initialsettings;
    procedure readsettings;
    procedure positioning(Sender: TObject);
    procedure openfile(fname: string);
    procedure closefile(Sender: TObject);
    procedure savefile;
    procedure contextmenu(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure checkboxclick(Sender: TObject);
    procedure checkbox2click(Sender: TObject);
    procedure readfilter(Sender: TObject; var Key: Char);
    procedure listfiles(strPath: string; ListView: TListView);
    procedure hidewarning(Sender: TObject);
    procedure ListViewWndProc(Sender: TObject);
    procedure select(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure listkey(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure onformclose(Sender: TObject; var CanClose: Boolean);
    procedure changes(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure countw(Sender: TObject);
    function countwords: string;
    function LoadTextFromFile(const FileName: string): string;
    function hastext(const FileName: string; searchstr: string): boolean;
    function getdatetime: string;
    function confirmchanges: integer;
    function HtmlToColor(s: string; aDefault: Tcolor): TColor;
    function ColorToHtml(DColor: TColor): string;
    function PrintText(RTLeftMargin, RTRightMargin, RTTopMargin,
      RTBottomMargin: Extended; RichTextMeasurement: TRichTextMeasurements;
      Copies: Integer): Boolean;

    procedure New1Click(Sender: TObject);
    procedure opendialog(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure saveasdialog(Sender: TObject);
    procedure Encrypt1Click(Sender: TObject);
    procedure Delete1Click(Sender: TObject);
    procedure print(Sender: TObject);
    procedure exit(Sender: TObject);
    procedure Undo1Click(Sender: TObject);
    procedure cut1Click(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure Paste1Click(Sender: TObject);
    procedure Delete2Click(Sender: TObject);
    procedure SelectAll1Click(Sender: TObject);
    procedure FindDialog1Find(Sender: TObject);
    procedure Findit(Sender: TObject);
    procedure ConvertfromUTF81Click(Sender: TObject);
    procedure Addfiletofavorites1Click(Sender: TObject);
    procedure Removefilefromfavorites1Click(Sender: TObject);
    procedure MenuItemClick(Sender: TObject);
    procedure favoritestoini;
    procedure favoritesfromini;
    procedure Settings(Sender: TObject);
    procedure About(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  lastfile, lasttext, searchstr, filtertext: string;
  path, startmaximized, backgroundcolor, foregroundcolor: string;
  fontsize, startpos, listsize: integer;

implementation

uses journalista_settings, journalista_rc4;

{$R *.dfm}

// Load the main form. Initialize the settings. Create a new journal.

procedure TForm1.formcreate(Sender: TObject);
begin
  Form1.Width := round(Screen.WorkAreaWidth * 0.6);
  Form1.Height := round(Screen.WorkAreaHeight * 0.6);
  listsize := 3650;
  initialsettings;
  readsettings;
  favoritesfromini;
  MonthCalendar1.Date := now;
  CheckBox1.checked := True;
  CheckBox2.checked := False;
  lasttext := '';
  RichEdit1.Text := lasttext;
  New1Click(Form1);
  FindDialog1.Options := [frDown, frHideWholeWord, frHideUpDown];
  with OpenDialog1 do begin
    Options := Options + [ofPathMustExist, ofFileMustExist];
    InitialDir := ExtractFilePath(Application.ExeName);
    Filter := 'Text files (*.txt)|*.txt|All files (*.*)|*.*';
  end;

  with SaveDialog1 do begin
    InitialDir := ExtractFilePath(Application.ExeName);
    Filter := 'Text files (*.txt)|*.txt';
  end;
end;

// Write the default settings in an .ini file if no such file exists.

procedure TForm1.initialsettings;
var
  myFile: TextFile;
begin
  if not FileExists(ChangeFileExt(Application.ExeName, '.ini')) then
  begin
    System.AssignFile(myFile, ChangeFileExt(Application.ExeName, '.ini'));
    ReWrite(myFile);
    WriteLn(myFile, '[Settings]');
    WriteLn(myFile, 'path=', ExtractFilePath(Application.ExeName) + 'entries\');
    WriteLn(myFile, 'startmaximized=no');
    WriteLn(myFile, 'backgroundcolor=#101010');
    WriteLn(myFile, 'foregroundcolor=#D6D6D6');
    WriteLn(myFile, 'fontsize=12');
    WriteLn(myFile, '');
    System.Closefile(myFile);
  end;
end;

// Read the setting from .ini file and apply them.

procedure TForm1.readsettings;
var
  appINI: TIniFile;
begin
  appINI := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  path := appINI.ReadString('Settings', 'path', path);
  if startmaximized <> 'done' then
    startmaximized := appINI.ReadString('Settings', 'startmaximized',
      startmaximized);
  backgroundcolor := appINI.ReadString('Settings', 'backgroundcolor',
    backgroundcolor);
  foregroundcolor := appINI.ReadString('Settings', 'foregroundcolor',
    foregroundcolor);
  fontsize := appINI.ReadInteger('Settings', 'fontsize', fontsize);
  RichEdit1.font.Size := fontsize;
  RichEdit1.Color := HtmlToColor(backgroundcolor, $101010);
  RichEdit1.font.color := HtmlToColor(foregroundcolor, $D6D6D6);
  ListView1.font.color := RichEdit1.font.color;
  ListView1.Color := RichEdit1.Color;
  Label1.font.color := RichEdit1.font.Color;
  Label1.Color := RichEdit1.Color;
  Label2.font.color := RichEdit1.font.Color;
  Label2.Color := RichEdit1.Color;
  Edit2.Font.Color := RichEdit1.Color;
  Edit2.Color := RichEdit1.font.Color;
  MonthCalendar1.calcolors.TextColor := RichEdit1.font.color;
  MonthCalendar1.calcolors.BackColor := RichEdit1.Color;
  MonthCalendar1.calcolors.MonthBackColor := RichEdit1.Color;
  MonthCalendar1.Calcolors.TitleBackColor := RichEdit1.font.color;
  MonthCalendar1.calcolors.TitleTextColor := RichEdit1.Color;
  StaticText1.color := RichEdit1.font.color;
  StaticText1.font.color := RichEdit1.color;
  Form1.Font.Color := RichEdit1.Font.Color;
  Form1.Color := RichEdit1.Color;
  appIni.Free;
  if not DirectoryExists(path) then
    CreateDir(path);
end;

// Settings to keep the form elements in the right positions.

procedure TForm1.positioning(Sender: TObject);

var
  rightspacer: integer;
begin
  rightspacer := 20;
  RichEdit1.Left := 0;
  RichEdit1.Top := 0;
  RichEdit1.Width := StatusBar1.Width - MonthCalendar1.Width - 2 * rightspacer;
  RichEdit1.Height := StatusBar1.Top - RichEdit1.Top;
  with RichEdit1 do
    PageRect := Rect(15, 15, 12, 15);
  RichEdit1.Refresh;
  RichEdit1.TabStop := False;
  MonthCalendar1.Top := rightspacer;
  MonthCalendar1.Left := RichEdit1.Left + RichEdit1.Width + rightspacer;
  MonthCalendar1.Height := 160;
  MonthCalendar1.TabStop := False;
  Checkbox1.Top := MonthCalendar1.Top + MonthCalendar1.Height + rightspacer;
  Checkbox1.Left := MonthCalendar1.Left;
  Label1.Top := Checkbox1.Top + 2;
  Label1.Left := Checkbox1.Left + 20;
  Label1.Width := MonthCalendar1.Width;
  Label1.Height := 25;
  Checkbox2.Top := Checkbox1.Top + 25;
  Checkbox2.Left := Checkbox1.Left;
  Label2.Top := Checkbox2.Top + 2;
  Label2.Left := Label1.Left;
  Label2.Width := MonthCalendar1.Width;
  Label2.Height := 25;
  Edit2.Left := Checkbox2.Left;
  Edit2.Top := Label2.Top + 25;
  Edit2.Width := MonthCalendar1.Width - 10;
  if Edit2.Visible = true then
    ListView1.Top := Edit2.Top + 30
  else
    ListView1.Top := Label2.Top + 25;
  ListView1.Left := Checkbox1.Left - 5;
  ListView1.Width := StatusBar1.Width - ListView1.Left;
  ListView1.Height := StatusBar1.Top - ListView1.Top;
  ListView1.TabStop := False;
  StaticText1.Top := RichEdit1.Height - 85;
  StaticText1.Left := ListView1.Left + 5;
  StaticText1.Width := ListView1.Width - 35;
  if Lowercase(startmaximized) = 'yes' then
  begin
    ShowWindow(handle, SW_MAXIMIZE);
    startmaximized := 'done';
  end;
end;

// Display the content of a file in the text editor

procedure TForm1.openfile(fname: string);
begin
  if confirmchanges <> mrCancel then
  begin
    lastfile := fname;
    Form1.Caption := 'Journalista - ' + lastfile;
    RichEdit1.Visible := true;
    Form1.RichEdit1.Lines.LoadFromFile(lastfile);
    Form1.RichEdit1.SelStart := 0;
    lasttext := Form1.RichEdit1.Text;
  end;
end;

// Remove the text from the text editor. Hide the editor window.

procedure TForm1.closefile(Sender: TObject);
begin
  if confirmchanges <> mrCancel then
  begin
    Form1.Caption := 'Journalista';
    RichEdit1.Text := '';
    RichEdit1.Visible := false;
    lasttext := '';
  end;
end;

// Save the text from the editor to a file.

procedure TForm1.savefile;
begin
  RichEdit1.Lines.SaveToFile(lastfile);
  lasttext := RichEdit1.Text;
  Form1.Caption := 'Journalista - ' + lastfile;
  listfiles(path, ListView1);
  readsettings;
end;

// Display the context menu in the editor.

procedure TForm1.contextmenu(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
  PopupMenu1.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
end;

// Option to view all files or just the entries of the current month.

procedure TForm1.checkboxclick(Sender: TObject);
begin
  RichEdit1.Refresh;
  listfiles(path, ListView1);
end;

// Option to view all files containing a given text string.

procedure TForm1.checkbox2click(Sender: TObject);
begin
  if checkbox2.Checked = true then
  begin
    Edit2.Visible := true;
    Edit2.Text := '';
    filtertext := '';
    positioning(Form1);
  end else
  begin
    Edit2.Visible := false;
    Edit2.Text := '';
    filtertext := '';
    positioning(Form1);
  end;
end;

// Apply text string filter

procedure TForm1.readfilter(Sender: TObject; var Key: Char);
begin
  if ord(Key) = VK_RETURN then
  begin
    filtertext := Edit2.text;
    Edit2.enabled := false;
    listfiles(path, ListView1);
  end;
end;

// Lists the files in listview. If the checkbox is enabled, it filters them.

procedure TForm1.listfiles(strPath: string; ListView: TListView);

var
  i, j: Integer;
  SearchRec: TSearchRec;
  ListItem: TListItem;
label
  noshow;
begin
  j := 0;
  ListView1.Clear;
  ListView1.ViewStyle := vsReport;
  ListView1.Items.BeginUpdate;
  try
    i := FindFirst(strPath + '*.*', faAnyFile, SearchRec);
    while i = 0 do
    begin
      with ListView do
      begin
        inc(j);
        if ((SearchRec.Attr and FaDirectory <> FaDirectory) and
          (SearchRec.Attr and FaVolumeId <> FaVolumeID)) then
        begin
          if CheckBox1.checked then
            if FormatDateTime('yyyy-mm', MonthCalendar1.Date) <>
              LeftStr(SearchRec.Name, 7) then
              goto noshow;
          if CheckBox2.checked then
            if filtertext <> '' then
              if not hastext(path + SearchRec.Name, filtertext) then
                goto noshow;
          ListItem := ListView.Items.Insert(0);
          Listitem.Caption := SearchRec.Name;
        end;
      end;
      noshow:
      i := FindNext(SearchRec);
    end;
    if (j > listsize) then
    begin
      StaticText1.Visible := true;
      listsize := 1000000;
    end;
  finally
    ListView1.Items.EndUpdate;
    ListView1.SortType := stData;
  end;
  Edit2.enabled := true;
end;

// Hides the 'too many entries' warning.

procedure TForm1.hidewarning(Sender: TObject);
begin
  StaticText1.visible := false;
end;

// Disables the horizontal scrollbar in listview.

procedure TForm1.ListViewWndProc(Sender: TObject);
begin
  ShowScrollBar(ListView1.Handle, SB_HORZ, False);
end;

// Opens the selected file from the list in listview.

procedure TForm1.select(Sender: TObject; Item: TListItem;
  Selected: Boolean);
var
  txt: string;
begin
  if Assigned(ListView1.Selected) then
    openfile(path + ListView1.Selected.Caption);
end;

// If Delete key is pressed while a list item is selected.

procedure TForm1.listkey(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_DELETE then
    if not AnsiContainsText(Form1.Caption, '(not saved)') then
      Delete1Click(Form1);
end;

// Checks if the file has changed before exiting the program.

procedure TForm1.onformclose(Sender: TObject; var CanClose: Boolean);
begin
  if confirmchanges = mrCancel then Canclose := False;
end;

// Changes the form caption if any changes are made to the file.

procedure TForm1.changes(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Richedit1.Text <> lasttext then
    Form1.Caption := 'Journalista - ' + lastfile + ' (not saved)'
  else
    Form1.Caption := 'Journalista - ' + lastfile;
end;

// Displays the cursor position as well as the wordcount into the statusbar.

procedure TForm1.countw(Sender: TObject);
var
  row, col: integer;
begin
  row := RichEdit1.Perform(EM_LineFromChar, RichEdit1.SelStart, 0);
  col := RichEdit1.SelStart - RichEdit1.Perform(EM_LineIndex, Row, 0);
  statusbar1.SimpleText := 'Words: ' + countwords + ', Line: ' + inttostr(row)
    + ', Column: ' + inttostr(col);
end;

// Counts the number of words.

function TForm1.countwords: string;
var
  text: string;
  count, i: Integer;
begin
  text := ' ' + RichEdit1.Text;
  text := StringReplace(text, sLineBreak, ' ', [rfReplaceAll]);
  count := 0;
  for i := 1 to (Length(text) - 1) do
  begin
    if (text[i] = ' ') and (text[i + 1] <> ' ') then count := count + 1;
  end;
  Result := InttoStr(count);
end;

// Loads the text from a file into a string.

function TForm1.LoadTextFromFile(const FileName: string): string;
var
  SL: TStringList;
begin
  Result := '';
  SL := TStringList.Create;
  try
    SL.LoadFromFile(FileName);
    Result := SL.Text;
  finally
    SL.Free;
  end;
end;

// Confirm if text loaded from file contains a given text string.

function TForm1.hastext(const FileName: string; searchstr: string): boolean;
begin
  if AnsiPos(searchstr, LoadTextFromFile(FileName)) <> 0 then
    Result := true
  else
    Result := false;
end;

// Converts the date in the format given below.

function TForm1.getdatetime: string;
begin
  Result := FormatDateTime('yyyy-mm-dd_HHMMSS', now);
end;

// Checking if the text displayed has changed since it was loaded.

function TForm1.confirmchanges: integer;
var
  buttonSelected: integer;
begin
  if RichEdit1.Text <> lasttext then
  begin
    buttonSelected := MessageDlg('Do you want to save the changes to '
      + Lastfile + '?', mtCustom, [mbYes, mbNo, mbCancel], 0);
    if buttonSelected = mrYes then savefile;
    if buttonSelected = mrNo then Result := mrNo;
    if buttonSelected = mrCancel then
    begin
      Result := mrCancel;
    end;
  end
  else
    Result := mrNo;
end;

// Converts HTML color format to delphi TColor format.

function TForm1.HtmlToColor(s: string; aDefault: Tcolor): TColor;
begin
  if copy(s, 1, 1) = '#' then begin
    s := '$' + copy(s, 6, 2) + copy(s, 4, 2) + copy(s, 2, 2);
  end
  else
    s := 'clNone';
  try
    result := StringToColor(s);
  except
    result := aDefault;
  end;
end;

// Converts delphi TColor format to HTML color format.

function Tform1.ColorToHtml(DColor: TColor): string;
var
  tmpRGB: TColorRef;
begin
  tmpRGB := ColorToRGB(DColor);
  Result := Format('#%.2x%.2x%.2x',
    [GetRValue(tmpRGB),
    GetGValue(tmpRGB),
      GetBValue(tmpRGB)]);
end;

// Printing function.

function TForm1.PrintText(RTLeftMargin, RTRightMargin, RTTopMargin,
  RTBottomMargin: Extended; RichTextMeasurement: TRichTextMeasurements;
  Copies: Integer): Boolean;
var
  PixelsX, PixelsY, LeftSpace, TopSpace: Integer;
  LeftMargin, RightMargin, TopMargin, BottomMargin: Extended;
  R: TRect;
  C: TColor;
begin
  Result := False;
  RichEdit1.Text := RichEdit1.Text;
  C := RichEdit1.Font.Color;
  RichEdit1.Font.Color := $000000;
  if RichTextMeasurement <> rtmNone then
  begin
    PixelsX := GetDeviceCaps(Printer.Handle, LOGPIXELSX);
    PixelsY := GetDeviceCaps(Printer.Handle, LOGPIXELSY);
    LeftSpace := GetDeviceCaps(Printer.Handle, PHYSICALOFFSETX);
    TopSpace := GetDeviceCaps(Printer.Handle, PHYSICALOFFSETY);
    LeftMargin := RTLeftMargin;
    RightMargin := RTRightMargin;
    TopMargin := RTTopMargin;
    BottomMargin := RTBottomMargin;
    if RichTextMeasurement = rtmCentimetres then
    begin
      LeftMargin := LeftMargin / 2.54;
      RightMargin := RightMargin / 2.54;
      TopMargin := TopMargin / 2.54;
      BottomMargin := BottomMargin / 2.54;
    end;
    R.Left := Round(PixelsX * LeftMargin) - LeftSpace;
    R.Right := Printer.PageWidth - Round(PixelsX * RightMargin) - LeftSpace;
    R.Top := Round(PixelsY * TopMargin) - TopSpace;
    R.Bottom := Printer.PageHeight - Round(PixelsY * BottomMargin) - TopSpace;
    RichEdit1.PageRect := R;
    Application.ProcessMessages;
  end;
  while Copies > 0 do
  begin
    RichEdit1.Print(lastfile);
    Dec(Copies);
    Application.ProcessMessages;
  end;
  RichEdit1.Font.Color := C;
  Result := True;
end;

// Menu-activated procedures

procedure TForm1.New1Click(Sender: TObject);
begin
  if confirmchanges <> mrCancel then ;
  begin
    lastfile := path + Form1.getdatetime + '.txt';
    Form1.Caption := 'Journalista - ' + lastfile + ' (not saved)';
    RichEdit1.Visible := true;
    RichEdit1.text := '';
    lasttext := RichEdit1.text;
  end;
end;

procedure TForm1.opendialog(Sender: TObject);
begin
  if OpenDialog1.Execute then begin
    if confirmchanges <> mrCancel then
    begin
      lastfile := OpenDialog1.FileName;
      Form1.Caption := 'Journalista - ' + lastfile;
      RichEdit1.Visible := true;
      RichEdit1.Lines.LoadFromFile(OpenDialog1.FileName);
      RichEdit1.SelStart := 0;
      lasttext := RichEdit1.text;
    end;
  end;
end;

procedure TForm1.Save1Click(Sender: TObject);
begin
  savefile;
end;

procedure TForm1.saveasdialog(Sender: TObject);
var
  buttonSelected: integer;
begin
  SaveDialog1.FileName := lastfile;
  if SaveDialog1.Execute then begin
    begin
      if FileExists(SaveDialog1.FileName) then
      begin
        buttonSelected := MessageDlg('Do you want to replace the existing file '
          + SaveDialog1.FileName + '?', mtCustom, [mbYes, mbNo, mbCancel], 0);
        if buttonSelected <> mrYes then system.exit;
      end;
      RichEdit1.Lines.SaveToFile(SaveDialog1.FileName);
      Form1.Caption := SaveDialog1.FileName;
      lastfile := SaveDialog1.FileName;
      lasttext := RichEdit1.Text;
      listview1.ClearSelection;
    end;
  end;
end;

procedure TForm1.Encrypt1Click(Sender: TObject);
var
  pass, newfile: string;
begin
  if AnsiContainsText(Form1.Caption, ' (not saved)') then
  begin
    showmessage('Please save the file first.');
    System.Exit;
  end;
  pass := InputBox('Encrypt / Decrypt', 'Enter your password...', '...here');
  newfile := lastfile + '_temp.txt';
  RC4cryptFile(lastfile, newfile, pass);
  if Rightstr(lastfile, 14) = '_encrypted.txt' then
  begin
    newfile := StringReplace(lastfile, '_encrypted.txt', '.txt', []);
    DeleteFile(lastfile);
    RenameFile(lastfile + '_temp.txt', newfile);
    openfile(newfile);
  end
  else
  begin
    newfile := StringReplace(lastfile, '.txt', '_encrypted.txt', []);
    DeleteFile(lastfile);
    RenameFile(lastfile + '_temp.txt', newfile);
    openfile(newfile);
  end;
  lastfile := newfile;
  listfiles(path, ListView1);
end;

procedure TForm1.Delete1Click(Sender: TObject);
var
  buttonSelected: integer;
begin
  if lastfile <> '' then
    buttonSelected := MessageDlg('Do you want to delete '
      + Lastfile + '?', mtCustom, [mbYes, mbNo], 0);
  if buttonSelected = mrYes then
  begin
    if DeleteFile(lastfile) then ShowMessage(lastfile + ' deleted.');
    Form1.Caption := 'Journalista';
    RichEdit1.Text := '';
    RichEdit1.Visible := false;
    lasttext := '';
    lastfile := '';
  end;
  listfiles(path, ListView1);
end;

procedure TForm1.print(Sender: TObject);
var
  i: integer;
begin
  if PrintDialog1.Execute then
    PrintText(1, 1, 1, 1, rtmInches, PrintDialog1.Copies);
end;

procedure TForm1.exit(Sender: TObject);
begin
  if confirmchanges <> mrCancel then Application.Terminate;
end;

procedure TForm1.Undo1Click(Sender: TObject);
begin
  if Self.ActiveControl is TCustomEdit then
    TCustomEdit(Self.ActiveControl).Perform(EM_UNDO, 0, 0);
end;

procedure TForm1.cut1Click(Sender: TObject);
begin
  RichEdit1.CutToClipboard;
end;

procedure TForm1.Copy1Click(Sender: TObject);
begin
  RichEdit1.CopyToClipboard;
end;

procedure TForm1.Paste1Click(Sender: TObject);
begin
  RichEdit1.PasteFromClipboard;
end;

procedure TForm1.Delete2Click(Sender: TObject);
begin
  RichEdit1.ClearSelection;
end;

procedure TForm1.SelectAll1Click(Sender: TObject);
begin
  RichEdit1.SelectAll;
end;

procedure TForm1.FindDialog1Find(Sender: TObject);
begin
  finddialog1.findtext := '';
  finddialog1.execute;
  startpos := RichEdit1.SelStart + 1;
end;

procedure TForm1.Findit(Sender: TObject);
var
  txt: string;
  N, L: integer;
begin
  searchstr := FindDialog1.FindText;
  txt := Copy(RichEdit1.Text, startpos, maxint);
  if frMatchCase in FindDialog1.Options then
    N := AnsiPos(searchstr, txt)
  else
    N := AnsiPos(AnsiLowerCase(searchstr), AnsiLowerCase(txt));
  L := Length(searchstr);
  if N > 0 then
  begin
    RichEdit1.SelStart := startpos + N - 2;
    RichEdit1.SelLength := L;
    startpos := RichEdit1.SelStart + 1 + L;
  end;
  if N = 0 then
  begin
    if (startpos = RichEdit1.SelStart + 1) then
      showmessage('No matches found.')
    else
    begin
      startpos := 1;
    end;
  end;
end;

procedure TForm1.ConvertfromUTF81Click(Sender: TObject);
begin
  if utf8toansi(RichEdit1.Text) <> '' then
    RichEdit1.text := utf8toansi(RichEdit1.Text);
end;

procedure TForm1.Addfiletofavorites1Click(Sender: TObject);
var
  MenuItem: TMenuItem;
  i: integer;
begin
  if FileExists(lastfile) then
  begin
    if Mainmenu1.Items[2].Count = 2 then
    begin
      MenuItem := TMenuItem.Create(Self);
      MenuItem.Caption := '-';
      MainMenu1.Items[2].Add(MenuItem);
    end;
    for i := 2 to Mainmenu1.Items[2].Count - 1 do
      if MainMenu1.Items[2].Items[i].Caption = lastfile then
        MainMenu1.Items[2].Items[i].Destroy;
    begin
      MenuItem := TMenuItem.Create(nil);
      MenuItem.Caption := lastfile;
      MenuItem.OnClick := MenuItemClick;
      MainMenu1.Items[2].Add(MenuItem);
      favoritestoini;
    end;
  end
  else
  begin
    savefile;
    Addfiletofavorites1Click(Form1);
  end;
end;

procedure TForm1.Removefilefromfavorites1Click(Sender: TObject);
var
  MenuItem: TMenuItem;
  i: integer;
begin
  i := 2;
  while i < Mainmenu1.Items[2].Count do
  begin
    if MainMenu1.Items[2].Items[i].Caption = lastfile then
      MainMenu1.Items[2].Items[i].Destroy;
    inc(i);
  end;
  if Mainmenu1.Items[2].Count = 3 then MainMenu1.Items[2].Items[2].Destroy;
  favoritestoini;
end;

procedure TForm1.MenuItemClick(Sender: TObject);
var
  Item: TMenuItem;
  buttonSelected: integer;
  oldfile: string;
begin
  listview1.ClearSelection;
  Item := Sender as TMenuItem;
  if FileExists(Item.Caption) then
    openfile(Item.Caption)
  else
    buttonSelected := MessageDlg('The shortcut points to a file that does ' +
      'not exist. Remove shortcut?', mtCustom, [mbYes, mbNo], 0);
  if buttonSelected = mrYes then
  begin
    oldfile := lastfile;
    lastfile := Item.Caption;
    Removefilefromfavorites1Click(Form1);
    lastfile := oldfile;
  end;
end;

procedure TForm1.favoritestoini;
var
  appINI: TIniFile;
  i: integer;
begin
  appINI := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  try
    appINI.EraseSection('Favorites');
    for i := 3 to Mainmenu1.Items[2].Count - 1 do
      appINI.WriteString('Favorites', 'favpath' +
        inttostr(i - 2), MainMenu1.Items[2].Items[i].Caption);
  finally
    appIni.Free;
  end;
  if Mainmenu1.Items[2].Count = 3 then MainMenu1.Items[2].Items[2].Destroy;
end;

procedure TForm1.favoritesfromini;
var
  appINI: TIniFile;
  MenuItem: TMenuItem;
  i: integer;
  favpath: string;
begin
  i := 1;
  appINI := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  favpath := appINI.ReadString('Favorites', 'favpath' + inttostr(i), '');
  while favpath <> '' do
  begin
    if Mainmenu1.Items[2].Count = 2 then
    begin
      MenuItem := TMenuItem.Create(nil);
      MenuItem.Caption := '-';
      MainMenu1.Items[2].Add(MenuItem);
    end;
    MenuItem := TMenuItem.Create(nil);
    MenuItem.Caption := favpath;
    MenuItem.OnClick := MenuItemClick;
    MainMenu1.Items[2].Add(MenuItem);
    inc(i);
    favpath := appINI.ReadString('Favorites', 'favpath' + inttostr(i), '');
  end;
end;

procedure TForm1.Settings(Sender: TObject);
begin
  Form2.Show;
end;

procedure TForm1.About(Sender: TObject);
begin
  Application.MessageBox('Journalista 2.0.0 - MIT License' + sLineBreak +
    'Copyright © MMXXI, Shpati Koleka.', 'About Program', 0)
end;

end.

