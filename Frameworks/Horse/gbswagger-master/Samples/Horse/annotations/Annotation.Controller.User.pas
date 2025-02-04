unit Annotation.Controller.User;

interface

uses
  Horse,
  GBSwagger.Path.Attributes,
  GBSwagger.Validator.Interfaces,
  Annotation.Classes,
  System.JSON;

type
  [SwagPath('user', 'Users')]
  TUserController = class
  private
    FRequest: THorseRequest;
    FResponse: THorseResponse;
  public
    constructor Create(AReq: THorseRequest; ARes: THorseResponse);
    destructor Destroy; override;

    [SwagGET('List Users', True)]
    [SwagParamQuery('id', 'user id')]
    [SwagResponse(200, TUser, 'Users data', True)]
    procedure GetUsers;

    [SwagGET('{id}', 'Find User')]
    [SwagParamPath('id', 'user id')]
    [SwagResponse(200, TUser, 'User data')]
    [SwagResponse(404)]
    procedure FindUser;

    [SwagPOST('Insert a new user')]
    [SwagParamBody('UserData', TUser)]
    [SwagResponse(201, TUser)]
    [SwagResponse(400)]
    procedure InsertUser;

    [SwagPUT('{id}', 'Update user')]
    [SwagParamPath('id', 'user id')]
    [SwagParamBody('User Data', TUser)]
    [SwagResponse(204)]
    [SwagResponse(400)]
    [SwagResponse(404)]
    procedure UpdateUser;

    [SwagDELETE('{id}', 'Delete user')]
    [SwagParamPath('id', 'user id')]
    [SwagResponse(204)]
    [SwagResponse(400)]
    [SwagResponse(404)]
    procedure DeleteUser;
  end;

implementation

{ TUserController }

constructor TUserController.Create(AReq: THorseRequest; ARes: THorseResponse);
begin
  FRequest := AReq;
  FResponse:= ARes;
end;

procedure TUserController.DeleteUser;
begin
  FResponse.Status(204);
end;

destructor TUserController.Destroy;
begin

  inherited;
end;

procedure TUserController.UpdateUser;
begin
  FResponse.Status(204);
end;

procedure TUserController.FindUser;
begin
  FResponse.Send('{"id": 1, "name": "user 1"}');
end;

procedure TUserController.GetUsers;
begin
  FResponse.Send('[{"id": 1, "name": "user 1"}]');
end;

procedure TUserController.InsertUser;
var
  LUser: TUser;
begin
  LUser := TUser.Create;
  try
    LUser.Id := 1;
    SwaggerValidator.Validate(LUser);
    FResponse.Send(FRequest.Body).Status(201);
  finally
    LUser.Free;
  end;
end;

end.
