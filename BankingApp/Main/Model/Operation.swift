//
//  Operation.swift
//  BankingApp
//
//  Created by Mohamed Ali BELHADJ on 08/05/2023.
//
import Foundation

// MARK: - Operation
struct Operation: Codable  {
    let amount: String?
    let category: String?
    let date: String?
    let id: String?
    let title: String?
    
    enum CodingKeys: String, CodingKey {

        case amount = "amount"
        case category = "category"
        case date = "date"
        case id = "id"
        case title = "title"
    }
}
