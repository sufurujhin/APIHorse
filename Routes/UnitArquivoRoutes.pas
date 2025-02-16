unit UnitArquivoRoutes;

interface

uses
  System.SysUtils,
  System.Classes,
  Horse,
  Horse.BasicAuthentication,
  Horse.Jhonson,
  System.Json,
  Horse.OctetStream,
  System.Types,
  System.StrUtils,
  IdHTTP,
  IdAuthentication,
  Vcl.Forms,
  FireDAC.Comp.Client,
  FireDAC.Stan.Option,
  System.DateUtils;

procedure RegisterArquivo(AHorse: THorse);

implementation

procedure GetBackup(AHorse: THorse);
var
  Dir, arquivo: String;
begin
  try
    AHorse.Get('/GetArquivo/:arquivo',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      var
        Stream: TFileStream;
      begin
        try
          arquivo := Req.params.items['arquivo'];
          Dir := ExtractFilePath(Application.ExeName) + 'download\' + arquivo;
          if not FileExists(Dir) then
            Stream := nil
          else
            Stream := TFileStream.Create(Dir, fmOpenRead);
          if Stream <> nil then
            Res.Send<TStream>(Stream).Status(201)
          else
            Res.Send(TJSONObject.Create(TJSONPair.Create('error', 'Arquivo não localizado!'))).Status(400);
        except
          on E: Exception do
          begin
            Res.Send(TJSONObject.Create(TJSONPair.Create('error', E.Message))).Status(400);
          end;
        end;
      end);
  except
  end;
end;

procedure PostBackup(AHorse: THorse);
begin
  AHorse.Post('/SetArquivo/:NomeArquivo',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
      dirFolder: string;
      Dir: string;
      Stream: TmemoryStream;
    begin
      try
        Stream := Req.Body<TmemoryStream>;
        Dir := ExtractFilePath(Application.ExeName) + 'download\' + Req.params.items['NomeArquivo'] + '.zip';
        if Stream <> nil then
        begin
          if Stream.size > 0 then
          begin
            Stream.SaveToFile(Dir);
            Res.Send('Arquivo trafegado com sucesso!').Status(200);
          end
        end
        else
        begin
          Res.Send('Erro no travego do arquivo!').Status(400);
        end;
      except
        on E: Exception do
        begin
          Res.Send('{"error":'+QuotedStr(E.Message)+'}').Status(400);
        end;
      end;
    end);
end;

procedure RegisterArquivo(AHorse: THorse);
begin
  PostBackup(AHorse);
  GetBackup(AHorse);
end;

end.

