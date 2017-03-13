unit uSubscriptionEndpoints;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Contnrs,
IdBaseComponent, IdIntercept {$IFDEF UNICODE}, IdInterceptSimLog {$ENDIF}, uCommonTypes, ComCtrls;

function CreatePlan: String;
function CreateSubscription(Id: String): String;
function DetailSubscription(Id: String): String;
function GetPlans: String;
function PaySubscription(Id: String): String;
function UpdateSubscription(Id: String): String;
function CancelSubscription(Id: String): String;
function DeletePlan(Id: String): String;

implementation

uses uGerenciaNetClientUtilities, uGerenciaClient
{$IFDEF UNICODE}
  , DateUtils,  uPaymentClasses, XSuperObject, Clipbrd
 {$ENDIF};

function CreatePlan: String;
var
  Body: String;
begin
    Body :=
    '{"name": "my_plan",'+
     '"interval": 2,'+
     '"repeats": 2}';
    Result := ExecuteGerenciaNetRequest( 'createPlan','','', Body );
end;

function CreateSubscription(Id: String): String;
var
  Params: String;
  Body: String;
begin
    Params := CreateRequestParams( [ 'id='+Id ] ).Text;
    Body :=
    '{"items": ['+
      '{"name": "Item 1",'+
       '"amount": 1,'+
       '"value": 2000}'+
    ']}';
    Result := ExecuteGerenciaNetRequest( 'createSubscription',Params,'', Body );
end;

function DetailSubscription(Id: String): String;
var
  Params: String;
begin
    Params := CreateRequestParams( [ 'id='+Id ] ).Text;
    Result := ExecuteGerenciaNetRequest( 'detailSubscription',Params,'', '' );
end;

function GetPlans: String;
var
  Params: String;
begin
    Params := CreateRequestParams( [ 'name=my plan', 'limit=20', 'offset=0' ] ).Text;
    Result := ExecuteGerenciaNetRequest( 'getPlans','', Params, '' );
end;

function PaySubscription(Id: String): String;
var
    Body : String;
    PaymentParams: String;
    {$IFDEF UNICODE}
    Payment : TPrivateBankBilletPayment;
    FAddress: TAddress;
    {$ENDIF}
{$IFNDEF UNICODE}
const BodyText = '{'+
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
begin
  PaymentParams := CreateRequestParams( [ 'id='+id ] ).Text;
  {$IFDEF UNICODE}
  FAddress.Street := 'Via Monte di Dio';
  FAddress.Number := 66;
  FAddress.City := 'Naples';
  FAddress.State := 'SP';
  FAddress.ZipCode := '35400000';
  FAddress.Neighborhood := 'Sao Paulo';
  Payment := TPrivateBankBilletPayment.Create;
  Payment.Payment.Billet.Customer.Name := 'Gorbadoc Oldbuck';
  Payment.Payment.Billet.Customer.CPF := '94271564656';
  Payment.Payment.Billet.Customer.Email := 'Gorbaboc.Oldbuck@email.com';
  Payment.Payment.Billet.Customer.PhoneNumber := '5144916523';
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
  Body := BodyText;
  {$ENDIF}
  Result := ExecuteGerenciaNetRequest( 'paySubscription',PaymentParams,'',Body );
end;

function UpdateSubscription(Id: String): String;
var
  Body: String;
  Params : String;
begin
    Params := CreateRequestParams( [ 'id='+Id ] ).Text;
    Body :=
    '{"custom_id": "Subscription10",'+
     '"notification_url": "http://domain.com/notification" }';
    Result := ExecuteGerenciaNetRequest( 'updateSubscriptionMetadata', Params,'', Body );
end;

function CancelSubscription(Id: String): String;
var
  Params: String;
begin
    Params := CreateRequestParams( [ 'id='+Id ] ).Text;
    Result := ExecuteGerenciaNetRequest( 'cancelSubscription',Params,'', '' );
end;

function DeletePlan(Id: String): String;
var
  Params: String;
begin
    Params := CreateRequestParams( [ 'id='+Id ] ).Text;
    Result := ExecuteGerenciaNetRequest( 'deletePlan',Params,'','' );
end;

end.
