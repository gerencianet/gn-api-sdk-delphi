program GerenciaDemo;

uses
  Forms,
  MainCode in 'MainCode.pas' {MainFrm},
  uGerenciaClient in 'uGerenciaClient.pas',
  uChargeClasses in 'uChargeClasses.pas',
  uCommonTypes in 'uCommonTypes.pas',
  uPaymentClasses in 'uPaymentClasses.pas',
  uCustomerClasses in 'uCustomerClasses.pas',
  uCarnetClasses in 'uCarnetClasses.pas',
  uCarnetEndpoints in 'uCarnetEndpoints.pas',
  uChargeEndpoints in 'uChargeEndpoints.pas',
  uSubscriptionEndpoints in 'uSubscriptionEndpoints.pas',
  uExtraEndepoints in 'uExtraEndepoints.pas',
  uGerenciaNetClientUtilities in 'uGerenciaNetClientUtilities.pas';

{$R *.res}

begin
  Application.Initialize;
  {$IFDEF UNICODE}
  Application.MainFormOnTaskbar := True;
  {$ENDIF}
  Application.CreateForm(TMainFrm, MainFrm);
  Application.Run;
end.
