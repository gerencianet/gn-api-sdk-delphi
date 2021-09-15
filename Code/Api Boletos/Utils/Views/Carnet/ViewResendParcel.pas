unit ViewResendParcel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.UITypes,
  Vcl.ComCtrls;

type
  TViewResendParcel = class(TForm)
    GroupBox3: TGroupBox;
    Label1: TLabel;
    txtIdent: TEdit;
    btnCancelRequest: TButton;
    btnConfirmRequest: TButton;
    txtEmail: TEdit;
    Label2: TLabel;
    txtParcel: TEdit;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmRequestClick(Sender: TObject);
    procedure btnCancelRequestClick(Sender: TObject);
  private
    function GetIdent: String;
    function GetParcel: String;
    function GetBody: String;
  public
    property Identifier: String read GetIdent;
    procedure ClearRequestfields;
    property Body: String read GetBody;
    property Parcel: String read GetParcel;
  end;

implementation

{$R *.dfm}

procedure TViewResendParcel.btnCancelRequestClick(Sender: TObject);
begin
  ModalResult := mrCancel
end;

procedure TViewResendParcel.btnConfirmRequestClick(Sender: TObject);
begin

  if txtIdent.Text = EmptyStr then
  begin
    MessageDlg('O identificador não pode ser vazia!', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtIdent.CanFocus then
      txtIdent.SetFocus;
  end
  else if txtParcel.Text = EmptyStr then
  begin
    MessageDlg('O campo Parcela não pode ser vazio', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtParcel.CanFocus then
      txtParcel.SetFocus;
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

procedure TViewResendParcel.ClearRequestfields;
begin
  txtIdent.Text := '';
  txtParcel.Text := '';
  txtEmail.Text := '';
end;

procedure TViewResendParcel.FormCreate(Sender: TObject);
begin
  Self.Position := poScreenCenter;
end;

function TViewResendParcel.GetBody: String;
begin
  Result := '{ "email": "'+ txtEmail.Text + '" }';
end;

function TViewResendParcel.GetIdent: String;
begin
  Result := txtIdent.Text;
end;

function TViewResendParcel.GetParcel: String;
begin
  Result := txtParcel.Text;
end;

end.
