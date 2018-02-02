unit uGerenciaNetClientUtilities;

interface

uses
  Classes, uGerenciaClient;

function ToPAnsiChar( AStr: String ) : TGerenciaChar;
function CreateRequestParams( ParamArray: array of string ) : TStringList;
function ExecuteGerenciaNetRequest(EndPointName, Params, OptionalParams, Body: String): String;
function GerenciaNetAuthorize: String;

implementation

uses
  {$IFDEF UNICODE}
  AnsiStrings
  {$ELSE}
  SysUtils
  {$ENDIF};

function GerenciaNetAuthorize : String;
const BodyText = '{"grant_type":"client_credentials"}';
var
    Body: TGerenciaChar;
    Retorno: String;
begin
  Body := ToPAnsiChar( BodyText );
  try
    Retorno := String( GerenciaNetService('authorize', '', '', Body) );
  finally
    if ( Retorno <> '' ) then
      Result := 'Connected'
    else Result := 'Fail to connect';
  end;
end;

function ExecuteGerenciaNetRequest(EndPointName, Params, OptionalParams,
  Body: String): String;
var EndPointPChar,
    ParamsPChar,
    OptionalParamsPChar,
    BodyPChar: PAnsiChar;
begin
  EndPointPChar := ToPAnsiChar( EndPointName );
  if Params <> '' then
    ParamsPChar := ToPAnsiChar( Params )
  else
    ParamsPChar := nil;
  if OptionalParams <> '' then
    OptionalParamsPChar := ToPAnsiChar( OptionalParams )
  else
    OptionalParamsPChar := nil;
  if Body <> '' then
    BodyPChar := ToPAnsiChar( Body )
  else
    BodyPChar := nil;
  if GerenciaNetExpiredToken then
    GerenciaNetAuthorize;
  Result := String( GerenciaNetService( EndPointPChar,ParamsPChar, OptionalParamsPChar , BodyPChar ) );
end;

function ToPAnsiChar(AStr: String): PAnsiChar;
begin
  GetMem( Result,Length( AStr ) + 1);
  Result := {$IFDEF UNICODE}AnsiStrings.{$ENDIF}StrPCopy( Result,AnsiString( AStr ) );
end;

function CreateRequestParams(ParamArray: array of string): TStringList;
var S: String;
    {$IFNDEF UNICODE}
    ParamIndex : Integer;
    {$ENDIF}
begin
  Result := TStringList.Create;
  {$IFDEF UNICODE}
  for S in ParamArray do
  begin
    Result.Add( S );
  end;
  {$ELSE}
    for ParamIndex := 0 to Length( ParamArray ) -1 do
    begin
      Result.Add( ParamArray[ ParamIndex ] );
    end;
  {$ENDIF}
  // Assign nil if there are no parameters.
  if Result.Count = 0 then
  begin
    Result.Free;
    Result := nil;
  end;
end;

end.