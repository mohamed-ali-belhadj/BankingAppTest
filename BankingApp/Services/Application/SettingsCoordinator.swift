//
//  SettingsCoordinator.swift
//  BankingApp
//
//  Created by Mohamed Ali BELHADJ on 09/05/2023.
//

import Foundation
import UIKit

class SettingsCoordinator:Coordinator {
    
    func start()->UIViewController{
        let settingsVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingsController") as! SettingsController
        let settingsViewModel = SettingsViewModel()
        settingsVc.viewModel = settingsViewModel
        settingsVc.tabBarItem = UITabBarItem(title: "A vous de jouer", image: UIImage(systemName: "star.fill"), tag: 2)
        return settingsVc
    }
}
