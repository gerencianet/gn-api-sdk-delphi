unit ViewUpdateLinkCharge;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.UITypes,
  Vcl.ComCtrls, uChargeClasses, XSuperJSON, XSuperObject;

type
  TViewUpdateLinkCharge = class(TForm)
    GroupBox3: TGroupBox;
    Label1: TLabel;
    txtIdent: TEdit;
    btnCancelRequest: TButton;
    btnConfirmRequest: TButton;
    Label2: TLabel;
    txtBilletDiscount: TEdit;
    Label3: TLabel;
    txtCardDiscount: TEdit;
    Label4: TLabel;
    txtExpireAt: TEdit;
    txtRequestDeliveryAddress: TCheckBox;
    Label5: TLabel;
    Label6: TLabel;
    txtPaymentMethod: TEdit;
    txtMessage: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmRequestClick(Sender: TObject);
    procedure btnCancelRequestClick(Sender: TObject);
  private
    function GetIdent: String;
    function GetBody: String;
  public
    property Identifier: String read GetIdent;
    procedure ClearRequestfields;
    property Body: String read GetBody;
  end;

implementation

{$R *.dfm}

procedure TViewUpdateLinkCharge.btnCancelRequestClick(Sender: TObject);
begin
  ModalResult := mrCancel;
  txtMessage.Text := '';
end;

procedure TViewUpdateLinkCharge.btnConfirmRequestClick(Sender: TObject);
begin

  if txtExpireAt.Text = EmptyStr then
  begin
    MessageDlg('Necessário colocar um valor de vencimento', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtExpireAt.CanFocus then
      txtExpireAt.SetFocus;
  end
  else
    ModalResult := mrOk;
end;

procedure TViewUpdateLinkCharge.ClearRequestfields;
begin
  txtIdent.Text := '';
  txtBilletDiscount.Text := '';
  txtCardDiscount.Text := '';
  txtExpireAt.Text := '';
  txtRequestDeliveryAddress.Checked := False;
  txtMessage.Text := '';
end;

procedure TViewUpdateLinkCharge.FormCreate(Sender: TObject);
begin
  Self.Position := poScreenCenter;
end;

function TViewUpdateLinkCharge.GetBody: String;
var
  ClassChargeCreate  : TLinkCharge;
  BodyRequest        : ISuperObject;
begin

  ClassChargeCreate := TLinkCharge.Create;

  ClassChargeCreate.PaymentMethod := txtPaymentMethod.Text;
  ClassChargeCreate.BilletDiscount := txtBilletDiscount.Text;
  ClassChargeCreate.CardDiscount := txtCardDiscount.Text;
  ClassChargeCreate.ExpireAt := txtExpireAt.Text;
  ClassChargeCreate.RequestDeliveryAddress := txtRequestDeliveryAddress.Checked;
  ClassChargeCreate.Message := txtMessage.Text;

  BodyRequest := SO(ClassChargeCreate.AsJSON(False, False));

  if ClassChargeCreate.PaymentMethod = EmptyStr then
    BodyRequest.Remove('payment_method');

  if ClassChargeCreate.CardDiscount = EmptyStr then
    BodyRequest.Remove('card_discount');

  if ClassChargeCreate.CardDiscount = EmptyStr then
    BodyRequest.Remove('card_discount');

  if ClassChargeCreate.BilletDiscount = EmptyStr then
    BodyRequest.Remove('billet_discount');

  if ClassChargeCreate.Message = EmptyStr then
    BodyRequest.Remove('message');

  Result := BodyRequest.AsJSON;
end;

function TViewUpdateLinkCharge.GetIdent: String;
begin
  Result := txtIdent.Text;
end;


end.
