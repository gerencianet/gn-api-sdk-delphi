unit uCarnetEndpoints;

interface

uses
  IdHTTP, XSuperObject, uCommonTypes, uChargeClasses, DateUtils,
  Classes, System.SysUtils, Vcl.Forms, uConnections,
  IdGlobal, Vcl.Dialogs, MainEmissions, ViewCreateCarnet, ViewDetailCarnet, ViewUpdateParcel,
  ViewUpdateMetadataCarnet, ViewResendParcel, ViewCancelParcel, ViewResendCarnet,
  ViewCreateCarnetHistory, ViewSettleCarnetParcel;

procedure CreateCarnet;
procedure DetailCarnet;
procedure UpdateCarnetMetadata;
procedure UpdateParcel;
procedure CancelCarnet;
procedure CancelParcel;
procedure ResendCarnet;
procedure ResendParcel;
procedure CreateCarnetHistory;
procedure SettleCarnet;
procedure SettleCarnetParcel;

implementation

threadvar
  HttpClient: TIdHTTP;
  AccessToken, ObjResult : iSuperObject;
  JsonToSend: TMemoryStream;

procedure CreateCarnet;
var
  sResponse: String;
  Modal    : TViewCreateCarnet;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewCreateCarnet, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := uConnections.OauthToken;
        HttpClient  := uConnections.SetupClient;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);

        JsonToSend := TMemoryStream.Create;
        WriteStringToStream(JsonToSend, Modal.Body, IndyTextEncoding_UTF8);
        JsonToSend.Position := 0;

        sResponse := HttpClient.Post(MainEmissions.frmBoletos.Enviroment +'/v1/carnet/', JsonToSend);

        MainEmissions.frmBoletos.MemoResponse.text := sresponse;

      end;
    except
      on E: Exception do
      begin
        ShowMessage('Erro na Requisição POST /v1/Carnet '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;

procedure DetailCarnet;
var
  sResponse: String;
  Modal    : TViewDetailCarnet;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewDetailCarnet, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := uConnections.OauthToken;
        HttpClient  := uConnections.SetupClient;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);

        sResponse := HttpClient.Get(MainEmissions.frmBoletos.Enviroment +'/v1/carnet/'+ Modal.Identifier);

        MainEmissions.frmBoletos.MemoResponse.text := sresponse;

      end;
    except
      on E: Exception do
      begin
        ShowMessage('Erro na Requisição GET /v1/Carnet/:id '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;

procedure UpdateParcel;
var
  sResponse: String;
  Modal    : TViewUpdateParcel;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewUpdateParcel, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := uConnections.OauthToken;
        HttpClient  := uConnections.SetupClient;

        JsonToSend := TMemoryStream.Create;
        WriteStringToStream(JsonToSend, Modal.Body, IndyTextEncoding_UTF8);
        JsonToSend.Position := 0;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);

        sResponse := HttpClient.Put(MainEmissions.frmBoletos.Enviroment +'/v1/carnet/'+ Modal.id + '/parcel/' + Modal.parcel,
          JsonToSend);

        MainEmissions.frmBoletos.MemoResponse.text := sresponse;

      end;
    except
      on E: Exception do
      begin
        ShowMessage('Erro na Requisição Put /v1/Carnet/:id/parcel '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;

procedure CancelCarnet;
var
  sResponse: String;
  Modal    : TViewDetailCarnet;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewDetailCarnet, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := uConnections.OauthToken;
        HttpClient  := uConnections.SetupClient;

        JsonToSend := TMemoryStream.Create;
        WriteStringToStream(JsonToSend, '{}', IndyTextEncoding_UTF8);
        JsonToSend.Position := 0;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);

        sResponse := HttpClient.Put(MainEmissions.frmBoletos.Enviroment +'/v1/carnet/'+ Modal.Identifier + '/cancel', JsonToSend);

        MainEmissions.frmBoletos.MemoResponse.text := sresponse;

      end;
    except
      on E: Exception do
      begin
        ShowMessage('Erro na Requisição Put /v1/carnet/:id/cancel '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;

procedure UpdateCarnetMetadata;
var
  sResponse: String;
  Modal    : TViewUpdateMetadataCarnet;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewUpdateMetadataCarnet, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := uConnections.OauthToken;
        HttpClient  := uConnections.SetupClient;

        JsonToSend := TMemoryStream.Create;
        WriteStringToStream(JsonToSend, Modal.Body, IndyTextEncoding_UTF8);
        JsonToSend.Position := 0;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);

        sResponse := HttpClient.Put(MainEmissions.frmBoletos.Enviroment +'/v1/carnet/'+ Modal.Identifier + '/metadata', JsonToSend);

        MainEmissions.frmBoletos.MemoResponse.text := sresponse;

      end;
    except
      on E: Exception do
      begin
        ShowMessage('Erro na Requisição Put /v1/Carnet/:id/metadata '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;

procedure ResendCarnet;
var
  sResponse: String;
  Modal    : TViewResendCarnet;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewResendCarnet, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := uConnections.OauthToken;
        HttpClient  := uConnections.SetupClient;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);

        JsonToSend := TMemoryStream.Create;
        WriteStringToStream(JsonToSend, Modal.Body, IndyTextEncoding_UTF8);
        JsonToSend.Position := 0;

        sResponse := HttpClient.Post(MainEmissions.frmBoletos.Enviroment +'/v1/carnet/'+ Modal.Identifier + '/resend', JsonToSend);

        MainEmissions.frmBoletos.MemoResponse.text := sresponse;

      end;
    except
      on E: Exception do
      begin
        ShowMessage('Erro na Requisição POST /v1/carnet/:id/resend '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;

procedure ResendParcel;
var
  sResponse: String;
  Modal    : TViewResendParcel;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewResendParcel, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := uConnections.OauthToken;
        HttpClient  := uConnections.SetupClient;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);

        JsonToSend := TMemoryStream.Create;
        WriteStringToStream(JsonToSend, Modal.Body, IndyTextEncoding_UTF8);
        JsonToSend.Position := 0;

        sResponse := HttpClient.Post(MainEmissions.frmBoletos.Enviroment +'/v1/carnet/'+ Modal.Identifier + '/parcel/'+
                          Modal.Parcel +'/resend', JsonToSend);

        MainEmissions.frmBoletos.MemoResponse.text := sresponse;

      end;
    except
      on E: Exception do
      begin
        ShowMessage('Erro na Requisição POST /v1/carnet/:id/parcel/:parcel/resend '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;

procedure CancelParcel;
var
  sResponse: String;
  Modal    : TViewCancelParcel;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewCancelParcel, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := uConnections.OauthToken;
        HttpClient  := uConnections.SetupClient;

        JsonToSend := TMemoryStream.Create;
        WriteStringToStream(JsonToSend, '{}', IndyTextEncoding_UTF8);
        JsonToSend.Position := 0;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);

        sResponse := HttpClient.Put(MainEmissions.frmBoletos.Enviroment +'/v1/carnet/'+ Modal.Identifier + '/parcel/'+
                          Modal.Parcel +'/cancel', JsonToSend);

        MainEmissions.frmBoletos.MemoResponse.text := sresponse;

      end;
    except
      on E: Exception do
      begin
        ShowMessage('Erro na Requisição PUT /v1/carnet/:id/parcel/:parcel/cancel '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;


procedure CreateCarnetHistory;
var
  sResponse: String;
  Modal    : TViewCreateCarnetHistory;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewCreateCarnetHistory, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := uConnections.OauthToken;
        HttpClient  := uConnections.SetupClient;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);

        JsonToSend := TMemoryStream.Create;
        WriteStringToStream(JsonToSend, Modal.Body, IndyTextEncoding_UTF8);
        JsonToSend.Position := 0;

        sResponse := HttpClient.Post(MainEmissions.frmBoletos.Enviroment +'/v1/carnet/'+ Modal.Identifier + '/history', JsonToSend);

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

procedure SettleCarnet;
var
  sResponse: String;
  Modal    : TViewDetailCarnet;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewDetailCarnet, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := uConnections.OauthToken;
        HttpClient  := uConnections.SetupClient;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);

        JsonToSend := TMemoryStream.Create;
        WriteStringToStream(JsonToSend, '{}', IndyTextEncoding_UTF8);
        JsonToSend.Position := 0;

        sResponse := HttpClient.Put(MainEmissions.frmBoletos.Enviroment +'/v1/carnet/'+ Modal.Identifier + '/settle', JsonToSend);

        MainEmissions.frmBoletos.MemoResponse.text := sresponse;

      end;
    except
      on E: Exception do
      begin
        ShowMessage('Erro na Requisição GET /v1/carnet/:id/settle '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;

procedure SettleCarnetParcel;
var
  sResponse: String;
  Modal    : TViewSettleCarnetParcel;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewSettleCarnetParcel, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := uConnections.OauthToken;
        HttpClient  := uConnections.SetupClient;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);

        JsonToSend := TMemoryStream.Create;
        WriteStringToStream(JsonToSend, '{}', IndyTextEncoding_UTF8);
        JsonToSend.Position := 0;

        sResponse := HttpClient.Put(MainEmissions.frmBoletos.Enviroment +'/v1/carnet/'+ Modal.Identifier
          + '/parcel/' + Modal.Parcel + '/settle', JsonToSend);

        MainEmissions.frmBoletos.MemoResponse.text := sresponse;

      end;
    except
      on E: Exception do
      begin
        ShowMessage('Erro na Requisição GET /v1/carnet/:id/settle '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;

end.
