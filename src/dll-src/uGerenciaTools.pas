unit uGerenciaTools;

interface

uses Classes, idHttp, Generics.Collections, Generics.Defaults;

Type

  THttpMethod = ( hmGet,hmPost,hmPut,hmDelete );

  TGerenciaConfigLookup = class
  private
    FLookup : TDictionary<string,THttpMethod>;
    function GetMethodString(Index: String): THttpMethod;
  public
    constructor Create;
    destructor Destroy; override;
    property MethodString[ Index : String ] : THttpMethod read GetMethodString;
  end;

  TGerenciaConfigItem = record
    EndPoint: String;
    Method : THttpMethod;
  end;

  TGerenciaConfig = class
  private
    FFileName : String;
    FEndPointsConfig: TDictionary<string,TGerenciaConfigItem>;
    FGerenciaConfigLookup : TGerenciaConfigLookup;
    function GetEndPoint(Index: String): TGerenciaConfigItem;
  protected
    procedure LoadFile;
  public
    constructor Create( AFileName: String );
    destructor Destroy; override;
    property EndPoint[ Index: String ] : TGerenciaConfigItem read GetEndPoint;
  end;

  TUrlResolver = class
  public
    class function ResolveURLParameters( Url: String;Parameters: TStringList ) : String;
    class function ResolveOptionalParameters( Url: String;Parameters: TStringList ): String;
  end;

function GerenciaConfig( FileName: String = 'config.json' ) : TGerenciaConfig;

implementation

uses SysUtils, XSuperObject, XSuperJson, idURI;

var Config : TGerenciaConfig;

function GerenciaConfig( FileName: String = 'config.json' ) : TGerenciaConfig;
begin
  if Not Assigned( Config ) then
    Config := TGerenciaConfig.Create( FileName );
  Result := Config;
end;

{ TUrlResolver }

class function TUrlResolver.ResolveOptionalParameters(Url: String;
  Parameters: TStringList): String;
var ParamCombo: String;
    UrlChar : Char;
begin
  Result := Url;
  if Parameters.Count = 0 then
    Exit;
  Parameters.StrictDelimiter := True;
  // Make all params separated by a &
  Parameters.Delimiter := '&';
  ParamCombo := Parameters.DelimitedText;
  ParamCombo := TIdURI.ParamsEncode( ParamCombo );
  if Pos( '?',Url ) > 0 then
  begin
    // There are parameters already, so stick the optional ones to the end
    UrlChar := '&';
  end
  else
    // If there are no parameters, then we need to signal that there are some optional ones.
    UrlChar := '?';
  Result := Url + UrlChar + ParamCombo;
end;

class function TUrlResolver.ResolveURLParameters(Url: String;
  Parameters: TStringList): String;
var NameIndex: Integer;
    CurrentParamName,
    CurrentParamValue : String;
begin
  Result := URL;
  for NameIndex := 0 to Parameters.Count -1 do
  begin
    CurrentParamName := Parameters.KeyNames[ NameIndex ];
    CurrentParamValue := Parameters.Values[ CurrentParamName ];
    CurrentParamName := ':'+CurrentParamName;
    Result := StringReplace( Result,CurrentParamName,CurrentParamValue,[rfIgnoreCase] );
  end;
end;

{ TGerenciaConfigLookup }

constructor TGerenciaConfigLookup.Create;
begin
  inherited Create;
  FLookup := TDictionary<string,THttpMethod>.Create;
  FLookup.Add( Id_HTTPMethodGet,hmGet );
  FLookup.Add( Id_HTTPMethodPost,hmPost );
  FLookup.Add( Id_HTTPMethodPut,hmPut );
  FLookup.Add( Id_HTTPMethodDelete,hmDelete );
end;

destructor TGerenciaConfigLookup.Destroy;
begin
  FLookup.Free;
  inherited;
end;

function TGerenciaConfigLookup.GetMethodString(Index: String): THttpMethod;
begin
  Result := FLookup.Items[ UpperCase( Index ) ];
end;

{ TGerenciaConfig }

constructor TGerenciaConfig.Create(AFileName: String);
begin
  inherited Create;
  FFileName := AFileName;
  FGerenciaConfigLookup := TGerenciaConfigLookup.Create;
  FEndPointsConfig := TDictionary<string,TGerenciaConfigItem>.Create;
  LoadFile;
end;

destructor TGerenciaConfig.Destroy;
begin
  FGerenciaConfigLookup.Free;
  FEndPointsConfig.Free;
  inherited;
end;

function TGerenciaConfig.GetEndPoint(Index: String): TGerenciaConfigItem;
begin
  try
    Result := FEndPointsConfig.Items[ Index ];
  except
    on E: Exception do
    begin
      raise Exception.Create('Problem in endpoint');
    end;
  end;
end;

procedure TGerenciaConfig.LoadFile;
var JSOn : ISuperObject;
    EndPoints: ISuperObject;
    JsonItem : ICast;
    ConfigItem : TGerenciaConfigItem;
    SL: TStringList;
begin
  SL := TStringList.Create;
  SL.LoadFromFile( FFileName );
  JSOn := SO( SL.Text );
  EndPoints := Json.O[ 'ENDPOINTS' ];
  for JsonItem in EndPoints do
  begin
    ConfigItem.EndPoint := JsonItem.AsObject.S[ 'route' ];
    ConfigItem.Method := FGerenciaConfigLookup.MethodString[ JsonItem.AsObject.S[ 'method' ] ];
    FEndPointsConfig.Add( JsonItem.Name,ConfigItem );
  end;
  SL.Free;
end;

end.
