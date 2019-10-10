//
//  ViewController.swift
//  Sample
//
//  Created by Denis Wilson de Souza Oliveira on 12/07/19.
//  Copyright © 2019 Merci. All rights reserved.
//

import UIKit
import MerciKit

enum SampleSection {
    case auth
    case method
}

enum SampleRow {
    case auth
    case revoke
    case launch
    case marketpay
}

final class SampleVC: UITableViewController {

    lazy var tableSchema: [(section: SampleSection, rows: [SampleRow])] =
        [
            (section: .auth, rows: [.auth, .revoke]),
            (section: .method,  rows: [.launch, .marketpay])
        ]
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - TableViewDelegate Methods
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let tableSection = tableSchema[indexPath.section]
        let row = tableSection.rows[indexPath.row]
        
        switch tableSection.section {
        case .auth:
            if case .auth = row, Merci.isAuthenticated() {
                return .leastNonzeroMagnitude
            }
                
            if case .revoke = row, !Merci.isAuthenticated() {
                return .leastNonzeroMagnitude
            }
            
        case .method:
            return UITableView.automaticDimension
        }
        
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let tableSection = tableSchema[indexPath.section]
        
        switch tableSection.rows[indexPath.row] {
        case .auth:
            Merci.authenticate(cpf: <#cpf: String#>) { [weak self] (result) in
                guard let self = self else { return }
                
                switch result {
                case .success:
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    debugPrint(error)
                }
            }
        
        case .revoke:
            Merci.revokeAuthentication { [weak self] (result) in
                guard let self = self else { return }
                debugPrint(result)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        
        case .launch:
            Merci.launch(viewController: self, module: .merchant(<#merchant id: String#>), transition: .crossDissolve) { (result) in
                switch result {
                case .success:
                    debugPrint("Merchant available.")

                case .failure(let error):
                    debugPrint(error)
                }
            }
            
        case .marketpay:
            Merci.launch(viewController: self, module: .marketpay, transition: .crossDissolve) { (result) in
                switch result {
                case .success:
                    debugPrint("OK.")

                case .failure(let error):
                    debugPrint(error)
                }
            }
        }
    }

    // MARK: - Memory Management
    
    deinit {
        print("\(String(describing: self)) -> deinit")
    }
    
}
