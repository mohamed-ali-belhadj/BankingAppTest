//
//  AccountCoordinator.swift
//  BankingApp
//
//  Created by Mohamed Ali BELHADJ on 08/05/2023.
//

import Foundation
import UIKit

class AccountCoordinator:Coordinator {
        
    private var account: Account?
    private var navc: UINavigationController?

    init(account : Account?,navc:UINavigationController?) {
        self.account = account
        self.navc = navc
    }
    // MARK: - Public
    func start() {
        if let accountDetailsVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AccountDetailsController") as? AccountDetailsController {
            let accountDetailsViewModel = AccountDetailsViewModel(account: self.account)
            accountDetailsVc.viewModel = accountDetailsViewModel
            self.navc?.pushViewController(accountDetailsVc, animated: true)
        }
    }
}
