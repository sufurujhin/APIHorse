unit Controller.API;

interface

uses Horse,
  UnitInterface.ConnectionDB,
  UnitDBConnectionFactory,
  System.SysUtils,
  FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef,
  UnitProfessorRoutes;

type
  TControllerAPI = Class
  private
    FPort: Integer;
    FSQLiteDriverLink: TFDPhysSQLiteDriverLink;
    function GetConnection: IDBConnection;

  public
    procedure AtivarAPI;
    procedure DesativarAPI;
    procedure StartConnection;
    property Port: Integer read FPort;
  End;
var
  APP: THorse;

implementation

uses
  UnitTableList,
  Horse.GBSwagger,
  UnitSwaggerConfigProfessor;

{ TControllerAPI }

procedure TControllerAPI.AtivarAPI;
begin
  FPort :=  8080;
  App :=  THorse.Create;
  try
    if not THorse.IsRunning then
    begin
      THorse.Use(HorseSwagger); // Access http://localhost:9000/swagger/doc/html
      THorse.MaxConnections := 9999999;
      THorse.Port := Port;
      StartConnection;
      RegisterProfessorRoutes(App, GetConnection);
      ConfigurarSwaggerProfessor;
      THorse.Listen(Port);
    end;
  except

  end;
end;

procedure TControllerAPI.DesativarAPI;
begin
  try
    if THorse.IsRunning then
      THorse.StopListen;
  except

  end;
end;

function TControllerAPI.GetConnection: IDBConnection;
begin
  try
    Result := TDBConnectionFactory.CreateConnection;
  except
    on E: Exception do
      raise Exception.Create('Erro: ' + E.Message);
  end;
end;

procedure TControllerAPI.StartConnection;
begin
  try
    if not Assigned(FSQLiteDriverLink) then
      FSQLiteDriverLink := TFDPhysSQLiteDriverLink.Create(nil);
    FSQLiteDriverLink.VendorLib := ExtractFilePath(ParamStr(0)) + 'sqlite3.dll';
    GetConnection.GetConnection.ExecSQL(TTableList.CreateTable);
  except
    on E: Exception do
      raise Exception.Create('Erro: ' + E.Message);
  end;
end;

end.
