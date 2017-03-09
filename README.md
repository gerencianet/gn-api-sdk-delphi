# SDK GERENCIANET FOR DELPHI

Beta SDK for Gerencianet Pagamentos' API.
For more informations about parameters and values, please refer to [Gerencianet](http://gerencianet.com.br) documentation.

**Em caso de dúvidas, você pode verificar a [Documentação](https://docs.gerencianet.com.br) da API na Gerencianet e, necessitando de mais detalhes ou informações, entre em contato com nossa consultoria técnica, via nossos [Canais de Comunicação](https://gerencianet.com.br/central-de-ajuda).**

## Requirements
* 32-bit Windows Platform Applications

## Tested with
```
Embarcadero Delphi Berlin 10.0 Starter
Borland Delphi 7
```

## Build

1. On Delphi open the project located in the ```src/dll-src/``` directory;
1. create an output folder and within it create a subfolder for release and another for debug;
1. In the Delphi Project Manager window edit GerenciaNet.dll build configurations:
 - In Delphi compiler -> Target (Debug configuration - 32 bit Windows platform) -> Output Directory  browse the debug subfolder created in the step 2;
 - In Delphi compiler -> Target (Release configuration - 32 bit Windows platform) -> Output Directory browse the release subfolder created in the step 2;
1. Download the x-superobject project from https://github.com/onryldz/x-superobject;
1. Add the x-superobject path on Delphi's library path:
  - Follow the menu Tools -> Options -> Delphi Options -> Library and select Library Path browse options;
  - click on the 'browse for folder' button and select the directory where you downloaded x-superobject project;
  - click on the add button;
1. Choice the enviroment you want (Release or Debug) and build the GerenciaNet.dll project. The dll will be generated in the release folder or in the debug folder depending on which environment you chose

* This step is optional since you download the DLL directly through the [link](https://gerencianet.com.br/material/api/delphi/gn-api-dll-delphi.zip)
* Originally this DLL was builded with Delphi 10.0 Berlin


## Installation

1. You must put the DLL and config.json file in the same folder where the output of your application is configured. In the provided demo application 
the DLL must be in the ```output/debug``` directory if the application is compiled in debug mode or 
```output/release``` if the application is compiled in release mode.
1. To facilitate the communication between your application's and Gerencianet's DLL, 
we suggest you import the following units into your application:
  - uGerenciaClient.pas
  - uGerenciaNetClientUtilities.pas


## Getting started
Require the units:
```pascal
uses uGerenciaClient, uGerenciaNetClientUtilities;
```
The SDK will always return a json string, however any type of parameter or request body (json format) sent in the request of some endpoint must be of type AnsiChar
Before consuming any endpoint it is necessary to authenticate in the Gerencianet API with your client-id and client-secret,
also informing the environment you want to run your application ('sandbox' for Sandbox/ 'api' for Production);

:warning: 
### The DLL was developed to be backward compatible, ie compatible with older versions of Delphi, but we will only support applications developed in Delphi Berlin 10.x, since it is the only current version of Delphi that company Ebarcadero offers support.


### For development environment
Instantiate the DLL passing using your client_id, client_secret and sandbox enviroment:
```pascal
ConfigureService( ToPAnsiChar( ClientID ),ToPAnsiChar( ClientSecret ),'sandbox','config.json',ToPAnsiChar(PartnerToken) );
GerenciaNetAuthorize();
```


### For production environment
To change the environment to production, just do that:
```pascal
ConfigureService( ToPAnsiChar( ClientID ),ToPAnsiChar( ClientSecret ),'api','config.json',ToPAnsiChar(PartnerToken) );
GerenciaNetAuthorize();
```

## Running examples

1. On Delphi Open the GerenciaNetDemo project located in the Demo folder;
1. create an output folder and within it create a subfolder for release and another for debug;
1. Copy the DLL and config.json file and paste them inside the folders created in the previous step (outuput/debug and output/release);
1. In the Delphi Project Manager window edit GerenciaDemo.proj build configurations:
 - In Delphi compiler -> Target (Debug configuration - 32 bit Windows platform) -> Output Directory  browse the debug subfolder created in the step 2;
 - In Delphi compiler -> Target (Release configuration - 32 bit Windows platform) -> Output Directory browse the release subfolder created in the step 2;
1. Download the x-superobject project from https://github.com/onryldz/x-superobject *;
1. Add the x-superobject path on Delphi's library path:
  - Follow the menu Tools -> Options -> Delphi Options -> Library and select Library Path browse options;
  - click on the 'browse for folder' button and select the directory where you downloaded x-superobject project;
  - click on the add button;
1. Copy the fles ```src/uGerenciaClient.pas``` and ```src/uGerenciaNetClientUtilities.pas``` and paste them into the ```demo/``` folder. Add this files to the GerenciaDemo project;
1. Choice the enviroment you want (Release or Debug) and build the GerenciaDemo project. The .exe will be generated in the release folder or in the debug folder depending on which environment you chose

:warning: 
If you want to create a demo application from scratch you only need to import the x-superobject library if you are going to use its functions to manipulate json objects or if you wanted to rebuild the source code of the Gerencianet DLL.

## Additional Documentation

The full documentation with all available endpoints is in https://dev.gerencianet.com.br/.

## Changelog

[CHANGELOG](CHANGELOG.md)

## License ##
[MIT](LICENSE)
