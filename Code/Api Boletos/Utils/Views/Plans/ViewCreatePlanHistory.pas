unit ViewCreatePlanHistory;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.UITypes,
  Vcl.ComCtrls;

type
  TViewCreatePlanHistory = class(TForm)
    GroupBox3: TGroupBox;
    Label1: TLabel;
    txtIdent: TEdit;
    btnCancelRequest: TButton;
    btnConfirmRequest: TButton;
    gbDevedor: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    Label2: TLabel;
    txtDescription: TEdit;
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

procedure TViewCreatePlanHistory.btnCancelRequestClick(Sender: TObject);
begin
  ModalResult := mrCancel
end;

procedure TViewCreatePlanHistory.btnConfirmRequestClick(Sender: TObject);
begin

  if txtIdent.Text = EmptyStr then
  begin
    MessageDlg('O campo identificador n�o pode ser vazio!', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtIdent.CanFocus then
      txtIdent.SetFocus;
  end
  else if txtDescription.Text = EmptyStr then
  begin
    MessageDlg('O campo de Descri��o n�o pode ser vazio!', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtDescription.CanFocus then
      txtDescription.SetFocus;
  end
  else
    ModalResult := mrOk;
end;

procedure TViewCreatePlanHistory.ClearRequestfields;
begin
  txtIdent.Text := '';
  txtDescription.Text := '';
end;

procedure TViewCreatePlanHistory.FormCreate(Sender: TObject);
begin
  Self.Position := poScreenCenter;
end;

function TViewCreatePlanHistory.GetBody: String;
begin
  Result := '{ "description": "'+ txtDescription.Text + '" }';
end;

function TViewCreatePlanHistory.GetIdent: String;
begin
  Result := txtIdent.Text;
end;


end.
