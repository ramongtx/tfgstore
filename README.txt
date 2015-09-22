TFGStore by Ramon Carvalho Maciel

=================================
INSTALAÇÃO

Projetos em Swift:
- Simplesmente importe os arquivos para o projeto.

Projetos em Objective-C:
- Seguir as diretivas da Apple para importação de código Swift em projetos Objective-C


=================================
USO

Para a demonstração:
- Chamar "TFGStore.presentDemo(viewController: self)" ou "[TFGStore presentDemoWithViewController:self]"

Para uso configurável:
- Chamar "TFGStore.present(...)" ou "[TFGStore presentWithViewController:...]", dando ao software os parâmetros de localização do arquivo JSON e os de chamada da API do Parse


=================================
CONFIGURAÇÃO

- O projeto está em Swift 2 e pode necessitar da versão mais atual do XCode para funcionar
- O arquivo JSON com os dados tem que estar no formato:
{
  "apps": [
    {
      "name": "App 1",
      "description": "Descrição do App 1",
      "icon": "https://www.server.com/icone_app_1.png",
      "screenshots": [
        "https://www.server.com/screenshot_app_1.jpeg",
        "https://www.server.com/screenshot_app_1.jpeg",
        "https://www.server.com/screenshot_app_1.jpeg"
      ]
    },
    {
      "name": "App 2",
      "description": "Descrição do App 2",
      "icon": "https://www.server.com/icone_app_2.png",
      "screenshots": [
        "https://www.server.com/screenshot_app_2.jpeg",
        "https://www.server.com/screenshot_app_2.jpeg",
        "https://www.server.com/screenshot_app_2.jpeg"
      ]
    },
    ...
  ]
}
- O app vai respeitar a ordem dos aplicativos para demonstrar na loja
- Devido ao App Transport Security do iOS 9.0, todos os links, inclusive o próprio JSON, devem estar em HTTPS ou as devidas exceções devem ser adicionadas ao arquivo "info.plist"
- O monitoramento dos eventos do usuário se dá pela classe TFGStoreLogger e é transmitido para o Parse para ser armazenado na Cloud.


=================================
CRÉDITOS

- Todo o código foi feito por mim (Ramon Carvalho Maciel), com exceção do componente KFSwiftImageLoader, usado por otimizar e facilitar o cache das imagens baixadas
- O componente KFSwiftImageLoader está sobre a licença MIT (uso comercial e não-comercial livre), e pode ser encontrado em: https://github.com/kiavashfaisali/KFSwiftImageLoader
- O KFSwiftImageLoader foi modificado para melhor atender as necessidades específicas desse projeto e se resume-se aqui aos arquivos "KFImageCacheManager.swift" e "UIImageViewExtensions.swift"
- Todas as imagens e textos utilizados no modo demonstração foram retirados da Apple App Store e são de propriedade da TFG Games
