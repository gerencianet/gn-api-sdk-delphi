unit uCommonTypes;

interface
  {$IFDEF UNICODE}
uses XSuperObject, XSuperJSON;

type
  TShipping = class
  private
    FName: string;
    FValue: Integer;
    FPayeeCode: string;
    procedure SetName(const Value: string);
    procedure SetPayeeCode(const Value: string);
    procedure SetValue(const Value: Integer);
  public
    [Alias('name')]
    property Name: string read FName write SetName;
    [Alias('value')]
    property Value: Integer read FValue write SetValue;
    [Alias('payee_code')]
    property PayeeCode: string read FPayeeCode write SetPayeeCode;
  end;

  TAddress = record
    [Alias('street')]
    Street: string;
    [Alias('number')]
    Number: string;
    [Alias('neighborhood')]
    Neighborhood: string;
    [Alias('complement')]
    Complement: string;
    [Alias('city')]
    City: string;
    [Alias('state')]
    State: string;
    [Alias('zipcode')]
    ZipCode: string;
  end;

  TMetadata = class
  private
    FNotificationURL: string;
    FCustomID: string;
    procedure SetCustomID(const Value: string);
    procedure SetNotificationURL(const Value: string);
  public
    [Alias('custom_id')]
    property CustomID: string read FCustomID write SetCustomID;
    [Alias('notification_url')]
    property NotificationURL: string read FNotificationURL
      write SetNotificationURL;
  end;

  TDiscount = record
    [Alias('discount_type')]
    DiscountType: string;
    [Alias('value')]
    Value: Integer;
  end;

  TGerenciaResponse = class
  public
    class function ExtractObject( AJson: String;ObjectID: String ) : String;
    class function NormalizeDate( ADate: TDateTime ) : String;overload;
    class function NormalizeDate( AYear, AMonth, ADay : Word ) : String;overload;
    class function NormalizeBoolean( ABoolean : Boolean ) : String;
  end;
                  {$ENDIF}
implementation

uses SysUtils;
  {$IFDEF UNICODE}
procedure TShipping.SetName(const Value: string);
begin
  FName := Value;
end;

procedure TShipping.SetPayeeCode(const Value: string);
begin
  FPayeeCode := Value;
end;

procedure TShipping.SetValue(const Value: Integer);
begin
  FValue := Value;
end;

procedure TMetadata.SetCustomID(const Value: string);
begin
  FCustomID := Value;
end;

procedure TMetadata.SetNotificationURL(const Value: string);
begin
  FNotificationURL := Value;
end;

{ TGerenciaResponse }

class function TGerenciaResponse.ExtractObject(AJson, ObjectID: String): String;
var JsonObject : ISuperObject;
begin
  JsonObject := SO( AJson );
  Result := JsonObject.O[ ObjectID ].AsJSON;
end;

class function TGerenciaResponse.NormalizeDate(ADate: TDateTime): String;
begin
  Result := FormatDateTime( 'yyyy-mm-dd',ADate );
end;

class function TGerenciaResponse.NormalizeBoolean(ABoolean: Boolean): String;
begin
  Result := LowerCase( BoolToStr( ABoolean,True ) );
end;

class function TGerenciaResponse.NormalizeDate(AYear, AMonth,
  ADay: Word): String;
begin
  Result := NormalizeDate( EncodeDate( AYear,AMonth, ADay ) );
end;
   {$ENDIF}
end.
