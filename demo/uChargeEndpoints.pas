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
function CreateChargeBalanceSheet(Id: String): String;
function SettleCharge(Id: String): String;

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

function SettleCharge(Id: String): String;
var
  Params : String;
begin
    Params := CreateRequestParams( [ 'id='+Id ] ).Text;
    Result := ExecuteGerenciaNetRequest( 'settleCharge', Params, '', '' );
end;


function CreateChargeBalanceSheet(Id: String): String;
var
    Body: String;
    PaymentParams: String;
begin
  Body :=
 '   {  '  +
 '   	"title": "Balancete Demonstrativo - Periodo 25/06/2018 a 25/07/2018",  '  +
 '   	"body": [{  '  +
 '   		"header": "Demonstrativo de Consumo",  '  +
 '   		"tables": [{  '  +
 '   			"rows": [[{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "Despesa de condomínio:",  '  +
 '   				"colspan": 2  '  +
 '   			},  '  +
 '   			{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "Total lançado",  '  +
 '   				"colspan": 1  '  +
 '   			},  '  +
 '   			{  '  +
 '   				"align": "right",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "Rateio",  '  +
 '   				"colspan": 1  '  +
 '   			}],  '  +
 '   			[{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "Serviço de Vigilância Contratado:",  '  +
 '   				"colspan": 2  '  +
 '   			},  '  +
 '   			{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "R$ 300,00",  '  +
 '   				"colspan": 1  '  +
 '   			},  '  +
 '   			{  '  +
 '   				"align": "right",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "R$ 75,00",  '  +
 '   				"colspan": 1  '  +
 '   			}],   '  +
 '   			[{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "Serviço de Zeladoria Contratado:",  '  +
 '   				"colspan": 2  '  +
 '   			},  '  +
 '   			{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "R$ 130,00",  '  +
 '   				"colspan": 1  '  +
 '   			},  '  +
 '   			{  '  +
 '   				"align": "right",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "R$ 32,00",  '  +
 '   				"colspan": 1  '  +
 '   			}], [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "Serviço de Jardinagem:",  '  +
 '   				"colspan": 2  '  +
 '   			},  '  +
 '   			{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "R$ 80,00",  '  +
 '   				"colspan": 1  '  +
 '   			},  '  +
 '   			{  '  +
 '   				"align": "right",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "R$ 20,00",  '  +
 '   				"colspan": 1  '  +
 '   			}], [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "Tarifa Bancária:",  '  +
 '   				"colspan": 2  '  +
 '   			},  '  +
 '   			{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "R$ 10,00",  '  +
 '   				"colspan": 1  '  +
 '   			},  '  +
 '   			{  '  +
 '   				"align": "right",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "R$ 2,50",  '  +
 '   				"colspan": 1  '  +
 '   			}], [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "Despesa condomínio:",  '  +
 '   				"colspan": 2  '  +
 '   			},  '  +
 '   			{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "R$ 800,00",  '  +
 '   				"colspan": 1  '  +
 '   			},  '  +
 '   			{  '  +
 '   				"align": "right",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "R$ 320,00",  '  +
 '   				"colspan": 1  '  +
 '   			}], [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "Reforma de prédio:",  '  +
 '   				"colspan": 2  '  +
 '   			},  '  +
 '   			{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "R$ 350,00",  '  +
 '   				"colspan": 1  '  +
 '   			},  '  +
 '   			{  '  +
 '   				"align": "right",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "R$ 140,00",  '  +
 '   				"colspan": 1  '  +
 '   			}],  [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "Investimentos:",  '  +
 '   				"colspan": 1  '  +
 '   			},  '  +
 '   			{  '  +
 '   				"align": "center",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "Total:",  '  +
 '   				"colspan": 1  '  +
 '   			},  '  +
 '   			{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "R$ 1320,00",  '  +
 '   				"colspan": 1  '  +
 '   			},  '  +
 '   			{  '  +
 '   				"align": "right",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "R$ 450,00",  '  +
 '   				"colspan": 1  '  +
 '   			}], [{  '  +
 '   				"align": "center",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "bold",  '  +
 '   				"text": " ",  '  +
 '   				"colspan": 1  '  +
 '   			},{  '  +
 '   				"align": "center",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "Total:",  '  +
 '   				"colspan": 1  '  +
 '   			}, {  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "R$ 350,00",  '  +
 '   				"colspan": 1  '  +
 '   			}, {  '  +
 '   				"align": "right",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "R$ 140,00",  '  +
 '   				"colspan": 1  '  +
 '   			}]]  '  +
 '   		},  '  +
 '   		{  '  +
 '   			"rows": [[{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "Despesas de Consumo",  '  +
 '   				"colspan": 4  '  +
 '   			}], [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "Leitura de gás:",  '  +
 '   				"colspan": 1  '  +
 '   			}, {  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "Data: 25/11/2017",  '  +
 '   				"colspan": 3  '  +
 '   			}], [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "Anterior",  '  +
 '   				"colspan": 1  '  +
 '   			}, {  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "Atual Consumo",  '  +
 '   				"colspan": 1  '  +
 '   			}, {  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "g/l",  '  +
 '   				"colspan": 1  '  +
 '   			},  {  '  +
 '   				"align": "right",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "Total",  '  +
 '   				"colspan": 1  '  +
 '   			}], [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "49,000000",  '  +
 '   				"colspan": 1  '  +
 '   			}, {  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "63,000000",  '  +
 '   				"colspan": 1  '  +
 '   			}, {  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "14,000000",  '  +
 '   				"colspan": 1  '  +
 '   			},  {  '  +
 '   				"align": "right",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "R$ 53,50",  '  +
 '   				"colspan": 1  '  +
 '   			}]]  '  +
 '   		},   '  +
 '   		{  '  +
 '   			"rows": [[{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "Leitura de água:",  '  +
 '   				"colspan": 1  '  +
 '   			}, {  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "Data: 25/11/2017",  '  +
 '   				"colspan": 3  '  +
 '   			}], [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "Anterior",  '  +
 '   				"colspan": 1  '  +
 '   			}, {  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "Atual Consumo",  '  +
 '   				"colspan": 1  '  +
 '   			}, {  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "m³",  '  +
 '   				"colspan": 1  '  +
 '   			},  {  '  +
 '   				"align": "right",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "Total",  '  +
 '   				"colspan": 1  '  +
 '   			}], [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "112,500000",  '  +
 '   				"colspan": 1  '  +
 '   			}, {  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "114,900000",  '  +
 '   				"colspan": 1  '  +
 '   			}, {  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "2,400000",  '  +
 '   				"colspan": 1  '  +
 '   			},  {  '  +
 '   				"align": "right",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "R$ 43,00",  '  +
 '   				"colspan": 1  '  +
 '   			}]]  '  +
 '   		},   '  +
 '   		{  '  +
 '   			"rows": [[{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "Leitura de esgoto:",  '  +
 '   				"colspan": 1  '  +
 '   			},  '  +
 '   			{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "Data: 25/11/2017",  '  +
 '   				"colspan": 3  '  +
 '   			}], [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "Anterior",  '  +
 '   				"colspan": 1  '  +
 '   			}, {  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "Atual Consumo",  '  +
 '   				"colspan": 1  '  +
 '   			}, {  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "m³",  '  +
 '   				"colspan": 1  '  +
 '   			},  {  '  +
 '   				"align": "right",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "Total",  '  +
 '   				"colspan": 1  '  +
 '   			}], [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "0,000000",  '  +
 '   				"colspan": 1  '  +
 '   			}, {  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "0,000000",  '  +
 '   				"colspan": 1  '  +
 '   			}, {  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "0,00",  '  +
 '   				"colspan": 1  '  +
 '   			},  {  '  +
 '   				"align": "right",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "R$ 34,40",  '  +
 '   				"colspan": 1  '  +
 '   			}]]   '  +
 '   		}, {   '  +
 '   				"rows": [[{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "Resumo do rateio",  '  +
 '   				"colspan": 4  '  +
 '   			}], [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "Despesas de condomínio",  '  +
 '   				"colspan": 2  '  +
 '   			}, {  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "R$ 450,00",  '  +
 '   				"colspan": 2  '  +
 '   			}], [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "Investimento",  '  +
 '   				"colspan": 2  '  +
 '   			}, {  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "R$ 140,00",  '  +
 '   				"colspan": 2  '  +
 '   			}], [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "Fundo de reserva 10%",  '  +
 '   				"colspan": 2  '  +
 '   			}, {  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "R$ 79,59",  '  +
 '   				"colspan": 2  '  +
 '   			}], [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "Leitura de gás",  '  +
 '   				"colspan": 2  '  +
 '   			}, {  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "R$ 53,50",  '  +
 '   				"colspan": 2  '  +
 '   			}], [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "Leitura de água",  '  +
 '   				"colspan": 2  '  +
 '   			}, {  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "R$ 43,00",  '  +
 '   				"colspan": 2  '  +
 '   			}], [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "Leitura de esgoto",  '  +
 '   				"colspan": 2  '  +
 '   			}, {  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "R$ 34,40",  '  +
 '   				"colspan": 2  '  +
 '   			}], [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "Garagens",  '  +
 '   				"colspan": 2  '  +
 '   			}, {  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "R$ 5,00",  '  +
 '   				"colspan": 2  '  +
 '   			}],  [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "Taxa de administradora",  '  +
 '   				"colspan": 2  '  +
 '   			}, {  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "R$ 25,00",  '  +
 '   				"colspan": 2  '  +
 '   			}], [{  '  +
 '   				"align": "right",  '  +
 '   				"color": "#DC143C",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "Total geral:",  '  +
 '   				"colspan": 2  '  +
 '   			}, {  '  +
 '   				"align": "left",  '  +
 '   				"color": "#DC143C",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "R$ 823,49",  '  +
 '   				"colspan": 2  '  +
 '   			}]]  '  +
 '   		}]  '  +
 '   	},  '  +
 '   	{  '  +
 '   		"header": "Balancete Geral",  '  +
 '   		"tables": [{  '  +
 '   			"rows": [[{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#DC143C",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "RECEITAS",  '  +
 '   				"colspan": 4  '  +
 '   			}], [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "RECEITAS DE CONDOMÍNIO",  '  +
 '   				"colspan": 2  '  +
 '   			}, {  '  +
 '   				"align": "center",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "R$ 2.090,12",  '  +
 '   				"colspan": 1  '  +
 '   			}, {  '  +
 '   				"align": "right",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "100,00%",  '  +
 '   				"colspan": 1  '  +
 '   			}], [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "Taxa de Condominio",  '  +
 '   				"colspan": 2  '  +
 '   			}, {  '  +
 '   				"align": "center",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "R$ 1.030,00",  '  +
 '   				"colspan": 1  '  +
 '   			}, {  '  +
 '   				"align": "right",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "49,28%",  '  +
 '   				"colspan": 1  '  +
 '   			}], [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "Investimentos",  '  +
 '   				"colspan": 2  '  +
 '   			}, {  '  +
 '   				"align": "center",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "R$ 280,00",  '  +
 '   				"colspan": 1  '  +
 '   			}, {  '  +
 '   				"align": "right",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "13,40%",  '  +
 '   				"colspan": 1  '  +
 '   			}], [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "Gás",  '  +
 '   				"colspan": 2  '  +
 '   			}, {  '  +
 '   				"align": "center",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "R$ 50,73",  '  +
 '   				"colspan": 1  '  +
 '   			}, {  '  +
 '   				"align": "right",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "2,43%",  '  +
 '   				"colspan": 1  '  +
 '   			}], [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "Garagens",  '  +
 '   				"colspan": 2  '  +
 '   			}, {  '  +
 '   				"align": "center",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "R$ 23,00",  '  +
 '   				"colspan": 1  '  +
 '   			}, {  '  +
 '   				"align": "right",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "1,10%",  '  +
 '   				"colspan": 1  '  +
 '   			}], [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "Reserva Técnica",  '  +
 '   				"colspan": 2  '  +
 '   			}, {  '  +
 '   				"align": "center",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "R$ 183,19",  '  +
 '   				"colspan": 1  '  +
 '   			}, {  '  +
 '   				"align": "right",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "8,67%",  '  +
 '   				"colspan": 1  '  +
 '   			}], [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "Água",  '  +
 '   				"colspan": 2  '  +
 '   			}, {  '  +
 '   				"align": "center",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "R$ 249,00",  '  +
 '   				"colspan": 1  '  +
 '   			}, {  '  +
 '   				"align": "right",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "11,91%",  '  +
 '   				"colspan": 1  '  +
 '   			}], [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "Esgoto",  '  +
 '   				"colspan": 2  '  +
 '   			}, {  '  +
 '   				"align": "center",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "R$ 199,20",  '  +
 '   				"colspan": 1  '  +
 '   			}, {  '  +
 '   				"align": "right",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "9,53%",  '  +
 '   				"colspan": 1  '  +
 '   			}], [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "Taxa Administradora",  '  +
 '   				"colspan": 2  '  +
 '   			}, {  '  +
 '   				"align": "center",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "R$ 75,00",  '  +
 '   				"colspan": 1  '  +
 '   			}, {  '  +
 '   				"align": "right",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "3,59%",  '  +
 '   				"colspan": 1  '  +
 '   			}]] }, {  '  +
 '   			"rows": [[{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#DC143C",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "DESPESAS",  '  +
 '   				"colspan": 4  '  +
 '   			}], [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "DESPESAS DE CONDOMÍNIO",  '  +
 '   				"colspan": 2  '  +
 '   			}, {  '  +
 '   				"align": "center",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "R$ 1.670,12",  '  +
 '   				"colspan": 1  '  +
 '   			},  {  '  +
 '   				"align": "right",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "100,00%",  '  +
 '   				"colspan": 1  '  +
 '   			}], [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "DESPESAS DE AQUISIÇÕES",  '  +
 '   				"colspan": 4  '  +
 '   			}], [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "Despesas de condomínio",  '  +
 '   				"colspan": 2  '  +
 '   			}, {  '  +
 '   				"align": "center",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "R$ 800,00",  '  +
 '   				"colspan": 1  '  +
 '   			}, {  '  +
 '   				"align": "right",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "47,90%",  '  +
 '   				"colspan": 1  '  +
 '   			}], [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "Reformas do prédio",  '  +
 '   				"colspan": 2  '  +
 '   			}, {  '  +
 '   				"align": "center",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "R$ 350,00",  '  +
 '   				"colspan": 1  '  +
 '   			}, {  '  +
 '   				"align": "right",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "20,96%",  '  +
 '   				"colspan": 1  '  +
 '   			}], [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": " ",  '  +
 '   				"colspan": 2  '  +
 '   			}, {  '  +
 '   				"align": "center",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "R$ 1.150,00",  '  +
 '   				"colspan": 1  '  +
 '   			}, {  '  +
 '   				"align": "right",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "68,86%",  '  +
 '   				"colspan": 1  '  +
 '   			}]] } , {  '  +
 '   			"rows": [[{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "DESPESAS COM SERVIÇOS",  '  +
 '   				"colspan": 4  '  +
 '   			}], [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "Serviço de Vigilância Contratado",  '  +
 '   				"colspan": 2  '  +
 '   			}, {  '  +
 '   				"align": "center",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "R$ 300,00",  '  +
 '   				"colspan": 1  '  +
 '   			},  {  '  +
 '   				"align": "right",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "17,96%",  '  +
 '   				"colspan": 1  '  +
 '   			}], [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "Serviço de Zeladoria Contratado",  '  +
 '   				"colspan": 2  '  +
 '   			}, {  '  +
 '   				"align": "center",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "R$ 130,00",  '  +
 '   				"colspan": 1  '  +
 '   			}, {  '  +
 '   				"align": "right",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "7,78%",  '  +
 '   				"colspan": 1  '  +
 '   			}], [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "Serviço de Jardinagem",  '  +
 '   				"colspan": 2  '  +
 '   			}, {  '  +
 '   				"align": "center",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "R$ 80,00",  '  +
 '   				"colspan": 1  '  +
 '   			}, {  '  +
 '   				"align": "right",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "4,79%",  '  +
 '   				"colspan": 1  '  +
 '   			}], [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": " ",  '  +
 '   				"colspan": 2  '  +
 '   			}, {  '  +
 '   				"align": "center",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "R$ 510,00",  '  +
 '   				"colspan": 1  '  +
 '   			}, {  '  +
 '   				"align": "right",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "30,54%",  '  +
 '   				"colspan": 1  '  +
 '   			}]]} , {  '  +
 '   			"rows": [[{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "DESPESAS BANCÁRIAS",  '  +
 '   				"colspan": 4  '  +
 '   			}], [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "Tarifa Bancária",  '  +
 '   				"colspan": 2  '  +
 '   			}, {  '  +
 '   				"align": "center",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "R$ 10,00",  '  +
 '   				"colspan": 1  '  +
 '   			}, {  '  +
 '   				"align": "right",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "0,60%",  '  +
 '   				"colspan": 1  '  +
 '   			}], [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": " ",  '  +
 '   				"colspan": 2  '  +
 '   			}, {  '  +
 '   				"align": "center",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "R$ 10,00",  '  +
 '   				"colspan": 1  '  +
 '   			}, {  '  +
 '   				"align": "right",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "0,60%",  '  +
 '   				"colspan": 1  '  +
 '   			}]] } , {  '  +
 '   			"rows": [[{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#DC143C",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "Resumo de Prestação de Contas",  '  +
 '   				"colspan": 4  '  +
 '   			}], [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "RECEITAS",  '  +
 '   				"colspan": 2  '  +
 '   			}, {  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "R$ 2.090,12",  '  +
 '   				"colspan": 2  '  +
 '   			}],  [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "DESPESAS",  '  +
 '   				"colspan": 2  '  +
 '   			}, {  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "R$ 1.670,00",  '  +
 '   				"colspan": 2  '  +
 '   			}], [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": " ",  '  +
 '   				"colspan": 2  '  +
 '   			}, {  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "(Receitas - Despesas)R$ 420,12",  '  +
 '   				"colspan": 2  '  +
 '   			}]]} , {  '  +
 '   			"rows": [[{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#DC143C",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "Resumo de Saldos",  '  +
 '   				"colspan": 4  '  +
 '   			}], [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "Conta",  '  +
 '   				"colspan": 1  '  +
 '   			}, {  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "Saldo Anterior",  '  +
 '   				"colspan": 1  '  +
 '   			},{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "Entradas Saídas",  '  +
 '   				"colspan": 1  '  +
 '   			}, {  '  +
 '   				"align": "right",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "Saldo Atual",  '  +
 '   				"colspan": 1  '  +
 '   			}],  [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "BANCOS",  '  +
 '   				"colspan": 1  '  +
 '   			}, {  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "21.816,28",  '  +
 '   				"colspan": 1  '  +
 '   			}, {  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "2.090,12 1670,00",  '  +
 '   				"colspan": 2  '  +
 '   			}, {  '  +
 '   				"align": "right",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "22.236,40",  '  +
 '   				"colspan": 2  '  +
 '   			}], [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "Banco do Brasil",  '  +
 '   				"colspan": 1  '  +
 '   			}, {  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "21.816,28",  '  +
 '   				"colspan": 1  '  +
 '   			}, {  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "2.090,12 1670,00",  '  +
 '   				"colspan": 2  '  +
 '   			}, {  '  +
 '   				"align": "right",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "22.236,40",  '  +
 '   				"colspan": 2  '  +
 '   			}], [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": " ",  '  +
 '   				"colspan": 2  '  +
 '   			}, {  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "(Bancos + Caixa)R$ 22.236,40",  '  +
 '   				"colspan": 2  '  +
 '   			}]] } , {  '  +
 '   			"rows": [[{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#DC143C",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "Contas a Receber",  '  +
 '   				"colspan": 4  '  +
 '   			}], [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "Contas a Receber até 30/09/2017",  '  +
 '   				"colspan": 3  '  +
 '   			}, {  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "R$ 2.271,27",  '  +
 '   				"colspan": 1  '  +
 '   			}],  [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "Contas a Receber no Período de 01/10/17 até 30/10/2017",  '  +
 '   				"colspan": 3  '  +
 '   			}, {  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "R$ 549,31",  '  +
 '   				"colspan": 1  '  +
 '   			}], [{  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "normal",  '  +
 '   				"text": "Total de Contas a Receber",  '  +
 '   				"colspan": 3  '  +
 '   			}, {  '  +
 '   				"align": "left",  '  +
 '   				"color": "#000000",  '  +
 '   				"style": "bold",  '  +
 '   				"text": "R$ 2.820,58",  '  +
 '   				"colspan": 1  '  +
 '   			}]]  '  +
 '   		}]  '  +
 '   	}]  '  +
 '  }  ' ;

  PaymentParams := CreateRequestParams( [ 'id='+Id ] ).Text;
  Result := ExecuteGerenciaNetRequest( 'createChargeBalanceSheet',PaymentParams,'',Body );
end;

end.
