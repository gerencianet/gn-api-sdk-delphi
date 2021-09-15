
{$IFDEF WIN32}
const DLLName = 'ChilkatDelphi32.dll';
{$ELSE}
  {$IFDEF WIN64}
  const DLLName = 'ChilkatDelphi64.dll';
  {$ELSE}
  const DLLName = 'ChilkatDelphi32.dll';  //Older versions of Delphi
  {$ENDIF}
{$ENDIF}

