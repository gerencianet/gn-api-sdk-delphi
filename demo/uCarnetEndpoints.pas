unit uCarnetEndpoints;

interface

uses
Windows,SysUtils, Variants, Classes, Contnrs,
  IdBaseComponent, IdIntercept{$IFDEF UNICODE}, IdInterceptSimLog {$ENDIF}, uCommonTypes, ComCtrls;

function CancelCarnet(CarnetID: String): String;
function CancelParcel(CarnetID, CarnetParcel:  String): String;
function CarnetCreate: String;
function DetailCarnet(CarnetID: String): String;
function UpdateParcel(CarnetID, CarnetParcel:  String): String;
function UpdateCarnetMetadata(CarnetID: String): String;
function ResendCarnet(CarnetID: String): String;
function ResendParcel(CarnetID, CarnetParcel:  String): String;
function CreateCarnetHistory(CarnetID: String): String;

implementation

uses
 {$IFDEF UNICODE}
 uCarnetClasses, DateUtils,   {$IFDEF UNICODE}XSuperObject,{$ENDIF}
 {$ENDIF}
 uGerenciaNetClientUtilities, 
 uGerenciaClient;

function CancelCarnet(CarnetID: String): String;
var
  CancelParams: String;
begin
    CancelParams := CreateRequestParams( [ 'id='+CarnetID ] ).Text;
    Result := ExecuteGerenciaNetRequest( 'cancelCarnet',CancelParams, '', '' );
end;

function CancelParcel(CarnetID, CarnetParcel:  String): String;
var
  CancelParams: String;
begin
    CancelParams := CreateRequestParams( [ 'id='+CarnetID, 'parcel='+CarnetParcel ] ).Text;
    Result := ExecuteGerenciaNetRequest( 'cancelParcel',CancelParams, '', '' );
end;

function UpdateParcel(CarnetID, CarnetParcel:  String): String;
var
  Body : String;
  UpdateParcelParams : String;
begin
    UpdateParcelParams := CreateRequestParams( [ 'id='+CarnetID, 'parcel='+CarnetParcel ] ).Text;
    Body := '{"expire_at": "2018-01-01"}';
    Result := ExecuteGerenciaNetRequest( 'updateParcel',UpdateParcelParams, '', Body );
end;

function UpdateCarnetMetadata(CarnetID: String): String;
var
  Body : String;
  UpdateParcelParams : String;
begin
    UpdateParcelParams := CreateRequestParams( [ 'id='+CarnetID ] ).Text;
    Body := '{"custom_id": "Carnet 0001", "notification_url" : "http://domain.com/notification"}';
    Result := ExecuteGerenciaNetRequest( 'updateCarnetMetadata',UpdateParcelParams, '', Body );
end;

function ResendCarnet(CarnetID: String): String;
var
  Body : String;
  UpdateParcelParams : String;
begin
    UpdateParcelParams := CreateRequestParams( [ 'id='+CarnetID ] ).Text;
    Body := '{"email": "oldbuck@gerencianet.com.br"}';
    Result := ExecuteGerenciaNetRequest( 'resendCarnet',UpdateParcelParams, '', Body );
end;

function ResendParcel(CarnetID, CarnetParcel:  String): String;
var
  Body : String;
  UpdateParcelParams : String;
begin
    UpdateParcelParams := CreateRequestParams( [ 'id='+CarnetID, 'parcel='+CarnetParcel ] ).Text;
    Body := '{"email": "oldbuck@gerencianet.com.br"}';
    Result := ExecuteGerenciaNetRequest( 'resendParcel',UpdateParcelParams, '', Body );
end;

function CreateCarnetHistory(CarnetID: String): String;
var
  Body : String;
  UpdateParcelParams : String;
begin
    UpdateParcelParams := CreateRequestParams( [ 'id='+CarnetID ] ).Text;
    Body := '{"description": "This carnet is about a service"}';
    Result := ExecuteGerenciaNetRequest( 'createCarnetHistory',UpdateParcelParams, '', Body );
end;


function DetailCarnet(CarnetID: String): String;
var
  DetailParams: String;
begin
    DetailParams := CreateRequestParams( [ 'id='+CarnetID ] ).Text;
    Result := ExecuteGerenciaNetRequest( 'detailCarnet',DetailParams, '', '' );
end;

function CarnetCreate: String;
{$IFDEF UNICODE}
var Carnet : TPrivateCarnet;
FAddress: TAddress;
{$ELSE}

const
      Body_Customer_Address = '"street": "Via Monte di Dio",       "number": 66,       "neighborhood": "Sao Paulo",       "complement": "",       "city": "Naples",       "state": "SP",       "zipcode": "35400000"';
      Body_Customer_Before_Address = '"email": "Gorbaboc.Oldbuck@email.com",     "phone_number": "5144916523",     "birth": "1977-07-17",';
      Body_Customer_After_Address = '"name": "Gorbadoc Oldbuck",     "cpf": "04267484171"';
      Body_Customer = '"customer": { '+Body_Customer_Before_Address + '"address": {  '+ Body_Customer_Address + ' }, '+Body_Customer_After_Address + ' }, ';
      Body_After_Customer_Line1 = '"expire_at": "2017-07-10",   "repeats": 4,   "split_items": false,';
      Body_Instructions = '"instructions": [     "inst1",     "inst2",     "inst3",     "inst4"   ], ';
      Body_Items = ' "items": [     {       "name": "Item 1",       "value": 1900,       "amount": 2     },     {       "name": "Item 2",       "value": 3000,       "amount": 1     }   ] ';
      Body = '{ '+Body_Customer + Body_After_Customer_Line1 + Body_Instructions + Body_Items + ' }';
{$ENDIF}
begin
  {$IFDEF UNICODE}
  FAddress.Street := 'Via Monte di Dio';
  FAddress.Number := 66;
  FAddress.City := 'Naples';
  FAddress.State := 'SP';
  FAddress.ZipCode := '35400000';
  FAddress.Neighborhood := 'Sao Paulo';
  Carnet := TPrivateCarnet.Create( 2 );
  Carnet.Items[ 0 ].Name := 'Item 1';
  Carnet.Items[ 0 ].Value := 1900;
  Carnet.Items[ 0 ].Quantity := 2;
  Carnet.Items[ 1 ].Name := 'Item 2';
  Carnet.Items[ 1 ].Value := 3000;
  Carnet.Items[ 1 ].Quantity := 1;
  Carnet.ExpireAt := TGerenciaResponse.NormalizeDate( Today + 180 );
  Carnet.Repeats := 4;
  Carnet.Customer.Name := 'Gorbadoc Oldbuck';
  Carnet.Customer.Address := FAddress;
  Carnet.Customer.CPF := '04267484171';
  Carnet.Customer.Email := 'Gorbaboc.Oldbuck@email.com';
  Carnet.Customer.PhoneNumber := '5144916523';
  Carnet.Customer.Birth := FormatDateTime( 'yyyy-mm-dd',EncodeDate( 1977,7,17 ) );
  Carnet.SplitItems := False;
  Carnet.Instructions[0] :=  'inst1';
  Carnet.Instructions[1] :=  'inst2';
  Carnet.Instructions[2] :=  'inst3';
  Carnet.Instructions[3] :=  'inst4';
  Result := ExecuteGerenciaNetRequest( 'createCarnet','','',Carnet.AsJSON );
  {$ELSE}
    Result := ExecuteGerenciaNetRequest( 'createCarnet','','',Body );
  {$ENDIF}
end;

end.
