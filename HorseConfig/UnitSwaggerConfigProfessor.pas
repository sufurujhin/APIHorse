unit UnitSwaggerConfigProfessor;

interface

uses
  Horse,
  Horse.GBSwagger,
  UnitProfessorModel;

procedure ConfigurarSwaggerProfessor;

implementation

procedure ConfigurarSwaggerProfessor;
begin
  {Swagger.BasePath('v1')
      .Path('professor')
        .Tag('Professor')
        .GET('List All', 'Lista completa de professores')
          .AddResponse(200, 'Sucesso na requisição professores')
            .Schema(TProfessor)
            .IsArray(True)
          .&End
        .&End
        .POST('Add teachers', 'Adicionar novo professor')
          .AddParamBody('Teacher data', 'Teacher data')
            .Required(True)
            .Schema(TProfessor)
          .&End
        .&End
      .&End
    .&End;     }
end;

end.

