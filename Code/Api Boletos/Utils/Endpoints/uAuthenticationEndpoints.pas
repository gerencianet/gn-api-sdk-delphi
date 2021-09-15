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
    MainEmissions.frmBoletos.MemoResponse.Text := 'Autenticação Realizada com Sucesso!';
    except
    on E: Exception do
    begin
      MainEmissions.frmBoletos.MemoResponse.Text := 'Erro na Requisião de Autenticação! "GET /v1/Authorize"';
    end;
  end;
end;

end.
