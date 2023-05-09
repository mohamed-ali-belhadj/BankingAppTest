//
//  Operation.swift
//  BankingApp
//
//  Created by Mohamed Ali BELHADJ on 08/05/2023.
//
import Foundation

// MARK: - Operation
public struct Operation: Codable  {
    public var amount: String?
    public var category: String?
    public var date: String?
    public var id: String?
    public var title: String?

    public init(amount: String?, category: String?, date: String?, id: String?, title: String?) {
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
