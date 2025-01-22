unit UnitSQLiteConnection;

interface

uses
  UnitInterfaces.Connection,
  FireDAC.Comp.Client,
  FireDAC.Stan.Def,
  FireDAC.Stan.Async,
  FireDAC.DApt;

type
  TSQLiteConnection = class(TInterfacedObject, IDBConnection)
  private
    FConnection: TFDConnection;
    function CreateConnection: TFDConnection;
  public
    constructor Create;
    destructor Destroy; override;
    function GetConnection: TFDConnection;
  end;

implementation

uses
  System.SysUtils,
  Vcl.Forms;

{ TSQLiteConnection }

constructor TSQLiteConnection.Create;
begin
  inherited;
  FConnection := CreateConnection;
end;

function TSQLiteConnection.CreateConnection: TFDConnection;
begin
  Result := TFDConnection.Create(nil);
  try
    Result.DriverName := 'SQLite';
    Result.Params.Database := ExtractFilePath(Application.ExeName) + 'APIDB.sqlite';
    Result.Params.Add('LockingMode=Normal');
    Result.Params.Add('Synchronous=Normal');
    Result.LoginPrompt := False;
    Result.Connected := True;
  except
    on E: Exception do
    begin
      Result.Free;
      raise Exception.Create('Erro ao conectar ao banco de dados da API: ' + E.Message);
    end;
  end;
end;

destructor TSQLiteConnection.Destroy;
begin
  if Assigned(FConnection) then
    FConnection.Free;
  inherited;
end;

function TSQLiteConnection.GetConnection: TFDConnection;
begin
  Result := FConnection;
end;

end.
