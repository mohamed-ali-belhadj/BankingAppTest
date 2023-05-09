//
//  ApplicationCoordinator.swift
//  BankingApp
//
//  Created by Mohamed Ali BELHADJ on 07/05/2023.
//

import Foundation
import UIKit

class ApplicationCoordinator:Coordinator {
        
    var window: UIWindow
    var myAccountNavigation: UINavigationController?

    init(window: UIWindow) {
        self.window = window
    }
    // MARK: - Public
    func start() {
        showHome()
    }
}
// MARK: - Routing
extension ApplicationCoordinator {
    
    func showHome() {
        var controllers: [UIViewController] = []
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabController = UITabBarController()
        tabController.tabBar.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
        tabController.tabBar.isTranslucent = false

        if let myAccountsVc = storyboard.instantiateViewController(withIdentifier: "MyAccountsController") as? MyAccountsController {
            let myAccountViewModel = MyAccountsViewModel()
            myAccountsVc.viewModel = myAccountViewModel
            self.myAccountNavigation = UINavigationController(rootViewController: myAccountsVc)
            self.myAccountNavigation?.tabBarItem = UITabBarItem(title: "Mes comptes", image: UIImage(systemName: "star.fill"), tag: 0)
            controllers.append(self.myAccountNavigation!)
        }
        if let simulatorVc = storyboard.instantiateViewController(withIdentifier: "SimulatorController") as? SimulatorController {
            let simulatorViewModel = SimulatorViewModel()
            simulatorVc.viewModel = simulatorViewModel
            simulatorVc.tabBarItem = UITabBarItem(title: "Simulation", image: UIImage(systemName: "star.fill"), tag: 1)
            controllers.append(simulatorVc)
        }
        if let settingsVc = storyboard.instantiateViewController(withIdentifier: "SettingsController") as? SettingsController {
            let settingsViewModel = SettingsViewModel()
            settingsVc.viewModel = settingsViewModel
           settingsVc.tabBarItem = UITabBarItem(title: "A vous de jouer", image: UIImage(systemName: "star.fill"), tag: 2)
            controllers.append(settingsVc)
        }
        tabController.viewControllers = controllers
        self.window.rootViewController = tabController
    }
    
    
}

// MARK: - Error Handling
private extension ApplicationCoordinator {
    func handle(error: String) {
        let alert = UIAlertController(
            title: "Error",
            message: error,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(
            title: "OK",
            style: .default,
            handler: nil
        ))
        guard let target = self.myAccountNavigation?.visibleViewController else { return  }
        target.present(alert, animated: true, completion: nil)
    }
}

