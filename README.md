# SDK PIX GERENCIANET - DELPHI

SDK oficial para API PIX da Gerencianet Pagamentos.

**Em caso de dúvidas, você pode verificar a [Documentação](https://dev.gerencianet.com.br/docs/api-pix) da API PIX na Gerencianet e, necessitando de mais detalhes ou informações, entre em contato com nossa consultoria técnica, via nossos [Canais de Comunicação](https://gerencianet.com.br/central-de-ajuda).**

## Pré requisitos
* Aplicaçoes que usarão a SDK devem ser compiladas na plataforma Windows 32-bit;
* Apenas aplicações Desktop.

## Testes
```
Embarcadeiro Delphi Community Edition
```

## Download da SDK

Todo o código de demonstração está disponível nesse repositório do GitHub. Após concluir o download descompacte o arquivo em alguma pasta de sua preferência e a SDK estará pronta para uso.

## Execução Demo

Dentro da SDK, abra a pasta `Api Compilada` e lá terá o arquivo a ser executado - `ApisGN.exe`. 

## Utilizando da SDK

Para utilização da SDK, basta adicionar as classes ao seu projeto e chama-las conforme suas necessidades.

:warning: 
### Dependendo do Endpoint a ser utilizado, será necessário adicionar as DLL´s (`Disponíveis em: \Api Compilada`) e classes externas (`Disponíveis em: \Code\External`) ao seu projeto também.

## Dependências do Projeto

Para desenvolvimento da SDK, foi utilizada algumas classes externas disponíveis em:

* Classe Super Object: https://github.com/onryldz/x-superobject
* Classe ZXingQRCode: https://github.com/foxitsoftware/DelphiZXingQRCode/tree/master/Source
* Classe Chilkat: https://www.chilkatsoft.com/delphiDll.asp

Essas classes externas estão dentro de nosso projeto na pasta "Utils/External".

:warning: 
### Este projeto foi desenvolvido para ser retrocompatível, ou seja, compatível tanto com as versões mais recentes do Delphi quanto as versões mais antigas, no entanto, a Gerencianet somente irá dar suporte às aplicações desktop win-32 desenvolvidas no Delphi Community Edition.

## Documentação Adicional

A documentação completa com todos os endpoints disponíveis está em [https://dev.gerencianet.com.br/docs/api-pix](https://dev.gerencianet.com.br/docs).

## Changelog

[CHANGELOG](CHANGELOG.md)

## License ##
[MIT](LICENSE)
