unit UnitTableList;

interface

uses
  System.Classes;

type
  TTableList = class
  public
    class function CreateTable: WideString;
  end;

implementation

{ TTableList }

class function TTableList.CreateTable: WideString;
var
  List: TStringList;
begin
  try
    List := TStringList.Create;
    List.Add('CREATE TABLE IF NOT EXISTS professor (id INTEGER PRIMARY KEY, nome TEXT, idade INTEGER);');
    List.Add('CREATE TABLE IF NOT EXISTS aluno (id INTEGER PRIMARY KEY, nome TEXT, idade INTEGER);');
    List.Add('CREATE TABLE IF NOT EXISTS professor_aluno (id INTEGER PRIMARY KEY, id_professor integer, id_aluno integer, FOREIGN KEY(id_professor) references professor(id),' +
    ' FOREIGN KEY(id_aluno) references aluno(id));');
    List.Add('CREATE TABLE IF NOT EXISTS materia (id INTEGER PRIMARY KEY, nome TEXT, idade INTEGER);');
    List.Add('CREATE TABLE IF NOT EXISTS professor_materia (id INTEGER PRIMARY KEY, id_professor integer, id_materia integer, FOREIGN KEY(id_professor) references professor(id),' +
    ' FOREIGN KEY(id_materia) references materia(id));');
    List.Add('CREATE TABLE IF NOT EXISTS aluno_materia (id INTEGER PRIMARY KEY, id_aluno integer, id_materia integer, FOREIGN KEY(id_aluno) references aluno(id),' +
    ' FOREIGN KEY(id_materia) references materia(id));');
    Result := List.Text;
  finally
    List.Free;
  end;
end;

end.
