//
//  Account.swift
//  BankingApp
//
//  Created by Mohamed Ali BELHADJ on 08/05/2023.
//
import Foundation

// MARK: - Account
struct Account: Codable {
    var balance: Double?
    var contractNumber: String?
    var holder: String?
    var id: String?
    var label: String?
    var operations: [Operation]?
    var order: Int?
    var productCode: String?
    var role: Int?
    
    enum CodingKeys: String, CodingKey {

        case balance = "balance"
        case contractNumber = "contract_number"
        case holder = "holder"
        case id = "id"
        case label = "label"
        case operations = "operations"
        case order = "order"
        case productCode = "product_code"
        case role = "role"
    }
}
