unit ChargesEndpoints;

interface

uses
  Vcl.Forms, Classes, Connections, IdHTTP, XSuperObject, IdGlobal, Vcl.Dialogs, System.SysUtils,
  MainPix, ViewPixList, ViewPixDetail, System.JSON,
  ViewPixCreateCharge, ViewPixCreateImmediateCharge, ViewPixUpdateCharge;

procedure PixListCharges;
procedure PixDetailCharge;
procedure PixCreateCharge;
procedure PixUpdateCharge;
procedure PixCreateImmediateCharge;

implementation

threadvar
  HttpClient: TIdHTTP;
  AccessToken, ObjResult : iSuperObject;
  JsonToSend: TMemoryStream;

procedure PixListCharges;
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
        HttpClient := Connections.SetupClient;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);
        sResponse := HttpClient.Get(MainPix.frmPix.Enviroment + '/v2/cob?inicio='+ Modal.StartDate +
                                   '&fim=' + Modal.EndDate );

        MainPix.frmPix.MemoResponse.text := sresponse;

      end;
    except
      on E: Exception do
      begin
        ShowMessage('Erro na Requisição GET /v2/cob '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;

procedure PixDetailCharge;
var
  sResponse: string;
  Modal    : TViewDetail;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewDetail, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := Connections.OauthToken;
        HttpClient := Connections.SetupClient;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);

        sResponse := HttpClient.Get(MainPix.frmPix.Enviroment + '/v2/cob/' + Modal.Identifier);

        MainPix.frmPix.MemoResponse.text := sresponse;
      end;

    except
      on E: Exception do
      begin
        ShowMessage('Erro na Requisição GET /v2/cob/:txid '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;


procedure PixCreateCharge;
var
  sResponse: String;
  Modal    : TViewPixCreateCharge;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewPixCreateCharge, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := Connections.OauthToken;
        HttpClient := Connections.SetupClient;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);

        JsonToSend := TMemoryStream.Create;
        WriteStringToStream(JsonToSend, Modal.Body, IndyTextEncoding_UTF8);
        JsonToSend.Position := 0;

        sResponse := HttpClient.Put( MainPix.frmPix.Enviroment +'/v2/cob/'+ Modal.Identifier, JsonToSend);

        MainPix.frmPix.MemoResponse.text := sresponse;

      end;
    except
      on E: Exception do
      begin
        ShowMessage('Erro na Requisição PUT /v2/cob/:txid '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;

procedure PixUpdateCharge;
var
  sResponse: string;
  Modal : TViewUpdateCharge;
begin
  try
    try

      if not Assigned(Modal) then
        Application.CreateForm(TViewUpdateCharge, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := Connections.OauthToken;
        HttpClient := Connections.SetupClient;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);

        JsonToSend := TMemoryStream.Create;
        WriteStringToStream(JsonToSend, Modal.Body, IndyTextEncoding_UTF8);
        JsonToSend.Position := 0;

        sResponse := HttpClient.Patch( MainPix.frmPix.Enviroment +'/v2/cob/'+ Modal.Identifier, JsonToSend);

        MainPix.frmPix.MemoResponse.text := sresponse;

      end;

    except
      on E: Exception do
      begin
        ShowMessage('Erro na Requisição PACTH /v2/Update/:txid '#13#10#13#10 + e.Message);
        end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;

procedure PixCreateImmediateCharge;
var
  sResponse: string;
  Modal    : TViewCreateImmediateCharge;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewCreateImmediateCharge, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := Connections.OauthToken;
        HttpClient := Connections.SetupClient;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);

        JsonToSend := TMemoryStream.Create;
        WriteStringToStream(JsonToSend, Modal.Body, IndyTextEncoding_UTF8);
        JsonToSend.Position := 0;

        sResponse := HttpClient.Post( MainPix.frmPix.Enviroment  + '/v2/cob', JsonToSend);

        MainPix.frmPix.MemoResponse.text := sresponse;

      end;

    except
      on E: Exception do
      begin
        ShowMessage('Erro na Requisição POST /v2/cob/ '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;

end.
