//
//  ApplicationCoordinator.swift
//  BankingApp
//
//  Created by Mohamed Ali BELHADJ on 07/05/2023.
//

import Foundation
import UIKit

final class ApplicationCoordinator:Coordinator {
    
    let accountCoordinator : AccountCoordinator = AccountCoordinator()
    let simulatorCoordinator : SimulatorCoordinator = SimulatorCoordinator()
    let settingsCoordinator : SettingsCoordinator = SettingsCoordinator()

    func start() -> UIViewController {
        var controllers: [UIViewController] = []
        let tabController = UITabBarController()
        tabController.tabBar.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
        tabController.tabBar.isTranslucent = false
        controllers.append(accountCoordinator.start())
        controllers.append(simulatorCoordinator.start())
        controllers.append(settingsCoordinator.start())
        tabController.viewControllers = controllers
        return tabController
    }
}

