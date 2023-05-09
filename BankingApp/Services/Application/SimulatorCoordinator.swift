//
//  SimulatorCoordinator.swift
//  BankingApp
//
//  Created by Mohamed Ali BELHADJ on 09/05/2023.
//

import Foundation
import UIKit

class SimulatorCoordinator:Coordinator {
    
    func start()->UIViewController{
        let simulatorVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SimulatorController") as! SimulatorController
        let simulatorViewModel = SimulatorViewModel()
        simulatorVc.viewModel = simulatorViewModel
        simulatorVc.tabBarItem = UITabBarItem(title: "Simulation", image: UIImage(systemName: "star.fill"), tag: 1)
        return simulatorVc
    }
}
