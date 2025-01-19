unit FormMainAPI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Controller.API;

type
  TStatus = (Offiline, Online);

  TFormMain = class(TForm)
    PanelCentral: TPanel;
    PanelPaddingBottom: TPanel;
    PanelButtonAtivar: TPanel;
    procedure PanelButtonAtivarMouseLeave(Sender: TObject);
    procedure PanelButtonAtivarMouseEnter(Sender: TObject);
    procedure PanelButtonAtivarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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
  UnitSQLiteDLLExtract;

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

end.
