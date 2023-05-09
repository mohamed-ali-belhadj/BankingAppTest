//
//  MyAccountViewModel.swift
//  BankingApp
//
//  Created by Mohamed Ali BELHADJ on 07/05/2023.
//

import Foundation
final class AccountDetailsViewModel {
    var account: Account?
    init(account:Account?) {
        self.account = account
    }
    var operationsCellViewModels = [OperationCellViewModel]()
    func fetchOperations() {
        var operationsCellViewModels = [OperationCellViewModel]()
        guard let account = self.account else { return }
        guard let operations = account.operations else { return }
        for operation in operations{
            let operationVm = createCellModel(operation: operation)
            operationsCellViewModels.append(operationVm)
        }
        operationsCellViewModels.sort(by: { $0.operationDate?.compare($1.operationDate ?? Date()) == .orderedDescending })
        self.operationsCellViewModels = self.filterDuplicates(operations: operationsCellViewModels)
    }
    func createCellModel(operation: Operation?) -> OperationCellViewModel {
        let operationDate = self.getOperationDate(operationDate: (operation?.date) ?? "")
        return OperationCellViewModel(operationTitle: operation?.title ?? "", operationAmount:  String (format: "%@ €", operation?.amount ?? ""), operationDate: operationDate,operationDateString: self.getOperationDateString(operationDate: operationDate))
    }
    func getCellViewModel(at indexPath: IndexPath) -> OperationCellViewModel {
        return self.operationsCellViewModels[indexPath.row]
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
        var operationsDuplicated : [OperationCellViewModel] = [OperationCellViewModel]()
        var operationsResult : [OperationCellViewModel] = operations
        var firstRang : Int? = -1
        for operation in operations {
            operationsDuplicated.removeAll()
            firstRang = -1
            for op in operations {
                if op.operationDateString == operation.operationDateString
                {
                    operationsDuplicated.append(op)
                    if firstRang == -1
                    {
                        firstRang = operations.firstIndex{$0.operationDateString == op.operationDateString}
                    }
                }
                operationsDuplicated = operationsDuplicated.sorted { $0.operationTitle.localizedCaseInsensitiveCompare($1.operationTitle) == .orderedAscending }
                guard let rang = firstRang else { return operationsResult }
                if rang != -1
                {
                    operationsResult[rang...rang + operationsDuplicated.count-1] = operationsDuplicated[0...operationsDuplicated.count-1]
                }
            }
        }
        return operationsResult
    }
}

