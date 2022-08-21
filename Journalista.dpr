program Journalista;

uses
  Forms,
  Windows,
  journalista_main in 'journalista_main.pas' {Form1},
  journalista_settings in 'journalista_settings.pas' {Form2},
  journalista_rc4 in 'journalista_rc4.pas';

var
  Mutex: THandle;
  hwind:HWND;

{$R *.RES}
                       
begin
  Mutex := CreateMutex(nil, TRUE, 'Journalista');

  if Mutex <> 0 then
  begin
    if GetLastError = ERROR_ALREADY_EXISTS then
    begin
      // MessageBox(0, 'Instance of this application is already running.',
      // 'Application already running', mb_IconHand);
      CloseHandle(Mutex);
      hwind:=0;
      repeat
        hwind:=Windows.FindWindowEx(0,hwind,'TApplication','Journalista');          
      until (hwind<>Application.Handle);

      if (hwind<>0) then
      begin
        { Found it, & show it }
        Windows.ShowWindow(hwind,SW_RESTORE and SW_SHOW);
        Windows.SetForegroundWindow(hwind);
      end;
      Halt;
    end;
  end;

  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;

end.
