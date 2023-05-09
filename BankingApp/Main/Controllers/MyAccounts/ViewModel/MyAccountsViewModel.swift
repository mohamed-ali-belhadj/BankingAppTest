//
//  MyAccountsViewModel.swift
//  BankingApp
//
//  Created by Mohamed Ali BELHADJ on 07/05/2023.
//

import Foundation

final class MyAccountsViewModel{
    
    var bankAccountService: BankAccountServiceProtocol = BankAccountService()
    var reloadTableView: (() -> Void)?
    var bankAccounts = [BankAccount]()
    var CABankAccountsViewModels = [BankAccountCellViewModel]()
    var othersBankAccountsViewModels = [BankAccountCellViewModel]()
    weak var coordinatorDelegate: AccountViewModelCoordinatorDelegate?
    
    func getBankAccounts(completion:@escaping (_ success:Bool,_ error:String?) -> Void) {
        bankAccountService.getBankAccounts { [weak self] success, model, error in
            if success, let bankAccounts = model {
                self?.fetchData(bankAccounts: bankAccounts)
                completion(success,nil)
            } else {
                completion(success,error)
            }
        }
    }
    func fetchData(bankAccounts: [BankAccount]) {
        self.bankAccounts = bankAccounts
        for bankAccount in bankAccounts {
            var bankAccountVm = createCellModel(bankAccount: bankAccount)
            bankAccount.accounts.flatMap { accounts in
                bankAccountVm.subAccountsCellViewModels = accounts
                    .map({ bankAccountVm.createCellModel(subAccount: $0) })
                    .sorted { $0.accountTitle.localizedCaseInsensitiveCompare($1.accountTitle) == .orderedAscending }
            }
            
            bankAccount.isCA.flatMap({ $0 == 1 ? self.CABankAccountsViewModels.append(bankAccountVm) : self.othersBankAccountsViewModels.append(bankAccountVm) })
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
            return CABankAccountsViewModels[indexPath.row]
        }
        else
        {
            return othersBankAccountsViewModels[indexPath.row]
        }
    }
}
extension MyAccountsViewModel: AccountViewModelCoordinatorDelegate
{
    func didTapOnAccount(account: Account) {
        coordinatorDelegate?.didTapOnAccount(account: account)
    }
}
