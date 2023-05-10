//
//  BankingAppTests.swift
//  BankingAppTests
//
//  Created by Mohamed Ali BELHADJ on 10/05/2023.
//

import XCTest
@testable import BankingApp

final class BankAccountViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    override class func setUp() {
        
    }
    override class func tearDown() {
        
    }
    func testCreateBankAccountCellModel()
    {
        let bankAccountViewModel = BankAccountCellViewModel(bankAccountTitle: "Compte de dépôt", bankAccountAmount: "30.0", bankAccountModel: BankAccount(accounts: [Account(balance: 30.0,label: "Compte de dépôt")], isCA: 1, name: "CA 1"))
        let account = Account(balance: 30.0,label: "Compte de dépôt")
        let cellAccountViewModel = bankAccountViewModel.createCellModel(subAccount: account)
        XCTAssert(cellAccountViewModel.accountTitle == account.label , "the two fields are not identical")
        XCTAssert(cellAccountViewModel.accountAmount == String(format: "%.2f €", account.balance ?? 0.0), "the two fields are not identical")
    }
   
    func testGetBankAccountViewModel()
    {
        let bankAccountsArray : [BankAccount] = [BankAccount(accounts: [Account(balance: 30.0,label: "Compte de dépôt")], isCA: 1, name: "CA 1"),BankAccount(accounts: [Account(balance: 20.0,label: "Compte joint")], isCA: 0, name: "Banque pop"),BankAccount(accounts: [Account(balance: 25.0,label: "Compte joint")], isCA: 1, name: "CA 2"),]
        let accountsViewModel = MyAccountsViewModel()
        accountsViewModel.fetchData(bankAccounts: bankAccountsArray)
        let CABankAccountsViewModel = accountsViewModel.CABankAccountsViewModels.first
        let subAccountViewModel = CABankAccountsViewModel?.getCellViewModel(at: IndexPath(row: 0, section: 0))
        XCTAssert(subAccountViewModel?.accountTitle == "Compte de dépôt" , "the two fields are not identical")
    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
