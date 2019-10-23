//
//  AppDelegate.swift
//  Sample
//
//  Created by Denis Wilson de Souza Oliveira on 12/07/19.
//  Copyright © 2019 Merci. All rights reserved.
//

import UIKit
import MerciKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let clientId = ""
        let clientSecret = ""
        
        assert(!clientId.isEmpty, "You need to setup clientId before starting SDK")
        assert(!clientSecret.isEmpty, "You need to setup clientSecret before starting SDK")
        
        Merci.instantiate(
            clientId: clientId,
            clientSecret: clientSecret,
            environment: .sandbox,
            clientName: "SDK",
            homeImage: UIImage(named: "ic_test"),
            merciBrandImage: UIImage(named: "ic_test"),
            homeBackgroundColor: .blue,
            homeTitleColor: .white,
            actionBarTintColor: .red,
            actionTintColor: .green,
            loadingTintColor: .red
        )
        
        return true
    }
    
}
