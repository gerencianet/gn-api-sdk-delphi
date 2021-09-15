unit uAuthenticationEndpoints;

interface

uses
  Classes, uConnections, IdHTTP, XSuperObject, IdGlobal, Vcl.Dialogs, System.SysUtils, MainEmissions;

procedure OauthToken;

implementation

threadvar
  AccessToken : iSuperObject;

procedure OauthToken;
begin
  try
    AccessToken := uConnections.OauthToken;
    MainEmissions.frmBoletos.MemoResponse.Text := 'Autentica��o Realizada com Sucesso!';
    except
    on E: Exception do
    begin
      MainEmissions.frmBoletos.MemoResponse.Text := 'Erro na Requisi�o de Autentica��o! "GET /v1/Authorize"';
    end;
  end;
end;

end.
