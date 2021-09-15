unit uPaymentTokenClasses;

interface

  Uses Classes, XSuperObject, IdHTTP, Vcl.Controls,Vcl.ExtDlgs, System.SysUtils,
  IdServerIOHandler, IdSSL, IdSSLOpenSSL, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, idLogFile, IdGlobal, MainEmissions, uChargeClasses,
  Rsa, PrivateKey, Vcl.Dialogs;

  function getSalt (Identifier: String) : String;
  function getPublicKey (identifier: String) : String;
  function saveCardData (identifier: String;  cardData: TCreditCardData) : String;
  function EncryptRSA (const AData, AKey: PWideChar) : String;

implementation

threadvar
  HttpClient: TIdHTTP;
  ObjResult : ISuperObject;
  JsonToSend, JsonToSendTest: TMemoryStream;

function getPublicKey(identifier: String): String;
begin

  HttpClient := TIdHTTP.Create(nil);

  HttpClient.IOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  with TIdSSLIOHandlerSocketOpenSSL(HttpClient.IOHandler).SSLOptions do
  begin
    Mode := sslmUnassigned;
    SSLVersions := [sslvTLSv1_2];
  end;

  HttpClient.Request.CustomHeaders.Values['account-code'] := Identifier;

  if MainEmissions.frmBoletos.CheckBoxSandbox.Checked then
    ObjResult := SO(HttpClient.Get('https://sandbox.gerencianet.com.br/v1/pubkey?code=' + identifier))
  else
    ObjResult := SO(HttpClient.Get('https://api.gerencianet.com.br/v1/pubkey?code=' + identifier));

  Result := ObjResult.S['data'];
end;

function getSalt(identifier: String): String;
begin

  HttpClient := TIdHTTP.Create(nil);

  HttpClient.IOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  with TIdSSLIOHandlerSocketOpenSSL(HttpClient.IOHandler).SSLOptions do
  begin
    Mode := sslmUnassigned;
    SSLVersions := [sslvTLSv1_2];
  end;

  HttpClient.Request.CustomHeaders.Values['account-code'] := identifier;

  ObjResult := SO(HttpClient.Get('https://tokenizer.gerencianet.com.br/salt'));

  Result := ObjResult.S['data'];
end;

function saveCardData(identifier : String;
  cardData: TCreditCardData): String;
var
  Salt, PublicKey: String;
begin
  Salt := getSalt(identifier);

  PublicKey := getPublicKey(identifier);
  PublicKey := StringReplace(PublicKey , '-----BEGIN PUBLIC KEY-----' , '', [rfReplaceAll]);
  PublicKey := StringReplace(PublicKey , '-----END PUBLIC KEY-----' , '', [rfReplaceAll]);
  PublicKey := StringReplace(PublicKey , ''#$A'' , '', [rfReplaceAll]);

  ObjResult := SO(cardData.AsJSON(False, False));
  ObjResult.S['salt'] := Salt;

  HttpClient := TIdHTTP.Create(nil);
  HttpClient.IOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  with TIdSSLIOHandlerSocketOpenSSL(HttpClient.IOHandler).SSLOptions do
  begin
    Mode := sslmUnassigned;
    SSLVersions := [sslvTLSv1_2];
  end;

  JsonToSend := TMemoryStream.Create;
  WriteStringToStream(JsonToSend, '{"data": "' +
      EncryptRSA(PWideChar(ObjResult.AsJSON(False, False)), PWideChar(PublicKey)) + '"}',
      IndyTextEncoding_UTF8) ;
  JsonToSend.Position := 0;

  HttpClient.Request.CustomHeaders.Values['account-code'] := Identifier;
  HttpClient.Request.CustomHeaders.Values['Content-Type'] := 'application/json';

  if MainEmissions.frmBoletos.CheckBoxSandbox.Checked then
    Result := HttpClient.Post('https://sandbox.gerencianet.com.br/v1/card', JsonToSend)
  else
    Result := HttpClient.Post('https://tokenizer.gerencianet.com.br/v1/card', JsonToSend);
end;

function EncryptRSA (const AData, AKey: PWideChar) : string;
var
  sucess, usePrivateKey : Boolean;
  rsa: HCkRsa;
begin

  rsa := CkRsa_Create();

  sucess := CkRsa_ImportPublicKey (rsa, AKey);
  if (sucess <> True ) then
  begin
    ShowMessage('Erro na leitura da chave pública '#13#10#13#10);
    exit;
  end;

  usePrivateKey := False;
  CkRsa_putEncodingMode(rsa,'base64');

  Result := CkRsa__encryptStringENC(rsa, AData, usePrivateKey)
end;

end.
