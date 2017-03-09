unit uChargeClasses;

interface
                     {$IFDEF UNICODE}
uses uCommonTypes    ,XSuperObject;

Type
  TMarketPlace = packed record
    [Alias('payee_code')]
    PayeeCode: String;
    [Alias('percentage')]
    Percentage: Integer;
  end;

  TItem = class
  private
    FName: String;
    FQuantity: Integer;
    FValue: Integer;
    procedure SetName(const Value: String);
    procedure SetQuantity(const Value: Integer);
    procedure SetValue(const Value: Integer);
  public
    [Alias('name')]
    property Name: String read FName write SetName;
    [Alias('value')]
    property Value: Integer read FValue write SetValue;
    [Alias('amount')]
    property Quantity: Integer read FQuantity write SetQuantity;
  end;

  TBaseCharge = class
  private
    FItems: TArray<TItem>;
    procedure SetItems(const Value: TArray<TItem>);
  public
    // When creating this class, we already know how many items will be in the
    // request, so we allocate enough space for all of them.
    constructor Create( ItemCount : Integer );reintroduce;virtual;
    destructor Destroy; override;
    [Alias('items')]
    property Items: TArray<TItem> read FItems write SetItems;
  end;

  TChargeClass = class of TBaseCharge;
  {$ENDIF}
implementation

{ TItem }
  {$IFDEF UNICODE}
procedure TItem.SetName(const Value: String);
begin
  FName := Value;
end;

procedure TItem.SetQuantity(const Value: Integer);
begin
  FQuantity := Value;
end;

procedure TItem.SetValue(const Value: Integer);
begin
  FValue := Value;
end;

constructor TBaseCharge.Create(ItemCount: Integer);
var Item : TItem;
    Index: Integer;
begin
  inherited Create;
  SetLength( FItems,ItemCount );
  for Index := 0 to ItemCount - 1 do
  begin
    Item := TItem.Create;
    FItems[ Index ] := Item;
  end;
end;

destructor TBaseCharge.Destroy;
var Item: TItem;
begin
  for Item in FItems do
  begin
    Item.Free;
  end;
  SetLength( FItems,0 );
  inherited;
end;

procedure TBaseCharge.SetItems(const Value: TArray<TItem>);
begin
  FItems := Value;
end;
 {$ENDIF}
end.
