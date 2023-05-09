//
//  MyAccountsViewModel.swift
//  BankingApp
//
//  Created by Mohamed Ali BELHADJ on 07/05/2023.
//

import Foundation

final class MyAccountsViewModel {
    
    private var bankAccountService: BankAccountServiceProtocol
    var currentIndexCollapsed : Int = -1
    var reloadTableView: (() -> Void)?
    
    var bankAccounts = [BankAccount]()
    var bankAccountsCellViewModels = [BankAccountCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }
    
    init(bankAccountService: BankAccountService = BankAccountService()) {
        self.bankAccountService = bankAccountService
    }
    
    func getBankAccounts() {
        self.bankAccountService.getBankAccounts { success, model, error in
            if success, let bankAccounts = model {
                self.fetchData(bankAccounts: bankAccounts)
            } else {
                print(error!)
            }
        }
    }
    func fetchData(bankAccounts: [BankAccount]) {
        self.bankAccounts = bankAccounts // Cache
        var bankAccountCellViewModels = [BankAccountCellViewModel]()
        for bankAccount in bankAccounts {
            var bankAccountVm = createCellModel(bankAccount: bankAccount)
            if let accounts = bankAccount.accounts
            {
                for account in accounts {
                    bankAccountVm.subAccountsCellViewModels.append(bankAccountVm.createCellModel(subAccount: account))
                }
            }
            bankAccountCellViewModels.append(bankAccountVm)
        }
        self.bankAccountsCellViewModels = bankAccountCellViewModels
    }
    
    func createCellModel(bankAccount: BankAccount) -> BankAccountCellViewModel {
        let bankAccountTitle = bankAccount.name
        let sumAmount : Double = bankAccount.accounts?.compactMap({$0.balance}).reduce(0.0, +) ?? 0.0
        return BankAccountCellViewModel(bankAccountTitle:bankAccountTitle ?? "" , bankAccountAmount: String(format: "%.2f €", sumAmount), bankAccountModel: bankAccount)
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> BankAccountCellViewModel {
        return self.bankAccountsCellViewModels[indexPath.row]
    }
    func updateCollapseValueForCellViewModel(at indexPath: IndexPath,isCollapsed:Bool) {
        self.bankAccountsCellViewModels[indexPath.row].isCollapsed = isCollapsed
    }
    
}
