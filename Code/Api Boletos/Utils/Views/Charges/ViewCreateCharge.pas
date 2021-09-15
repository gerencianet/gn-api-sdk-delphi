unit ViewCreateCharge;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.UITypes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uChargeClasses, XSuperJSON, XSuperObject, System.JSON;

type
  TViewCreateCharge = class(TForm)
    gbDevedor: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    txtName: TEdit;
    txtAmount: TEdit;
    Label5: TLabel;
    txtValue: TEdit;
    btnCancelRequest: TButton;
    btnConfirmRequest: TButton;
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

procedure TViewCreateCharge.btnCancelRequestClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TViewCreateCharge.btnConfirmRequestClick(Sender: TObject);
begin

  if (txtName.Text = EmptyStr) then
  begin
    MessageDlg('Necessário você preencher o nome da requisição', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
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
    MessageDlg('Necessário colocar um valor para Quantidade', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtAmount.CanFocus then
      txtAmount.SetFocus;
  end
  else
    ModalResult := mrOk;

end;

procedure TViewCreateCharge.FormCreate(Sender: TObject);
begin
  Self.Position := poScreenCenter;
end;


function TViewCreateCharge.GetBody: String;
var
  ClassChargeCreate  : TBaseCharge;
begin

  ClassChargeCreate := TBaseCharge.Create(1);
  ClassChargeCreate.Items[ 0 ].Name := txtName.Text;
  ClassChargeCreate.Items[ 0 ].Value := StrToInt(txtValue.Text);
  ClassChargeCreate.Items[ 0 ].Quantity := StrToInt(txtAmount.Text);

  Result := ClassChargeCreate.AsJSON;
end;

procedure TViewCreateCharge.ClearRequestfields;
begin
  txtName.Text := '';
  txtValue.Text := '';
  txtAmount.Text := '';
end;

end.
