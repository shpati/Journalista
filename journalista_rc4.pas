// RC4 encryption unit

unit journalista_rc4;

interface

type
  RC4State = record
    x, y: Integer;
    buf: array[0..255] of Byte;
  end;

  KeyString = string[255];

procedure RC4cryptFile(fInName, fOutName, key: string);

implementation

procedure RC4cryptFile(fInName, fOutName, key: string);
var
  fIn, fOut: file;
  x, y, i: Integer;
  nRead, nWritten: Longword;
  buf: array[0..4095] of Byte;
  tmp: Byte;
  state: RC4State;
begin
  Assign(fIn, fInName);
  Assign(fOut, fOutName);
  Reset(fIn, 1);
  Rewrite(fOut, 1);
  state.x := 0;
  state.y := 0;
  for x := 0 to 255 do
    state.buf[x] := Byte(x);
  y := 0;
  for x := 0 to 255 do begin
    y := (y + state.buf[x] + Integer(key[1 + x mod Length(key)])) and 255;
    tmp := state.buf[x];
    state.buf[x] := state.buf[y];
    state.buf[y] := tmp;
  end;
  state.x := 255;
  state.y := y;
  repeat
    BlockRead(fIN, buf, sizeof(buf), nRead);
    x := state.x;
    y := state.y;
    for i := 0 to nRead - 1 do begin
      x := (x + 1) and 255;
      y := (y + state.buf[x]) and 255;
      tmp := state.buf[x];
      state.buf[x] := state.buf[y];
      state.buf[y] := tmp;
      tmp := (state.buf[x] + state.buf[y]) and 255;
      buf[i] := buf[i] xor state.buf[tmp]
    end;
    state.x := x;
    state.y := y;
    BlockWrite(fOut, buf, nRead, nWritten);
  until (nRead <> sizeof(buf)) or (nRead <> nWritten);
  Close(fIn);
  Close(fOut);
end;

end.

