//
//  MyAccountsViewModel.swift
//  BankingApp
//
//  Created by Mohamed Ali BELHADJ on 07/05/2023.
//

import Foundation
enum AccountTypeEnum: Int {
    case CA = 0
    case Other = 1
    
    init(fromRawValue: Int) {
        self = AccountTypeEnum(rawValue: fromRawValue) ?? .CA
    }
}
final class MyAccountsViewModel{
    
    var bankAccountService: BankAccountServiceProtocol = BankAccountService()
    var reloadTableView: (() -> Void)?
    var bankAccounts = [BankAccount]()
    var CABankAccountsViewModels = [BankAccountCellViewModel]()
    var othersBankAccountsViewModels = [BankAccountCellViewModel]()
    weak var coordinatorDelegate: AccountViewModelCoordinatorDelegate?
    /// Call api to get bank accounts list
    /// - Parameter completion: completion handler, it return us success (true or false) and return error like string
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
    /// Prepare data to display after call api, prepare tow array, one for creadit agricole and others for others banks
    /// - Parameter bankAccounts : array of bank account objects getted from api
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
    /// Prepare bank account cell model
    /// - Parameter bankAccount: bank acount object
    /// - Returns  Bank account view model
    func createCellModel(bankAccount: BankAccount) -> BankAccountCellViewModel {
        let bankAccountTitle = bankAccount.name
        let sumAmount : Double = bankAccount.accounts?.compactMap({$0.balance}).reduce(0.0, +) ?? 0.0
        var cellViewModel = BankAccountCellViewModel(bankAccountTitle:bankAccountTitle ?? "" , bankAccountAmount: String(format: "%.2f €", sumAmount), bankAccountModel: bankAccount)
        cellViewModel.coordinatorDelegate = self
        return cellViewModel
    }
    /// Get bank account cell model at index
    /// - Parameter index: row
    /// - Parameter type: section type : credit agricole or others
    /// - Returns  Bank account view model
    func getCellViewModel(at index: Int, type: AccountTypeEnum) -> BankAccountCellViewModel {
           switch type {
           case .CA:
               return self.CABankAccountsViewModels[index]
           case .Other:
               return self.othersBankAccountsViewModels[index]
           }
       }
}
extension MyAccountsViewModel: AccountViewModelCoordinatorDelegate
{
    func didTapOnAccount(account: Account) {
        coordinatorDelegate?.didTapOnAccount(account: account)
    }
}
