# MCIKit iOS

MCIKit é um _framework_ da Merci para seus parceiros.

## Pré-requisitos

- iOS: 9.0 ou superior
- Swift: 5.0 ou superior
- CocoaPods
- Info.plist

Dependencias do CocoaPods:

- Alamofire - 4.8.2
- Kingfisher - :branch => 'ios9'
- KeychainAccess - 3.2.0
- TPKeyboardAvoiding - 1.3

Dependencias do Info.plist:

```xml
<key>NSCameraUsageDescription</key>
<string>DESCRIÇÃO</string>
<key>NSFaceIDUsageDescription</key>
<string>DESCRIÇÃO</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>DESCRIÇÃO</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>DESCRIÇÃO</string>
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>waze</string>
    <string>comgooglemaps</string>
    <string>uber</string>
    <string>cydia</string>
</array>
```

## Como usar

### Tabela de conteúdos
- [Inicialização](#inicialização)
- [Delegate](#delegate)
- [Autenticação](#autenticação)
- [Desautenticar](#desautenticar)
- [Apresentar](#apresentar)
- [Notificações](#notificações)

### Inicialização

O framework deverá ser iniciado dentro do _application delegate_ como a seguir:

```swift
import UIKit
import MCIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    lazy var merciDelegate = SampleDelegate()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        Merci.instantiate(
            clientId: <#String#>,
            clientSecret: <#String#>,
            primaryColor: <#UIColor?#>,
            secondaryColor: <#UIColor?#>,
            homeImage: <#UIImage?#>,
            delegate: <#MerciDelegate?#>
        )
        
        return true
    }

}
```

### Delegate

A instrução de delegação é opcional e utiliza o seguinte `protocol`:

```swift
public protocol MerciDelegate {
    func supportFlow(reason: String?) -> UIViewController?
    func loadingFlow() -> UIViewController
}
```

Caso seja necessário implementar, segue abaixo um exemplo:

```swift
import UIKit
import MCIKit

class SampleDelegate: MerciDelegate {

    func supportFlow(reason: String?) -> UIViewController? {
        debugPrint(reason ?? "")
        return nil
    }
    
    func loadingFlow() -> UIViewController {
        return UIViewController()
    }
    
}
```

### Autenticação

Para utilizar os recursos do framework é necessário autenticar o usuário como exibido a seguir:

```swift
import MCIKit

Merci.authenticate(cpf: <#String#>) { [weak self] (result) in
    guard let self = self else { return }
  
    switch result {
    case .success:
        debugPrint("OK")
    
    case .failure(let error):
        debugPrint(error)
    }
}
```

Se o aplicativo já realizou a autenciação o framework fornece uma função para verificar se o usuário possui um sessão disponível ou não como mostra a seguir:

```swift
Merci.isAuthenticated()
```

### Desautenticar

Esta função é utilizada para revogar a seção de um usuário já autenticado:

```swift
Merci.revokeAuthentication { [weak self] (result) in
    switch result {
    case .success:
        debugPrint("OK")
    
    case .failure(error)
        debugPrint(error)
    }
}
```

### Apresentar

O framework tem o recurso de apresentar, com isso é possível abrir uma tela para a aquisição de _voucher_ de um estabelecimento. Para isso é necessário informar o identifcador do estabelecimento como mostra a seguir:

```swift
import UIKit
import MCIKit

Merci.launch(
    viewController: <#UIViewController#>,
    module: .merchant(<#merchant id: String#>)
)
```

### Notificações

O framework usa a nova estrutura do _swift_ e coloca as `Notification.Name` dentro do `Merci`. Caso seja necessáro escutar segue os eventos gerados pelo framework:

```swift
//🎟 O establecimento foi aberto
Merci.merchantOpenedNotification

//🎟 O estabelecimento foi fechado
Merci.merchantClosedNotification

//💵 O pagamento foi iniciado
Merci.checkoutStartedNotification

//💵 O pagamento foi concluído
Merci.checkoutCompletedNotification
```

Segue um exemplo:

```swift
extension SampleVC {
    
    private func registerNotifications() {
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(log(_:)), name: Merci.merchantOpenedNotification, object: nil)
        nc.addObserver(self, selector: #selector(log(_:)), name: Merci.merchantClosedNotification, object: nil)
        nc.addObserver(self, selector: #selector(log(_:)), name: Merci.checkoutStartedNotification, object: nil)
        nc.addObserver(self, selector: #selector(log(_:)), name: Merci.checkoutCompletedNotification, object: nil)
    }
    
    @objc fileprivate func log(_ notification: Notification) {
        MCILog("Sample: notificação recebida: \(notification.name)")
    }
    
    private func unregisterNotifications() {
        let nc = NotificationCenter.default
        nc.removeObserver(self, name: Merci.merchantOpenedNotification, object: nil)
        nc.removeObserver(self, name: Merci.merchantClosedNotification, object: nil)
        nc.removeObserver(self, name: Merci.checkoutStartedNotification, object: nil)
        nc.removeObserver(self, name: Merci.checkoutCompletedNotification, object: nil)
    }
}
```

---

[Merci @ 2019](https://merci.com.br)
