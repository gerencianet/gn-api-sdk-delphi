unit ViewResendBillet;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.UITypes,
  Vcl.ComCtrls;

type
  TViewResendBillet = class(TForm)
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

procedure TViewResendBillet.btnCancelRequestClick(Sender: TObject);
begin
  ModalResult := mrCancel
end;

procedure TViewResendBillet.btnConfirmRequestClick(Sender: TObject);
begin

  if txtIdent.Text = EmptyStr then
  begin
    MessageDlg('O identificador n�o pode ser vazia!', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtIdent.CanFocus then
      txtIdent.SetFocus;
  end
  else if txtEmail.Text = EmptyStr then
  begin
    MessageDlg('O campo de Email n�o pode ser vazio!', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtEmail.CanFocus then
      txtEmail.SetFocus;
  end
  else
    ModalResult := mrOk;
end;

procedure TViewResendBillet.ClearRequestfields;
begin
  txtIdent.Text := '';
end;

procedure TViewResendBillet.FormCreate(Sender: TObject);
begin
  Self.Position := poScreenCenter;
end;

function TViewResendBillet.GetBody: String;
begin
  Result := '{ "email": "'+ txtEmail.Text + '" }';
end;

function TViewResendBillet.GetIdent: String;
begin
  Result := txtIdent.Text;
end;


end.
