Unit uBaseCustomerTransactionClasses;

interface
     {$IFDEF UNICODE}
uses uCustomerClasses;

Type

  TBaseCustomerTransaction = class
  strict private
    FInternalCustomer: TBaseCustomer;
    procedure SetInternalCustomer(const Value: TBaseCustomer);
  strict protected
    function GetCustomerClass: TCustomerClass; virtual;abstract;
    // To publish the right customer, just create a public property of the
    // type you need.
    property InternalCustomer: TBaseCustomer read FInternalCustomer write SetInternalCustomer;
  public
    constructor Create;virtual;
    destructor Destroy; override;
  end;
      {$ENDIF}
implementation

{ TBaseCustomerTransaction }
      {$IFDEF UNICODE}
constructor TBaseCustomerTransaction.Create;
begin
  inherited Create;
  if Not( GetCustomerClass = nil ) then
    InternalCustomer := GetCustomerClass.Create;
end;

destructor TBaseCustomerTransaction.Destroy;
begin
  InternalCustomer.Free;
  inherited;
end;

procedure TBaseCustomerTransaction.SetInternalCustomer(
  const Value: TBaseCustomer);
begin
  FInternalCustomer := Value;
end;
        {$ENDIF}
end.
