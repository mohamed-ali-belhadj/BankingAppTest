//
//  MyAccountViewModel.swift
//  BankingApp
//
//  Created by Mohamed Ali BELHADJ on 07/05/2023.
//

import Foundation
final class AccountDetailsViewModel {
    var accountModel: Account?
    var operationsCellViewModels = [OperationCellViewModel]()
    /// Init method
    /// - Parameter Account: account object
    init(account:Account?) {
        accountModel = account
    }
    /// Get operations list
    func fetchOperations() {
        var operationsCellViewM = [OperationCellViewModel]()
        guard let account = accountModel else { return }
        guard let operations = account.operations else { return }
        for operation in operations{
            let operationVm = createCellModel(operation: operation)
            operationsCellViewM.append(operationVm)
        }
        operationsCellViewM.sort(by: { $0.operationDate?.compare($1.operationDate ?? Date()) == .orderedDescending })
        operationsCellViewModels = filterDuplicates(operations: operationsCellViewM)
    }
    /// Prepare operation cell model
    /// - Parameter Operation: operation object
    /// - Returns  Operation view model
    func createCellModel(operation: Operation?) -> OperationCellViewModel {
        let operationDate = getOperationDate(operationDate: (operation?.date) ?? "")
        return OperationCellViewModel(operationTitle: operation?.title ?? "", operationAmount:  String (format: "%@ €", operation?.amount ?? ""), operationDate: operationDate,operationDateString: getOperationDateString(operationDate: operationDate))
    }
    /// Get operation cell model at index
    /// - Parameter indexPath: index
    /// - Returns  Operation view model
    func getCellViewModel(at indexPath: IndexPath) -> OperationCellViewModel {
        return operationsCellViewModels[indexPath.row]
    }
    /// Convert date returned by api (timestamp) to Date
    /// - Parameter operationDate: operation Date (timestamp)
    /// - Returns  operationDate like Date
    func getOperationDate(operationDate:String) -> Date? {
        guard let operationTimeStamp = Double(operationDate) else { return nil }
        let date = Date(timeIntervalSince1970: operationTimeStamp)
        return date
    }
    /// Convert operation date to date string with specific format
    /// - Parameter operationDate: operation Date
    /// - Returns  operation Date string with dd/MM/YYYY format
    func getOperationDateString(operationDate:Date?) -> String? {
        guard let opDate = operationDate else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY"
        return dateFormatter.string(from: opDate)
    }
    /// Get item with same date, sort them alphabetically  if we have same dates
    /// - Parameter operations: operations array to sort
    /// - Returns  operations arrays result
    func filterDuplicates(operations: [OperationCellViewModel])->[OperationCellViewModel]
    {
        let operationsResult = operations.sorted { lhs, rhs in
            if lhs.operationDateString == rhs.operationDateString {
                return lhs.operationTitle.lowercased() < rhs.operationTitle.lowercased()
            }
            return false
        }
        return operationsResult
    }
}

