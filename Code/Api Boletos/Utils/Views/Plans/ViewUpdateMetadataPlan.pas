unit ViewUpdateMetadataPlan;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.UITypes,
  Vcl.ComCtrls;

type
  TViewUpdateMetadataPlan = class(TForm)
    GroupBox3: TGroupBox;
    Label1: TLabel;
    txtIdent: TEdit;
    btnCancelRequest: TButton;
    btnConfirmRequest: TButton;
    Label2: TLabel;
    txtNotification: TEdit;
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

procedure TViewUpdateMetadataPlan.btnCancelRequestClick(Sender: TObject);
begin
  ModalResult := mrCancel
end;

procedure TViewUpdateMetadataPlan.btnConfirmRequestClick(Sender: TObject);
begin

  if txtIdent.Text = EmptyStr then
  begin
    MessageDlg('O identificador não pode ser vazia!', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtIdent.CanFocus then
      txtIdent.SetFocus;
  end
  else if txtnotification.Text = EmptyStr then
  begin
    MessageDlg('O campo de notificação não pode ser vazio!', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtNotification.CanFocus then
      txtNotification.SetFocus;
  end
  else
    ModalResult := mrOk;
end;

procedure TViewUpdateMetadataPlan.ClearRequestfields;
begin
  txtIdent.Text := '';
  txtNotification.Text := '';
end;

procedure TViewUpdateMetadataPlan.FormCreate(Sender: TObject);
begin
  Self.Position := poScreenCenter;
end;

function TViewUpdateMetadataPlan.GetBody: String;
begin
  Result := '{ "notification_url": "'+ txtNotification.Text + '",' +
            '  "custom_id": "SDK_Delphi" }';
end;

function TViewUpdateMetadataPlan.GetIdent: String;
begin
  Result := txtIdent.Text;
end;


end.
