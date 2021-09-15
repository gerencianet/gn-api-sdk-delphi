unit uPlansEndpoints;

interface

uses
  IdHTTP, XSuperObject, uCommonTypes, uChargeClasses, DateUtils,
  Classes, System.SysUtils, Vcl.Forms, uConnections,
  IdGlobal, Vcl.Dialogs, MainEmissions, ViewCreatePlan, ViewGetPlan, ViewUpdatePlan,
  ViewDetailPlan, ViewCreateSubscription, ViewUpdateMetadataPlan,
  ViewCreatePlanHistory, ViewPayPlan, ViewPayPlanCreditCard;

procedure CreatePlan;
procedure GetPlans;
procedure UpdatePlan;
procedure DeletePlan;
procedure CreateSubscription;
procedure DetailSubscription;
procedure CancelSubscription;
procedure UpdateSubscriptionMetadata;
procedure PaySubscriptionBillet;
procedure PaySubscriptionCreditCard;
procedure CreateSubscriptionHistory;

implementation

threadvar
  HttpClient: TIdHTTP;
  AccessToken, ObjResult : iSuperObject;
  JsonToSend: TMemoryStream;

procedure CreatePlan;
var
  sResponse: String;
  Modal    : TViewCreatePlan;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewCreatePlan, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := uConnections.OauthToken;
        HttpClient  := uConnections.SetupClient;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);

        JsonToSend := TMemoryStream.Create;
        WriteStringToStream(JsonToSend, Modal.Body, IndyTextEncoding_UTF8);
        JsonToSend.Position := 0;

        sResponse := HttpClient.Post(MainEmissions.frmBoletos.Enviroment +'/v1/plan/', JsonToSend);

        MainEmissions.frmBoletos.MemoResponse.text := sresponse;

      end;
    except
      on E: Exception do
      begin
        ShowMessage('Erro na Requisição POST /v1/plan '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;

procedure GetPlans;
var
  sResponse: String;
  Modal    : TViewGetPlan;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewGetPlan, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := uConnections.OauthToken;
        HttpClient  := uConnections.SetupClient;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);

        if Modal.NameIdentifier <> EmptyStr then
          HttpClient.Request.CustomHeaders.Params['Name', Modal.NameIdentifier];

        if Modal.Limit <> EmptyStr then
          HttpClient.Request.CustomHeaders.Params['Limit', Modal.Limit];

        if Modal.Offset <> EmptyStr then
          HttpClient.Request.CustomHeaders.Params['Offset', Modal.Offset];

        sResponse := HttpClient.Get(MainEmissions.frmBoletos.Enviroment +'/v1/plans');

        MainEmissions.frmBoletos.MemoResponse.text := sresponse;

      end;
    except
      on E: Exception do
      begin
        ShowMessage('Erro na Requisição GET /v1/plan/:id '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;

procedure UpdatePlan;
var
  sResponse: String;
  Modal    : TViewUpdatePlan;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewUpdatePlan, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := uConnections.OauthToken;
        HttpClient  := uConnections.SetupClient;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);

        JsonToSend := TMemoryStream.Create;
        WriteStringToStream(JsonToSend, Modal.Body, IndyTextEncoding_UTF8);
        JsonToSend.Position := 0;

        sResponse := HttpClient.Post(MainEmissions.frmBoletos.Enviroment +'/v1/plan/'+ Modal.Identifier, JsonToSend);

        MainEmissions.frmBoletos.MemoResponse.text := sresponse;

      end;
    except
      on E: Exception do
      begin
        ShowMessage('Erro na Requisição POST /v1/plan/:id '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;

procedure DeletePlan;
var
  sResponse: String;
  Modal    : TViewDetailPlan;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewDetailPlan, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := uConnections.OauthToken;
        HttpClient  := uConnections.SetupClient;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);

        sResponse := HttpClient.Delete(MainEmissions.frmBoletos.Enviroment +'/v1/plan/'+ Modal.Identifier);

        MainEmissions.frmBoletos.MemoResponse.text := sresponse;

      end;
    except
      on E: Exception do
      begin
        ShowMessage('Erro na Requisição DELETE /v1/plan/:id '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;

procedure CreateSubscription;
var
  sResponse: String;
  Modal    : TViewCreateSubscription;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewCreateSubscription, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := uConnections.OauthToken;
        HttpClient  := uConnections.SetupClient;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);

        JsonToSend := TMemoryStream.Create;
        WriteStringToStream(JsonToSend, Modal.Body, IndyTextEncoding_UTF8);
        JsonToSend.Position := 0;

        sResponse := HttpClient.Post(MainEmissions.frmBoletos.Enviroment +'/v1/plan/' +
                          Modal.Identifier + '/subscription', JsonToSend);

        MainEmissions.frmBoletos.MemoResponse.text := sresponse;

      end;
    except
      on E: Exception do
      begin
        ShowMessage('Erro na Requisição POST /v1/plan/:id/subscription '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;

procedure CancelSubscription;
var
  sResponse: String;
  Modal    : TViewDetailPlan;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewDetailPlan, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := uConnections.OauthToken;
        HttpClient  := uConnections.SetupClient;

        JsonToSend := TMemoryStream.Create;
        WriteStringToStream(JsonToSend, '{}', IndyTextEncoding_UTF8);
        JsonToSend.Position := 0;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);

        sResponse := HttpClient.Put(MainEmissions.frmBoletos.Enviroment +'/v1/subscription/'
              + Modal.Identifier + '/cancel', JsonToSend);

        MainEmissions.frmBoletos.MemoResponse.text := sresponse;

      end;
    except
      on E: Exception do
      begin
        ShowMessage('Erro na Requisição GET /v1/subscription/:id/cancel '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;

procedure DetailSubscription;
var
  sResponse: String;
  Modal    : TViewDetailPlan;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewDetailPlan, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := uConnections.OauthToken;
        HttpClient  := uConnections.SetupClient;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);

        sResponse := HttpClient.Get(MainEmissions.frmBoletos.Enviroment +'/v1/subscription/' + Modal.Identifier);

        MainEmissions.frmBoletos.MemoResponse.text := sresponse;

      end;
    except
      on E: Exception do
      begin
        ShowMessage('Erro na Requisição GET /v1/subscription/:id '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;

procedure UpdateSubscriptionMetadata;
var
  sResponse: String;
  Modal    : TViewUpdateMetadataPlan;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewUpdateMetadataPlan, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := uConnections.OauthToken;
        HttpClient  := uConnections.SetupClient;

        JsonToSend := TMemoryStream.Create;
        WriteStringToStream(JsonToSend, Modal.Body, IndyTextEncoding_UTF8);
        JsonToSend.Position := 0;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);

        sResponse := HttpClient.Put(MainEmissions.frmBoletos.Enviroment +'/v1/subscription/'+
                      Modal.Identifier + '/metadata', JsonToSend);

        MainEmissions.frmBoletos.MemoResponse.text := sresponse;

      end;
    except
      on E: Exception do
      begin
        ShowMessage('Erro na Requisição Put /v1/subscription/:id/metadata '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;

end;

procedure CreateSubscriptionHistory;
var
  sResponse: String;
  Modal    : TViewCreatePlanHistory;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewCreatePlanHistory, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := uConnections.OauthToken;
        HttpClient  := uConnections.SetupClient;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);

        JsonToSend := TMemoryStream.Create;
        WriteStringToStream(JsonToSend, Modal.Body, IndyTextEncoding_UTF8);
        JsonToSend.Position := 0;

        sResponse := HttpClient.Post(MainEmissions.frmBoletos.Enviroment +'/v1/subscription/'+
                      Modal.Identifier + '/history', JsonToSend);

        MainEmissions.frmBoletos.MemoResponse.text := sresponse;

      end;
    except
      on E: Exception do
      begin
        ShowMessage('Erro na Requisição GET /v1/subscription/:id/history '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;

procedure PaySubscriptionBillet;
var
  sResponse: String;
  Modal    : TViewPayPlan;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewPayPlan, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := uConnections.OauthToken;
        HttpClient  := uConnections.SetupClient;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);

        JsonToSend := TMemoryStream.Create;
        WriteStringToStream(JsonToSend, Modal.Body, IndyTextEncoding_UTF8);
        JsonToSend.Position := 0;

        sResponse := HttpClient.Post(MainEmissions.frmBoletos.Enviroment +'/v1/subscription/' + Modal.Identifier + '/pay', JsonToSend);

        MainEmissions.frmBoletos.MemoResponse.text := sresponse;

      end;
    except
      on E: Exception do
      begin
        ShowMessage('Erro na Requisição POST /v1/subscription/:id/pay '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;

procedure PaySubscriptionCreditCard;
var
  sResponse: String;
  Modal    : TViewPayPlanCreditCard;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewPayPlanCreditCard, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := uConnections.OauthToken;
        HttpClient  := uConnections.SetupClient;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);

        JsonToSend := TMemoryStream.Create;
        WriteStringToStream(JsonToSend, Modal.Body, IndyTextEncoding_UTF8);
        JsonToSend.Position := 0;

        sResponse := HttpClient.Post(MainEmissions.frmBoletos.Enviroment +'/v1/subscription/' + Modal.Identifier + '/pay', JsonToSend);

        MainEmissions.frmBoletos.MemoResponse.text := sresponse;

      end;
    except
      on E: Exception do
      begin
        ShowMessage('Erro na Requisição POST /v1/subscription/:id/pay '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;
end.
