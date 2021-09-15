unit ViewPayCreditCardOneStep;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.DateUtils,
  uCommonTypes, uPaymentClasses, MainEmissions,
  XSuperJSON, XSuperObject, uPaymentTokenClasses, uChargeClasses;

type
  TViewPayCreditCardOneStep = class(TForm)
    GroupBox1: TGroupBox;
    btnCancelRequest: TButton;
    btnConfirmRequest: TButton;
    GroupBox3: TGroupBox;
    Label4: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    txtName: TEdit;
    txtCPF: TEdit;
    txtEmail: TEdit;
    txtPhone: TEdit;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    txtNumber: TEdit;
    txtZipCode: TEdit;
    txtNeighborhood: TEdit;
    txtState: TEdit;
    txtComplement: TEdit;
    txtCity: TEdit;
    txtStreet: TEdit;
    Label18: TLabel;
    GroupBox4: TGroupBox;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    txtCard1: TEdit;
    txtMonth: TEdit;
    txtCVV: TEdit;
    txtBrand: TEdit;
    txtCard2: TEdit;
    txtCard3: TEdit;
    txtCard4: TEdit;
    txtYear: TEdit;
    Label17: TLabel;
    txtInstallments: TEdit;
    txtBirth: TEdit;
    GroupBox6: TGroupBox;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    txtItem: TEdit;
    txtValue: TEdit;
    txtAmount: TEdit;
    procedure btnConfirmRequestClick(Sender: TObject);
    procedure btnCancelRequestClick(Sender: TObject);

    procedure ClearRequestfields;
    procedure FormCreate(Sender: TObject);
  public
    function GetBody: String;

  public
    property Body: String read GetBody;
  end;

implementation

{$R *.dfm}

{ TViewPayCharge }

procedure TViewPayCreditCardOneStep.btnCancelRequestClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TViewPayCreditCardOneStep.btnConfirmRequestClick(Sender: TObject);
begin
  if (txtItem.Text = EmptyStr) then
  begin
    MessageDlg('Necessário você preencher o item da requisição', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtItem.CanFocus then
      txtItem.SetFocus;
  end
  else if txtValue.Text = EmptyStr then
  begin
    MessageDlg('Necessário informar um valor para a cobrança', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtValue.CanFocus then
      txtValue.SetFocus;
  end
  else if txtAmount.Text = EmptyStr then
  begin
    MessageDlg('Necessário colocar um valor para Quantidade', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtAmount.CanFocus then
      txtAmount.SetFocus;
  end
  else if txtName.Text = EmptyStr then
  begin
    MessageDlg('O nome não pode ser vazio', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtName.CanFocus then
      txtName.SetFocus;
  end
  else if txtCPF.Text = EmptyStr then
  begin
    MessageDlg('O CPF não pode ser vazio', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtCPF.CanFocus then
      txtCPF.SetFocus;
  end
  else if txtEmail.Text = EmptyStr then
  begin
    MessageDlg('O email não pode ser vazio', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtEmail.CanFocus then
      txtEmail.SetFocus;
  end
  else if txtPhone.Text = EmptyStr then
  begin
    MessageDlg('O telefone não pode ser vazio', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtPhone.CanFocus then
      txtPhone.SetFocus;
  end
  else if txtBirth.Text = EmptyStr then
  begin
    MessageDlg('A data de nascimento não pode ser vazia', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtBirth.CanFocus then
      txtBirth.SetFocus;
  end
  else if txtStreet.Text = EmptyStr then
  begin
    MessageDlg('A rua não pode ser vazia', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtStreet.CanFocus then
      txtStreet.SetFocus;
  end
  else if txtNumber.Text = EmptyStr then
  begin
    MessageDlg('O numero não pode ser vazio', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtNumber.CanFocus then
      txtNumber.SetFocus;
  end
  else if txtCity.Text = EmptyStr then
  begin
    MessageDlg('A cidade não pode ser vazia', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtCity.CanFocus then
      txtCity.SetFocus;
  end
  else if txtNeighborhood.Text = EmptyStr then
  begin
    MessageDlg('O bairro não pode ser vazio', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtNeighborhood.CanFocus then
      txtNeighborhood.SetFocus;
  end
  else if txtZipCode.Text = EmptyStr then
  begin
    MessageDlg('O CEP não pode ser vazio', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtZipCode.CanFocus then
      txtZipCode.SetFocus;
  end
  else if txtState.Text = EmptyStr then
  begin
    MessageDlg('O estado não pode ser vazia', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtState.CanFocus then
      txtState.SetFocus;
  end
  else if txtBrand.Text = EmptyStr then
  begin
    MessageDlg('A bandeira do cartão não pode ser vazia', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtBrand.CanFocus then
      txtBrand.SetFocus;
  end
  else if ((txtCard1.Text = EmptyStr) or (txtCard1.Text = EmptyStr)
            or (txtCard1.Text = EmptyStr) or (txtCard1.Text = EmptyStr)) then
  begin
    MessageDlg('Os numeros referente ao cartão de crédito não podem ser vazios', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtCard1.CanFocus then
      txtCard1.SetFocus;
  end
  else if txtInstallments.Text = EmptyStr then
  begin
    MessageDlg('Quantidade de parcelas não pode ser vazia', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtInstallments.CanFocus then
      txtInstallments.SetFocus;
  end
  else if txtCVV.Text = EmptyStr then
  begin
    MessageDlg('O CVV do cartão de crédito não pode ser vazio', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtState.CanFocus then
      txtState.SetFocus;
  end
  else if ((txtMonth.Text = EmptyStr) or (txtYear.Text = EmptyStr)) then
  begin
    MessageDlg('A expiração do cartão de crédito não pode ser vazia', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtMonth.CanFocus then
      txtMonth.SetFocus;
  end
  else
    ModalResult := mrOk;
end;

procedure TViewPayCreditCardOneStep.ClearRequestfields;
begin
  txtItem.Text := '';
  txtValue.Text := '';
  txtAmount.Text := '';
  txtName.Text :=  '';
  txtCPF.Text :=  '';
  txtEmail.Text :=  '';
  txtPhone.Text :=  '';
  txtStreet.Text :=  '';
  txtNumber.Text :=  '';
  txtZipCode.Text :=  '';
  txtNeighborhood.Text :=  '';
  txtState.Text :=  '';
  txtComplement.Text :=  '';
  txtCity.Text :=  '';
end;

procedure TViewPayCreditCardOneStep.FormCreate(Sender: TObject);
begin
  Self.Position := poScreenCenter;
end;

function TViewPayCreditCardOneStep.GetBody: String;
var
  ClassChargeCreate                  : TPrivateCreditCardPayment;
  ClassChargeItem                    : TBaseCharge;
  FAddress                           : TAddress;
  strConcat                          : String;
  BodyItem,
  BodyRequest,
  BodyToken,
  BodyTokenData                      : ISuperObject;
  CreditCardData                     : TCreditCardData;
begin

  ClassChargeCreate := TPrivateCreditCardPayment.Create();
  CreditCardData    := TCreditCardData.Create();
  ClassChargeItem := TBaseCharge.Create(1);

  ClassChargeItem.Items[ 0 ].Name := txtItem.Text;
  ClassChargeItem.Items[ 0 ].Value := StrToInt(txtValue.Text);
  ClassChargeItem.Items[ 0 ].Quantity := StrToInt(txtAmount.Text);

  ClassChargeCreate.Payment.CreditCard.Customer.Name  := txtName.Text;
  ClassChargeCreate.Payment.CreditCard.Customer.CPF   := txtCPF.Text;
  ClassChargeCreate.Payment.CreditCard.Customer.Email := txtEmail.Text;
  ClassChargeCreate.Payment.CreditCard.Customer.PhoneNumber := txtPhone.Text;
  ClassChargeCreate.Payment.CreditCard.Customer.Birth := txtBirth.Text;

  CreditCardData.brand := txtBrand.Text;
  CreditCardData.number := txtCard1.Text + txtCard2.Text + txtCard3.Text + txtCard4.Text;
  CreditCardData.cvv := txtCVV.Text;
  CreditCardData.expiration_month := txtMonth.Text;
  CreditCardData.expiration_year := txtYear.Text;

  BodyToken := SO(uPaymentTokenClasses.saveCardData(MainEmissions.frmBoletos.txtIdentifier.Text, CreditCardData));
  BodyTokenData := BodyToken.O['data'];
  ClassChargeCreate.Payment.CreditCard.PaymentToken := BodyTokenData.S['payment_token'];

  FAddress.Street := txtStreet.Text;
  FAddress.Number := txtNumber.Text;
  FAddress.City   := txtCity.Text;
  FAddress.State  := txtState.Text;
  FAddress.ZipCode := txtZipCode.Text;
  FAddress.Neighborhood := txtNeighborhood.Text;
  FAddress.State := txtState.Text;
  FAddress.City  := txtCity.Text;
  FAddress.Complement := txtComplement.Text;

  ClassChargeCreate.Payment.CreditCard.BillingAddress := FAddress;
  ClassChargeCreate.Payment.CreditCard.Installments   := StrToInt(txtInstallments.Text);

  strConcat := Concat(ClassChargeItem.AsJSON(False, False), ClassChargeCreate.AsJSON(False, False));
  BodyRequest := SO(StringReplace(strConcat , '}{' , ',', []));

  Result := BodyRequest.AsJSON;
end;

end.
