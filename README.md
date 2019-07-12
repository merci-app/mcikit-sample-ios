# MCIKit iOS

MCIKit is a SDK from Merci for your partners.

## How to use

### Table of contents
- [Initialization](#initialization)
- [Delegate](#delegate)
- [Authenticate](#authenticate)
- [Revoke](#revoke)
- [Launch](#launch)
- [Notifications](#notifications)

### Initialization

The framework inicialization should be place on application delegate as follows:

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

Delegate instruction is optional and follows this `protocol`:

```swift
public protocol MerciDelegate {
    func supportFlow(reason: String?) -> UIViewController?
    func loadingFlow() -> UIViewController
}
```

Here is a sample implementation if necessary:

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


### Authenticate

For use the framework features the application need authenticate the user as show below:

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

If the application was authenticated the framework provide a simple function to verify user session is available as show below:

```swift
Merci.isAuthenticated()
```

### Revoke

The revoke was designed to desauthenticate user from current session as shown below:

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

### Launch

The framework has a feature launch with this you can open vouchers and purchase them as shown below:

```swift
import UIKit
import MCIKit

Merci.launch(
    viewController: <#UIViewController#>,
    module: .merchant(<#merchant id: String#>)
)
```

### Notifications

The framework use the new swift structure and place the notifcations on Merci, if need listean events:

```swift
//🎟 Merchant Open
Merci.merchantOpenedNotification

//🎟 Merchant Clodsed
Merci.merchantClosedNotification

//💵 Checkout Started
Merci.checkoutStartedNotification

//💵 Checkout Completed
Merci.checkoutCompletedNotification
```

Here is a sample:

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
        MCILog("Sample: Did Receive notification with name: \(notification.name)")
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
