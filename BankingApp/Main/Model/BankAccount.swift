//
//  BankAccount.swift
//  BankingApp
//
//  Created by Mohamed Ali BELHADJ on 08/05/2023.
//
import Foundation

// MARK: - BankAccount
struct BankAccount:Codable {
    var accounts: [Account]?
    var isCA: Int?
    var name: String?

    init(accounts: [Account]?, isCA: Int?, name: String?) {
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
