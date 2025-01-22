unit UnitProfessorDAO;

interface

uses
  UnitProfessorModel,
  UnitInterfaces.Connection,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.Classes,
  FireDAC.DApt;

type
  TProfessorDAO = class
  private
    FDBConnection: IDBConnection;
  public
    constructor Create(ADBConnection: IDBConnection);
    function Insert(AProfessor: TProfessor): Boolean;
    function Update(AProfessor: TProfessor): Boolean;
    function Delete(AId: Integer): Boolean;
    function GetById(AId: Integer): TProfessor;
    function GetAll: TArray<TProfessor>;
  end;

implementation

{ TProfessorDAO }

constructor TProfessorDAO.Create(ADBConnection: IDBConnection);
begin
  FDBConnection := ADBConnection;
end;

function TProfessorDAO.Insert(AProfessor: TProfessor): Boolean;
var
  Query: TFDQuery;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FDBConnection.GetConnection;
    Query.SQL.Text :=
      'INSERT INTO professor (nome, idade) VALUES (:nome, :idade)';
    Query.ParamByName('nome').AsString := AProfessor.Nome;
    Query.ParamByName('idade').AsInteger := AProfessor.Idade;
    Query.ExecSQL;
    Result := True;
  finally
    Query.Free;
  end;
end;

function TProfessorDAO.Update(AProfessor: TProfessor): Boolean;
var
  Query: TFDQuery;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FDBConnection.GetConnection;
    Query.SQL.Text :=
      'UPDATE professor SET nome = :nome, idade = :idade WHERE id = :id';
    Query.ParamByName('nome').AsString := AProfessor.Nome;
    Query.ParamByName('idade').AsInteger := AProfessor.Idade;
    Query.ParamByName('id').AsInteger := AProfessor.Id;
    Query.ExecSQL;
    Result := True;
  finally
    Query.Free;
  end;
end;

function TProfessorDAO.Delete(AId: Integer): Boolean;
var
  Query: TFDQuery;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FDBConnection.GetConnection;
    Query.SQL.Text := 'DELETE FROM professor WHERE id = :id';
    Query.ParamByName('id').AsInteger := AId;
    Query.ExecSQL;
    Result := True;
  finally
    Query.Free;
  end;
end;

function TProfessorDAO.GetById(AId: Integer): TProfessor;
var
  Query: TFDQuery;
begin
  Result := nil;
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FDBConnection.GetConnection;
    Query.SQL.Text := 'SELECT id, nome, idade FROM professor WHERE id = :id';
    Query.ParamByName('id').AsInteger := AId;
    Query.Open;

    if not Query.IsEmpty then
      Result := TProfessor.Create(Query.FieldByName('id').AsInteger,
        Query.FieldByName('nome').AsString, Query.FieldByName('idade')
        .AsInteger);
  finally
    Query.Free;
  end;
end;

function TProfessorDAO.GetAll: TArray<TProfessor>;
var
  Query: TFDQuery;
  Professores: TArray<TProfessor>;
  Professor: TProfessor;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FDBConnection.GetConnection;
    Query.SQL.Text := 'SELECT id, nome, idade FROM professor';
    Query.Open;

    SetLength(Professores, 0);
    while not Query.Eof do
    begin
      Professor := TProfessor.Create(Query.FieldByName('id').AsInteger,
        Query.FieldByName('nome').AsString, Query.FieldByName('idade')
        .AsInteger);

      SetLength(Professores, Length(Professores) + 1);
      Professores[High(Professores)] := Professor;

      Query.Next;
    end;

    Result := Professores;
  finally
    Query.Free;
  end;
end;

end.
