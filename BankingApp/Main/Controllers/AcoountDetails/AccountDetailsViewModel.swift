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
        var operationsDateEqual = operationsCellViewModels.filterDuplicates { $0.operationDateString == $1.operationDateString}
        operationsDateEqual = operationsDateEqual.sorted { $0.operationTitle.localizedCaseInsensitiveCompare($1.operationTitle) == .orderedAscending }
        self.operationsCellViewModels = operationsDateEqual
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
}

extension Array {

    func filterDuplicates(includeElement: @escaping (_ lhs: Element, _ rhs: Element) -> Bool) -> [Element] {

        var results = [Element]()

        forEach { (element) in

            let existingElements = results.filter {
                return includeElement(element, $0)
            }

            if existingElements.count == 0 {
                results.append(element)
            }
        }
        return results
    }
}
