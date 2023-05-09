//
//  SettingsCoordinator.swift
//  BankingApp
//
//  Created by Mohamed Ali BELHADJ on 09/05/2023.
//

import Foundation
import UIKit

final class AccountDetailsCoordinator:Coordinator {
    
    private var account: Account?

    init(account : Account?) {
        self.account = account
    }
    func start()->UIViewController{
        let accountDetailsVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AccountDetailsController") as! AccountDetailsController
        let accountDetailsViewModel = AccountDetailsViewModel(account: account)
        accountDetailsVc.viewModel = accountDetailsViewModel
        return accountDetailsVc
    }
}
