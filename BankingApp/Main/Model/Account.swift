//
//  Account.swift
//  BankingApp
//
//  Created by Mohamed Ali BELHADJ on 08/05/2023.
//
import Foundation

// MARK: - Account
public struct Account: Codable {
    public var balance: Double?
    public var contractNumber: String?
    public var holder: String?
    public var id: String?
    public var label: String?
    public var operations: [Operation]?
    public var order: Int?
    public var productCode: String?
    public var role: Int?

    public init(balance: Double?, contractNumber: String?, holder: String?, id: String?, label: String?, operations: [Operation]?, order: Int?, productCode: String?, role: Int?) {
        self.balance = balance
        self.contractNumber = contractNumber
        self.holder = holder
        self.id = id
        self.label = label
        self.operations = operations
        self.order = order
        self.productCode = productCode
        self.role = role
    }
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
