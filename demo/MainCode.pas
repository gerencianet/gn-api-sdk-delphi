unit MainCode;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Contnrs, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls,
  IdBaseComponent, IdIntercept {$IFDEF UNICODE}, IdInterceptSimLog {$ENDIF}, uCommonTypes, ComCtrls;

type
  TForm2 = class(TForm)
  end;
  TMainFrm = class(TForm)
    GroupBox1: TGroupBox;
    txtClientID: TLabeledEdit;
    txtClientSecret: TLabeledEdit;
    ConnectBtn: TButton;
    PaymentBtn: TButton;
    txtId: TEdit;
    Label1: TLabel;
    txtCarnetParcel: TEdit;
    Label2: TLabel;
    Actions: TComboBox;
    Label3: TLabel;
    ActionBtn: TButton;
    Label5: TLabel;
    Memo2: TMemo;
    Label6: TLabel;
    txtToken: TEdit;
    txtStreet: TEdit;
    txtNumber: TEdit;
    txtCity: TEdit;
    txtState: TEdit;
    txtZipCode: TEdit;
    txtNeighborhood: TEdit;
    Label4: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    txtName: TEdit;
    Label12: TLabel;
    txtCPF: TEdit;
    Label13: TLabel;
    txtEmail: TEdit;
    Label14: TLabel;
    txtPhonenumber: TEdit;
    Label15: TLabel;
    Panel1: TPanel;
    Label17: TLabel;
    Label16: TLabel;
    Panel2: TPanel;
    Label18: TLabel;
    Panel3: TPanel;
    Label19: TLabel;
    CheckBoxSandbox: TCheckBox;
    CheckBoxProxy: TCheckBox;
    txtProxyServer: TLabeledEdit;
    txtProxyPort: TLabeledEdit;
    txtProxyUserName: TLabeledEdit;
    txtProxyPassword: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure ConnectBtnClick(Sender: TObject);
    procedure PaymentBtnClick(Sender: TObject);
    procedure ActionsChange(Sender: TObject);
    procedure ActionBtnClick(Sender: TObject);
    procedure EnableAll;
    procedure EnableProxy;
    procedure DisableProxy;
    procedure CheckBoxProxyClick(Sender: TObject);
  private
    FChargeID: String;
    {$IFDEF UNICODE}
    FAddress: TAddress;
    {$ENDIF}
    function GetClientID: String;
    function GetClientSecret: String;
    function getEnviroment: String;
    function GetID: String;
    function GetCarnetParcel: String;
    function GetProxyServer: String;
    function GetProxyPort: Integer;
    function GetProxyUsername: String;
    function GetProxyPassword: String;
    procedure DisplayServerResponse(Response: String);
  protected
    function GetJSONValue( JSONText, ID: String ) : String;
  public
    property ClientID: String read GetClientID;
    property ClientSecret: String read GetClientSecret;
    property Enviroment : String read getEnviroment;
    property Id: String read GetId;
    property CarnetParcel: String read GetCarnetParcel;
    property ProxyServer: String read GetProxyServer;
    property ProxyPort: Integer read GetProxyPort;
    property ProxyUsername: String read GetProxyUsername;
    property ProxyPassword: String read GetProxyPassword;
  end;

var
  MainFrm: TMainFrm;

implementation

uses uGerenciaClient, uChargeClasses,  {$IFDEF UNICODE}XSuperObject,{$ENDIF}
     uPaymentClasses, DateUtils, uCarnetEndpoints, uChargeEndpoints, uSubscriptionEndpoints, uGerenciaNetClientUtilities,
     uExtraEndepoints;

{$R *.dfm}

{ TForm1 }
procedure TMainFrm.DisplayServerResponse(Response: String);
begin
   Memo2.Lines.Text := Response;
end;

procedure TMainFrm.ActionBtnClick(Sender: TObject);
var Option : Integer;
begin
  Option := Integer(Actions.ItemIndex);
  case Option of
    0  : DisplayServerResponse(CarnetCreate);
    1  : DisplayServerResponse(DetailCarnet(Id));
    2  : DisplayServerResponse(UpdateParcel(Id, CarnetParcel));
    3  : DisplayServerResponse(UpdateCarnetMetadata(Id));
    4  : DisplayServerResponse(ResendCarnet(Id));
    5  : DisplayServerResponse(ResendParcel(Id, CarnetParcel));
    6  : DisplayServerResponse(CreateCarnetHistory(Id));
    7  : DisplayServerResponse(CancelCarnet(Id));
    8  : DisplayServerResponse(CancelParcel(Id, CarnetParcel));
    9  : DisplayServerResponse(CreateCharge);
    10 : DisplayServerResponse(DetailCharge(Id));
    11 : DisplayServerResponse(PayChargeWithBillet(Id));
    12 : DisplayServerResponse(PayChargeWithCard(Id, txtToken.Text));
    13 : DisplayServerResponse(CancelCharge(Id));
    14 : DisplayServerResponse(CreateChargeHistory(Id));
    15 : DisplayServerResponse(LinkCharge(Id));
    16 : DisplayServerResponse(ResendBillet(Id));
    17 : DisplayServerResponse(UpdateBillet(Id));
    18 : DisplayServerResponse(UpdateChargeMetadata(Id));
    19 : DisplayServerResponse(CreatePlan);
    20 : DisplayServerResponse(CreateSubscription(Id));
    21 : DisplayServerResponse(DetailSubscription(Id));
    22 : DisplayServerResponse(GetPlans);
    23 : DisplayServerResponse(PaySubscription(Id));
    24 : DisplayServerResponse(UpdateSubscription(Id));
    25 : DisplayServerResponse(CancelSubscription(Id));
    26 : DisplayServerResponse(DeletePlan(Id));
    27 : DisplayServerResponse(UpdatePlan(Id));
    28 : DisplayServerResponse(CreateSubscriptionHistory(Id));
    29 : DisplayServerResponse(GetInstallments);
    30 : DisplayServerResponse(CreateChargeBalanceSheet(Id));
    31 : DisplayServerResponse(SettleCharge(Id));
    32 : DisplayServerResponse(settleCarnetParcel(Id, CarnetParcel));
  end;
end;

procedure TMainFrm.ActionsChange(Sender: TObject);
var Option : Integer;
begin
  Option := Integer(Actions.ItemIndex);
  case Option of
    0,9,19,22,29 : begin
      txtId.Enabled:= False;
      txtCarnetParcel.Enabled := False;
      txtToken.Enabled := False
    end;
    2,5,8,32 : begin
      txtId.Enabled:= True;
      txtCarnetParcel.Enabled := True;
      txtToken.Enabled := False
    end;
    1,3,4,6,7,10,11,13,14,15,16,17,18,20,21,23,24,25,26,27,28,30,31 : begin
      txtId.Enabled:= True;
      txtCarnetParcel.Enabled := False;
      txtToken.Enabled := False
    end;
    12 : begin
      txtId.Enabled:= True;
      txtCarnetParcel.Enabled := False;
      txtToken.Enabled := True
    end;
  end;
end;

procedure TMainFrm.EnableAll;
begin
  Actions.Enabled := True;
  ActionBtn.Enabled := True;
  PaymentBtn.Enabled := True;
  txtStreet.Enabled := True;
  txtNumber.Enabled := True;
  txtCity.Enabled := True;
  txtState.Enabled := True;
  txtZipCode.Enabled := True;
  txtNeighborhood.Enabled := True;
  txtName.Enabled := True;
  txtCPF.Enabled := True;
  txtEmail.Enabled := True;
  txtPhonenumber.Enabled := True;
end;

procedure TMainFrm.EnableProxy;
begin
  txtProxyPort.Enabled := true;
  txtProxyServer.Enabled := true;
  txtProxyUserName.Enabled := true;
  txtProxyPassword.Enabled := true;
end;

procedure TMainFrm.DisableProxy;
begin
  txtProxyPort.Enabled := false;
  txtProxyServer.Enabled := false;
  txtProxyUserName.Enabled := false;
  txtProxyPassword.Enabled := false;
end;

procedure TMainFrm.CheckBoxProxyClick(Sender: TObject);
begin
  if CheckBoxProxy.Checked = true then
    EnableProxy
  else DisableProxy;
end;

procedure TMainFrm.ConnectBtnClick(Sender: TObject);
begin
  if (CheckBoxProxy.Checked = true) then
  begin
    ConfigureProxy( ToPAnsiChar( ProxyServer ), ToPAnsiChar( ProxyUsername ), ToPAnsiChar( ProxyPassword ), ProxyPort );
  end;
  ConfigureService( ToPAnsiChar( ClientID ),ToPAnsiChar( ClientSecret ),ToPAnsiChar( Enviroment ),'config.json', '');
  DisplayServerResponse(GerenciaNetAuthorize());
  EnableAll;
end;

procedure TMainFrm.FormCreate(Sender: TObject);
begin
  EnableService( 'GerenciaNet.dll' );
  {$IFDEF UNICODE}
  FAddress.Street := 'Via Monte di Dio';
  FAddress.Number := 66;
  FAddress.City := 'Naples';
  FAddress.State := 'SP';
  FAddress.ZipCode := '35400000';
  FAddress.Neighborhood := 'Sao Paulo';
  {$ENDIF}
end;

function TMainFrm.GetClientID: String;
begin
  Result := txtClientID.Text;
end;

function TMainFrm.GetProxyServer: String;
begin
  Result := txtProxyServer.Text;
end;

function TMainFrm.GetProxyPort: Integer;
begin
  Result :=  StrToInt( txtProxyPort.Text );
end;

function TMainFrm.GetProxyUsername: String;
begin
  Result := txtProxyUsername.Text;
end;

function TMainFrm.GetProxyPassword: String;
begin
  Result := txtProxyPassword.Text;
end;

function TMainFrm.GetClientSecret: String;
begin
  Result := txtClientSecret.Text;
end;

function TMainFrm.GetID: String;
begin
    Result := txtId.Text;
end;

function TMainFrm.getEnviroment;
begin
  if CheckBoxSandbox.Checked then
    Result := 'sandbox'
  else Result := 'api';
end;


// WARNING: this function ASSUMES that the value ALWAYS ENDS with a comma.
// This MAY NOT ALWAYS HOLD TRUE IN PRACTICE.
function TMainFrm.GetJSONValue(JSONText, ID: String): String;
var JSONID : String;
    Buffer: String;
    ValueStartPos: Integer;
    ValueEndPos : Integer;
begin
  Buffer := JSONText;
  JSONID := '"'+ID+'":';
  ValueStartPos := Pos( JSONID,Buffer ) + 1;
  System.Delete( Buffer,1, ValueStartPos -1);
  ValueEndPos := Pos( ',',Buffer ) -1;
  System.Delete( Buffer,ValueEndPos + 1,Length( Buffer ) - ValueEndPos );
  Result := Buffer;
end;

function TMainFrm.GetCarnetParcel: String;
begin
    Result := txtCarnetParcel.Text;
end;

procedure TMainFrm.PaymentBtnClick(Sender: TObject);
var Response : String;
    Body : String;
    PaymentParams: String;
    {$IFDEF UNICODE}
    Payment : TPrivateBankBilletPayment;
    Configuration : TConfiguration;
    {$ENDIF}
begin
  FChargeID := txtId.Text;
  PaymentParams := CreateRequestParams( [ 'id='+FChargeID ] ).Text;
  {$IFDEF UNICODE}
  FAddress.Street := txtStreet.Text;
  FAddress.Number := StrToInt(txtNumber.Text);
  FAddress.City := txtCity.Text;
  FAddress.State := txtState.Text;
  FAddress.ZipCode := txtZipCode.Text;
  FAddress.Neighborhood := txtNeighborhood.Text;
  Configuration.Fine := 1;
  Configuration.Interest := 200;
  Payment := TPrivateBankBilletPayment.Create;
  Payment.Payment.Billet.Customer.Name := txtName.Text;
  Payment.Payment.Billet.Customer.CPF := txtCPF.Text;
  Payment.Payment.Billet.Customer.Email := txtEmail.Text;
  Payment.Payment.Billet.Customer.PhoneNumber := txtPhonenumber.Text;
  Payment.Payment.Billet.Customer.Birth := FormatDateTime( 'yyyy-mm-dd',EncodeDate( 1977,7,17 ) );
  Payment.Payment.Billet.Customer.Address := FAddress;
  Payment.Payment.Billet.ExpireAt := FormatDateTime( 'yyyy-mm-dd',Today + 10 );
  Payment.Payment.Billet.Message := 'Test';
  Payment.Payment.Billet.Instructions[ 0 ] := 'Test';
  Payment.Payment.Billet.Instructions[ 1 ] := '.';
  Payment.Payment.Billet.Instructions[ 2 ] := '.';
  Payment.Payment.Billet.Instructions[ 3 ] := '.';
  Body := Payment.AsJSON(False,False);
  {$ELSE}
  Body := '{'+
  '"payment": {'+
    '"banking_billet": {'+
      '"customer": {'+
        '"email": "teste@gmail.com",'+
        '"phone_number": "5144916523",'+
        '"birth": "1977-07-17",'+
        '"address": {'+
          '"street": "Av. JK",'+
          '"number": 909,'+
          '"neighborhood": "Bauxita",'+
          '"complement": "",'+
          '"city": "Ouro Preto",'+
          '"state": "MG",'+
          '"zipcode": "35400000"'+
        '},'+
        '"name": "Gorbadoc Oldbuck",'+
        '"cpf": "94271564656"'+
      '},'+
      '"message": "Test",'+
      '"expire_at": "2019-02-21"'+
    '}'+
  '}'+
'}';
  {$ENDIF}
  Response := ExecuteGerenciaNetRequest( 'payCharge',PaymentParams,'',Body ) ;
  DisplayServerResponse(Response);
end;

end.
