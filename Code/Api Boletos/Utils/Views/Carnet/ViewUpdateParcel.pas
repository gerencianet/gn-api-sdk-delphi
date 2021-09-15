unit ViewUpdateParcel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, BodyPixClass, System.UITypes;

type
  TViewUpdateParcel = class(TForm)
    GroupBox3: TGroupBox;
    txtId: TEdit;
    Parcela: TLabel;
    Label2: TLabel;
    btnConfirmRequest: TButton;
    btnCancelRequest: TButton;
    txtParcel: TEdit;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    txtValue: TEdit;
    procedure btnConfirmRequestClick(Sender: TObject);
    procedure btnCancelRequestClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    function GetParcel: String;
    function GetId: String;
    function GetBody: String;
  public
    property parcel: String read GetParcel;
    property id:    String read GetId;
    property Body: String read GetBody;
    procedure ClearRequestfields;
  end;

implementation

{$R *.dfm}

procedure TViewUpdateParcel.btnCancelRequestClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TViewUpdateParcel.btnConfirmRequestClick(Sender: TObject);
begin

  if txtId.Text = EmptyStr then
  begin
    MessageDlg('O campo Id não pode ser vazio', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtId.CanFocus then
      txtId.SetFocus;
  end
  else if txtParcel.Text = EmptyStr then
  begin
    MessageDlg('O campo Parcela não pode ser vazio', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtParcel.CanFocus then
      txtParcel.SetFocus;
  end
  else if txtValue.Text = EmptyStr then
  begin
    MessageDlg('O campo de valor não pode ser vazio', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtValue.CanFocus then
      txtValue.SetFocus;
  end
  else
    ModalResult := mrOk;
end;

procedure TViewUpdateParcel.FormCreate(Sender: TObject);
begin
  Self.Position := poScreenCenter;
end;

function TViewUpdateParcel.GetBody: String;
var
  BodyRequest : TBodyPixDevolution;
begin
  BodyRequest := TBodyPixDevolution.Create;

  BodyRequest.Value := txtValue.Text;

  Result := BodyRequest.AsJSON;
end;

function TViewUpdateParcel.GetId: String;
begin
  Result := txtId.Text;
end;

function TViewUpdateParcel.GetParcel: String;
begin
  Result := txtParcel.Text;
end;

procedure TViewUpdateParcel.ClearRequestfields;
begin
  txtParcel.Text := '';
  txtId.Text := '';
  txtValue.Text := '';
end;

end.
