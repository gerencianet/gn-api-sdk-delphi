unit PrivateKey;

interface

type

HCkPublicKey = Pointer;
HCkBinData = Pointer;
HCkPrivateKey = Pointer;
HCkByteData = Pointer;
HCkString = Pointer;
HCkStringBuilder = Pointer;


function CkPrivateKey_Create: HCkPrivateKey; stdcall;
procedure CkPrivateKey_Dispose(handle: HCkPrivateKey); stdcall;
function CkPrivateKey_getBitLength(objHandle: HCkPrivateKey): Integer; stdcall;

procedure CkPrivateKey_getDebugLogFilePath(objHandle: HCkPrivateKey; outPropVal: HCkString); stdcall;

procedure CkPrivateKey_putDebugLogFilePath(objHandle: HCkPrivateKey; newPropVal: PWideChar); stdcall;

function CkPrivateKey__debugLogFilePath(objHandle: HCkPrivateKey): PWideChar; stdcall;

procedure CkPrivateKey_getKeyType(objHandle: HCkPrivateKey; outPropVal: HCkString); stdcall;

function CkPrivateKey__keyType(objHandle: HCkPrivateKey): PWideChar; stdcall;

procedure CkPrivateKey_getLastErrorHtml(objHandle: HCkPrivateKey; outPropVal: HCkString); stdcall;

function CkPrivateKey__lastErrorHtml(objHandle: HCkPrivateKey): PWideChar; stdcall;

procedure CkPrivateKey_getLastErrorText(objHandle: HCkPrivateKey; outPropVal: HCkString); stdcall;

function CkPrivateKey__lastErrorText(objHandle: HCkPrivateKey): PWideChar; stdcall;

procedure CkPrivateKey_getLastErrorXml(objHandle: HCkPrivateKey; outPropVal: HCkString); stdcall;

function CkPrivateKey__lastErrorXml(objHandle: HCkPrivateKey): PWideChar; stdcall;

function CkPrivateKey_getLastMethodSuccess(objHandle: HCkPrivateKey): wordbool; stdcall;

procedure CkPrivateKey_putLastMethodSuccess(objHandle: HCkPrivateKey; newPropVal: wordbool); stdcall;

procedure CkPrivateKey_getPkcs8EncryptAlg(objHandle: HCkPrivateKey; outPropVal: HCkString); stdcall;

procedure CkPrivateKey_putPkcs8EncryptAlg(objHandle: HCkPrivateKey; newPropVal: PWideChar); stdcall;

function CkPrivateKey__pkcs8EncryptAlg(objHandle: HCkPrivateKey): PWideChar; stdcall;

function CkPrivateKey_getVerboseLogging(objHandle: HCkPrivateKey): wordbool; stdcall;

procedure CkPrivateKey_putVerboseLogging(objHandle: HCkPrivateKey; newPropVal: wordbool); stdcall;

procedure CkPrivateKey_getVersion(objHandle: HCkPrivateKey; outPropVal: HCkString); stdcall;

function CkPrivateKey__version(objHandle: HCkPrivateKey): PWideChar; stdcall;

function CkPrivateKey_GetJwk(objHandle: HCkPrivateKey; outStr: HCkString): wordbool; stdcall;

function CkPrivateKey__getJwk(objHandle: HCkPrivateKey): PWideChar; stdcall;

function CkPrivateKey_GetJwkThumbprint(objHandle: HCkPrivateKey; hashAlg: PWideChar; outStr: HCkString): wordbool; stdcall;

function CkPrivateKey__getJwkThumbprint(objHandle: HCkPrivateKey; hashAlg: PWideChar): PWideChar; stdcall;

function CkPrivateKey_GetPkcs1(objHandle: HCkPrivateKey; outData: HCkByteData): wordbool; stdcall;

function CkPrivateKey_GetPkcs1ENC(objHandle: HCkPrivateKey; encoding: PWideChar; outStr: HCkString): wordbool; stdcall;

function CkPrivateKey__getPkcs1ENC(objHandle: HCkPrivateKey; encoding: PWideChar): PWideChar; stdcall;

function CkPrivateKey_GetPkcs1Pem(objHandle: HCkPrivateKey; outStr: HCkString): wordbool; stdcall;

function CkPrivateKey__getPkcs1Pem(objHandle: HCkPrivateKey): PWideChar; stdcall;

function CkPrivateKey_GetPkcs8(objHandle: HCkPrivateKey; outData: HCkByteData): wordbool; stdcall;

function CkPrivateKey_GetPkcs8ENC(objHandle: HCkPrivateKey; encoding: PWideChar; outStr: HCkString): wordbool; stdcall;

function CkPrivateKey__getPkcs8ENC(objHandle: HCkPrivateKey; encoding: PWideChar): PWideChar; stdcall;

function CkPrivateKey_GetPkcs8Encrypted(objHandle: HCkPrivateKey; password: PWideChar; outData: HCkByteData): wordbool; stdcall;

function CkPrivateKey_GetPkcs8EncryptedENC(objHandle: HCkPrivateKey; encoding: PWideChar; password: PWideChar; outStr: HCkString): wordbool; stdcall;

function CkPrivateKey__getPkcs8EncryptedENC(objHandle: HCkPrivateKey; encoding: PWideChar; password: PWideChar): PWideChar; stdcall;

function CkPrivateKey_GetPkcs8EncryptedPem(objHandle: HCkPrivateKey; password: PWideChar; outStr: HCkString): wordbool; stdcall;

function CkPrivateKey__getPkcs8EncryptedPem(objHandle: HCkPrivateKey; password: PWideChar): PWideChar; stdcall;

function CkPrivateKey_GetPkcs8Pem(objHandle: HCkPrivateKey; outStr: HCkString): wordbool; stdcall;

function CkPrivateKey__getPkcs8Pem(objHandle: HCkPrivateKey): PWideChar; stdcall;

function CkPrivateKey_GetPublicKey(objHandle: HCkPrivateKey): HCkPublicKey; stdcall;

function CkPrivateKey_GetRawHex(objHandle: HCkPrivateKey; pubKey: HCkStringBuilder; outStr: HCkString): wordbool; stdcall;

function CkPrivateKey__getRawHex(objHandle: HCkPrivateKey; pubKey: HCkStringBuilder): PWideChar; stdcall;

function CkPrivateKey_GetRsaDer(objHandle: HCkPrivateKey; outData: HCkByteData): wordbool; stdcall;

function CkPrivateKey_GetRsaPem(objHandle: HCkPrivateKey; outStr: HCkString): wordbool; stdcall;

function CkPrivateKey__getRsaPem(objHandle: HCkPrivateKey): PWideChar; stdcall;

function CkPrivateKey_GetXml(objHandle: HCkPrivateKey; outStr: HCkString): wordbool; stdcall;

function CkPrivateKey__getXml(objHandle: HCkPrivateKey): PWideChar; stdcall;

function CkPrivateKey_LoadAnyFormat(objHandle: HCkPrivateKey; privKeyData: HCkBinData; password: PWideChar): wordbool; stdcall;

function CkPrivateKey_LoadAnyFormatFile(objHandle: HCkPrivateKey; path: PWideChar; password: PWideChar): wordbool; stdcall;

function CkPrivateKey_LoadEd25519(objHandle: HCkPrivateKey; privKey: PWideChar; pubKey: PWideChar): wordbool; stdcall;

function CkPrivateKey_LoadEncryptedPem(objHandle: HCkPrivateKey; pemStr: PWideChar; password: PWideChar): wordbool; stdcall;

function CkPrivateKey_LoadEncryptedPemFile(objHandle: HCkPrivateKey; path: PWideChar; password: PWideChar): wordbool; stdcall;

function CkPrivateKey_LoadJwk(objHandle: HCkPrivateKey; jsonStr: PWideChar): wordbool; stdcall;

function CkPrivateKey_LoadPem(objHandle: HCkPrivateKey; str: PWideChar): wordbool; stdcall;

function CkPrivateKey_LoadPemFile(objHandle: HCkPrivateKey; path: PWideChar): wordbool; stdcall;

function CkPrivateKey_LoadPkcs1(objHandle: HCkPrivateKey; data: HCkByteData): wordbool; stdcall;

function CkPrivateKey_LoadPkcs1File(objHandle: HCkPrivateKey; path: PWideChar): wordbool; stdcall;

function CkPrivateKey_LoadPkcs8(objHandle: HCkPrivateKey; data: HCkByteData): wordbool; stdcall;

function CkPrivateKey_LoadPkcs8Encrypted(objHandle: HCkPrivateKey; data: HCkByteData; password: PWideChar): wordbool; stdcall;

function CkPrivateKey_LoadPkcs8EncryptedFile(objHandle: HCkPrivateKey; path: PWideChar; password: PWideChar): wordbool; stdcall;

function CkPrivateKey_LoadPkcs8File(objHandle: HCkPrivateKey; path: PWideChar): wordbool; stdcall;

function CkPrivateKey_LoadPvk(objHandle: HCkPrivateKey; data: HCkByteData; password: PWideChar): wordbool; stdcall;

function CkPrivateKey_LoadPvkFile(objHandle: HCkPrivateKey; path: PWideChar; password: PWideChar): wordbool; stdcall;

function CkPrivateKey_LoadRsaDer(objHandle: HCkPrivateKey; data: HCkByteData): wordbool; stdcall;

function CkPrivateKey_LoadRsaDerFile(objHandle: HCkPrivateKey; path: PWideChar): wordbool; stdcall;

function CkPrivateKey_LoadXml(objHandle: HCkPrivateKey; xml: PWideChar): wordbool; stdcall;

function CkPrivateKey_LoadXmlFile(objHandle: HCkPrivateKey; path: PWideChar): wordbool; stdcall;

function CkPrivateKey_SaveLastError(objHandle: HCkPrivateKey; path: PWideChar): wordbool; stdcall;

function CkPrivateKey_SavePemFile(objHandle: HCkPrivateKey; path: PWideChar): wordbool; stdcall;

function CkPrivateKey_SavePkcs1File(objHandle: HCkPrivateKey; path: PWideChar): wordbool; stdcall;

function CkPrivateKey_SavePkcs8EncryptedFile(objHandle: HCkPrivateKey; password: PWideChar; path: PWideChar): wordbool; stdcall;

function CkPrivateKey_SavePkcs8EncryptedPemFile(objHandle: HCkPrivateKey; password: PWideChar; path: PWideChar): wordbool; stdcall;

function CkPrivateKey_SavePkcs8File(objHandle: HCkPrivateKey; path: PWideChar): wordbool; stdcall;

function CkPrivateKey_SavePkcs8PemFile(objHandle: HCkPrivateKey; path: PWideChar): wordbool; stdcall;

function CkPrivateKey_SaveRsaDerFile(objHandle: HCkPrivateKey; path: PWideChar): wordbool; stdcall;

function CkPrivateKey_SaveRsaPemFile(objHandle: HCkPrivateKey; path: PWideChar): wordbool; stdcall;

function CkPrivateKey_SaveXmlFile(objHandle: HCkPrivateKey; path: PWideChar): wordbool; stdcall;

implementation

{$Include chilkatDllPath.inc}

function CkPrivateKey_Create; external DLLName;
procedure CkPrivateKey_Dispose; external DLLName;
function CkPrivateKey_getBitLength; external DLLName;
procedure CkPrivateKey_getDebugLogFilePath; external DLLName;
procedure CkPrivateKey_putDebugLogFilePath; external DLLName;
function CkPrivateKey__debugLogFilePath; external DLLName;
procedure CkPrivateKey_getKeyType; external DLLName;
function CkPrivateKey__keyType; external DLLName;
procedure CkPrivateKey_getLastErrorHtml; external DLLName;
function CkPrivateKey__lastErrorHtml; external DLLName;
procedure CkPrivateKey_getLastErrorText; external DLLName;
function CkPrivateKey__lastErrorText; external DLLName;
procedure CkPrivateKey_getLastErrorXml; external DLLName;
function CkPrivateKey__lastErrorXml; external DLLName;
function CkPrivateKey_getLastMethodSuccess; external DLLName;
procedure CkPrivateKey_putLastMethodSuccess; external DLLName;
procedure CkPrivateKey_getPkcs8EncryptAlg; external DLLName;
procedure CkPrivateKey_putPkcs8EncryptAlg; external DLLName;
function CkPrivateKey__pkcs8EncryptAlg; external DLLName;
function CkPrivateKey_getVerboseLogging; external DLLName;
procedure CkPrivateKey_putVerboseLogging; external DLLName;
procedure CkPrivateKey_getVersion; external DLLName;
function CkPrivateKey__version; external DLLName;
function CkPrivateKey_GetJwk; external DLLName;
function CkPrivateKey__getJwk; external DLLName;
function CkPrivateKey_GetJwkThumbprint; external DLLName;
function CkPrivateKey__getJwkThumbprint; external DLLName;
function CkPrivateKey_GetPkcs1; external DLLName;
function CkPrivateKey_GetPkcs1ENC; external DLLName;
function CkPrivateKey__getPkcs1ENC; external DLLName;
function CkPrivateKey_GetPkcs1Pem; external DLLName;
function CkPrivateKey__getPkcs1Pem; external DLLName;
function CkPrivateKey_GetPkcs8; external DLLName;
function CkPrivateKey_GetPkcs8ENC; external DLLName;
function CkPrivateKey__getPkcs8ENC; external DLLName;
function CkPrivateKey_GetPkcs8Encrypted; external DLLName;
function CkPrivateKey_GetPkcs8EncryptedENC; external DLLName;
function CkPrivateKey__getPkcs8EncryptedENC; external DLLName;
function CkPrivateKey_GetPkcs8EncryptedPem; external DLLName;
function CkPrivateKey__getPkcs8EncryptedPem; external DLLName;
function CkPrivateKey_GetPkcs8Pem; external DLLName;
function CkPrivateKey__getPkcs8Pem; external DLLName;
function CkPrivateKey_GetPublicKey; external DLLName;
function CkPrivateKey_GetRawHex; external DLLName;
function CkPrivateKey__getRawHex; external DLLName;
function CkPrivateKey_GetRsaDer; external DLLName;
function CkPrivateKey_GetRsaPem; external DLLName;
function CkPrivateKey__getRsaPem; external DLLName;
function CkPrivateKey_GetXml; external DLLName;
function CkPrivateKey__getXml; external DLLName;
function CkPrivateKey_LoadAnyFormat; external DLLName;
function CkPrivateKey_LoadAnyFormatFile; external DLLName;
function CkPrivateKey_LoadEd25519; external DLLName;
function CkPrivateKey_LoadEncryptedPem; external DLLName;
function CkPrivateKey_LoadEncryptedPemFile; external DLLName;
function CkPrivateKey_LoadJwk; external DLLName;
function CkPrivateKey_LoadPem; external DLLName;
function CkPrivateKey_LoadPemFile; external DLLName;
function CkPrivateKey_LoadPkcs1; external DLLName;
function CkPrivateKey_LoadPkcs1File; external DLLName;
function CkPrivateKey_LoadPkcs8; external DLLName;
function CkPrivateKey_LoadPkcs8Encrypted; external DLLName;
function CkPrivateKey_LoadPkcs8EncryptedFile; external DLLName;
function CkPrivateKey_LoadPkcs8File; external DLLName;
function CkPrivateKey_LoadPvk; external DLLName;
function CkPrivateKey_LoadPvkFile; external DLLName;
function CkPrivateKey_LoadRsaDer; external DLLName;
function CkPrivateKey_LoadRsaDerFile; external DLLName;
function CkPrivateKey_LoadXml; external DLLName;
function CkPrivateKey_LoadXmlFile; external DLLName;
function CkPrivateKey_SaveLastError; external DLLName;
function CkPrivateKey_SavePemFile; external DLLName;
function CkPrivateKey_SavePkcs1File; external DLLName;
function CkPrivateKey_SavePkcs8EncryptedFile; external DLLName;
function CkPrivateKey_SavePkcs8EncryptedPemFile; external DLLName;
function CkPrivateKey_SavePkcs8File; external DLLName;
function CkPrivateKey_SavePkcs8PemFile; external DLLName;
function CkPrivateKey_SaveRsaDerFile; external DLLName;
function CkPrivateKey_SaveRsaPemFile; external DLLName;
function CkPrivateKey_SaveXmlFile; external DLLName;



end.
