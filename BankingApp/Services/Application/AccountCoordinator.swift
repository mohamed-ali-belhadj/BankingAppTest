//
//  AccountCoordinator.swift
//  BankingApp
//
//  Created by Mohamed Ali BELHADJ on 08/05/2023.
//

import Foundation
import UIKit

final class AccountCoordinator:Coordinator {
    
    
    var rootViewController: UINavigationController?
    
    func start()->UIViewController{
        let myAccountsVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyAccountsController") as! MyAccountsController
        let myAccountViewModel = MyAccountsViewModel()
        myAccountViewModel.coordinatorDelegate = self
        myAccountsVc.viewModel = myAccountViewModel
        myAccountsVc.tabBarItem = UITabBarItem(title: "Mes comptes", image: UIImage(systemName: "star.fill"), tag: 0)
        rootViewController = UINavigationController(rootViewController: myAccountsVc)
        return rootViewController!
    }
}
extension AccountCoordinator : AccountViewModelCoordinatorDelegate
{
    func didTapOnAccount(account: Account) {
        let detailCoordinator = AccountDetailsCoordinator(account: account)
        let detailVc = detailCoordinator.start()
        rootViewController?.pushViewController(detailVc, animated: true)
    }
}
