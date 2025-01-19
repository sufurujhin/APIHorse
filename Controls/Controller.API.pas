unit Controller.API;

interface

uses Horse, UnitDBConnectionIntf, FireDAC.Comp.Client, UnitDBConnectionFactory,
  System.SysUtils,
  FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef;

type
  TControllerAPI = Class
  private
    FConnection: TFDConnection;
    FSQLiteDriverLink: TFDPhysSQLiteDriverLink;
    function GetConnection: IDBConnection;

  public
    procedure AtivarAPI;
    procedure DesativarAPI;
    procedure StartConnection;
  End;

implementation

uses
  UnitTableList;

{ TControllerAPI }

procedure TControllerAPI.AtivarAPI;
begin
  try
    if not THorse.IsRunning then
    begin
      THorse.MaxConnections := 9999999;
      THorse.Port := 8080;
      THorse.Listen(8080);
      StartConnection;
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
    FConnection := GetConnection.GetConnection;
    FConnection.ExecSQL(TTableList.CreateTable);
  except
    on E: Exception do
      raise Exception.Create('Erro: ' + E.Message);
  end;
end;

end.
