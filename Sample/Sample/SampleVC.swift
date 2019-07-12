//
//  ViewController.swift
//  Sample
//
//  Created by Denis Wilson de Souza Oliveira on 12/07/19.
//  Copyright © 2019 Merci. All rights reserved.
//

import UIKit

enum SampleSection {
    case auth
    case method
}

enum SampleRow {
    case auth
    case revoke
    case launch
}

final class SampleVC: UITableViewController {

    lazy var tableSchema: [(section: SampleSection, rows: [SampleRow])] =
        [
            (section: .auth, rows: [.auth, .revoke]),
            (section: .method,  rows: [.launch])
        ]
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNotifications()
    }
    
    // MARK: - TableViewDelegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - Memory Management
    
    deinit {
        print("\(String(describing: self)) -> deinit")
        unregisterNotifications()
    }
    
}

extension SampleVC {
    
    private func registerNotifications() {
    }
    
    @objc fileprivate func log(_ notification: Notification) {
        print("MerciKit: Did Receive notification with name: \(notification.name)")
    }
    
    private func unregisterNotifications() {
    }
    
}
