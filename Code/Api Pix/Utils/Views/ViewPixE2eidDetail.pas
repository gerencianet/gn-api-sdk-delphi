unit ViewPixE2eidDetail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.UITypes;

type
  TViewPixE2eidDetail = class(TForm)
    GroupBox3: TGroupBox;
    Label1: TLabel;
    txtIdent: TEdit;
    btnCancelRequest: TButton;
    btnConfirmRequest: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmRequestClick(Sender: TObject);
    procedure btnCancelRequestClick(Sender: TObject);
  private
    function GetIdent: String;
  public
    property Identifier: String read GetIdent;
    procedure ClearRequestfields;
  end;

implementation

{$R *.dfm}

procedure TViewPixE2eidDetail.btnCancelRequestClick(Sender: TObject);
begin
  ModalResult := mrCancel
end;

procedure TViewPixE2eidDetail.btnConfirmRequestClick(Sender: TObject);
begin

  if txtIdent.Text = EmptyStr then
  begin
    MessageDlg('O identificador não pode ser vazia!', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtIdent.CanFocus then
      txtIdent.SetFocus;
  end
  else
    ModalResult := mrOk;
end;

procedure TViewPixE2eidDetail.ClearRequestfields;
begin
  txtIdent.Text := '';
end;

procedure TViewPixE2eidDetail.FormCreate(Sender: TObject);
begin
  Self.Position := poScreenCenter;
end;

function TViewPixE2eidDetail.GetIdent: String;
begin
  Result := txtIdent.Text;
end;


end.
