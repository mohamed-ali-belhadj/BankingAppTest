//
//  Operation.swift
//  BankingApp
//
//  Created by Mohamed Ali BELHADJ on 08/05/2023.
//
import Foundation

// MARK: - Operation
struct Operation: Codable  {
    var amount: String?
    var category: String?
    var date: String?
    var id: String?
    var title: String?

    init(amount: String?, category: String?, date: String?, id: String?, title: String?) {
        self.amount = amount
        self.category = category
        self.date = date
        self.id = id
        self.title = title
    }
    enum CodingKeys: String, CodingKey {

        case amount = "amount"
        case category = "category"
        case date = "date"
        case id = "id"
        case title = "title"
    }
}
