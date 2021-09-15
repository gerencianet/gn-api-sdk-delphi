unit ViewPayChargeBillet;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.DateUtils,
  uCommonTypes, uPaymentClasses, XSuperJSON, XSuperObject;

type
  TViewPayChargeBillet = class(TForm)
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
    Label12: TLabel;
    txtExpire: TEdit;
    GroupBox4: TGroupBox;
    Label13: TLabel;
    Label14: TLabel;
    txtFine: TEdit;
    txtInterest: TEdit;
    GroupBox5: TGroupBox;
    txtMessage: TMemo;
    Label15: TLabel;
    txtIdent: TEdit;
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
    txtBirth: TEdit;
    procedure btnConfirmRequestClick(Sender: TObject);
    procedure btnCancelRequestClick(Sender: TObject);

    procedure ClearRequestfields;
    function GetIdent: String;
    procedure FormCreate(Sender: TObject);
  public
    property Identifier: String read GetIdent;
    function GetBody: String;

  public
    property Body: String read GetBody;
  end;


implementation

{$R *.dfm}

{ TViewPayCharge }

procedure TViewPayChargeBillet.btnCancelRequestClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TViewPayChargeBillet.btnConfirmRequestClick(Sender: TObject);
begin

  if txtIdent.Text = EmptyStr then
  begin
    MessageDlg('O identificador não pode ser vazio', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtIdent.CanFocus then
      txtIdent.SetFocus;
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
  else if txtPhone.Text = EmptyStr then
  begin
    MessageDlg('O telefone não pode ser vazio', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtPhone.CanFocus then
      txtPhone.SetFocus;
  end
  else if txtExpire.Text = EmptyStr then
  begin
    MessageDlg('A data de vencimento não pode ser vazia', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtExpire.CanFocus then
      txtExpire.SetFocus;
  end
  else
    ModalResult := mrOk;
end;

procedure TViewPayChargeBillet.ClearRequestfields;
begin
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
  txtExpire.Text :=  '';
  txtFine.Text :=  '';
  txtInterest.Text :=  '';
  txtMessage.Text :=  '';
end;

procedure TViewPayChargeBillet.FormCreate(Sender: TObject);
begin
  Self.Position := poScreenCenter;
  txtMessage.Text := '';
end;

function TViewPayChargeBillet.GetBody: String;
var
  ClassChargeCreate  : TPrivateBankBilletPayment;
  FAddress           : TAddress;
  Conf               : TConfiguration;
  BodyRequest,
  BodyPayment,
  BodyBillet,
  BodyCustomer : ISuperObject;
begin

  ClassChargeCreate := TPrivateBankBilletPayment.Create();

  ClassChargeCreate.Payment.Billet.Customer.Name  := txtName.Text;
  ClassChargeCreate.Payment.Billet.Customer.CPF   := txtCPF.Text;
  ClassChargeCreate.Payment.Billet.Customer.Email := txtEmail.Text;
  ClassChargeCreate.Payment.Billet.Customer.PhoneNumber := txtPhone.Text;

  ClassChargeCreate.Payment.Billet.Customer.Birth := txtBirth.Text;

  FAddress.Street := txtStreet.Text;
  FAddress.Number := txtNumber.Text;
  FAddress.City   := txtCity.Text;
  FAddress.State  := txtState.Text;
  FAddress.ZipCode := txtZipCode.Text;
  FAddress.Neighborhood := txtNeighborhood.Text;
  FAddress.State := txtState.Text;
  FAddress.City  := txtCity.Text;
  FAddress.Complement := txtComplement.Text;
  ClassChargeCreate.Payment.Billet.Customer.Address := FAddress;

  if (txtFine.Text <> EmptyStr) then
    Conf.Fine := StrToInt(txtFine.Text);

  if (txtInterest.Text <> EmptyStr) then
    Conf.Interest := StrToInt(txtInterest.Text);

  ClassChargeCreate.Payment.Billet.Configurations := Conf;

  ClassChargeCreate.Payment.Billet.ExpireAt := FormatDateTime( 'yyyy-mm-dd', Today + 10 );
  ClassChargeCreate.Payment.Billet.Message := txtMessage.Text;

  BodyRequest := SO(ClassChargeCreate.AsJSON(False, False));

  BodyPayment := BodyRequest.O['payment'];

  BodyBillet  := BodyPayment.O['banking_billet'];
  if ClassChargeCreate.Payment.Billet.Message = EmptyStr then
  begin
    BodyBillet.Remove('message');
    BodyPayment.SetData('banking_billet', BodyBillet);
  end;

  if (ClassChargeCreate.Payment.Billet.Configurations.Fine <= 0) or
      (ClassChargeCreate.Payment.Billet.Configurations.Interest <= 0)   then
  begin
    BodyBillet.Remove('configurations');
    BodyPayment.SetData('banking_billet', BodyBillet);
  end;

  BodyCustomer := BodyBillet.O['customer'];
  if ClassChargeCreate.Payment.Billet.Customer.Address.Street = EmptyStr then
  begin
    BodyCustomer.Remove('address');
    BodyPayment.SetData('customer', BodyCustomer);
  end;

  if ClassChargeCreate.Payment.Billet.Customer.Birth = EmptyStr then
  begin
    BodyCustomer.Remove('birth');
    BodyPayment.SetData('customer', BodyCustomer);
  end;

  if ClassChargeCreate.Payment.Billet.Customer.Email = EmptyStr then
  begin
    BodyCustomer.Remove('email');
    BodyPayment.SetData('customer', BodyCustomer);
  end;

  Result := BodyRequest.AsJSON;
end;

function TViewPayChargeBillet.GetIdent: String;
begin
  Result := txtIdent.Text;
end;

end.
