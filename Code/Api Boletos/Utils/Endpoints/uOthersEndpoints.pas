unit uOthersEndpoints;

interface

uses
  IdHTTP, XSuperObject, uCommonTypes, uChargeClasses, DateUtils,
  Classes, System.SysUtils, Vcl.Forms, uConnections,
  IdGlobal, Vcl.Dialogs, MainEmissions, ViewDetailOthers;

procedure GetNotification;

implementation

threadvar
  HttpClient: TIdHTTP;
  AccessToken, ObjResult : iSuperObject;
  JsonToSend: TMemoryStream;

procedure GetNotification;
var
  sResponse: String;
  Modal    : TViewDetailOthers;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewDetailOthers, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := uConnections.OauthToken;
        HttpClient  := uConnections.SetupClient;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);

        sResponse := HttpClient.Get(MainEmissions.frmBoletos.Enviroment +'/v1/notification/'+ Modal.Identifier);

        MainEmissions.frmBoletos.MemoResponse.text := sresponse;

      end;
    except
      on E: Exception do
      begin
        ShowMessage('Erro na Requisição GET /v1/notification/:id '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;

end.
