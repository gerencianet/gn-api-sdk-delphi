unit uChargeEndpoints;

interface

uses
Windows, Messages, SysUtils, Variants, Classes, Contnrs,
IdBaseComponent, IdIntercept {$IFDEF UNICODE}, IdInterceptSimLog {$ENDIF}, uCommonTypes, ComCtrls;

function CreateCharge: String;
function DetailCharge(Id: String): String;
function PayChargeWithBillet(Id: String): String;
function PayChargeWithCard(Id, Token: String): String;
function CancelCharge(Id: String): String;
function CreateChargeHistory(Id: String): String;
function LinkCharge(Id: String): String;
function ResendBillet(Id: String): String;
function UpdateBillet(Id: String): String;
function UpdateChargeMetadata(Id: String): String;

implementation

uses

 uGerenciaNetClientUtilities, uGerenciaClient

 {$IFDEF UNICODE}, uChargeClasses, uPaymentClasses, DateUtils ,XSuperObject{$ENDIF};

function CreateCharge: String;
var Body :  String;
{$IFDEF UNICODE}
    Charge : TBaseCharge;
{$ENDIF}
begin
  {$IFDEF UNICODE}
  Charge := TBaseCharge.Create( 2 );
  Charge.Items[ 0 ].Name := 'test article';
  Charge.Items[ 0 ].Value := 1900;
  Charge.Items[ 0 ].Quantity := 2;
  Charge.Items[ 1 ].Name := 'test article 2';
  Charge.Items[ 1 ].Value := 3000;
  Charge.Items[ 1 ].Quantity := 1;
  Body := Charge.AsJSON;
  Result :=  ExecuteGerenciaNetRequest( 'createCharge','','',Body );
  {$ELSE}
  Body := '{"items":[{"name":"test article","value":1900,"amount":2},{"name":"test article 2","value":3000,"amount":1}]}';
  Result := ExecuteGerenciaNetRequest( 'createCharge','','',Body );
  {$ENDIF}
end;

function PayChargeWithBillet(Id: String): String;
var Body : String;
    PaymentParams: String;
    {$IFDEF UNICODE}
    Payment : TPrivateBankBilletPayment;
    Configuration : TConfiguration;
    FChargeID: String;
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
  FChargeID := Id;
  FAddress.Street := 'Via Monte di Dio';
  FAddress.Number := 66;
  FAddress.City := 'Naples';
  FAddress.State := 'SP';
  FAddress.ZipCode := '35400000';
  FAddress.Neighborhood := 'Sao Paulo';
  Configuration.Fine := 1;
  Configuration.Interest := 200;
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
  Result := ExecuteGerenciaNetRequest( 'payCharge',PaymentParams,'',Body );
end;

function PayChargeWithCard(Id, Token: String): String;
var
    Body: String;
    PaymentParams: String;

begin
  Body :=
  '{'+
    '"payment": {'+
      '"credit_card": {'+
        '"customer": {'+
          '"name": "Gorbadoc Oldbuck",'+
          '"cpf": "94271564656",'+
          '"phone_number": "5144916523",'+
          '"email": "oldbuck@gerencianet.com.br",'+
          '"birth": "1977-01-15"'+
        '},'+
        '"installments": 1,'+
        '"payment_token": "'+Token+'",'+
        '"billing_address": {'+
          '"street": "Av. JK",'+
          '"number": "909",'+
          '"neighborhood": "Bauxita",'+
          '"zipcode": "35400000",'+
          '"city": "Ouro Preto",'+
          '"state": "MG"'+
        '}'+
      '}'+
    '}'+
  '}';

  PaymentParams := CreateRequestParams( [ 'id='+Id ] ).Text;
  Result := ExecuteGerenciaNetRequest( 'payCharge',PaymentParams,'',Body );
end;


function DetailCharge(Id: String): String;
var
  DetailParams: String;
begin
    DetailParams := CreateRequestParams( [ 'id='+Id ] ).Text;
    Result := ExecuteGerenciaNetRequest( 'detailCharge',DetailParams, '', '' );
end;

function CancelCharge(Id: String): String;
var
  CancelParams: String;
begin
    CancelParams := CreateRequestParams( [ 'id='+Id ] ).Text;
    Result := ExecuteGerenciaNetRequest( 'cancelCharge',CancelParams, '', '' );
end;

function CreateChargeHistory(Id: String): String;
var
  Body : String;
  UpdateParams : String;
begin
    UpdateParams := CreateRequestParams( [ 'id='+Id ] ).Text;
    Body := '{"description": "This carnet is about a service"}';
    Result := ExecuteGerenciaNetRequest( 'createChargeHistory',UpdateParams, '', Body );
end;

function LinkCharge(Id: String): String;
var
  Params: String;
  Body : String;
begin
    Params := CreateRequestParams( [ 'id='+Id ] ).Text;
    Body := '{"billet_discount": 10,'+
     '"card_discount": 10,'+
     '"message": "link test",'+
     '"expire_at": "2018-12-12",'+
     '"request_delivery_address": false,'+
     '"payment_method": "all"}';
    Result := ExecuteGerenciaNetRequest( 'linkCharge',Params, '', Body );
end;

function ResendBillet(Id: String): String;
var
  Body : String;
  Params : String;
begin
    Params := CreateRequestParams( [ 'id='+Id ] ).Text;
    Body := '{"email": "oldbuck@gerencianet.com.br"}';
    Result := ExecuteGerenciaNetRequest( 'resendBillet', Params, '', Body );
end;

function UpdateBillet(Id: String): String;
var
  Body : String;
  Params : String;
begin
    Params := CreateRequestParams( [ 'id='+Id ] ).Text;
    Body := '{"expire_at": "2020-12-12"}';
    Result := ExecuteGerenciaNetRequest( 'updateBillet', Params, '', Body );
end;

function UpdateChargeMetadata(Id: String): String;
var
  Body : String;
  Params : String;
begin
    Params := CreateRequestParams( [ 'id='+Id ] ).Text;
    Body :=
    '{"custom_id": "Product10",'+
     '"notification_url": "http://domain.com/notification" }';
    Result := ExecuteGerenciaNetRequest( 'updateChargeMetadata', Params, '', Body );
end;

end.
