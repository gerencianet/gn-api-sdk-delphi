unit ViewCreateSubscription;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.UITypes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uChargeClasses, XSuperJSON, XSuperObject, System.JSON;

type
  TViewCreateSubscription = class(TForm)
    gbDevedor: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    txtName: TEdit;
    txtAmount: TEdit;
    Label5: TLabel;
    txtValue: TEdit;
    btnCancelRequest: TButton;
    btnConfirmRequest: TButton;
    Label1: TLabel;
    txtIdent: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnCancelRequestClick(Sender: TObject);
    procedure btnConfirmRequestClick(Sender: TObject);
  private
    function GetIdent: String;
    function GetBody : String;
  public
    property Identifier: String read GetIdent;
    property Body: String read GetBody;
    procedure ClearRequestfields;
  end;

implementation

{$R *.dfm}

procedure TViewCreateSubscription.btnCancelRequestClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TViewCreateSubscription.btnConfirmRequestClick(Sender: TObject);
begin

  if (txtIdent.Text = EmptyStr) then
  begin
    MessageDlg('Necessário você preencher o identificador da requisição', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtIdent.CanFocus then
      txtIdent.SetFocus;
  end
  else if (txtName.Text = EmptyStr) then
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
    MessageDlg('Necessário colocar um valor inteiro para Quantia', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtAmount.CanFocus then
      txtAmount.SetFocus;
  end
  else
    ModalResult := mrOk;

end;

procedure TViewCreateSubscription.FormCreate(Sender: TObject);
begin
  Self.Position := poScreenCenter;
end;


function TViewCreateSubscription.GetBody: String;
var
  ClassChargeCreate  : TBaseCharge;
begin

  ClassChargeCreate := TBaseCharge.Create(1);
  ClassChargeCreate.Items[ 0 ].Name := txtName.Text;
  ClassChargeCreate.Items[ 0 ].Value := StrToInt(txtValue.Text);
  ClassChargeCreate.Items[ 0 ].Quantity := StrToInt(txtAmount.Text);

  Result := ClassChargeCreate.AsJSON;
end;

function TViewCreateSubscription.GetIdent: String;
begin
  Result := txtIdent.Text;
end;

procedure TViewCreateSubscription.ClearRequestfields;
begin
  txtIdent.Text := '';
  txtName.Text := '';
  txtValue.Text := '';
  txtAmount.Text := '';
end;

end.
