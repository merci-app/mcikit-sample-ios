# Configurações Merci-Kit iOS

## Pré-Requisitos
````ruby
    - iOS version: 9.0 ou superior
    - Swift: 5.0 ou superior
    - CocoaPods
    - Info.plist
````

## Dependências:

### CocoaPods
````ruby
    - Alamofire - 4.8.2
    - Kingfisher - :branch => 'ios9'
    - KeychainAccess - 3.2.0
    - TPKeyboardAvoiding - 1.3
````

### Info.plist:
````xml
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
````

## Configuração
Para configurar o MCIKit em seu projeto adicione as dependências no `Podfile`:

```ruby
    pod 'Kingfisher', :git => 'https://github.com/onevcat/Kingfisher', :branch => 'ios9'
    pod 'MCIKit', :git =>'https://github.com/merci-app/mcikit-podspec', :tag => "1.1.10"
```

## Inicialização
A framework deverá ser iniciada dentro do `application delegate` como a seguir:

````swift
import UIKit
import MerciKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    lazy var merciDelegate = SampleDelegate()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        Merci.instantiate(
            clientId: <#String#>,
            clientSecret: <#String#>,
            environment: <#MerciEnvironment>,
            primaryColor: <#UIColor?#>,
            secondaryColor: <#UIColor?#>,
            homeImage: <#UIImage?#>,
            delegate: <#MerciDelegate?#>
        )
        
        return true
    }

}
````

A instrução de delegação é opcional e utiliza o seguinte `protocol`:
````swift
public protocol MerciDelegate {
    func supportFlow(reason: String?) -> UIViewController?
    func authenticationFlow() -> UIViewController
}
````

Caso seja necessário implementar, segue abaixo um exemplo:
````swift
import UIKit
import MerciKit

class SampleDelegate: MerciDelegate {

    func supportFlow(reason: String?) -> UIViewController? {
        debugPrint(reason ?? "")
        return nil
    }
    
    func authenticationFlow() -> UIViewController {
        return UIViewController()
    }
    
}
````

## Autenticação

Para utilizar os recursos da framework é necessário autenticar o usuário como exibido a seguir:
````swift
import MerciKit

Merci.authenticate(cpf: <#String#>) { [weak self] (result) in
    guard let self = self else { return }
  
    switch result {
    case .success:
        debugPrint("OK")
    
    case .failure(let error):
        debugPrint(error)
    }
}
````

Para realizar o logout:
````swift
Merci.revokeAuthentication { [weak self] (result) in
    switch result {
    case .success:
        debugPrint("OK")

    case .failure(error)
        debugPrint(error)
    }
}
````

Para checar se o usuário esta autenticado na nossa plataforma:
````swift
Merci.isAuthenticated()
````


## Iniciar uma venda

Para iniciar uma venda direta, é necessário chamar o método abaixo, informando o identifcador do estabelecimento como mostra a seguir:
````swift
import UIKit
import MerciKit

Merci.launch(viewController: <#UIViewController#>, module: .merchant(<#merchant id: String#>)) { result in 
    switch result {
    case .success:
    debugPrint("Merchant available.")
    
    case .failure(let error):
    debugPrint("Merchant not found.")
    }
}
````

## Iniciar a marketpay

Para iniciar a marketpay, é necessário chamar o método abaixo:

````swift
Merci.launch(viewController: self, module: .marketpay) { (result) in
    switch result {
        case .success:
            debugPrint("OK.")

        case .failure(let error):
            debugPrint(error)
    }
}
````

---

[Merci @ 2019](https://merci.com.br)
