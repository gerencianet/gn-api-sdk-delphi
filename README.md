# SDK GERENCIANET - DELPHI

SDK oficial para API da Gerencianet Pagamentos.

**Em caso de dúvidas, você pode verificar a [Documentação](https://docs.gerencianet.com.br) da API na Gerencianet e, necessitando de mais detalhes ou informações, entre em contato com nossa consultoria técnica, via nossos [Canais de Comunicação](https://gerencianet.com.br/central-de-ajuda).**

## Pré requisitos
* Aplicaçoes que usarão a SDK devem ser compiladas na plataforma Windows 32-bit;
* Apenas aplicações Desktop.

## Testes
```
Embarcadeiro Delphi Berlin 10.0 Starter
Borland Delphi 7
```

## Download da SDK

A SDK Delphi disponibilizada pela Gerencianet é composta de uma DLL e duas unidades que fazem a comunicação da sua aplicação com a DLL. Para fazer o download de todo o código fonte da SDK e do projeto de demonstração, clique no [link](https://github.com/gerencianet/gn-api-sdk-delphi/archive/master.zip).
Após concluir o download descompacte o arquivo em alguma pasta de sua preferência.

## Como gerar a DLL

Estes passos são opcional desde que você baixe a DLL já compilada da Gerencianet através do [link](https://github.com/gerencianet/gn-api-sdk-delphi/tree/master/src/dll-compilada). Caso você queira compilar o código da DLL siga as seguintes instruções:

1. Acesse o diretório onde você fez o download e descompactou o arquivo zip contendo o código fonte da DLL;
1. Dentro do seu Delphi, abra o projeto localizado no diretório ```src/dll-src/```;
1. Dentro do diretório ```src/dll-src/``` crie uma pasta chamada ```output``` e dentro desta pasta crie duas subpastas, uma chamada ```release``` e outra chamada ```debug```
1. No gerenciador de projetos do seu Delphi (No Delphi Berlin é a janela Project Manager, localizada no canto superior direito) selecione a edição das configurações de build do seu projeto - ```Build Configurations -> Edit```. Configure os ambientes de compitalação da seguinte forma:
	- Em Delphi compiler -> menu Target (Debug configuration - 32 bit Windows platform) -> "Output Directory" selecione o diretório ```output/debug``` criado no passo 3;
	- Em Delphi compiler -> menu Target (Release configuration - 32 bit Windows platform) -> "Output Directory" selecione o diretório ```output/release``` criado no passo 3;
	- Cique em 'OK'.
1. Faça o download do zip do projeto [x-superobject](https://github.com/onryldz/x-superobject) e descompacte-o em alguma pasta de sua preferência;
1. Adicione no library path do Delphi o caminho da pasta que você escolheu para armazenar os arquivos da x-superobject:
  - No Delphi clique em Tools -> Options
  - Na janela que abrir selecione a opção 'Delphi Options' -> 'Library' 
  - Nas configurações selecione a edição do campo 'Library path'
  - Clique no botão 'browse for folder...' e selecione o diretório onde você baixou e descompatou o projeto x-superobject;
  - Clique no botão 'Add' e feche a janela de opções

1. Selecione o ambiente que você deseja compilar a DLL, Release ou Debug, e logo em seguida clique em Run -> Run Withou Debuggin. A DLL Gerencianet será gerada em um dos diretórios que você criou no passo 3, dependendo do ambiente que você escolheu.

Obs: Originalmente estes passos foram executados no Delphi Berlin 10.1

## Como importar a SDK no seu projeto

1. Você precisa copiar a DLL da Gerencianet (GerenciaNet.dll) e o arquivo config.json para o mesmo diretório que você definiu como diretório de destino da sua aplicação, por exemplo ```output -> debug``` ou ```output->release```.
1. Você deverá copiar os arquivos ```src/uGerenciaClient.pas``` e ```src/uGerenciaNetClientUtilities.pas``` , disponíveis no zip da SDK que você  baixou neste repositório, para o diretório raiz de seu projeto, ou seja, no mesmo lugar onde os seus arquivos .pas estão;
3. Adicione ao seu projeto os arquivos copiados no passo anterior. Isto pode ser feito clicando em 'Project' -> 'Add to project...'.


## Usando a SDK Gerencianet

Importe as unidades principais:
```pascal
uses uGerenciaClient, uGerenciaNetClientUtilities;
```

A API sempre irá retornar uma string JSON, portanto qualquer argumento passado para as funções da SDK deve ser do tipo String.
Antes de consumir qualquer endpoint da API é necessário:
* Carregar a DLL;
* Autenticar na API usando a SDK. Nesta autenticação você irá fornecer o seu Client_Id, Client_Secret e o ambiente (sandbox ou produção).

### Configurando Proxy

A DLL permite a configuração de saída por proxy em sua aplicação Delphi:

```pascal
ConfigureProxy( ToPAnsiChar( ProxyServer ), ToPAnsiChar( ProxyUsername ), ToPAnsiChar( ProxyPassword ), ProxyPort );
```

### Autenticando em Sandbox

```pascal
EnableService( 'GerenciaNet.dll' ); // carregando a DLL
ConfigureService( ToPAnsiChar( ClientID ),ToPAnsiChar( ClientSecret ),'sandbox','config.json',ToPAnsiChar(PartnerToken) ); //passando as credenciais para a DLL
GerenciaNetAuthorize(); //autenticando na API Gerencianet
```

### Autenticando em Produção

```pascal
EnableService( 'GerenciaNet.dll' ); // carregando a DLL
ConfigureService( ToPAnsiChar( ClientID ),ToPAnsiChar( ClientSecret ),'api','config.json',ToPAnsiChar(PartnerToken) ); //passando as credenciais para a DLL
GerenciaNetAuthorize(); //autenticando na API Gerencianet
```

:warning: 
### Esta DLL foi desenvolvida para ser retrocompatível, ou seja, compatível tanto com as versões mais recentes do Delphi quanto as versões mais antigas, no entanto, a Gerencianet somente irá dar suporte às aplicações desktop win-32 desenvolvidas no Delphi Berlin 10.x, visto que esta é a versão mais recente do Delphi e é a única versão que é oficial e que ainda está sob suporte da Embarcadero, empresa que distribui o Delphi.

## Rodando a aplicação Demo

1. No Delphi abra o projeto GerenciaDemo localizado na pasta 'demo';
1. Dentro do diretório ```demo/``` crie uma pasta chamada ```output``` e dentro desta pasta crie duas subpastas, uma chamada ```release``` e outra chamada ```debug```
1. Copie os arquivos GerenciaNet.dll e config.json para dentro das pastas ```demo/output/debug``` e ```demo/output/release``` criadas anteriormente;
1. No gerenciador de projetos do seu Delphi (No Delphi Berlin é janela Project Manager, localizada no canto superior direito) selecione a edição das configurações de build do seu projeto - ```Build Configurations -> Edit```. Configure os ambientes de compitalação da seguinte forma:
	- Em Delphi compiler -> menu Target (Debug configuration - 32 bit Windows platform) -> "Output Directory" selecione o diretório ```demo/output/debug``` criado no passo 2;
	- Em Delphi compiler -> menu Target (Release configuration - 32 bit Windows platform) -> "Output Directory" selecione o diretório ```demo/output/release``` criado no passo 2;
	- Cique em 'OK'.
1. Faça o download do zip do projeto [x-superobject](https://github.com/onryldz/x-superobject) e descompacte-o em alguma pasta de sua preferência *;
1. Adicione no library path do Delphi o caminho da pasta que você escolheu para armazenar os arquivos da x-superobject:
  - No Delphi clique em Tools -> Options
  - Na janela que abrir selecione a opção 'Delphi Options' -> 'Library' 
  - Nas configurações selecione a edição do campo 'Library path'
  - Clique no botão 'browse for folder...' e selecione o diretório onde você baixou e descompatou o projeto x-superobject;
  - Clique no botão 'Add' e feche a janela de opções
1. Copie os arquivos ```src/uGerenciaClient.pas``` e ```src/uGerenciaNetClientUtilities.pas``` , disponíveis no zip da SDK que você  baixou neste repositório, para dentro da pasta ```demo/```, ou seja, no mesmo lugar onde os arquivos .pas estão;
1. Selecione o ambiente que você deseja compilar a aplicação GerenciaDemo, Release ou Debug, e logo em seguida clique em Run -> Run Withou Debuggin. O arquivo executável será gerado em um dos diretórios que você criou no passo 2, dependendo do ambiente que você escolheu.

:warning:
Se você deseja criar uma aplicação de teste do zero você só precisará importar a biblioteca x-superobject se você for usar as funções de manipulação de objecto JSON da mesma. A biblioteca x-superobject será necessária, também, caso você queira compilar o código fonte da DLL.

## Documentação Adicional

A documentação completa com todos os endpoints disponíveis está em [https://dev.gerencianet.com.br/](https://dev.gerencianet.com.br/).

## Changelog

[CHANGELOG](CHANGELOG.md)

## License ##
[MIT](LICENSE)
