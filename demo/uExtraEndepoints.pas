unit uExtraEndepoints;

interface

function GetInstallments: String;

implementation

uses
  uGerenciaNetClientUtilities, uGerenciaClient;

function GetInstallments: String;
var
  Params: String;
begin
    Params := CreateRequestParams( [ 'total=20000', 'brand=visa' ] ).Text;
    Result := ExecuteGerenciaNetRequest( 'getInstallments','',Params,'' );
end;

end.
