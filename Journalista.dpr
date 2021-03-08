program Journalista;

uses
  Forms,
  journalista_main in 'journalista_main.pas' {Form1},
  journalista_settings in 'journalista_settings.pas' {Form2},
  journalista_rc4 in 'journalista_rc4.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
