//
//  MyAccountViewModel.swift
//  BankingApp
//
//  Created by Mohamed Ali BELHADJ on 07/05/2023.
//

import Foundation
final class AccountDetailsViewModel {
    var accountModel: Account?
    init(account:Account?) {
        accountModel = account
    }
    var operationsCellViewModels = [OperationCellViewModel]()
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
    func createCellModel(operation: Operation?) -> OperationCellViewModel {
        let operationDate = getOperationDate(operationDate: (operation?.date) ?? "")
        return OperationCellViewModel(operationTitle: operation?.title ?? "", operationAmount:  String (format: "%@ €", operation?.amount ?? ""), operationDate: operationDate,operationDateString: getOperationDateString(operationDate: operationDate))
    }
    func getCellViewModel(at indexPath: IndexPath) -> OperationCellViewModel {
        return operationsCellViewModels[indexPath.row]
    }
    func getOperationDate(operationDate:String) -> Date? {
        guard let operationTimeStamp = Double(operationDate) else { return nil }
        let date = Date(timeIntervalSince1970: operationTimeStamp)
        return date
    }
    func getOperationDateString(operationDate:Date?) -> String? {
        guard let opDate = operationDate else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY"
        return dateFormatter.string(from: opDate)
    }
    
    func filterDuplicates(operations: [OperationCellViewModel])->[OperationCellViewModel]
    {
        let operationsResult = operations.sorted { lhs, rhs in
            if lhs.operationDateString == lhs.operationDateString {
                return lhs.operationTitle.lowercased() < rhs.operationTitle.lowercased()
            }
            return true
        }
        return operationsResult
    }
}

