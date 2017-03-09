unit uCarnetClasses;

interface

{$IFDEF UNICODE}
uses uChargeClasses, uCustomerClasses  , XSuperObject;

Type
  TInstructions = array[1..4] of String;
  TBaseCarnet = class( TBaseCharge )
  public
  end;

  TCarnet = class( TBaseCarnet )
  private
    FSplitItems: Boolean;
    FExpireAt: String;
    FRepeats: Integer;
    FInstructions: TArray<String>;
    procedure SetExpireAt(const Value: String);
    procedure SetInstructions(const Value: TArray<String>);
    procedure SetRepeats(const Value: Integer);
    procedure SetSplitItems(const Value: Boolean);
  public
    procedure AfterConstruction; override;
    [Alias( 'expire_at' )]
    property ExpireAt: String read FExpireAt write SetExpireAt;
    [Alias( 'repeats' )]
    property Repeats: Integer read FRepeats write SetRepeats;
    [Alias('split_items')]
    property SplitItems: Boolean read FSplitItems write SetSplitItems;
    [Alias( 'instructions' )]
    property Instructions: TArray<String> read FInstructions write SetInstructions;
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
procedure TCarnet.SetExpireAt(const Value: String);
begin
  FExpireAt := Value;
end;

procedure TCarnet.SetInstructions(const Value: TArray<String>);
begin
  FInstructions := Value;
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

procedure TCarnet.AfterConstruction;
begin
  inherited;
  SetLength( FInstructions,4 );
end;
{$ENDIF}
end.
