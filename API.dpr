program API;

uses
  Vcl.Forms,
  FormMainAPI in 'FormMainAPI.pas' {FormMain},
  Controller.API in 'Controls\Controller.API.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
