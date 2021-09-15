unit uChargesEndpoints;

interface

uses
  IdHTTP, XSuperObject, uCommonTypes, uChargeClasses, DateUtils,
  Classes, System.SysUtils, Vcl.Forms, uConnections,
  IdGlobal, Vcl.Dialogs, MainEmissions, ViewCreateCharge, ViewDetailBillet,
  ViewPayChargeBillet, ViewPayCreditCard, ViewUpdateLinkCharge, ViewResendBillet,
  ViewCreateChargeHistory, ViewCreateLinkCharge, ViewUpdateMetadataCharge,
  ViewPayChargeBilletOneStep, ViewPayCreditCardOneStep;

procedure CreateCharge;
procedure CreateChargeOneStepBillet;
procedure CreateChargeOneStepCreditCard;
procedure DetailCharge;
procedure CancelCharge;
procedure PayChargeBillet;
procedure PayChargeCreditCard;
procedure CreateChargeHistory;
procedure ResendBillet;
procedure LinkCharge;
procedure UpdateChargeLink;
procedure SettleCharge;
procedure UpdateChargeMetadata;

implementation

threadvar
  HttpClient: TIdHTTP;
  AccessToken, ObjResult : iSuperObject;
  JsonToSend: TMemoryStream;

procedure CreateCharge;
var
  sResponse: String;
  Modal    : TViewCreateCharge;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewCreateCharge, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := uConnections.OauthToken;
        HttpClient  := uConnections.SetupClient;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);

        JsonToSend := TMemoryStream.Create;
        WriteStringToStream(JsonToSend, Modal.Body, IndyTextEncoding_UTF8);
        JsonToSend.Position := 0;

        sResponse := HttpClient.Post(MainEmissions.frmBoletos.Enviroment +'/v1/charge/', JsonToSend);

        MainEmissions.frmBoletos.MemoResponse.text := sresponse;

      end;
    except
      on E: Exception do
      begin
        ShowMessage('Erro na Requisição POST /v1/charge '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;

procedure CreateChargeOneStepBillet;
var
  sResponse: String;
  Modal    : TViewPayChargeBilletOneStep;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewPayChargeBilletOneStep, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := uConnections.OauthToken;
        HttpClient  := uConnections.SetupClient;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);

        JsonToSend := TMemoryStream.Create;
        WriteStringToStream(JsonToSend, Modal.Body, IndyTextEncoding_UTF8);
        JsonToSend.Position := 0;

        sResponse := HttpClient.Post(MainEmissions.frmBoletos.Enviroment +'/v1/charge/one-step', JsonToSend);

        MainEmissions.frmBoletos.MemoResponse.text := sresponse;

      end;
    except
      on E: Exception do
      begin
        ShowMessage('Erro na Requisição POST /v1/charge/one-step '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;

procedure CreateChargeOneStepCreditCard;
var
  sResponse: String;
  Modal    : TViewPayCreditCardOneStep;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewPayCreditCardOneStep, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := uConnections.OauthToken;
        HttpClient  := uConnections.SetupClient;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);

        JsonToSend := TMemoryStream.Create;
        WriteStringToStream(JsonToSend, Modal.Body, IndyTextEncoding_UTF8);
        JsonToSend.Position := 0;

        sResponse := HttpClient.Post(MainEmissions.frmBoletos.Enviroment +'/v1/charge/one-step', JsonToSend);

        MainEmissions.frmBoletos.MemoResponse.text := sresponse;

      end;
    except
      on E: Exception do
      begin
        ShowMessage('Erro na Requisição POST /v1/charge/one-step '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;

procedure DetailCharge;
var
  sResponse: String;
  Modal    : TViewDetailBillet;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewDetailBillet, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := uConnections.OauthToken;
        HttpClient  := uConnections.SetupClient;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);

        sResponse := HttpClient.Get(MainEmissions.frmBoletos.Enviroment +'/v1/charge/'+ Modal.Identifier);

        MainEmissions.frmBoletos.MemoResponse.text := sresponse;

      end;
    except
      on E: Exception do
      begin
        ShowMessage('Erro na Requisição GET /v1/charge/:id '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;

procedure CancelCharge;
var
  sResponse: String;
  Modal    : TViewDetailBillet;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewDetailBillet, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := uConnections.OauthToken;
        HttpClient  := uConnections.SetupClient;

        JsonToSend := TMemoryStream.Create;
        WriteStringToStream(JsonToSend, '{}', IndyTextEncoding_UTF8);
        JsonToSend.Position := 0;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);

        sResponse := HttpClient.Put(MainEmissions.frmBoletos.Enviroment +'/v1/charge/'+ Modal.Identifier + '/cancel', JsonToSend);

        MainEmissions.frmBoletos.MemoResponse.text := sresponse;

      end;
    except
      on E: Exception do
      begin
        ShowMessage('Erro na Requisição Put /v1/charge/:id/cancel '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;

procedure UpdateChargeMetadata;
var
  sResponse: String;
  Modal    : TViewUpdateMetadataCharge;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewUpdateMetadataCharge, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := uConnections.OauthToken;
        HttpClient  := uConnections.SetupClient;

        JsonToSend := TMemoryStream.Create;
        WriteStringToStream(JsonToSend, Modal.Body, IndyTextEncoding_UTF8);
        JsonToSend.Position := 0;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);

        sResponse := HttpClient.Put(MainEmissions.frmBoletos.Enviroment +'/v1/charge/'+ Modal.Identifier + '/metadata', JsonToSend);

        MainEmissions.frmBoletos.MemoResponse.text := sresponse;

      end;
    except
      on E: Exception do
      begin
        ShowMessage('Erro na Requisição Put /v1/charge/:id/metadata '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;

procedure PayChargeBillet;
var
  sResponse: String;
  Modal    : TViewPayChargeBillet;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewPayChargeBillet, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := uConnections.OauthToken;
        HttpClient  := uConnections.SetupClient;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);

        JsonToSend := TMemoryStream.Create;
        WriteStringToStream(JsonToSend, Modal.Body, IndyTextEncoding_UTF8);
        JsonToSend.Position := 0;

        sResponse := HttpClient.Post(MainEmissions.frmBoletos.Enviroment +'/v1/charge/' + Modal.Identifier + '/pay', JsonToSend);

        MainEmissions.frmBoletos.MemoResponse.text := sresponse;

      end;
    except
      on E: Exception do
      begin
        ShowMessage('Erro na Requisição POST /v1/charge/:id/pay '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;

procedure PayChargeCreditCard;
var
  sResponse: String;
  Modal    : TViewPayCreditCard;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewPayCreditCard, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := uConnections.OauthToken;
        HttpClient  := uConnections.SetupClient;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);

        JsonToSend := TMemoryStream.Create;
        WriteStringToStream(JsonToSend, Modal.Body, IndyTextEncoding_UTF8);
        JsonToSend.Position := 0;

        sResponse := HttpClient.Post(MainEmissions.frmBoletos.Enviroment +'/v1/charge/' + Modal.Identifier + '/pay', JsonToSend);

        MainEmissions.frmBoletos.MemoResponse.text := sresponse;

      end;
    except
      on E: Exception do
      begin
        ShowMessage('Erro na Requisição POST /v1/charge/:id/pay '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;

procedure ResendBillet;
var
  sResponse: String;
  Modal    : TViewResendBillet;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewResendBillet, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := uConnections.OauthToken;
        HttpClient  := uConnections.SetupClient;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);

        JsonToSend := TMemoryStream.Create;
        WriteStringToStream(JsonToSend, Modal.Body, IndyTextEncoding_UTF8);
        JsonToSend.Position := 0;

        sResponse := HttpClient.Post(MainEmissions.frmBoletos.Enviroment +'/v1/charge/'+ Modal.Identifier + '/billet/resend', JsonToSend);

        MainEmissions.frmBoletos.MemoResponse.text := sresponse;

      end;
    except
      on E: Exception do
      begin
        ShowMessage('Erro na Requisição GET /v1/charge/:id/billet/resend '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;

procedure CreateChargeHistory;
var
  sResponse: String;
  Modal    : TViewCreateChargeHistory;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewCreateChargeHistory, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := uConnections.OauthToken;
        HttpClient  := uConnections.SetupClient;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);

        JsonToSend := TMemoryStream.Create;
        WriteStringToStream(JsonToSend, Modal.Body, IndyTextEncoding_UTF8);
        JsonToSend.Position := 0;

        sResponse := HttpClient.Post(MainEmissions.frmBoletos.Enviroment +'/v1/charge/'+ Modal.Identifier + '/history', JsonToSend);

        MainEmissions.frmBoletos.MemoResponse.text := sresponse;

      end;
    except
      on E: Exception do
      begin
        ShowMessage('Erro na Requisição GET /v1/charge/:id/history '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;

procedure LinkCharge;
var
  sResponse: String;
  Modal    : TViewCreateLinkCharge;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewCreateLinkCharge, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := uConnections.OauthToken;
        HttpClient  := uConnections.SetupClient;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);

        JsonToSend := TMemoryStream.Create;
        WriteStringToStream(JsonToSend, Modal.Body, IndyTextEncoding_UTF8);
        JsonToSend.Position := 0;

        sResponse := HttpClient.Post(MainEmissions.frmBoletos.Enviroment +'/v1/charge/'+ Modal.Identifier + '/link', JsonToSend);

        MainEmissions.frmBoletos.MemoResponse.text := sresponse;

      end;
    except
      on E: Exception do
      begin
        ShowMessage('Erro na Requisição GET /v1/charge/:id/link '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;

procedure UpdateChargeLink;
var
  sResponse: String;
  Modal    : TViewUpdateLinkCharge;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewUpdateLinkCharge, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := uConnections.OauthToken;
        HttpClient  := uConnections.SetupClient;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);

        JsonToSend := TMemoryStream.Create;
        WriteStringToStream(JsonToSend, Modal.Body, IndyTextEncoding_UTF8);
        JsonToSend.Position := 0;

        sResponse := HttpClient.Put(MainEmissions.frmBoletos.Enviroment +'/v1/charge/'+ Modal.Identifier + '/link', JsonToSend);

        MainEmissions.frmBoletos.MemoResponse.text := sresponse;

      end;
    except
      on E: Exception do
      begin
        ShowMessage('Erro na Requisição GET /v1/charge/:id/link '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;

procedure SettleCharge;
var
  sResponse: String;
  Modal    : TViewDetailBillet;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewDetailBillet, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := uConnections.OauthToken;
        HttpClient  := uConnections.SetupClient;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);

        JsonToSend := TMemoryStream.Create;
        WriteStringToStream(JsonToSend, '{}', IndyTextEncoding_UTF8);
        JsonToSend.Position := 0;

        sResponse := HttpClient.Put(MainEmissions.frmBoletos.Enviroment +'/v1/charge/'+ Modal.Identifier + '/settle', JsonToSend);

        MainEmissions.frmBoletos.MemoResponse.text := sresponse;

      end;
    except
      on E: Exception do
      begin
        ShowMessage('Erro na Requisição GET /v1/charge/:id/settle '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;

end.
