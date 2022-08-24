// Program settings unit

unit journalista_settings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, inifiles, Buttons, ExtCtrls, FileCtrl, Mask;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    ColorDialog1: TColorDialog;
    Shape1: TShape;
    Shape2: TShape;
    Label4: TLabel;
    ComboBox1: TComboBox;
    Label5: TLabel;
    CheckBox1: TCheckBox;
    Button1: TButton;
    Label6: TLabel;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    Label7: TLabel;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    procedure load(Sender: TObject);
    procedure forecolor(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure backcolor(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1click(Sender: TObject);
    procedure fontsizechange(Sender: TObject);
    procedure maxchange(Sender: TObject);
    procedure browse(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure minchange(Sender: TObject);
    procedure reminderchange(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses journalista_main;

{$R *.dfm}

// Load the settings form. Display the saved settings.

procedure TForm2.load(Sender: TObject);
var
  appINI: TIniFile;
  path,hh,mm: string;
begin
  appINI := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  path := appINI.ReadString('Settings', 'path', path);
  Edit1.Text := path;
  Shape1.Brush.Color := Form1.HtmlToColor(foregroundcolor, $D6D6D6);
  Shape2.Brush.Color := Form1.HtmlToColor(backgroundcolor, $101010);
  Combobox1.Text := inttostr(fontsize);
  Button1.Width := Form2.Width - Button1.Left - 14;
  if Lowercase(appINI.ReadString('Settings', 'startmaximized', startmaximized))
    = 'yes' then checkbox1.checked := true;
  if Lowercase(appINI.ReadString('Settings', 'minimizetotray', minimizetotray))
    = 'yes' then checkbox2.checked := true;
  hh:= Copy(reminder, 1, 2);
  mm:= Copy(reminder, 4, 2);
  if StrScan(PAnsiChar(reminder), ':') <> nil then
    begin
      checkbox3.checked := true;
      ComboBox2.Text := hh;
      ComboBox3.Text := mm;
    end;

end;

// Select the foreground color.

procedure TForm2.forecolor(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  appINI: TIniFile;
begin
  appINI := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  foregroundcolor := appINI.ReadString('Settings', 'foregroundcolor',
    foregroundcolor);
  colordialog1.Color := Form1.HtmlToColor(foregroundcolor, $D6D6D6);
  Shape1.Brush.Color := colordialog1.Color;
  colordialog1.Execute;
  Shape1.Brush.Color := colordialog1.Color;
  foregroundcolor := Form1.ColorToHtml(Shape1.Brush.Color);
  appINI.WriteString('Settings', 'foregroundcolor', foregroundcolor);
  Form1.readsettings;
  Form2.Edit1.SetFocus;
end;

// Select the background color.

procedure TForm2.backcolor(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  appINI: TIniFile;
begin
  appINI := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  backgroundcolor := appINI.ReadString('Settings', 'backgroundcolor',
    backgroundcolor);
  colordialog1.Color := Form1.HtmlToColor(backgroundcolor, $101010);
  Shape2.Brush.Color := colordialog1.Color;
  colordialog1.Execute;
  Shape2.Brush.Color := colordialog1.Color;
  backgroundcolor := Form1.ColorToHtml(Shape2.Brush.Color);
  appINI.WriteString('Settings', 'backgroundcolor', backgroundcolor);
  Form1.readsettings;
  Form2.Edit1.SetFocus;
end;

// Select the directory to store the journal entries.

procedure TForm2.Button1click(Sender: TObject);
var
  appINI: TIniFile;
begin
  appINI := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  if SelectDirectory('Select a directory', '', path) then
    path := path + '\';
  appINI.WriteString('Settings', 'path', path);
  Edit1.text := path;
  Form1.listfiles(path, Form1.ListView1);
  Form1.readsettings;
  Form2.Edit1.SetFocus;
end;

// Change the size of the font, the font type is Courier New.

procedure TForm2.fontsizechange(Sender: TObject);
var
  appINI: TIniFile;
begin
  appINI := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  fontsize := strtoint(combobox1.text);
  appINI.WriteInteger('Settings', 'fontsize', fontsize);
  Form1.readsettings;
  Form2.Edit1.SetFocus;
end;

// Option to maximize program window on program start.

procedure TForm2.maxchange(Sender: TObject);
var
  appINI: TIniFile;
begin
  appINI := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  if checkbox1.checked = true then
    appINI.WriteString('Settings', 'startmaximized', 'yes');
  if checkbox1.checked = false then
    appINI.WriteString('Settings', 'startmaximized', 'no');
  Form2.Edit1.SetFocus;
end;

procedure TForm2.browse(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ord(Key)=27) then Close else Button1Click(Form2);
end;

procedure TForm2.minchange(Sender: TObject);
var
  appINI: TIniFile;
begin
  appINI := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  if checkbox2.checked = true then
    begin
    minimizetotray := 'yes';
    appINI.WriteString('Settings', 'minimizetotray', 'yes');
    end;
  if checkbox2.checked = false then
    begin
    minimizetotray := 'no';
    appINI.WriteString('Settings', 'minimizetotray', 'no');
    end;
  Form2.Edit1.SetFocus;
end;



procedure TForm2.reminderchange(Sender: TObject);
var
  appINI: TIniFile;
begin
  appINI := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  if checkbox3.checked = true then
    begin
    reminder := ComboBox2.Text + ':' + ComboBox3.Text;
    appINI.WriteString('Settings', 'reminder', reminder);
    ComboBox2.Enabled := true;
    ComboBox3.Enabled := true;
    end;
  if checkbox3.checked = false then
    begin
    reminder := 'no';
    appINI.WriteString('Settings', 'reminder', 'no');
    ComboBox2.Enabled := false;
    ComboBox3.Enabled := false;
    end;
  Form2.Edit1.SetFocus;
end;

end.

