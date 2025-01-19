unit UnitSQLiteDLLExtract;

interface

uses
  System.SysUtils, System.Classes, Windows, Vcl.Forms;

type
  TSQLiteDLLExtract = class
  public
    class procedure ExtractSQLiteDLL;
  end;

implementation

class procedure TSQLiteDLLExtract.ExtractSQLiteDLL;
var
  ResStream: TResourceStream;
  FileStream: TFileStream;
  DllPath: string;
begin
  DllPath := ExtractFilePath(Application.ExeName) + 'sqlite3.dll';
  if not FileExists(DllPath) then
  begin
    try
      ResStream := TResourceStream.Create(HInstance, 'SQLITE3DLL', RT_RCDATA);
      try
        FileStream := TFileStream.Create(DllPath, fmCreate);
        try
          FileStream.CopyFrom(ResStream, ResStream.Size);
        finally
          FileStream.Free;
        end;
      finally
        ResStream.Free;
      end;
    except
      on E: Exception do
        raise Exception.Create('Erro ao extrair a DLL: ' + E.Message);
    end;
  end;
end;

end.
