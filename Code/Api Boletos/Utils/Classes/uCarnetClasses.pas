unit uCarnetClasses;

interface

{$IFDEF UNICODE}
uses uChargeClasses, uCustomerClasses  , XSuperObject, uPaymentClasses;

Type

  TBaseCarnet = class( TBaseCharge )
  public
  end;

  TCarnet = class( TBaseCarnet )
  private
    FSplitItems: Boolean;
    FExpireAt: String;
    FRepeats: Integer;
    FMessage: String;
    FConfigurations: TConfiguration;
    procedure SetExpireAt(const Value: String);
    procedure SetMessage(const Value: String);
    procedure SetRepeats(const Value: Integer);
    procedure SetSplitItems(const Value: Boolean);
    procedure SetConfigurations(const Value: TConfiguration);
  public
    [Alias( 'expire_at' )]
    property ExpireAt: String read FExpireAt write SetExpireAt;
    [Alias( 'repeats' )]
    property Repeats: Integer read FRepeats write SetRepeats;
    [Alias('split_items')]
    property SplitItems: Boolean read FSplitItems write SetSplitItems;
    [Alias( 'message' )]
    property Message: String read FMessage write SetMessage;
    [Alias( 'configurations' )]
    property Configurations: TConfiguration read FConfigurations write SetConfigurations;
  end;

  TPrivateCarnet = class( TCarnet )
  strict private
    FCustomer: TPrivateCustomer;
  public
    constructor Create( ItemCount : Integer ); override;
    destructor Destroy; override;
    [Alias( 'customer' ) ]
    property Customer : TPrivateCustomer read FCustomer;
  end;
{$ENDIF}

implementation

{$IFDEF UNICODE}

procedure TCarnet.SetConfigurations(const Value: TConfiguration);
begin
  FConfigurations := Value;
end;

procedure TCarnet.SetExpireAt(const Value: String);
begin
  FExpireAt := Value;
end;

procedure TCarnet.SetMessage(const Value: String);
begin
  FMessage := Value;
end;

procedure TCarnet.SetRepeats(const Value: Integer);
begin
  FRepeats := Value;
end;

procedure TCarnet.SetSplitItems(const Value: Boolean);
begin
  FSplitItems := Value;
end;

{ TPrivateCarnet }

constructor TPrivateCarnet.Create( ItemCount : Integer );
begin
  inherited Create( ItemCount );
  FCustomer := TPrivateCustomer.Create;
end;

destructor TPrivateCarnet.Destroy;
begin
  FCustomer.Free;
  inherited;
end;

{$ENDIF}
end.
