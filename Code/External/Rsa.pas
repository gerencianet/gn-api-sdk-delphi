unit Rsa;

interface

type

HCkPublicKey = Pointer;
HCkBinData = Pointer;
HCkPrivateKey = Pointer;
HCkByteData = Pointer;
HCkString = Pointer;
HCkRsa = Pointer;
HCkCert = Pointer;


function CkRsa_Create: HCkRsa; stdcall;
procedure CkRsa_Dispose(handle: HCkRsa); stdcall;
procedure CkRsa_getCharset(objHandle: HCkRsa; outPropVal: HCkString); stdcall;

procedure CkRsa_putCharset(objHandle: HCkRsa; newPropVal: PWideChar); stdcall;

function CkRsa__charset(objHandle: HCkRsa): PWideChar; stdcall;

procedure CkRsa_getDebugLogFilePath(objHandle: HCkRsa; outPropVal: HCkString); stdcall;

procedure CkRsa_putDebugLogFilePath(objHandle: HCkRsa; newPropVal: PWideChar); stdcall;

function CkRsa__debugLogFilePath(objHandle: HCkRsa): PWideChar; stdcall;

procedure CkRsa_getEncodingMode(objHandle: HCkRsa; outPropVal: HCkString); stdcall;

procedure CkRsa_putEncodingMode(objHandle: HCkRsa; newPropVal: PWideChar); stdcall;

function CkRsa__encodingMode(objHandle: HCkRsa): PWideChar; stdcall;

procedure CkRsa_getLastErrorHtml(objHandle: HCkRsa; outPropVal: HCkString); stdcall;

function CkRsa__lastErrorHtml(objHandle: HCkRsa): PWideChar; stdcall;

procedure CkRsa_getLastErrorText(objHandle: HCkRsa; outPropVal: HCkString); stdcall;

function CkRsa__lastErrorText(objHandle: HCkRsa): PWideChar; stdcall;

procedure CkRsa_getLastErrorXml(objHandle: HCkRsa; outPropVal: HCkString); stdcall;

function CkRsa__lastErrorXml(objHandle: HCkRsa): PWideChar; stdcall;

function CkRsa_getLastMethodSuccess(objHandle: HCkRsa): wordbool; stdcall;

procedure CkRsa_putLastMethodSuccess(objHandle: HCkRsa; newPropVal: wordbool); stdcall;

function CkRsa_getLittleEndian(objHandle: HCkRsa): wordbool; stdcall;

procedure CkRsa_putLittleEndian(objHandle: HCkRsa; newPropVal: wordbool); stdcall;

function CkRsa_getNoUnpad(objHandle: HCkRsa): wordbool; stdcall;

procedure CkRsa_putNoUnpad(objHandle: HCkRsa; newPropVal: wordbool); stdcall;

function CkRsa_getNumBits(objHandle: HCkRsa): Integer; stdcall;

procedure CkRsa_getOaepHash(objHandle: HCkRsa; outPropVal: HCkString); stdcall;

procedure CkRsa_putOaepHash(objHandle: HCkRsa; newPropVal: PWideChar); stdcall;

function CkRsa__oaepHash(objHandle: HCkRsa): PWideChar; stdcall;

procedure CkRsa_getOaepMgfHash(objHandle: HCkRsa; outPropVal: HCkString); stdcall;

procedure CkRsa_putOaepMgfHash(objHandle: HCkRsa; newPropVal: PWideChar); stdcall;

function CkRsa__oaepMgfHash(objHandle: HCkRsa): PWideChar; stdcall;

function CkRsa_getOaepPadding(objHandle: HCkRsa): wordbool; stdcall;

procedure CkRsa_putOaepPadding(objHandle: HCkRsa; newPropVal: wordbool); stdcall;

function CkRsa_getPssSaltLen(objHandle: HCkRsa): Integer; stdcall;

procedure CkRsa_putPssSaltLen(objHandle: HCkRsa; newPropVal: Integer); stdcall;

function CkRsa_getVerboseLogging(objHandle: HCkRsa): wordbool; stdcall;

procedure CkRsa_putVerboseLogging(objHandle: HCkRsa; newPropVal: wordbool); stdcall;

procedure CkRsa_getVersion(objHandle: HCkRsa; outPropVal: HCkString); stdcall;

function CkRsa__version(objHandle: HCkRsa): PWideChar; stdcall;

function CkRsa_DecryptBd(objHandle: HCkRsa; bd: HCkBinData; usePrivateKey: wordbool): wordbool; stdcall;

function CkRsa_DecryptBytes(objHandle: HCkRsa; inData: HCkByteData; usePrivateKey: wordbool; outData: HCkByteData): wordbool; stdcall;

function CkRsa_DecryptBytesENC(objHandle: HCkRsa; str: PWideChar; bUsePrivateKey: wordbool; outData: HCkByteData): wordbool; stdcall;

function CkRsa_DecryptString(objHandle: HCkRsa; binarySig: HCkByteData; usePrivateKey: wordbool; outStr: HCkString): wordbool; stdcall;

function CkRsa__decryptString(objHandle: HCkRsa; binarySig: HCkByteData; usePrivateKey: wordbool): PWideChar; stdcall;

function CkRsa_DecryptStringENC(objHandle: HCkRsa; encodedSig: PWideChar; usePrivateKey: wordbool; outStr: HCkString): wordbool; stdcall;

function CkRsa__decryptStringENC(objHandle: HCkRsa; encodedSig: PWideChar; usePrivateKey: wordbool): PWideChar; stdcall;

function CkRsa_EncryptBd(objHandle: HCkRsa; bd: HCkBinData; usePrivateKey: wordbool): wordbool; stdcall;

function CkRsa_EncryptBytes(objHandle: HCkRsa; binaryData: HCkByteData; usePrivateKey: wordbool; outData: HCkByteData): wordbool; stdcall;

function CkRsa_EncryptBytesENC(objHandle: HCkRsa; data: HCkByteData; bUsePrivateKey: wordbool; outStr: HCkString): wordbool; stdcall;

function CkRsa__encryptBytesENC(objHandle: HCkRsa; data: HCkByteData; bUsePrivateKey: wordbool): PWideChar; stdcall;

function CkRsa_EncryptString(objHandle: HCkRsa; stringToEncrypt: PWideChar; usePrivateKey: wordbool; outData: HCkByteData): wordbool; stdcall;

function CkRsa_EncryptStringENC(objHandle: HCkRsa; str: PWideChar; bUsePrivateKey: wordbool; outStr: HCkString): wordbool; stdcall;

function CkRsa__encryptStringENC(objHandle: HCkRsa; str: PWideChar; bUsePrivateKey: wordbool): PWideChar; stdcall;

function CkRsa_ExportPrivateKey(objHandle: HCkRsa; outStr: HCkString): wordbool; stdcall;

function CkRsa__exportPrivateKey(objHandle: HCkRsa): PWideChar; stdcall;

function CkRsa_ExportPrivateKeyObj(objHandle: HCkRsa): HCkPrivateKey; stdcall;

function CkRsa_ExportPublicKey(objHandle: HCkRsa; outStr: HCkString): wordbool; stdcall;

function CkRsa__exportPublicKey(objHandle: HCkRsa): PWideChar; stdcall;

function CkRsa_ExportPublicKeyObj(objHandle: HCkRsa): HCkPublicKey; stdcall;

function CkRsa_GenerateKey(objHandle: HCkRsa; numBits: Integer): wordbool; stdcall;

function CkRsa_ImportPrivateKey(objHandle: HCkRsa; xmlKey: PWideChar): wordbool; stdcall;

function CkRsa_ImportPrivateKeyObj(objHandle: HCkRsa; key: HCkPrivateKey): wordbool; stdcall;

function CkRsa_ImportPublicKey(objHandle: HCkRsa; xmlKey: PWideChar): wordbool; stdcall;

function CkRsa_ImportPublicKeyObj(objHandle: HCkRsa; key: HCkPublicKey): wordbool; stdcall;

function CkRsa_OpenSslSignBd(objHandle: HCkRsa; bd: HCkBinData): wordbool; stdcall;

function CkRsa_OpenSslSignBytes(objHandle: HCkRsa; data: HCkByteData; outData: HCkByteData): wordbool; stdcall;

function CkRsa_OpenSslSignBytesENC(objHandle: HCkRsa; data: HCkByteData; outStr: HCkString): wordbool; stdcall;

function CkRsa__openSslSignBytesENC(objHandle: HCkRsa; data: HCkByteData): PWideChar; stdcall;

function CkRsa_OpenSslSignString(objHandle: HCkRsa; str: PWideChar; outData: HCkByteData): wordbool; stdcall;

function CkRsa_OpenSslSignStringENC(objHandle: HCkRsa; str: PWideChar; outStr: HCkString): wordbool; stdcall;

function CkRsa__openSslSignStringENC(objHandle: HCkRsa; str: PWideChar): PWideChar; stdcall;

function CkRsa_OpenSslVerifyBd(objHandle: HCkRsa; bd: HCkBinData): wordbool; stdcall;

function CkRsa_OpenSslVerifyBytes(objHandle: HCkRsa; signature: HCkByteData; outData: HCkByteData): wordbool; stdcall;

function CkRsa_OpenSslVerifyBytesENC(objHandle: HCkRsa; str: PWideChar; outData: HCkByteData): wordbool; stdcall;

function CkRsa_OpenSslVerifyString(objHandle: HCkRsa; data: HCkByteData; outStr: HCkString): wordbool; stdcall;

function CkRsa__openSslVerifyString(objHandle: HCkRsa; data: HCkByteData): PWideChar; stdcall;

function CkRsa_OpenSslVerifyStringENC(objHandle: HCkRsa; str: PWideChar; outStr: HCkString): wordbool; stdcall;

function CkRsa__openSslVerifyStringENC(objHandle: HCkRsa; str: PWideChar): PWideChar; stdcall;

function CkRsa_SaveLastError(objHandle: HCkRsa; path: PWideChar): wordbool; stdcall;

function CkRsa_SetX509Cert(objHandle: HCkRsa; cert: HCkCert; usePrivateKey: wordbool): wordbool; stdcall;

function CkRsa_SignBd(objHandle: HCkRsa; bdData: HCkBinData; hashAlgorithm: PWideChar; bdSig: HCkBinData): wordbool; stdcall;

function CkRsa_SignBytes(objHandle: HCkRsa; binaryData: HCkByteData; hashAlgorithm: PWideChar; outData: HCkByteData): wordbool; stdcall;

function CkRsa_SignBytesENC(objHandle: HCkRsa; binaryData: HCkByteData; hashAlgorithm: PWideChar; outStr: HCkString): wordbool; stdcall;

function CkRsa__signBytesENC(objHandle: HCkRsa; binaryData: HCkByteData; hashAlgorithm: PWideChar): PWideChar; stdcall;

function CkRsa_SignHash(objHandle: HCkRsa; hashBytes: HCkByteData; hashAlg: PWideChar; outData: HCkByteData): wordbool; stdcall;

function CkRsa_SignHashENC(objHandle: HCkRsa; encodedHash: PWideChar; hashAlg: PWideChar; outStr: HCkString): wordbool; stdcall;

function CkRsa__signHashENC(objHandle: HCkRsa; encodedHash: PWideChar; hashAlg: PWideChar): PWideChar; stdcall;

function CkRsa_SignString(objHandle: HCkRsa; strToBeHashed: PWideChar; hashAlgorithm: PWideChar; outData: HCkByteData): wordbool; stdcall;

function CkRsa_SignStringENC(objHandle: HCkRsa; strToBeHashed: PWideChar; hashAlgorithm: PWideChar; outStr: HCkString): wordbool; stdcall;

function CkRsa__signStringENC(objHandle: HCkRsa; strToBeHashed: PWideChar; hashAlgorithm: PWideChar): PWideChar; stdcall;

function CkRsa_SnkToXml(objHandle: HCkRsa; filename: PWideChar; outStr: HCkString): wordbool; stdcall;

function CkRsa__snkToXml(objHandle: HCkRsa; filename: PWideChar): PWideChar; stdcall;

function CkRsa_UnlockComponent(objHandle: HCkRsa; unlockCode: PWideChar): wordbool; stdcall;

function CkRsa_VerifyBd(objHandle: HCkRsa; bdData: HCkBinData; hashAlgorithm: PWideChar; bdSig: HCkBinData): wordbool; stdcall;

function CkRsa_VerifyBytes(objHandle: HCkRsa; originalData: HCkByteData; hashAlgorithm: PWideChar; signatureBytes: HCkByteData): wordbool; stdcall;

function CkRsa_VerifyBytesENC(objHandle: HCkRsa; originalData: HCkByteData; hashAlgorithm: PWideChar; encodedSig: PWideChar): wordbool; stdcall;

function CkRsa_VerifyHash(objHandle: HCkRsa; hashBytes: HCkByteData; hashAlg: PWideChar; sigBytes: HCkByteData): wordbool; stdcall;

function CkRsa_VerifyHashENC(objHandle: HCkRsa; encodedHash: PWideChar; hashAlg: PWideChar; encodedSig: PWideChar): wordbool; stdcall;

function CkRsa_VerifyPrivateKey(objHandle: HCkRsa; xml: PWideChar): wordbool; stdcall;

function CkRsa_VerifyString(objHandle: HCkRsa; originalString: PWideChar; hashAlgorithm: PWideChar; binarySig: HCkByteData): wordbool; stdcall;

function CkRsa_VerifyStringENC(objHandle: HCkRsa; originalString: PWideChar; hashAlgorithm: PWideChar; encodedSig: PWideChar): wordbool; stdcall;

implementation

{$Include chilkatDllPath.inc}

function CkRsa_Create; external DLLName;
procedure CkRsa_Dispose; external DLLName;
procedure CkRsa_getCharset; external DLLName;
procedure CkRsa_putCharset; external DLLName;
function CkRsa__charset; external DLLName;
procedure CkRsa_getDebugLogFilePath; external DLLName;
procedure CkRsa_putDebugLogFilePath; external DLLName;
function CkRsa__debugLogFilePath; external DLLName;
procedure CkRsa_getEncodingMode; external DLLName;
procedure CkRsa_putEncodingMode; external DLLName;
function CkRsa__encodingMode; external DLLName;
procedure CkRsa_getLastErrorHtml; external DLLName;
function CkRsa__lastErrorHtml; external DLLName;
procedure CkRsa_getLastErrorText; external DLLName;
function CkRsa__lastErrorText; external DLLName;
procedure CkRsa_getLastErrorXml; external DLLName;
function CkRsa__lastErrorXml; external DLLName;
function CkRsa_getLastMethodSuccess; external DLLName;
procedure CkRsa_putLastMethodSuccess; external DLLName;
function CkRsa_getLittleEndian; external DLLName;
procedure CkRsa_putLittleEndian; external DLLName;
function CkRsa_getNoUnpad; external DLLName;
procedure CkRsa_putNoUnpad; external DLLName;
function CkRsa_getNumBits; external DLLName;
procedure CkRsa_getOaepHash; external DLLName;
procedure CkRsa_putOaepHash; external DLLName;
function CkRsa__oaepHash; external DLLName;
procedure CkRsa_getOaepMgfHash; external DLLName;
procedure CkRsa_putOaepMgfHash; external DLLName;
function CkRsa__oaepMgfHash; external DLLName;
function CkRsa_getOaepPadding; external DLLName;
procedure CkRsa_putOaepPadding; external DLLName;
function CkRsa_getPssSaltLen; external DLLName;
procedure CkRsa_putPssSaltLen; external DLLName;
function CkRsa_getVerboseLogging; external DLLName;
procedure CkRsa_putVerboseLogging; external DLLName;
procedure CkRsa_getVersion; external DLLName;
function CkRsa__version; external DLLName;
function CkRsa_DecryptBd; external DLLName;
function CkRsa_DecryptBytes; external DLLName;
function CkRsa_DecryptBytesENC; external DLLName;
function CkRsa_DecryptString; external DLLName;
function CkRsa__decryptString; external DLLName;
function CkRsa_DecryptStringENC; external DLLName;
function CkRsa__decryptStringENC; external DLLName;
function CkRsa_EncryptBd; external DLLName;
function CkRsa_EncryptBytes; external DLLName;
function CkRsa_EncryptBytesENC; external DLLName;
function CkRsa__encryptBytesENC; external DLLName;
function CkRsa_EncryptString; external DLLName;
function CkRsa_EncryptStringENC; external DLLName;
function CkRsa__encryptStringENC; external DLLName;
function CkRsa_ExportPrivateKey; external DLLName;
function CkRsa__exportPrivateKey; external DLLName;
function CkRsa_ExportPrivateKeyObj; external DLLName;
function CkRsa_ExportPublicKey; external DLLName;
function CkRsa__exportPublicKey; external DLLName;
function CkRsa_ExportPublicKeyObj; external DLLName;
function CkRsa_GenerateKey; external DLLName;
function CkRsa_ImportPrivateKey; external DLLName;
function CkRsa_ImportPrivateKeyObj; external DLLName;
function CkRsa_ImportPublicKey; external DLLName;
function CkRsa_ImportPublicKeyObj; external DLLName;
function CkRsa_OpenSslSignBd; external DLLName;
function CkRsa_OpenSslSignBytes; external DLLName;
function CkRsa_OpenSslSignBytesENC; external DLLName;
function CkRsa__openSslSignBytesENC; external DLLName;
function CkRsa_OpenSslSignString; external DLLName;
function CkRsa_OpenSslSignStringENC; external DLLName;
function CkRsa__openSslSignStringENC; external DLLName;
function CkRsa_OpenSslVerifyBd; external DLLName;
function CkRsa_OpenSslVerifyBytes; external DLLName;
function CkRsa_OpenSslVerifyBytesENC; external DLLName;
function CkRsa_OpenSslVerifyString; external DLLName;
function CkRsa__openSslVerifyString; external DLLName;
function CkRsa_OpenSslVerifyStringENC; external DLLName;
function CkRsa__openSslVerifyStringENC; external DLLName;
function CkRsa_SaveLastError; external DLLName;
function CkRsa_SetX509Cert; external DLLName;
function CkRsa_SignBd; external DLLName;
function CkRsa_SignBytes; external DLLName;
function CkRsa_SignBytesENC; external DLLName;
function CkRsa__signBytesENC; external DLLName;
function CkRsa_SignHash; external DLLName;
function CkRsa_SignHashENC; external DLLName;
function CkRsa__signHashENC; external DLLName;
function CkRsa_SignString; external DLLName;
function CkRsa_SignStringENC; external DLLName;
function CkRsa__signStringENC; external DLLName;
function CkRsa_SnkToXml; external DLLName;
function CkRsa__snkToXml; external DLLName;
function CkRsa_UnlockComponent; external DLLName;
function CkRsa_VerifyBd; external DLLName;
function CkRsa_VerifyBytes; external DLLName;
function CkRsa_VerifyBytesENC; external DLLName;
function CkRsa_VerifyHash; external DLLName;
function CkRsa_VerifyHashENC; external DLLName;
function CkRsa_VerifyPrivateKey; external DLLName;
function CkRsa_VerifyString; external DLLName;
function CkRsa_VerifyStringENC; external DLLName;



end.
