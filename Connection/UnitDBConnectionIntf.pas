unit UnitDBConnectionIntf;

interface

uses
  FireDAC.Comp.Client;

type
  IDBConnection = interface
    ['{A1B2C3D4-E5F6-1122-3344-556677889900}']
    function GetConnection: TFDConnection;
  end;

implementation

end.
