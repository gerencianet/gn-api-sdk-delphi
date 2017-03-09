{$IFDEF FPC}
{$MODE DELPHI}
{$ENDIF}
unit uGerenciaClient;

interface

Type

  TGerenciaChar = {$IFDEF UNICODE} PAnsiChar {$ELSE} PChar {$ENDIF};

  TConfigureService = procedure ( ClientID, ClientSecret,Environment,ConfigFileName,PartnerToken: TGerenciaChar );cdecl;
  TGerenciaNetService = function ( EndPointOperation, Parameters, OptionalParameters, Body: TGerenciaChar ): TGerenciaChar;cdecl;
  TGerenciaNetExpiredToken = function : boolean;cdecl;
  TGerenciaNetGetInstanceData = procedure( out AccessToken: PAnsiChar );cdecl;

var ConfigureService : TConfigureService;
    GerenciaNetService: TGerenciaNetService;
    GerenciaNetExpiredToken: TGerenciaNetExpiredToken;
    GerenciaNetGetInstanceData : TGerenciaNetGetInstanceData;

procedure EnableService( DLLFilePath: String );
procedure DisableService;

implementation

uses SysUtils, Windows;

var DLLHandle : THandle;

procedure EnableService( DLLFilePath: String );
begin
    {$IFDEF UNICODE}
    DLLHandle := LoadLibraryW( PWideChar( DLLFilePath ) );
      if DLLHandle=0 then raise Exception.Create('Error loading GerenciaNet DLL');
    {$ELSE}
    DLLHandle := LoadLibraryA( TGerenciaChar( DLLFilePath ) );
      if DLLHandle=0 then raise Exception.Create('Error loading GerenciaNet DLL');
    {$ENDIF}

  @ConfigureService := GetProcAddress( DLLHandle,'ConfigureService' );
  @GerenciaNetService := GetProcAddress( DLLHandle,'GerenciaNet' );
  @GerenciaNetExpiredToken := GetProcAddress( DLLHandle,'GerenciaNetTokenExpired' );
  @GerenciaNetGetInstanceData := GetProcAddress( DLLHandle,'GerenciaNetGetInstanceData' );
  if Not Assigned( ConfigureService ) then
    raise Exception.Create('Loading error while mapping DLL');
  if Not Assigned( GerenciaNetService ) then
    raise Exception.Create('Loading error while mapping DLL');
  if Not Assigned( GerenciaNetExpiredToken ) then
    raise Exception.Create('Loading error while mapping DLL');
  if Not Assigned( GerenciaNetGetInstanceData ) then
    raise Exception.Create('Loading error while mapping DLL');
end;

procedure DisableService;
begin
  ConfigureService := nil;
  GerenciaNetService := nil;
  FreeLibrary( DLLHandle );
end;

end.
