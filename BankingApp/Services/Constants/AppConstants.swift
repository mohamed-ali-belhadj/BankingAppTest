//
//  AppConstants.swift
//  BankingApp
//
//  Created by MacBook Pro on 10/05/2023.
//

import Foundation
struct AppConstants {
    struct Link {
        static let bankAccountLink = "https://cdf-test-mobile-default-rtdb.europe-west1.firebasedatabase.app/banks.json"

    }
    static let environment: AppEnvironment = .mock
    
    struct Mock {
        static let bankAccountMockFile = "bank_account_mock_file"
    }
}

enum AppEnvironment {
    case mock, prod
}
