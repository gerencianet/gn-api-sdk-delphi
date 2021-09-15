unit ViewGetPlan;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.UITypes,
  Vcl.StdCtrls, uChargeClasses, XSuperJSON, XSuperObject, System.JSON;

type
  TViewGetPlan = class(TForm)
    gbDevedor: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    txtName: TEdit;
    txtOffset: TEdit;
    Label5: TLabel;
    txtLimit: TEdit;
    btnCancelRequest: TButton;
    btnConfirmRequest: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnCancelRequestClick(Sender: TObject);
    procedure btnConfirmRequestClick(Sender: TObject);
  private
    function GetName: String;
    function GetLimit: String;
    function GetOffset: String;
  public
    property NameIdentifier: String read GetName;
    property Limit: String read GetLimit;
    property Offset: String read GetOffset;
    procedure ClearRequestfields;
  end;

implementation

{$R *.dfm}

procedure TViewGetPlan.btnCancelRequestClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TViewGetPlan.btnConfirmRequestClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TViewGetPlan.FormCreate(Sender: TObject);
begin
  Self.Position := poScreenCenter;
end;

function TViewGetPlan.GetLimit: String;
begin
  Result := txtLimit.Text;
end;

function TViewGetPlan.GetName: String;
begin
  Result := txtName.Text;
end;

function TViewGetPlan.GetOffset: String;
begin
  Result := txtOffset.Text;
end;

procedure TViewGetPlan.ClearRequestfields;
begin
  txtName.Text := '';
  txtOffset.Text := '';
  txtLimit.Text := '';
end;

end.
