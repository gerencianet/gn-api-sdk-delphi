unit uPaymentClasses;

interface

uses uCustomerClasses, uCommonTypes, uBaseCustomerTransactionClasses  {$IFDEF UNICODE},
     XSuperObject{$ENDIF};

{$IFDEF UNICODE}
Type

  TBasePayment = class( TBaseCustomerTransaction )
  end;

  TPaymentClass = class of TBasePayment;

  // Unfortunately, the JSON data packet does not provide a "payment_type" sort of
  // thing, so basically each payment must directly have an appropriate property
  // which represents the payment type that we want. Thus, we'll do the same
  // sort of thing we did with the customer.
  TBasePaymentType = class
  private
    FInternalPaymentType: TBasePayment;
    procedure SetInternalPaymentType(const Value: TBasePayment);
  strict protected
    function GetPaymentType: TPaymentClass;virtual;abstract;
    property InternalPaymentType : TBasePayment read FInternalPaymentType write SetInternalPaymentType;
  public
    constructor Create;virtual;
    destructor Destroy; override;
  end;

  TConfiguration = record
    [Alias('fine')]
    Fine: Integer;
    [Alias('interest')]
    Interest: Integer;
  end;

  TCardData = record
    [Alias('brand')]
    Brand: String;
    [Alias('number')]
    Number: String;
    CVV: String;
    [Alias('expiration_month')]
    ExpirationMonth: String;
    [Alias('expiration_year')]
    ExpirationYear: String;
    [Alias('salt')]
    Salt: String;
  end;

  TCreditCard = class( TBasePayment )
  private
    FBilling_Address: TAddress;
    procedure SetBilling_Address(const Value: TAddress);
  public
    [Alias('billing_address')]
    property BillingAddress: TAddress read FBilling_Address write SetBilling_Address;
  end;

  TBankBillet = class( TBasePayment )
  private
    FExpireAt: String;
    procedure SetExpireAt(const Value: String);
  public
    [Alias('expire_at')]
    property ExpireAt: String read FExpireAt write SetExpireAt;
  end;

  TBankBilletPrivateCustomer = class( TBankBillet )
  private
    FMessage: String;
    FConfigurations: TConfiguration;
    function GetCustomer: TPrivateCustomer;
    procedure SetCustomer(const Value: TPrivateCustomer);
    procedure SetMessage(const Value: String);
    procedure SetConfigurations(const Value: TConfiguration);
  strict protected
    function GetCustomerClass: TCustomerClass; override;
  public
    [Alias('customer')]
    property Customer : TPrivateCustomer read GetCustomer write SetCustomer;
    [Alias('message')]
    property Message: String read FMessage write SetMessage;
    [Alias( 'configurations' )]
    property Configurations: TConfiguration read FConfigurations write SetConfigurations;
  end;

  TCreditCardPrivateCustomer = class( TCreditCard )
  private
    FPaymentToken: String;
    FInstallments: Integer;
    function GetCustomer: TPrivateCustomerCreditCard;
    procedure SetCustomer(const Value: TPrivateCustomerCreditCard);
    procedure SetPaymentToken(const Value: String);
    procedure SetInstallments(const Value: Integer);
  strict protected
    function GetCustomerClass: TCustomerClass; override;
  public
    [Alias('customer')]
    property Customer : TPrivateCustomerCreditCard read GetCustomer write SetCustomer;
    [Alias('payment_token')]
    property PaymentToken: String read FPaymentToken write SetPaymentToken;
    [Alias('installments')]
    property Installments: Integer read FInstallments write SetInstallments;
  end;

  TCreditCardPayment = class( TBasePaymentType )
  private
    procedure SetCreditCard(const Value: TCreditCardPrivateCustomer);
    function GetCreditCard: TCreditCardPrivateCustomer;
  strict protected
    function GetPaymentType: TPaymentClass; override;
  public
    [Alias('credit_card')]
    property CreditCard: TCreditCardPrivateCustomer read GetCreditCard write SetCreditCard;
  end;

  TBankBilletCorporate = class( TBankBillet )
  private
    function GetCustomer: TCorporateCustomer;
    procedure SetCustomer(const Value: TCorporateCustomer);
  strict protected
    function GetCustomerClass: TCustomerClass; override;
  public
    [Alias('customer')]
    property Customer: TCorporateCustomer read GetCustomer write SetCustomer;
  end;

  TBilletPaymentPrivate = class( TBasePaymentType )
  private
    procedure SetBillet(const Value: TBankBilletPrivateCustomer);
    function GetBillet: TBankBilletPrivateCustomer;
  strict protected
    function GetPaymentType: TPaymentClass; override;
  public
    [Alias('banking_billet')]
    property Billet: TBankBilletPrivateCustomer read GetBillet write SetBillet;
  end;

  TBilletPaymentCorporate = class( TBasePaymentType )
  private
    function GetBillet: TBankBilletCorporate;
    procedure SetBillet(const Value: TBankBilletCorporate);
  strict protected
    function GetPaymentType: TPaymentClass; override;
  public
    [Alias('bank_billet')]
    property Billet: TBankBilletCorporate read GetBillet write SetBillet;
  end;

  TPaymentBase<TPayment: class,constructor> = class
  private
    FPayment: TPayment;
    procedure SetPayment(const Value: TPayment);
  public
    constructor Create;
    destructor Destroy;override;
    [Alias('payment')]
    property Payment : TPayment read FPayment write SetPayment;
  end;

  TPrivateCreditCardPayment = class (TPaymentBase<TCreditCardPayment>)
  end;

  TPrivateBankBilletPayment = class( TPaymentBase<TBilletPaymentPrivate>)
  end;

  TCorporateBankBilletPayment = class( TPaymentBase<TBilletPaymentCorporate>)
  end;

{$ENDIF}
implementation
{$IFDEF UNICODE}
{ TBasePaymentType }

constructor TBasePaymentType.Create;
begin
  inherited Create;
  FInternalPaymentType := GetPaymentType.Create;
end;

destructor TBasePaymentType.Destroy;
begin
  FInternalPaymentType.Free;
  inherited;
end;

procedure TBasePaymentType.SetInternalPaymentType(const Value: TBasePayment);
begin
  FInternalPaymentType := Value;
end;

{ TCreditCard }

procedure TCreditCard.SetBilling_Address(const Value: TAddress);
begin
  FBilling_Address := Value;
end;

{ TBankBillet }

procedure TBankBillet.SetExpireAt(const Value: String);
begin
  FExpireAt := Value;
end;

{ TBankBilletPrivateCustomer }

function TBankBilletPrivateCustomer.GetCustomer: TPrivateCustomer;
begin
  Result := TPrivateCustomer( InternalCustomer );
end;

function TBankBilletPrivateCustomer.GetCustomerClass: TCustomerClass;
begin
  Result := TPrivateCustomer;
end;

procedure TBankBilletPrivateCustomer.SetConfigurations(
  const Value: TConfiguration);
begin
  FConfigurations := Value;
end;

procedure TBankBilletPrivateCustomer.SetCustomer(const Value: TPrivateCustomer);
begin
  InternalCustomer := Value;
end;

procedure TBankBilletPrivateCustomer.SetMessage(const Value: String);
begin
  FMessage := Value;
end;

{ TBankBilletCorporate }

function TBankBilletCorporate.GetCustomer: TCorporateCustomer;
begin
  Result := TCorporateCustomer( InternalCustomer );
end;

function TBankBilletCorporate.GetCustomerClass: TCustomerClass;
begin
  Result := TCorporateCustomer;
end;

procedure TBankBilletCorporate.SetCustomer(const Value: TCorporateCustomer);
begin
  InternalCustomer := Value;
end;

{ TBilletPaymentPrivate }

function TBilletPaymentPrivate.GetBillet: TBankBilletPrivateCustomer;
begin
  Result := TBankBilletPrivateCustomer( InternalPaymentType );
end;

function TBilletPaymentPrivate.GetPaymentType: TPaymentClass;
begin
  Result := TBankBilletPrivateCustomer;
end;

procedure TBilletPaymentPrivate.SetBillet(
  const Value: TBankBilletPrivateCustomer);
begin
  InternalPaymentType := Value;
end;

{ TBilletPaymentCorporate }

function TBilletPaymentCorporate.GetBillet: TBankBilletCorporate;
begin
  Result := TBankBilletCorporate( InternalPaymentType );
end;

function TBilletPaymentCorporate.GetPaymentType: TPaymentClass;
begin
  Result := TBankBilletCorporate;
end;

procedure TBilletPaymentCorporate.SetBillet(const Value: TBankBilletCorporate);
begin
  InternalPaymentType := Value;
end;

{ TPaymentBase<TPayment> }

constructor TPaymentBase<TPayment>.Create;
begin
  inherited Create;
  FPayment := TPayment.Create;
end;

destructor TPaymentBase<TPayment>.Destroy;
begin
  FPayment.Free;
  inherited;
end;

procedure TPaymentBase<TPayment>.SetPayment(const Value: TPayment);
begin
  FPayment := Value;
end;

{ TCreditCardPrivateCustomer }

function TCreditCardPrivateCustomer.GetCustomer: TPrivateCustomerCreditCard;
begin
  Result := TPrivateCustomerCreditCard( InternalCustomer );
end;

function TCreditCardPrivateCustomer.GetCustomerClass: TCustomerClass;
begin
  Result := TPrivateCustomerCreditCard;
end;

procedure TCreditCardPrivateCustomer.SetCustomer(const Value: TPrivateCustomerCreditCard);
begin
  InternalCustomer := Value;
end;

procedure TCreditCardPrivateCustomer.SetInstallments(const Value: Integer);
begin
  FInstallments := Value;
end;

procedure TCreditCardPrivateCustomer.SetPaymentToken(const Value: String);
begin
  FPaymentToken := Value;
end;

{$ENDIF}

{ TCreditCardPayment }

function TCreditCardPayment.GetCreditCard: TCreditCardPrivateCustomer;
begin
  Result := TCreditCardPrivateCustomer( InternalPaymentType );
end;

function TCreditCardPayment.GetPaymentType: TPaymentClass;
begin
  Result := TCreditCardPrivateCustomer;
end;

procedure TCreditCardPayment.SetCreditCard(
  const Value: TCreditCardPrivateCustomer);
begin
  InternalPaymentType := Value;
end;

end.

