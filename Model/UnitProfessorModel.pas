unit UnitProfessorModel;

interface

type
  TProfessor = class
  private
    FId: Integer;
    FNome: string;
    FIdade: Integer;
  public
    property Id: Integer read FId write FId;
    property Nome: string read FNome write FNome;
    property Idade: Integer read FIdade write FIdade;
    constructor Create; overload;
    constructor Create(AId: Integer; ANome: string; AIdade: Integer); overload;
  end;

implementation

constructor TProfessor.Create(AId: Integer; ANome: string; AIdade: Integer);
begin
  FId := AId;
  FNome := ANome;
  FIdade := AIdade;
end;

constructor TProfessor.Create;
begin

  inherited;
end;

end.
