unit UnitSwaggerConfigProfessor;

interface

uses
  Horse,
  Horse.GBSwagger,
  UnitProfessorModel;

  type
  TSwaggerProfesso = class
  Public
    class procedure ConfigurarSwaggerProfessor;
  end;

implementation

class procedure TSwaggerProfesso.ConfigurarSwaggerProfessor;
begin
 Swagger.BasePath('/v1').Path('/professores').Tag('Professor')
  .GET('Listar todos', 'Lista completa de professores').
     AddResponse(200, 'Sucesso na requisição professores').
       Schema(TProfessor).IsArray(True).
         &End.
           &End
  .POST('Adiciona professor', 'Adicionar novo professor').
    AddParamBody('professor data', 'professor data').
      Required(True).
        Schema(TProfessor).
          &End.
        AddResponse(201, 'Professor criado com sucesso').
          &End.
            &End
  .PUT('Atualizar professor', 'Atualiza um professor pelo código').
    AddParamBody('professor data', 'professor data').
      Required(True).
        Schema(TProfessor).
    &End.
    AddResponse(201, 'Professor atualizado com sucesso').
      &End.
        &End
  .DELETE('Deleta professor', 'Delete um professor pelo código').
    AddParamBody('professor data', 'professor data').
      Required(True).
        Schema(TProfessor).
    &End.
  AddResponse(201, 'Professor deletado com sucesso').
    &End.
      &End;
end;

end.
