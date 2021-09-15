unit ViewUpdatePlan;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.UITypes,
  Vcl.ComCtrls;

type
  TViewUpdatePlan = class(TForm)
    GroupBox3: TGroupBox;
    Label1: TLabel;
    txtIdent: TEdit;
    btnCancelRequest: TButton;
    btnConfirmRequest: TButton;
    txtName: TEdit;
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

procedure TViewUpdatePlan.btnCancelRequestClick(Sender: TObject);
begin
  ModalResult := mrCancel
end;

procedure TViewUpdatePlan.btnConfirmRequestClick(Sender: TObject);
begin

  if txtIdent.Text = EmptyStr then
  begin
    MessageDlg('O identificador não pode ser vazia!', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtIdent.CanFocus then
      txtIdent.SetFocus;
  end
  else if txtName.Text = EmptyStr then
  begin
    MessageDlg('O campo de nome não pode ser vazio!', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtName.CanFocus then
      txtName.SetFocus;
  end
  else
    ModalResult := mrOk;
end;

procedure TViewUpdatePlan.ClearRequestfields;
begin
  txtIdent.Text := '';
  txtName.Text := '';
end;

procedure TViewUpdatePlan.FormCreate(Sender: TObject);
begin
  Self.Position := poScreenCenter;
end;

function TViewUpdatePlan.GetBody: String;
begin
  Result := '{ "name": '+ QuotedStr(txtName.Text) + ' }';
end;

function TViewUpdatePlan.GetIdent: String;
begin
  Result := txtIdent.Text;
end;


end.
