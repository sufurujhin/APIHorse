unit UnitDBConnectionFactory;

interface

uses
  UnitDBConnectionIntf;

type
  TDBConnectionFactory = class
  public
    class function CreateConnection: IDBConnection;
  end;

implementation

uses
  UnitSQLiteConnection;

{ TDBConnectionFactory }

class function TDBConnectionFactory.CreateConnection: IDBConnection;
begin
  Result := TSQLiteConnection.Create;
end;

end.

