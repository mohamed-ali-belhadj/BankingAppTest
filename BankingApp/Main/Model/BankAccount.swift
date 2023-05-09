//
//  BankAccount.swift
//  BankingApp
//
//  Created by Mohamed Ali BELHADJ on 08/05/2023.
//
import Foundation

// MARK: - BankAccount
public struct BankAccount:Codable {
    public var accounts: [Account]?
    public var isCA: Int?
    public var name: String?

    public init(accounts: [Account]?, isCA: Int?, name: String?) {
        self.accounts = accounts
        self.isCA = isCA
        self.name = name
    }
    enum CodingKeys: String, CodingKey {

        case accounts = "accounts"
        case isCA = "isCA"
        case name = "name"
    }
}
