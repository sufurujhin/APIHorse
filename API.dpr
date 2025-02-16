program API;

uses
  Vcl.Forms,
  FormMainAPI in 'FormMainAPI.pas' {FormMain},
  Controller.API in 'Controls\Controller.API.pas',
  UnitDBConnectionFactory in 'Connection\UnitDBConnectionFactory.pas',
  UnitSQLiteConnection in 'Connection\UnitSQLiteConnection.pas',
  UnitTableList in 'Connection\UnitTableList.pas',
  UnitSQLiteDLLExtract in 'FuncoesUteis\UnitSQLiteDLLExtract.pas',
  UnitSwaggerConfigProfessor in 'HorseConfig\UnitSwaggerConfigProfessor.pas',
  UnitProfessorModel in 'Model\UnitProfessorModel.pas' {$R *.res},
  UnitProfessorRoutes in 'Routes\UnitProfessorRoutes.pas',
  UnitInterfaces.Connection in 'Connection\UnitInterfaces.Connection.pas',
  UnitProfessorDAO in 'DAO\UnitProfessorDAO.pas',
  UnitArquivoRoutes in 'Routes\UnitArquivoRoutes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
