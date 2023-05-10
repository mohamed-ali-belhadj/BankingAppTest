//
//  BankAccountService.swift
//  BankingApp
//
//  Created by Mohamed Ali BELHADJ on 08/05/2023.
//

import Foundation
protocol BankAccountServiceProtocol {
    func getBankAccounts(completion: @escaping (_ success: Bool, _ results: [BankAccount]?, _ error: String?) -> ())
}

final class BankAccountService: BankAccountServiceProtocol {
    func getBankAccounts(completion: @escaping (Bool, [BankAccount]?, String?) -> ()) {
        HttpRequestHelper().GET(url: AppConstants.Link.bankAccountLink, params: ["": ""], httpHeader: .application_json, type: [BankAccount].self, mockFilePath: AppConstants.Mock.bankAccountMockFile) { success, data in
            if success {
                    completion(true, data, nil)
            } else {
                completion(false, nil, "Error: BankAccounts GET Request failed")
            }
        }
    }
}
