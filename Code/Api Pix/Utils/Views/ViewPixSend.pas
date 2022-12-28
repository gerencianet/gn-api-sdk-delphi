unit ViewPixSend;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, BodyPixClass, XSuperJSON, XSuperObject,
  System.UITypes, System.JSON;

type
  TViewPixSend = class(TForm)
    GroupBox3: TGroupBox;
    btnConfirmRequest: TButton;
    btnCancelRequest: TButton;
    GroupBox1: TGroupBox;
    txtValue: TEdit;
    Label3: TLabel;
    GroupBox2: TGroupBox;
    txtKeyFav: TEdit;
    Label4: TLabel;
    GroupBox4: TGroupBox;
    Label5: TLabel;
    txtKeyPag: TEdit;
    txtPayerInfo: TEdit;
    Label6: TLabel;
    Label1: TLabel;
    txtIdEnvio: TEdit;
    Label2: TLabel;
    txtDocumento: TEdit;
    procedure btnConfirmRequestClick(Sender: TObject);
    procedure btnCancelRequestClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    function GetBody: String;
  public
    property Body:    String read GetBody;
    procedure ClearRequestfields;
  end;

implementation

{$R *.dfm}
        
procedure TViewPixSend.btnCancelRequestClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TViewPixSend.btnConfirmRequestClick(Sender: TObject);
begin

  if txtValue.Text = EmptyStr then
  begin
    MessageDlg('Necessário informar um valor para a cobrança', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtValue.CanFocus then
      txtValue.SetFocus;
  end
  else if txtKeyPag.Text = EmptyStr then
  begin
    MessageDlg('A chave do pagador não pode ser vazia', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtKeyPag.CanFocus then
      txtKeyPag.SetFocus;
  end
  else if txtKeyFav.Text = EmptyStr then
  begin
    MessageDlg('A chave do favorecido não pode ser vazia', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtKeyFav.CanFocus then
      txtKeyFav.SetFocus;
  end
  else if txtIdEnvio.Text = EmptyStr then
  begin
    MessageDlg('Identificador não pode ser vazio', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtIdEnvio.CanFocus then
      txtIdEnvio.SetFocus;
  end
  else if txtDocumento.Text = EmptyStr then
  begin
    MessageDlg('Documento não pode ser vazio', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtDocumento.CanFocus then
      txtDocumento.SetFocus;
  end
  else
    ModalResult := mrOk;
end;

procedure TViewPixSend.FormCreate(Sender: TObject);
begin
  Self.Position := poScreenCenter;
end;


function TViewPixSend.GetBody: String;
var
  ClassPix : TBodyPixClass;
  FFavored    : TFavored;
  FPayer      : TPayer;
  FValue      : String;
  BodyRequest : ISuperObject;
begin
  ClassPix := TBodyPixClass.Create;

  FValue := txtValue.Text;

  FFavored.Key := txtKeyFav.Text;
  FFavored.Cpf := txtDocumento.Text;
  ClassPix.Favored := FFavored;

  FPayer.key := txtKeyPag.Text;
  FPayer.PayingInfo := txtPayerInfo.Text;
  ClassPix.Payer := FPayer;

  ClassPix.Value := FValue;

  BodyRequest := SO(ClassPix.AsJSON(False, False));



  if ClassPix.Payer.PayingInfo = EmptyStr then
    BodyRequest.Remove('infoPagador');




  Result := BodyRequest.AsJSON;
end;

procedure TViewPixSend.ClearRequestfields;
begin
  txtValue.Text := '';
  txtKeyFav.Text := '';
  txtKeyPag.Text := '';
  txtPayerInfo.Text := '';
  txtIdEnvio.Text := '';
  txtDocumento.Text := '';
end;


end.
