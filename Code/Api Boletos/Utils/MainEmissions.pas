unit MainEmissions;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, XSuperObject;

type
  TMainEmissions = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    txtClientId: TEdit;
    txtClientSecret: TEdit;
    PostAuthorization: TButton;
    MOAuth: TPanel;
    CheckBoxSandbox: TCheckBox;
    MemoResponse: TMemo;
    MCharges: TPanel;
    SCharges: TPanel;
    createCharge: TButton;
    detailCharge: TButton;
    cancelCharge: TButton;
    payChargeBillet: TButton;
    payChargeCreditCard: TButton;
    resendBillet: TButton;
    createChargeHistory: TButton;
    linkCharge: TButton;
    updateChargeLink: TButton;
    settleCharge: TButton;
    MCarnet: TPanel;
    SCarnet: TPanel;
    createCarnet: TButton;
    detailCarnet: TButton;
    cancelCarnet: TButton;
    updateParcel: TButton;
    updateCarnetMetadata: TButton;
    settleCarnet: TButton;
    createCarnetHistory: TButton;
    updateChargeMetadata: TButton;
    cancelParcel: TButton;
    ResendParcel: TButton;
    MPlans: TPanel;
    SPlans: TPanel;
    createSubscription: TButton;
    detailSubscription: TButton;
    cancelSubscription: TButton;
    updateSubscriptionMetadata: TButton;
    createSubscriptionHistory: TButton;
    createPlan: TButton;
    getPlans: TButton;
    updatePlan: TButton;
    deletePlan: TButton;
    paySubscriptionBillet: TButton;
    paySubscriptionCreditCard: TButton;
    txtIdentifier: TEdit;
    Label3: TLabel;
    MOthers: TPanel;
    SOthers: TPanel;
    Button4: TButton;
    ResendCarnet: TButton;
    createChargeOneStepBillet: TButton;
    createChargeOneStepCreditCard: TButton;
    procedure FormCreate(Sender: TObject);
    procedure PostAuthorizationClick(Sender: TObject);
    procedure MChargesClick(Sender: TObject);
    procedure SChargesMouseLeave(Sender: TObject);
    procedure createChargeClick(Sender: TObject);
    procedure detailChargeClick(Sender: TObject);
    procedure cancelChargeClick(Sender: TObject);
    procedure payChargeBilletClick(Sender: TObject);
    procedure payChargeCreditCardClick(Sender: TObject);
    procedure resendBilletClick(Sender: TObject);
    procedure createChargeHistoryClick(Sender: TObject);
    procedure linkChargeClick(Sender: TObject);
    procedure updateChargeLinkClick(Sender: TObject);
    procedure settleChargeClick(Sender: TObject);
    procedure MCarnetClick(Sender: TObject);
    procedure createCarnetClick(Sender: TObject);
    procedure updateParcelClick(Sender: TObject);
    procedure cancelCarnetClick(Sender: TObject);
    procedure updateChargeMetadataClick(Sender: TObject);
    procedure updateCarnetMetadataClick(Sender: TObject);
    procedure cancelParcelClick(Sender: TObject);
    procedure ResendParcelClick(Sender: TObject);
    procedure MPlansClick(Sender: TObject);
    procedure SPlansMouseLeave(Sender: TObject);
    procedure SCarnetMouseLeave(Sender: TObject);
    procedure createPlanClick(Sender: TObject);
    procedure getPlansClick(Sender: TObject);
    procedure updatePlanClick(Sender: TObject);
    procedure deletePlanClick(Sender: TObject);
    procedure createSubscriptionClick(Sender: TObject);
    procedure detailSubscriptionClick(Sender: TObject);
    procedure cancelSubscriptionClick(Sender: TObject);
    procedure updateSubscriptionMetadataClick(Sender: TObject);
    procedure createSubscriptionHistoryClick(Sender: TObject);
    procedure paySubscriptionCreditCardClick(Sender: TObject);
    procedure paySubscriptionBilletClick(Sender: TObject);
    procedure MOthersClick(Sender: TObject);
    procedure SOthersMouseLeave(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ResendCarnetClick(Sender: TObject);
    procedure createCarnetHistoryClick(Sender: TObject);
    procedure settleCarnetClick(Sender: TObject);
    procedure detailCarnetClick(Sender: TObject);
    procedure createChargeOneStepBilletClick(Sender: TObject);
    procedure createChargeOneStepCreditCardClick(Sender: TObject);
  private
    function GetClientID: String;
    function GetClientSecret: String;
    function GetEnviroment: String;
  public
    property ClientID: String read GetClientID;
    property ClientSecret: String read GetClientSecret;
    property Enviroment : String read GetEnviroment;
  end;

  var
  frmBoletos: TMainEmissions;


implementation

  uses uAuthenticationEndpoints, uChargesEndpoints, uCarnetEndpoints,
  uPlansEndpoints, uOthersEndpoints;

{$R *.dfm}

procedure TMainEmissions.createChargeHistoryClick(Sender: TObject);
begin
  uChargesEndpoints.CreateChargeHistory;
end;

procedure TMainEmissions.createChargeOneStepBilletClick(Sender: TObject);
begin
  uChargesEndpoints.CreateChargeOneStepBillet;
end;

procedure TMainEmissions.createChargeOneStepCreditCardClick(Sender: TObject);
begin
  uChargesEndpoints.CreateChargeOneStepCreditCard;
end;

procedure TMainEmissions.createPlanClick(Sender: TObject);
begin
  uPlansEndpoints.CreatePlan;
end;

procedure TMainEmissions.createSubscriptionClick(Sender: TObject);
begin
  uPlansEndpoints.CreateSubscription;
end;

procedure TMainEmissions.createSubscriptionHistoryClick(Sender: TObject);
begin
  uPlansEndpoints.CreateSubscriptionHistory;
end;

procedure TMainEmissions.Button4Click(Sender: TObject);
begin
  uOthersEndpoints.GetNotification;
end;

procedure TMainEmissions.cancelCarnetClick(Sender: TObject);
begin
  uCarnetEndpoints.CancelCarnet;
end;

procedure TMainEmissions.cancelChargeClick(Sender: TObject);
begin
  uChargesEndpoints.CancelCharge;
end;

procedure TMainEmissions.cancelParcelClick(Sender: TObject);
begin
  uCarnetEndpoints.CancelParcel;
end;

procedure TMainEmissions.cancelSubscriptionClick(Sender: TObject);
begin
  uPlansEndpoints.CancelSubscription;
end;

procedure TMainEmissions.createCarnetClick(Sender: TObject);
begin
  uCarnetEndpoints.CreateCarnet;
end;

procedure TMainEmissions.createCarnetHistoryClick(Sender: TObject);
begin
  uCarnetEndpoints.createCarnetHistory;
end;

procedure TMainEmissions.createChargeClick(Sender: TObject);
begin
  uChargesEndpoints.CreateCharge;
end;

procedure TMainEmissions.deletePlanClick(Sender: TObject);
begin
  uPlansEndpoints.DeletePlan;
end;

procedure TMainEmissions.detailCarnetClick(Sender: TObject);
begin
  uCarnetEndpoints.DetailCarnet;
end;

procedure TMainEmissions.detailChargeClick(Sender: TObject);
begin
  uChargesEndpoints.DetailCharge;
end;

procedure TMainEmissions.detailSubscriptionClick(Sender: TObject);
begin
  uPlansEndpoints.DetailSubscription;
end;

procedure TMainEmissions.FormCreate(Sender: TObject);
begin
  Self.Position := poScreenCenter;
  MemoResponse.Text := '';
end;

//Encapsulando Credenciais
function TMainEmissions.GetClientSecret: String;
begin
  Result := txtClientSecret.Text;
end;

function TMainEmissions.GetClientID : String;
begin
  Result := txtClientID.Text;
end;

function TMainEmissions.GetEnviroment : String;
begin
  if CheckBoxSandbox.Checked then
    Result := 'https://sandbox.gerencianet.com.br'
  else
    Result := 'https://api.gerencianet.com.br';
end;

procedure TMainEmissions.getPlansClick(Sender: TObject);
begin
  uPlansEndpoints.GetPlans;
end;

procedure TMainEmissions.linkChargeClick(Sender: TObject);
begin
  uChargesEndpoints.LinkCharge;
end;

procedure TMainEmissions.MCarnetClick(Sender: TObject);
begin
  SCarnet.Visible := not SCarnet.Visible;
end;

procedure TMainEmissions.MChargesClick(Sender: TObject);
begin
  SCharges.Visible := not SCharges.Visible;
end;

procedure TMainEmissions.MOthersClick(Sender: TObject);
begin
  SOthers.Visible := not SOthers.Visible;
end;

procedure TMainEmissions.MPlansClick(Sender: TObject);
begin
  SPlans.Visible := not SPlans.Visible;
end;

procedure TMainEmissions.payChargeBilletClick(Sender: TObject);
begin
  uChargesEndpoints.PayChargeBillet;
end;

procedure TMainEmissions.payChargeCreditCardClick(Sender: TObject);
begin
  uChargesEndpoints.PayChargeCreditCard;
end;

procedure TMainEmissions.paySubscriptionBilletClick(Sender: TObject);
begin
  uPlansEndpoints.PaySubscriptionBillet;
end;

procedure TMainEmissions.paySubscriptionCreditCardClick(Sender: TObject);
begin
  uPlansEndpoints.PaySubscriptionCreditCard;
end;

procedure TMainEmissions.PostAuthorizationClick(Sender: TObject);
begin
  uAuthenticationEndpoints.OauthToken;
end;

procedure TMainEmissions.resendBilletClick(Sender: TObject);
begin
  uChargesEndpoints.ResendBillet;
end;

procedure TMainEmissions.ResendCarnetClick(Sender: TObject);
begin
  uCarnetEndpoints.ResendCarnet;
end;

procedure TMainEmissions.ResendParcelClick(Sender: TObject);
begin
  uCarnetEndpoints.ResendParcel;
end;

procedure TMainEmissions.SCarnetMouseLeave(Sender: TObject);
begin
  SCarnet.Visible := False;
end;

procedure TMainEmissions.SChargesMouseLeave(Sender: TObject);
begin
  SCharges.Visible := False;
end;

procedure TMainEmissions.settleCarnetClick(Sender: TObject);
begin
  uCarnetEndpoints.settleCarnet;
end;

procedure TMainEmissions.settleChargeClick(Sender: TObject);
begin
  uChargesEndpoints.SettleCharge;
end;

procedure TMainEmissions.SOthersMouseLeave(Sender: TObject);
begin
  SOthers.Visible := False
end;

procedure TMainEmissions.SPlansMouseLeave(Sender: TObject);
begin
  SPlans.Visible := False;
end;

procedure TMainEmissions.updateChargeLinkClick(Sender: TObject);
begin
  uChargesEndpoints.UpdateChargeLink;
end;

procedure TMainEmissions.updateCarnetMetadataClick(Sender: TObject);
begin
  uCarnetEndpoints.UpdateCarnetMetadata;
end;

procedure TMainEmissions.updateChargeMetadataClick(Sender: TObject);
begin
  uChargesEndpoints.UpdateChargeMetadata;
end;

procedure TMainEmissions.updateParcelClick(Sender: TObject);
begin
  uCarnetEndpoints.UpdateParcel;
end;

procedure TMainEmissions.updatePlanClick(Sender: TObject);
begin
  uPlansEndpoints.UpdatePlan;
end;

procedure TMainEmissions.updateSubscriptionMetadataClick(Sender: TObject);
begin
  uPlansEndpoints.UpdateSubscriptionMetadata;
end;

end.
