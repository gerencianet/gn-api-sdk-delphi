unit WebhookEndpoints;

interface

uses
  Classes, Connections, IdHTTP, XSuperObject, IdGlobal, Vcl.Dialogs, System.SysUtils,
  MainPix, ViewPixList, ViewPixDetail, ViewPixConfigWebhook, Forms, ViewPixKeyDetail;

procedure PixListWebhook;
procedure PixConfigWebhook;
procedure PixGetWebhook;
procedure PixDeleteWebhook;

implementation

threadvar
  HttpClient: TIdHTTP;
  AccessToken, ObjResult : iSuperObject;
  JsonToSend: TMemoryStream;

procedure PixListWebhook;
var
  sResponse: string;
  Modal    : TViewList;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewList, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := Connections.OauthToken;
        HttpClient := SetupClient;
        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);
        sResponse := HttpClient.Get(MainPix.frmPix.Enviroment + '/v2/webhook/?inicio=' + Modal.StartDate
                                    +'&fim=' + Modal.EndDate);

        MainPix.frmPix.MemoResponse.text := sresponse;
      end;

    except
      on E: Exception do
      begin
        ShowMessage('Erro na Requisição GET /v2/webhook/: '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;

procedure PixGetWebhook;
var
  sResponse: string;
  Modal    : TViewPixKeyDetail;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewPixKeyDetail, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := Connections.OauthToken;
        HttpClient := SetupClient;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);

        sResponse := HttpClient.Get(MainPix.frmPix.Enviroment + '/v2/webhook/' + Modal.Identifier);

        MainPix.frmPix.MemoResponse.text := sresponse;
      end;

    except
      on E: Exception do
      begin
        ShowMessage('Erro na Requisição GET /v2/webhook/:chave '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;

procedure PixConfigWebhook;
var
  sResponse: string;
  Modal    : TViewConfigWebhook;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewConfigWebhook, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := Connections.OauthToken;
        HttpClient := SetupClient;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);
        HttpClient.Request.CustomHeaders.Values['x-skip-mtls-checking'] := Modal.SkipMTLS;

        JsonToSend := TMemoryStream.Create;
        WriteStringToStream(JsonToSend, Modal.Body, IndyTextEncoding_UTF8);
        JsonToSend.Position := 0;

        sResponse := HttpClient.Put(MainPix.frmPix.Enviroment + '/v2/webhook/'
                              + Modal.Identifier, JsonToSend);

        MainPix.frmPix.MemoResponse.text := sresponse;
      end;

    except
      on E: Exception do
      begin
        ShowMessage('Erro na requisição PUT /v2/webhook/:chave '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;

procedure PixDeleteWebhook;
var
  sResponse: string;
  Modal    : TViewPixKeyDetail;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewPixKeyDetail, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := Connections.OauthToken;
        HttpClient := Connections.SetupClient;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);
        sResponse := HttpClient.Delete(MainPix.frmPix.Enviroment + '/v2/webhook/'+ Modal.Identifier);

        MainPix.frmPix.MemoResponse.text := sresponse;
      end;

    except
      on E: Exception do
      begin
        ShowMessage('Erro na requisição DELETE /v2/webhook/:chave '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;



end.
