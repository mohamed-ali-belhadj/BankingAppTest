//
//  BankAccountCellViewModel.swift
//  BankingApp
//
//  Created by Mohamed Ali BELHADJ on 08/05/2023.
//

import Foundation
protocol AccountViewModelCoordinatorDelegate : AnyObject{
    func didTapOnAccount(account: Account)
}
struct BankAccountCellViewModel {
    var bankAccountTitle: String
    var bankAccountAmount: String
    var bankAccountModel : BankAccount
    var subAccountsCellViewModels = [SubAccountCellViewModel]()
    var isCollapsed : Bool = false
    weak var coordinatorDelegate: AccountViewModelCoordinatorDelegate?

    func didTapOnAccount(account:Account)
    {
        self.coordinatorDelegate?.didTapOnAccount(account: account)
    }
    func createCellModel(subAccount: Account) -> SubAccountCellViewModel {
        let accountTitle = subAccount.label ?? ""
        let accountAmount = String(format: "%.2f €", subAccount.balance ?? 0.0)
        return SubAccountCellViewModel(accountTitle: accountTitle, accountAmount: accountAmount,accountModel: subAccount)
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> SubAccountCellViewModel {
        return self.subAccountsCellViewModels[indexPath.row]
    }
}
