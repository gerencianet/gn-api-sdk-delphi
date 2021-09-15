unit ViewCreateCarnet;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uChargeClasses, XSuperJSON, XSuperObject, System.JSON,
  uCarnetClasses, uPaymentClasses, System.UITypes, uCommonTypes;

type
  TViewCreateCarnet = class(TForm)
    gbDevedor: TGroupBox;
    btnCancelRequest: TButton;
    btnConfirmRequest: TButton;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    txtNameCli: TEdit;
    txtCPF: TEdit;
    txtEmail: TEdit;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label5: TLabel;
    Label3: TLabel;
    txtAmount: TEdit;
    txtValue: TEdit;
    txtName: TEdit;
    Label12: TLabel;
    txtExpire: TEdit;
    GroupBox4: TGroupBox;
    txtFine: TEdit;
    txtInterest: TEdit;
    GroupBox5: TGroupBox;
    txtMessage: TMemo;
    Label4: TLabel;
    txtRepeats: TEdit;
    txtSplitItems: TCheckBox;
    Label8: TLabel;
    txtPhone: TEdit;
    Label18: TLabel;
    txtBirth: TEdit;
    GroupBox2: TGroupBox;
    Label9: TLabel;
    txtNumber: TEdit;
    txtZipCode: TEdit;
    txtNeighborhood: TEdit;
    txtState: TEdit;
    txtComplement: TEdit;
    txtCity: TEdit;
    txtStreet: TEdit;
    Label13: TLabel;
    Label14: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnCancelRequestClick(Sender: TObject);
    procedure btnConfirmRequestClick(Sender: TObject);
  private
    function GetBody : String;
  public
    property Body: String read GetBody;
    procedure ClearRequestfields;
  end;

implementation

{$R *.dfm}

procedure TViewCreateCarnet.btnCancelRequestClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TViewCreateCarnet.btnConfirmRequestClick(Sender: TObject);
begin

  if (txtName.Text = EmptyStr) then
  begin
    MessageDlg('Necessário você preencher o nome para o carnê', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtName.CanFocus then
      txtName.SetFocus;
  end
  else if txtValue.Text = EmptyStr then
  begin
    MessageDlg('Necessário informar um valor para a cobrança', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtValue.CanFocus then
      txtValue.SetFocus;
  end
  else if txtAmount.Text = EmptyStr then
  begin
    MessageDlg('Necessário colocar um valor inteiro para a quantidade', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtAmount.CanFocus then
      txtAmount.SetFocus;
  end
  else if txtNameCli.Text = EmptyStr then
  begin
    MessageDlg('O nome não pode ser vazio', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtNameCli.CanFocus then
      txtNameCli.SetFocus;
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
  else if txtRepeats.Text = EmptyStr then
  begin
    MessageDlg('As parcelas não podem ser vazia', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtRepeats.CanFocus then
      txtRepeats.SetFocus;
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

procedure TViewCreateCarnet.FormCreate(Sender: TObject);
begin
  Self.Position := poScreenCenter;
  txtMessage.Text := '';
end;


function TViewCreateCarnet.GetBody: String;
var
  BodyRequest,
  BodyCustomer       : ISuperObject;
  ClassChargeCreate  : TPrivateCarnet;
  FAddress           : TAddress;
  Conf               : TConfiguration;
begin

  ClassChargeCreate := TPrivateCarnet.Create(1);
  ClassChargeCreate.Items[ 0 ].Name := txtName.Text;
  ClassChargeCreate.Items[ 0 ].Value := StrToInt(txtValue.Text);
  ClassChargeCreate.Items[ 0 ].Quantity := StrToInt(txtAmount.Text);

  ClassChargeCreate.Customer.Name  := txtNameCli.Text;
  ClassChargeCreate.Customer.CPF   := txtCPF.Text;
  ClassChargeCreate.Customer.Email := txtEmail.Text;
  ClassChargeCreate.Customer.PhoneNumber := txtPhone.Text;
  ClassChargeCreate.Customer.Birth := txtBirth.Text;

  FAddress.Street := txtStreet.Text;
  FAddress.Number := txtNumber.Text;
  FAddress.City   := txtCity.Text;
  FAddress.State  := txtState.Text;
  FAddress.ZipCode := txtZipCode.Text;
  FAddress.Neighborhood := txtNeighborhood.Text;
  FAddress.State := txtState.Text;
  FAddress.City  := txtCity.Text;
  FAddress.Complement := txtComplement.Text;
  ClassChargeCreate.Customer.Address := FAddress;

  ClassChargeCreate.ExpireAt := txtExpire.Text;

  if (txtFine.Text <> EmptyStr) then
    Conf.Fine := StrToInt(txtFine.Text);

  if (txtInterest.Text <> EmptyStr) then
    Conf.Interest := StrToInt(txtInterest.Text);

  ClassChargeCreate.Configurations := Conf;

  ClassChargeCreate.Message := txtMessage.Text;
  ClassChargeCreate.Repeats := StrToInt(txtRepeats.Text);
  ClassChargeCreate.SplitItems := txtSplitItems.Checked;

  BodyRequest := SO(ClassChargeCreate.AsJSON(False, False));

  if ClassChargeCreate.Message = EmptyStr then
    BodyRequest.Remove('message');

  if (ClassChargeCreate.Configurations.Fine <= 0) or
      (ClassChargeCreate.Configurations.Interest <= 0) then
    BodyRequest.Remove('configurations');

  BodyCustomer := BodyRequest.O['customer'];

  if ClassChargeCreate.Customer.Address.Street = EmptyStr then
  begin
    BodyCustomer.Remove('address');
    BodyRequest.SetData('customer', BodyCustomer);
  end;

  if ClassChargeCreate.Customer.Birth = EmptyStr then
  begin
    BodyCustomer.Remove('birth');
    BodyRequest.SetData('customer', BodyCustomer);
  end;

  if ClassChargeCreate.Customer.Email = EmptyStr then
  begin
    BodyCustomer.Remove('email');
    BodyRequest.SetData('customer', BodyCustomer);
  end;

  Result := BodyRequest.AsJSON;
end;

procedure TViewCreateCarnet.ClearRequestfields;
begin
  txtName.Text := '';
  txtValue.Text := '';
  txtAmount.Text := '';
  txtNameCli.Text :=  '';
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

end.
