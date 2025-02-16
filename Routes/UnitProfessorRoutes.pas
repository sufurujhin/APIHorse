unit UnitProfessorRoutes;

interface

uses
  Horse,
  Horse.GBSwagger,
  Horse.JWT,
  UnitProfessorDAO,
  UnitProfessorModel,
  UnitSQLiteConnection,
  System.SysUtils,
  System.JSON,
  UnitInterfaces.Connection,
  UnitSwaggerConfigProfessor;

procedure RegisterProfessorRoutes(AHorse: THorse; ADBConnection: IDBConnection);

procedure ConfigurarSwaggerProfessor;

implementation

procedure GetAllProfessores(Req: THorseRequest; Res: THorseResponse;
  Next: TProc; ADBConnection: IDBConnection);
var
  DAO: TProfessorDAO;
  Professores: TArray<TProfessor>;
  JSONArray: TJSONArray;
  Professor: TProfessor;
begin
  DAO := TProfessorDAO.Create(ADBConnection);
  JSONArray := TJSONArray.Create;
  try
    try
      Professores := DAO.GetAll;

      for Professor in Professores do
      begin
        JSONArray.AddElement(TJSONObject.Create.AddPair('id',
          TJSONNumber.Create(Professor.Id)).AddPair('nome', Professor.Nome)
          .AddPair('idade', TJSONNumber.Create(Professor.Idade)));
        Professor.Free;
      end;

      Res.Send(JSONArray.ToString).Status(200);
    finally
      DAO.Free;
    end;
  except
    on E: Exception do
      raise EHorseException.New.Error('Erro:' + E.Message);
  end;
end;

procedure RegisterProfessorRoutes(AHorse: THorse; ADBConnection: IDBConnection);
const BasePath = '/v1/professores';
begin
  AHorse.GET(BasePath,
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    begin
      try
        GetAllProfessores(Req, Res, Next, ADBConnection);

      except
        on E: Exception do
          raise EHorseException.New.Error('Erro:' + E.Message);
      end;
    end);

  AHorse.POST(BasePath,
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
      NewProfessor: TProfessor;
      ProfessorDAO: TProfessorDAO;
      JSONBody: TJSONObject;
    begin
      try
        NewProfessor := TProfessor.Create;
        JSONBody := TJSONObject.ParseJSONValue(Req.Body) as TJSONObject;
        try
          NewProfessor.Nome := JSONBody.GetValue('Nome').Value;
          NewProfessor.Idade := StrToIntDef(JSONBody.GetValue('Idade')
            .Value, 0);

          ProfessorDAO := TProfessorDAO.Create(ADBConnection);
          try
            ProfessorDAO.Insert(NewProfessor);
            Res.Send<TJSONObject>(TJSONObject.Create.AddPair('message',
              'Professor criado com sucesso.'));
          finally
            ProfessorDAO.Free;
          end;
        finally
          NewProfessor.Free;
          JSONBody.Free;
        end;
      except
        on E: Exception do
          raise EHorseException.New.Error('Erro:' + E.Message);
      end;
    end);

  // PUT
  AHorse.Put(BasePath,
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
      UpdatedProfessor: TProfessor;
      ProfessorDAO: TProfessorDAO;
      JSONBody: TJSONObject;
    begin
      try
        UpdatedProfessor := TProfessor.Create;
        JSONBody := TJSONObject.ParseJSONValue(Req.Body) as TJSONObject;
        try
          UpdatedProfessor.Id := StrToIntDef(JSONBody.GetValue('Id').Value, 0);
          UpdatedProfessor.Nome := JSONBody.GetValue('Nome').Value;
          UpdatedProfessor.Idade := StrToIntDef(JSONBody.GetValue('Idade')
            .Value, 0);

          ProfessorDAO := TProfessorDAO.Create(ADBConnection);
          try
            if ProfessorDAO.Update(UpdatedProfessor) then
              Res.Send<TJSONObject>(TJSONObject.Create.AddPair('message',
                'Professor atualizado com sucesso.'))
            else
              Res.Status(404).Send<TJSONObject>(TJSONObject.Create.AddPair
                ('error', 'Professor não encontrado.'));
          finally
            ProfessorDAO.Free;
          end;
        finally
          UpdatedProfessor.Free;
          JSONBody.Free;
        end;
      except
        on E: Exception do
          raise EHorseException.New.Error('Erro:' + E.Message);
      end;
    end);


  // Delete
  AHorse.AddCallback(HorseJWT('MY-PASSWORD')).Delete(BasePath,
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
      ProfessorId: Integer;
      ProfessorDAO: TProfessorDAO;
      JSONBody: TJSONObject;
    begin
      try
        JSONBody := TJSONObject.ParseJSONValue(Req.Body) as TJSONObject;

        ProfessorId := StrToIntDef(JSONBody.GetValue('Id').Value, 0);
        ProfessorDAO := TProfessorDAO.Create(ADBConnection);
        try
          if ProfessorDAO.Delete(ProfessorId) then
            Res.Send<TJSONObject>(TJSONObject.Create.AddPair('message',
              'Professor excluído com sucesso.'))
          else
            Res.Status(404).Send<TJSONObject>(TJSONObject.Create.AddPair
              ('error', 'Professor não encontrado.'));
        finally
          ProfessorDAO.Free;
          JSONBody.Free;
        end;
      except
        on E: Exception do
          raise EHorseException.New.Error('Erro:' + E.Message);
      end;
    end);

  ConfigurarSwaggerProfessor;
end;

procedure ConfigurarSwaggerProfessor;
begin
  TSwaggerProfesso.ConfigurarSwaggerProfessor;
end;

end.
