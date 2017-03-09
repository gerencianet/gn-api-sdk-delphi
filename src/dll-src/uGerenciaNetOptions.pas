unit uGerenciaNetOptions;

interface

Type

  TGerenciaNetOption = (gnoAutoRecall );
  TGerenciaNetOptions = set of TGerenciaNetOption;

const OPT_AUTO_RECALL = 1;

function GetGerenciaNetOptions( OptionFlags : Integer ) : TGerenciaNetOptions;

implementation

function GetGerenciaNetOptions( OptionFlags : Integer ) : TGerenciaNetOptions;
begin
  Result := [];
  if ( OptionFlags and OPT_AUTO_RECALL ) = OPT_AUTO_RECALL then
    Include( Result,gnoAutoRecall );
end;

end.
