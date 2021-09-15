unit uCustomerClasses;

interface
     {$IFDEF UNICODE}
uses ucommontypes , xSuperObject, xSuperJSON;

Type

  TBaseCustomer = class
  private
    FName: String;
    FCPF: String;
    procedure SetCPF(const Value: String);
    procedure SetName(const Value: String);
  public
    [Alias('name')]
    property Name: String read FName write SetName;
    [Alias('cpf')]
    property CPF: String read FCPF write SetCPF;
  end;

  TCustomerClass = class of TBaseCustomer;

  TPrivateCustomer = class( TBaseCustomer )
  private
    FPhoneNumber: String;
    FEmail: String;
    FAddress: TAddress;
    FBirth: String;
    procedure SetAddress(const Value: TAddress);
    procedure SetBirth(const Value: String);
    procedure SetEmail(const Value: String);
    procedure SetPhoneNumber(const Value: String);
  public
    [Alias('email')]
    property Email: String read FEmail write SetEmail;
    [Alias('phone_number')]
    property PhoneNumber: String read FPhoneNumber write SetPhoneNumber;
    [Alias('birth')]
    property Birth: String read FBirth write SetBirth;
    [Alias('address')]
    property Address: TAddress read FAddress write SetAddress;
  end;

  TPrivateCustomerCreditCard = class( TBaseCustomer )
  private
    FPhoneNumber: String;
    FEmail: String;
    FBirth: String;
    procedure SetBirth(const Value: String);
    procedure SetEmail(const Value: String);
    procedure SetPhoneNumber(const Value: String);
  public
    [Alias('email')]
    property Email: String read FEmail write SetEmail;
    [Alias('phone_number')]
    property PhoneNumber: String read FPhoneNumber write SetPhoneNumber;
    [Alias('birth')]
    property Birth: String read FBirth write SetBirth;
  end;

  TJuridicalPerson = record
    [Alias('corporate_name')]
    CorporateName: String;
    [Alias('cnpj')]
    CNPJ: String;
  end;

  TCorporateCustomer = class( TBaseCustomer )
  private
    FJuridical_Person: TJuridicalPerson;
    procedure SetJuridical_Person(const Value: TJuridicalPerson);
  public
    [Alias('juridical_person')]
    property Juridical_Person: TJuridicalPerson read FJuridical_Person write SetJuridical_Person;
  end;

 {$ENDIF}
implementation

{ TBaseCustomer }
 {$IFDEF UNICODE}
procedure TBaseCustomer.SetCPF(const Value: String);
begin
  FCPF := Value;
end;

procedure TBaseCustomer.SetName(const Value: String);
begin
  FName := Value;
end;

{ TPrivateCustomer }

procedure TPrivateCustomer.SetAddress(const Value: TAddress);
begin
  FAddress := Value;
end;

procedure TPrivateCustomer.SetBirth(const Value: String);
begin
  FBirth := Value;
end;

procedure TPrivateCustomer.SetEmail(const Value: String);
begin
  FEmail := Value;
end;

procedure TPrivateCustomer.SetPhoneNumber(const Value: String);
begin
  FPhoneNumber := Value;
end;

{ TCorporateCustomer }

procedure TCorporateCustomer.SetJuridical_Person(const Value: TJuridicalPerson);
begin
  FJuridical_Person := Value;
end;
  {$ENDIF}
{ TPrivateCustomerCreditCard }

procedure TPrivateCustomerCreditCard.SetBirth(const Value: String);
begin
  FBirth := Value;
end;

procedure TPrivateCustomerCreditCard.SetEmail(const Value: String);
begin
  FEmail := Value;
end;

procedure TPrivateCustomerCreditCard.SetPhoneNumber(const Value: String);
begin
  FPhoneNumber := Value;
end;

end.
