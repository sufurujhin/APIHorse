program API;

uses
  Vcl.Forms,
  FormMainAPI in 'FormMainAPI.pas' {FormMain},
  Controller.API in 'Controls\Controller.API.pas',
  UnitDBConnectionFactory in 'Connection\UnitDBConnectionFactory.pas',
  UnitDBConnectionIntf in 'Connection\UnitDBConnectionIntf.pas',
  UnitSQLiteConnection in 'Connection\UnitSQLiteConnection.pas',
  UnitTableList in 'Connection\UnitTableList.pas',
  UnitSQLiteDLLExtract in 'FuncoesUteis\UnitSQLiteDLLExtract.pas',
  UnitSwaggerConfig in 'HorseConfig\UnitSwaggerConfig.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
