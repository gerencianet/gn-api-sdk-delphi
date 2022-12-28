unit PixEndpoints;

interface

uses
  Classes, Connections, IdHTTP, XSuperObject, IdGlobal, Vcl.Dialogs, System.SysUtils,
  MainPix, ViewPixDetail, ViewPixCreateImmediateCharge, Forms, ViewPixList,
  ViewPixDetailDevolution, ViewPixSend, ViewPixDevolution, ViewPixE2eidDetail;

procedure PixListReceived;
procedure PixSend;
procedure PixDetail;
procedure PixDevolutionGet;
procedure PixDevolution;

implementation

threadvar
  HttpClient: TIdHTTP;
  AccessToken, ObjResult : iSuperObject;
  JsonToSend: TMemoryStream;

procedure PixListReceived;
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
        sResponse := HttpClient.Get(MainPix.frmPix.Enviroment + '/v2/pix?inicio='+ Modal.StartDate +
          '&fim=' + Modal.EndDate );

        MainPix.frmPix.MemoResponse.text := sresponse;
      end;

    except
      on E: Exception do
      begin
        ShowMessage('Erro na Requisição GET /v2/pix/'#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;

procedure PixSend;
var
  sResponse: string;
  Modal    : TViewPixSend;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewPixSend, Modal);

      if Modal.ShowModal = 1 then
      begin

        AccessToken := Connections.OauthToken;
        HttpClient := Connections.SetupClient;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);

        JsonToSend := TMemoryStream.Create;
        WriteStringToStream(JsonToSend, Modal.Body, IndyTextEncoding_UTF8);
        JsonToSend.Position := 0;

        sResponse := HttpClient.Put( MainPix.frmPix.Enviroment  + '/v2/gn/pix/' + Modal.txtIdEnvio.Text, JsonToSend);

        MainPix.frmPix.MemoResponse.text := sresponse;
      end;

    except
      on E: Exception do
      begin
        ShowMessage('Erro na Requisição POST /v2/pix '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;

procedure PixDetail;
var
  sResponse: string;
  Modal    : TViewPixE2eidDetail;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewPixE2eidDetail, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := Connections.OauthToken;
        HttpClient := Connections.SetupClient;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);
        sResponse := HttpClient.Get(MainPix.frmPix.Enviroment + '/v2/pix/'+ Modal.Identifier);

        MainPix.frmPix.MemoResponse.text := sresponse;
      end;

    except
      on E: Exception do
      begin
        ShowMessage('Erro na Requisição GET /v2/pix/:e2id '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;

procedure PixDevolutionGet;
var
  sResponse: string;
  Modal    : TViewPixDetailDevolution;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewPixDetailDevolution, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := Connections.OauthToken;
        HttpClient := Connections.SetupClient;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);
        sResponse := HttpClient.Get(MainPix.frmPix.Enviroment + '/v2/pix/'+ Modal.e2eid +
                                    '/devolucao/'+Modal.id);

        MainPix.frmPix.MemoResponse.text := sresponse;
      end;

    except
      on E: Exception do
      begin
        ShowMessage('Erro na Requisição GET /v2/pix/:e2id/devolucao/:id '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;

procedure PixDevolution;
var
  sResponse: string;
  Modal    : TViewPixDevolution;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewPixDevolution, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := Connections.OauthToken;
        HttpClient := Connections.SetupClient;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);

        JsonToSend := TMemoryStream.Create;
        WriteStringToStream(JsonToSend, Modal.Body, IndyTextEncoding_UTF8);
        JsonToSend.Position := 0;

        sResponse := HttpClient.Put(MainPix.frmPix.Enviroment + '/v2/pix/'+ Modal.e2eid +
                                    '/devolucao/'+ Modal.id, JsonToSend);

        MainPix.frmPix.MemoResponse.text := sresponse;
      end;

    except
      on E: Exception do
      begin
        ShowMessage('Erro na Requisição PUT /v2/pix/:e2id/devolucao/:id '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;

end.
