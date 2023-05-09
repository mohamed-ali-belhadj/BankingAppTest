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

class BankAccountService: BankAccountServiceProtocol {
    func getBankAccounts(completion: @escaping (Bool, [BankAccount]?, String?) -> ()) {
        HttpRequestHelper().GET(url: "https://cdf-test-mobile-default-rtdb.europe-west1.firebasedatabase.app/banks.json", params: ["": ""], httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode([BankAccount].self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, "Error: Trying to parse BankAccounts to model")
                }
            } else {
                completion(false, nil, "Error: BankAccounts GET Request failed")
            }
        }
    }
}
