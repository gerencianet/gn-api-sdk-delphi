unit LocEndpoints;

interface

uses
  Classes, Connections, IdHTTP, XSuperObject, IdGlobal, Vcl.Dialogs, System.SysUtils,
  System.StrUtils, System.Types,
  MainPix, Vcl.Graphics, Vcl.Imaging.pngimage, DelphiZXIngQRCode,
  ViewPixDetail,ViewPixIdDetail, Forms, ViewPixList,
  ViewPixCreateImmediateCharge;

procedure PixListLocation;
procedure PixDetailLocation;
procedure PixGenerateQRCode;
procedure PixCreateLocation;
procedure PixUnsetTxid;
procedure QrCodeGenerator(texto: WideString);

implementation

threadvar
  HttpClient: TIdHTTP;
  AccessToken, ObjResult : iSuperObject;
  JsonToSend: TMemoryStream;


procedure PixListLocation;
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
        sResponse := HttpClient.Get(MainPix.frmPix.Enviroment + '/v2/loc/?inicio='
                                  +Modal.StartDate+'&fim='+Modal.EndDate);

        MainPix.frmPix.MemoResponse.text := sresponse;
      end;

    except
      on E: Exception do
      begin
        ShowMessage('Erro na requisição GET /v2/loc '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;

procedure PixDetailLocation;
var
  sResponse: string;
  Modal    : TViewPixIdDetail;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewPixIdDetail, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := Connections.OauthToken;
        HttpClient := Connections.SetupClient;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);
        sResponse := HttpClient.Get(MainPix.frmPix.Enviroment + '/v2/loc/'+ Modal.Identifier);

        MainPix.frmPix.MemoResponse.text := sresponse;
      end;

    except
      on E: Exception do
      begin
        ShowMessage('Erro na requisição GET /v2/loc/:id '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;

procedure PixGenerateQRCode;
var
  sResponse: WideString;
  Modal    : TViewPixIdDetail;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewPixIdDetail, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := Connections.OauthToken;
        HttpClient := Connections.SetupClient;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);
        sResponse := HttpClient.Get(MainPix.frmPix.Enviroment + '/v2/loc/'+ Modal.Identifier +'/qrcode');

        ObjResult := SO(sResponse);

        MainPix.frmPix.MemoResponse.text := sresponse;

        QrCodeGenerator(ObjResult.S['qrcode']);
      end;

    except
      on E: Exception do
      begin
        ShowMessage('Erro na requisição GET /v2/loc/:id/qrcode '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;

procedure PixCreateLocation;
Const
  Body = '{"tipoCob": "cob"}';
var
  sResponse: string;
begin
  try
    try

      AccessToken := Connections.OauthToken;
      HttpClient := Connections.SetupClient;

      HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);

      JsonToSend := TMemoryStream.Create;
      WriteStringToStream(JsonToSend, Body, IndyTextEncoding_UTF8);
      JsonToSend.Position := 0;

      sResponse := HttpClient.Post( MainPix.frmPix.Enviroment  + '/v2/loc', JsonToSend);

      MainPix.frmPix.MemoResponse.text := sresponse;

    except
      on E: Exception do
      begin
        ShowMessage('Erro na requisição POST /v2/loc '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    //
  end;
end;

procedure PixUnsetTxid;
var
  sResponse: string;
  Modal    : TViewPixIdDetail;
begin
  try
    try
      if not Assigned(Modal) then
        Application.CreateForm(TViewPixIdDetail, Modal);

      if Modal.ShowModal = 1 then
      begin
        AccessToken := Connections.OauthToken;
        HttpClient := Connections.SetupClient;

        HttpClient.Request.CustomHeaders.Values['Authorization'] := ('Bearer '+ AccessToken.S['access_token']);
        sResponse := HttpClient.Delete(MainPix.frmPix.Enviroment + '/v2/loc/'+Modal.Identifier+'/txid');

        MainPix.frmPix.MemoResponse.text := sresponse;
      end;

    except
      on E: Exception do
      begin
        ShowMessage('Erro na requisição DELETE /v2/loc/:id/txid '#13#10#13#10 + e.Message);
      end;
    end;
  finally
    Modal.ClearRequestfields;
  end;
end;

///Procedure de imprimir o QRCode na tela
procedure QrCodeGenerator(texto: WideString);
var
  bitmap: TBitmap;
  QRCode: TDelphiZXingQRCode;
  Row, Column: Integer;
  scala: Double;
  textoSeparado: TStringDynArray;
begin
  bitmap := TBitmap.create;
  QRCode := TDelphiZXingQRCode.create;

  textoSeparado := SplitString(texto, '/');

  QRCode.Data := texto;

  bitmap.SetSize(QRCode.Rows, QRCode.Columns);

  for Row := 0 to QRCode.Rows do
    for Column := 0 to QRCode.Columns do
      if QRCode.IsBlack[Row, Column] then
        bitmap.Canvas.Pixels[Column, Row] := clBlack
      else
        bitmap.Canvas.Pixels[Column, Row] := clWhite;

  if (MainPix.frmPix.QrCodeImg.Width < bitmap.Height) then
    scala := MainPix.frmPix.QrCodeImg.Width / bitmap.Width
  else
    scala := MainPix.frmPix.QrCodeImg.Height / bitmap.Height;

  MainPix.frmPix.QrCodeImg.Canvas.StretchDraw(Rect(0, 0, Trunc(scala * bitmap.Width), Trunc(scala * bitmap.Height)), bitmap);
end;

end.
