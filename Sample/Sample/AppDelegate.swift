//
//  AppDelegate.swift
//  Sample
//
//  Created by Denis Wilson de Souza Oliveira on 12/07/19.
//  Copyright © 2019 Merci. All rights reserved.
//

import UIKit
import MCIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Merci.instantiate(
            clientId: <#client id: String#>,
            clientSecret: <#client secret: String#>,
            environment: <#environment: MerciEnvironment#>,
            primaryColor: <#primary color: UIColor?#>,
            secondaryColor: <#secondary color: UIColor?#>
        )
        
        return true
    }
    
}
