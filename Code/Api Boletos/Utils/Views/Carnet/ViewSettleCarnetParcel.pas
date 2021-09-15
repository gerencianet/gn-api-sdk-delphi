unit ViewSettleCarnetParcel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.UITypes,
  Vcl.ComCtrls;

type
  TViewSettleCarnetParcel = class(TForm)
    GroupBox3: TGroupBox;
    Label1: TLabel;
    txtIdent: TEdit;
    btnCancelRequest: TButton;
    btnConfirmRequest: TButton;
    txtParcel: TEdit;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmRequestClick(Sender: TObject);
    procedure btnCancelRequestClick(Sender: TObject);
  private
    function GetIdent: String;
    function GetParcel: String;
  public
    property Identifier: String read GetIdent;
    procedure ClearRequestfields;
    property Parcel: String read GetParcel;
  end;

implementation

{$R *.dfm}

procedure TViewSettleCarnetParcel.btnCancelRequestClick(Sender: TObject);
begin
  ModalResult := mrCancel
end;

procedure TViewSettleCarnetParcel.btnConfirmRequestClick(Sender: TObject);
begin

  if txtIdent.Text = EmptyStr then
  begin
    MessageDlg('O identificador não pode ser vazia!', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtIdent.CanFocus then
      txtIdent.SetFocus;
  end
  else if txtParcel.Text = EmptyStr then
  begin
    MessageDlg('O campo de parcela não pode ser vazio!', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtParcel.CanFocus then
      txtParcel.SetFocus;
  end
  else
    ModalResult := mrOk;
end;

procedure TViewSettleCarnetParcel.ClearRequestfields;
begin
  txtIdent.Text := '';
  txtParcel.Text := '';
end;

procedure TViewSettleCarnetParcel.FormCreate(Sender: TObject);
begin
  Self.Position := poScreenCenter;
end;


function TViewSettleCarnetParcel.GetIdent: String;
begin
  Result := txtIdent.Text;
end;


function TViewSettleCarnetParcel.GetParcel: String;
begin
  Result := txtParcel.Text;
end;

end.
