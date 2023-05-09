//
//  BankAccount.swift
//  BankingApp
//
//  Created by Mohamed Ali BELHADJ on 08/05/2023.
//
import Foundation

// MARK: - BankAccount
struct BankAccount:Codable {
    let accounts: [Account]?
    let isCA: Int?
    let name: String?

    enum CodingKeys: String, CodingKey {

        case accounts = "accounts"
        case isCA = "isCA"
        case name = "name"
    }
}
