unit uGerenciaNet;

interface

procedure ConfigureService( ClientID, ClientSecret,Environment,ConfigFileName, PartnerToken: PAnsiChar );cdecl;export;
function GerenciaNetService( EndPointOperation, Parameters,OptionalParameters, Body: PAnsiChar ): PAnsiChar;cdecl;export;
function GerenciaNetTokenExpired: Boolean;cdecl;
procedure GerenciaNetGetInstanceData( out AccessToken: PAnsiChar );cdecl;

implementation

uses Windows, AnsiStrings, SysUtils, Classes,uGerenciaNetIndy, uGerenciaTools,XSuperObject,
     DateUtils;

procedure GerenciaNetGetInstanceData( out AccessToken: PAnsiChar );
begin
  GetMem( AccessToken,Length( uGerenciaNetIndy.AccessToken ) );
  AnsiStrings.StrPCopy( AccessToken,AnsiString( uGerenciaNetIndy.AccessToken ) );
end;

// 60 seconds in a minute, 60 minutes in an hour, 24 hours in a day.
const SecondsInADay = 60 * 60 * 24;

// Use this to configure the service. We could have used a
// record here, but it would've gotten very complicated.
// Using simple strings, instead, pretty much every Win32
// environment will know how to interface to it.
procedure ConfigureService( ClientID, ClientSecret,Environment,ConfigFileName, PartnerToken: PAnsiChar );
begin
  uGerenciaNetIndy.ClientID := String( AnsiStrings.StrPas( ClientID ) );
  uGerenciaNetIndy.ClientSecret := String( AnsiStrings.StrPas ( ClientSecret ) );
  uGerenciaNetIndy.Environment  := String( AnsiStrings.StrPas( Environment ) );
  uGerenciaNetIndy.ConfigFileName := String( AnsiStrings.StrPas( ConfigFileName ) );
  uGerenciaNetIndy.PartnerToken := String( AnsiStrings.StrPas( PartnerToken ) );
end;

function GerenciaNetService( EndPointOperation, Parameters, OptionalParameters, Body: PAnsiChar ): PAnsiChar;cdecl;
var StringResult : String;
    Config: TGerenciaConfigItem;
    Params: TStringList;
    OptionalParams: TStringList;
    NeedsOauth: Boolean;
    Authorize: ISuperObject;
    DateTimeToExpire : TDateTime;
begin
  Config := GerenciaConfig( uGerenciaNetIndy.ConfigFileName ).EndPoint[ String( EndPointOperation ) ];
  Params := TStringList.Create;
  Params.Text := String( Parameters );
  OptionalParams := TStringList.Create;
  OptionalParams.Text := String( OptionalParameters );

  NeedsOauth := UpperCase( String( EndPointOperation ) ) = 'AUTHORIZE';
  case Config.Method of
    hmGet: StringResult := GerenciaGet( Config.EndPoint,Params,OptionalParams );
    hmPost: StringResult := GerenciaPost( Config.EndPoint,String( Body ),Params, OptionalParams,NeedsOauth );
    hmPut: StringResult := GerenciaPut( Config.EndPoint, String( Body ),Params, OptionalParams );
    hmDelete: StringResult := GerenciaDelete( Config.EndPoint,Params, OptionalParams );
  else
    StringResult := '';
  end;
  if NeedsOauth And ( UpperCase( StringResult ) <> 'UNAUTHORIZED' ) then
  begin
    Authorize := SO( StringResult );
    uGerenciaNetIndy.AccessToken := Authorize.S[ 'access_token' ];
    uGerenciaNetIndy.TokenType := Authorize.S[ 'token_type' ];
    DateTimeToExpire := Now + ( Authorize.I[ 'expires_in'] / SecondsInADay );
    uGerenciaNetIndy.ExpireDateTime := DateTimeToExpire;
  end;
  GetMem( Result,Length( StringResult )+1 );
  AnsiStrings.StrPCopy( Result,AnsiString( StringResult ) );
end;

function GerenciaNetTokenExpired: Boolean;
begin
  Result := TokenExpired;
end;

end.
