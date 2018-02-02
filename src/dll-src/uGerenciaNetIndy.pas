unit uGerenciaNetIndy;

interface

uses Classes;

function GerenciaPost( EndPoint, Body: String;Parameters: TStringList;OptionalParameters: TStringList;OAuth: Boolean ) : String;
function GerenciaPut( EndPoint, Body: String;Parameters: TStringList;OptionalParameters: TStringList ) : String;
function GerenciaDelete( EndPoint: String;Parameters: TStringList;OptionalParameters: TStringList ) : String;
function GerenciaGet( EndPoint: String;Parameters: TStringList;OptionalParameters: TStringList ) : String;
procedure GerencianetProxy();

function TokenExpired: Boolean;

threadvar ClientID, ClientSecret, Environment, ConfigFileName,
          AccessToken, TokenType, PartnerToken, ProxyServer,
          ProxyUserName, ProxyPassword: String;
          ProxyPort: Integer;
          ExpireDateTime : TDateTime;

const API_SDK = 'delphi-2.0.0';

implementation

uses SysUtils, idHTTP, idLogFile, uGerenciaTools, idStackConsts,idSocketHandle;

Type

  TPreparedRequest = record
    URL: String;
    Body: TStream;
  end;

threadvar HttpClient: TIdHTTP;
          {$IFDEF DEBUG}HttpLog: TIdLogFile; {$ENDIF}

function TokenExpired: Boolean;
begin
  // We only need a new token if the current one has expired.
  Result := ExpireDateTime < Now;
end;

function FullBaseUrl: String;
begin
  Result := 'https://'+Environment+'.gerencianet.com.br';
end;

function SetupClient: TIdHTTP;
begin
  Result := TIdHTTP.Create( nil );

  Result.ConnectTimeout := 20000;
  Result.HTTPOptions := Result.HTTPOptions + [hoWantProtocolErrorContent]+ [ hoNoProtocolErrorException ];
  {$IFDEF DEBUG}
    Result.Intercept := HttpLog;
  {$ENDIF}
end;

function PrepareGerenciaRequest( EndPoint, Body: String;Parameters: TStringList;OptionalParameters: TStringList;IsOAuth: Boolean = False ): TPreparedRequest;
var TemplateURL : String;
    BodyStream : TStringStream;
begin
  HttpClient.Free;
  HttpClient := SetupClient;
  GerencianetProxy(); // verify proxy existence
  TemplateURL := FullBaseUrl +EndPoint;
  Result.URL := TUrlResolver.ResolveURLParameters( TemplateURL,Parameters );
  Result.URL := TUrlResolver.ResolveOptionalParameters( Result.URL,OptionalParameters );
  if Body <> '' then
  begin
    BodyStream := TStringStream.Create( Body,TEncoding.UTF8 );
    Result.Body := BodyStream;
  end
  else Result.Body := nil;
  HttpClient.Request.ContentType := 'application/json';
  HttpClient.Request.Accept := 'application/json';
  if IsOAuth then
  begin
    HttpClient.Request.BasicAuthentication := True;
    HttpClient.Request.Username := ClientID;
    HttpClient.Request.Password := ClientSecret;
  end
  else begin
          if ( AccessToken <> '' ) then
          begin
            HttpClient.Request.BasicAuthentication := False;
            HttpClient.Request.Username := '';
            HttpClient.Request.Password := '';
            HttpClient.Request.CustomHeaders.AddValue( 'Authorization',TokenType+' '+AccessToken );
          end;
       end;
  HttpClient.Request.CustomHeaders.AddValue( 'api-sdk',API_SDK );
  if PartnerToken <> '' then
  begin
    HttpClient.Request.CustomHeaders.AddValue( 'partner-token',PartnerToken );
  end;
end;

function GerenciaPost( EndPoint, Body: String;Parameters: TStringList;OptionalParameters: TStringList;OAuth: Boolean ) : String;
var PreparedRequest: TPreparedRequest;
begin
  PreparedRequest := PrepareGerenciaRequest( EndPoint,Body,Parameters,OptionalParameters,OAuth );
  try
    Result := HttpClient.Post( PreparedRequest.URL,PreparedRequest.Body );
  except
    on E: Exception do
    begin
      Result := HttpClient.Response.ResponseText;
    end;
  end;
end;

function GerenciaPut( EndPoint, Body: String;Parameters: TStringList;OptionalParameters: TStringList ) : String;
var PreparedRequest: TPreparedRequest;
begin
  PreparedRequest := PrepareGerenciaRequest( EndPoint,Body,Parameters,OptionalParameters );
  try
    Result := HttpClient.Put( PreparedRequest.URL,PreparedRequest.Body );
  except
    on E: Exception do
    begin
      Result := HttpClient.Response.ResponseText;
    end;
  end;
end;

function GerenciaDelete( EndPoint: String;Parameters: TStringList;OptionalParameters: TStringList ) : String;
var PreparedRequest: TPreparedRequest;
begin
  PreparedRequest := PrepareGerenciaRequest( EndPoint,'',Parameters,OptionalParameters );
  try
    Result := HttpClient.Delete( PreparedRequest.URL );
  except
    on E: Exception do
    begin
      Result := HttpClient.Response.ResponseText;
    end;
  end;
end;

function GerenciaGet( EndPoint: String;Parameters: TStringList;OptionalParameters: TStringList ) : String;
var PreparedRequest: TPreparedRequest;
begin
  PreparedRequest := PrepareGerenciaRequest( EndPoint,'',Parameters,OptionalParameters );
  try
    Result := HttpClient.Get( PreparedRequest.URL );
  except
    on E: Exception do
    begin
      Result := HttpClient.Response.ResponseText;
    end;
  end;
end;

procedure GerencianetProxy();
begin
  if (ProxyServer <> '') then
  begin
     HttpClient.ProxyParams.ProxyServer := ProxyServer;
     HttpClient.ProxyParams.ProxyPort := ProxyPort;
     if ( ( ProxyUserName <> '' ) and ( ProxyPassword <> '') ) then
     begin
        HttpClient.ProxyParams.BasicAuthentication := True;
        HttpClient.ProxyParams.ProxyUsername := ProxyUserName;
        HttpClient.ProxyParams.ProxyPassword := ProxyPassword;
     end;
  end;
end;

initialization
begin
  HttpClient := TIdHTTP.Create( nil );

  GerencianetProxy();

  {$IFDEF DEBUG}
  HttpLog := TIdLogFile.Create( nil );
  HttpClient.Intercept := HttpLog;
  HttpLog.Filename := 'Call Logs.txt';
  HttpLog.Active := True;
  {$ENDIF}
end;

finalization
begin
  HttpClient.Free;
  {$IFDEF DEBUG}
  HttpLog.Free;
  {$ENDIF}
end;

end.
