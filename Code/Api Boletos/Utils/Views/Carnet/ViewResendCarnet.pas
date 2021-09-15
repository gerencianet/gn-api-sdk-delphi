unit ViewResendCarnet;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.UITypes,
  Vcl.ComCtrls;

type
  TViewResendCarnet = class(TForm)
    GroupBox3: TGroupBox;
    Label1: TLabel;
    txtIdent: TEdit;
    btnCancelRequest: TButton;
    btnConfirmRequest: TButton;
    txtEmail: TEdit;
    Label2: TLabel;
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

procedure TViewResendCarnet.btnCancelRequestClick(Sender: TObject);
begin
  ModalResult := mrCancel
end;

procedure TViewResendCarnet.btnConfirmRequestClick(Sender: TObject);
begin

  if txtIdent.Text = EmptyStr then
  begin
    MessageDlg('O identificador não pode ser vazia!', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtIdent.CanFocus then
      txtIdent.SetFocus;
  end
  else if txtEmail.Text = EmptyStr then
  begin
    MessageDlg('O campo de Email não pode ser vazio!', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtEmail.CanFocus then
      txtEmail.SetFocus;
  end
  else
    ModalResult := mrOk;
end;

procedure TViewResendCarnet.ClearRequestfields;
begin
  txtIdent.Text := '';
  txtEmail.Text := '';
end;

procedure TViewResendCarnet.FormCreate(Sender: TObject);
begin
  Self.Position := poScreenCenter;
end;

function TViewResendCarnet.GetBody: String;
begin
  Result := '{ "email": "'+ txtEmail.Text + '" }';
end;

function TViewResendCarnet.GetIdent: String;
begin
  Result := txtIdent.Text;
end;

end.
