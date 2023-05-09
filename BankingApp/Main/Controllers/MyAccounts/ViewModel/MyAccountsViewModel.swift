//
//  MyAccountsViewModel.swift
//  BankingApp
//
//  Created by Mohamed Ali BELHADJ on 07/05/2023.
//

import Foundation

final class MyAccountsViewModel: AccountViewModelCoordinatorDelegate {
    
    var bankAccountService: BankAccountServiceProtocol
    var reloadTableView: (() -> Void)?
    var bankAccounts = [BankAccount]()
    var CABankAccountsViewModels = [BankAccountCellViewModel]()
    var othersBankAccountsViewModels = [BankAccountCellViewModel]()
    weak var coordinatorDelegate: AccountViewModelCoordinatorDelegate?

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
        for bankAccount in bankAccounts {
            var bankAccountVm = createCellModel(bankAccount: bankAccount)
            if let accounts = bankAccount.accounts
            {
                for account in accounts {
                    bankAccountVm.subAccountsCellViewModels.append(bankAccountVm.createCellModel(subAccount: account))
                }
                bankAccountVm.subAccountsCellViewModels = bankAccountVm.subAccountsCellViewModels .sorted { $0.accountTitle.localizedCaseInsensitiveCompare($1.accountTitle) == .orderedAscending }
            }
            if let isCA = bankAccount.isCA
            {
                if isCA == 1
                {
                    self.CABankAccountsViewModels.append(bankAccountVm)
                }
                else
                {
                    self.othersBankAccountsViewModels.append(bankAccountVm)
                }
            }
            else
            {
                self.othersBankAccountsViewModels.append(bankAccountVm)
            }
            
        }
        self.CABankAccountsViewModels = self.CABankAccountsViewModels.sorted { $0.bankAccountTitle.localizedCaseInsensitiveCompare($1.bankAccountTitle) == .orderedAscending }
        self.othersBankAccountsViewModels = self.othersBankAccountsViewModels.sorted { $0.bankAccountTitle.localizedCaseInsensitiveCompare($1.bankAccountTitle) == .orderedAscending }

        self.reloadTableView?()
    }
    
    func createCellModel(bankAccount: BankAccount) -> BankAccountCellViewModel {
        let bankAccountTitle = bankAccount.name
        let sumAmount : Double = bankAccount.accounts?.compactMap({$0.balance}).reduce(0.0, +) ?? 0.0
        var cellViewModel = BankAccountCellViewModel(bankAccountTitle:bankAccountTitle ?? "" , bankAccountAmount: String(format: "%.2f €", sumAmount), bankAccountModel: bankAccount)
        cellViewModel.coordinatorDelegate = self
        return cellViewModel
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> BankAccountCellViewModel {
        if indexPath.section == 0
        {
            return self.CABankAccountsViewModels[indexPath.row]
        }
        else
        {
            return self.othersBankAccountsViewModels[indexPath.row]
        }
    }
    
    func didTapOnAccount(account: Account) {
        self.coordinatorDelegate?.didTapOnAccount(account: account)
    }
    
}
