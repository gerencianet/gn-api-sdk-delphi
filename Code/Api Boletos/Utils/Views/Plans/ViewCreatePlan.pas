unit ViewCreatePlan;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.UITypes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uChargeClasses, XSuperJSON, XSuperObject, System.JSON;

type
  TViewCreatePlan = class(TForm)
    gbDevedor: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    txtName: TEdit;
    txtRepeats: TEdit;
    Label5: TLabel;
    txtInterval: TEdit;
    btnCancelRequest: TButton;
    btnConfirmRequest: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnCancelRequestClick(Sender: TObject);
    procedure btnConfirmRequestClick(Sender: TObject);
  private
    function GetBody : String;
  public
    property Body: String read GetBody;
    procedure ClearRequestfields;
  end;

implementation

{$R *.dfm}

procedure TViewCreatePlan.btnCancelRequestClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TViewCreatePlan.btnConfirmRequestClick(Sender: TObject);
begin

  if (txtName.Text = EmptyStr) then
  begin
    MessageDlg('Necessário você preencher o nome da requisição', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtName.CanFocus then
      txtName.SetFocus;
  end
  else if txtInterval.Text = EmptyStr then
  begin
    MessageDlg('Necessário informar um intervalo para a cobrança', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtInterval.CanFocus then
      txtInterval.SetFocus;
  end
  else if txtRepeats.Text = EmptyStr then
  begin
    MessageDlg('Necessário colocar uma repetição inteiro para Amount', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    if txtRepeats.CanFocus then
      txtRepeats.SetFocus;
  end
  else
    ModalResult := mrOk;

end;

procedure TViewCreatePlan.FormCreate(Sender: TObject);
begin
  Self.Position := poScreenCenter;
end;


function TViewCreatePlan.GetBody: String;
var
  ClassPlanCreate  : TPlan;
begin

  ClassPlanCreate := TPlan.Create();
  ClassPlanCreate.Name := txtName.Text;
  ClassPlanCreate.Interval := StrToInt(txtInterval.Text);
  ClassPlanCreate.Repeats := StrToInt(txtRepeats.Text);

  Result := ClassPlanCreate.AsJSON;
end;

procedure TViewCreatePlan.ClearRequestfields;
begin
  txtName.Text := '';
  txtInterval.Text := '';
  txtRepeats.Text := '';
end;

end.
