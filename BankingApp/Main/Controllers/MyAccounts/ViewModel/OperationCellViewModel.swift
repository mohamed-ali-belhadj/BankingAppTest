//
//  OpertationCellViewModel.swift
//  BankingApp
//
//  Created by Mohamed Ali BELHADJ on 08/05/2023.
//

import Foundation
struct OperationCellViewModel {
    var operationTitle: String
    var operationAmount: String
    var operationDate: Date?
    var operationDateString: String?

    init(operationTitle: String, operationAmount: String, operationDate: Date? = nil,operationDateString:String? = nil) {
        self.operationTitle = operationTitle
        self.operationAmount = operationAmount
        self.operationDate = operationDate
        self.operationDateString = operationDateString
    }
}
