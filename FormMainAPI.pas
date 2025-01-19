unit FormMainAPI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Controller.API,
  FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Stan.Intf, FireDAC.Comp.UI;

type
  TStatus = (Offiline, Online);

  TFormMain = class(TForm)
    PanelCentral: TPanel;
    PanelPaddingBottom: TPanel;
    PanelButtonAtivar: TPanel;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    PanelNavegador: TPanel;
    procedure PanelButtonAtivarMouseLeave(Sender: TObject);
    procedure PanelButtonAtivarMouseEnter(Sender: TObject);
    procedure PanelButtonAtivarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PanelNavegadorClick(Sender: TObject);
    procedure PanelNavegadorMouseEnter(Sender: TObject);
    procedure PanelNavegadorMouseLeave(Sender: TObject);
  private
    { Private declarations }
    FStatus: TStatus;
    FAPI: TControllerAPI;
    procedure AtivarAPI(Sender: TObject);
    procedure DesativarAPI(Sender: TObject);
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

const
  CAPTION_ATIVAR = 'Online';
  CAPTION_DESATIVAR = 'OffLine';
  VERMELHO_FOSCO = $00B3B3FF;
  VERMELHO_FOSCO_CLARO = $007D7DFF;
  VERDE_FOSCO = $00A3FF46;
  VERDE_FOSCO_CLARO = $00D7FFAE;

implementation

uses
  UnitSQLiteDLLExtract,
  ShellAPI;

{$R *.dfm}
{$R Resources/SQLiteDll.res}

procedure TFormMain.AtivarAPI(Sender: TObject);
begin
  FStatus := Online;
  TPanel(Sender).Color := VERDE_FOSCO_CLARO;
  TPanel(Sender).Caption := CAPTION_ATIVAR;
  FAPI.AtivarAPI;
  Application.ProcessMessages;
end;

procedure TFormMain.DesativarAPI(Sender: TObject);
begin
  FStatus := Offiline;
  TPanel(Sender).Color := VERMELHO_FOSCO_CLARO;
  TPanel(Sender).Caption := CAPTION_DESATIVAR;
  FAPI.DesativarAPI;
  Application.ProcessMessages;
end;

procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FAPI.DesativarAPI;
  FreeAndNil(FAPI);
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  FAPI := TControllerAPI.Create;
  TSQLiteDLLExtract.ExtractSQLiteDLL;
end;

procedure TFormMain.FormShow(Sender: TObject);
begin
  FStatus := Offiline;
  PanelButtonAtivarMouseLeave(PanelButtonAtivar);
end;

procedure TFormMain.PanelButtonAtivarClick(Sender: TObject);
begin
  case FStatus of
    Offiline:
      AtivarAPI(Sender);
    Online:
      DesativarAPI(Sender);
  end;
end;

procedure TFormMain.PanelButtonAtivarMouseEnter(Sender: TObject);
begin
  case FStatus of
    Offiline:
      TPanel(Sender).Color := VERMELHO_FOSCO_CLARO;
    Online:
      TPanel(Sender).Color := VERDE_FOSCO_CLARO;
  end;
  Application.ProcessMessages;
end;

procedure TFormMain.PanelButtonAtivarMouseLeave(Sender: TObject);
begin
  case FStatus of
    Offiline:
      TPanel(Sender).Color := VERMELHO_FOSCO;
    Online:
      TPanel(Sender).Color := VERDE_FOSCO;
  end;
  Application.ProcessMessages;
end;

procedure TFormMain.PanelNavegadorClick(Sender: TObject);
var
  URLSwagger: WideString;
begin
  if FAPI.Port = 0 then
  begin
    AtivarAPI(PanelButtonAtivar);
    Sleep(100);
  end;
  URLSwagger := '--start-fullscreen http://localhost:' + IntToStr(FAPI.Port) + '/swagger/doc/html';
  ShellExecute(0, 'OPEN', 'chrome.exe', PWideChar(URLSwagger), nil, SW_SHOWNORMAL);
end;

procedure TFormMain.PanelNavegadorMouseEnter(Sender: TObject);
begin
  TPanel(Sender).Color := $00AFAF61;
end;

procedure TFormMain.PanelNavegadorMouseLeave(Sender: TObject);
begin
  TPanel(Sender).Color := $00808040;
end;

end.
