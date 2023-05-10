//
//  BankingAppTests.swift
//  BankingAppTests
//
//  Created by Mohamed Ali BELHADJ on 07/05/2023.
//

import XCTest
@testable import BankingApp

final class MyAccountsViewModelTests: XCTestCase {

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
    func testGetBankAcountsApi() {
        XCTAssert(AppConstants.Link.bankAccountLink == "https://cdf-test-mobile-default-rtdb.europe-west1.firebasedatabase.app/banks.json", "bank account link is wrong")
        let getBankAcountsApiExpection = expectation(description: "BankAcountsApiExpection")
        var response = false
        MyAccountsViewModel().getBankAccounts { success, error in
            response = success
            getBankAcountsApiExpection.fulfill()
        }
        waitForExpectations(timeout: 2) { _ in
            XCTAssert(response == true,"get bank accounts api does not work")
        }
    }
    func testFetchDataForGetBankAccountApi()
    {
        let bankAccountsArray : [BankAccount] = [BankAccount(accounts: [Account(balance: 30.0,label: "Compte de dépôt")], isCA: 1, name: "CA 1"),BankAccount(accounts: [Account(balance: 20.0,label: "Compte joint")], isCA: 0, name: "Banque pop"),BankAccount(accounts: [Account(balance: 25.0,label: "Compte joint")], isCA: 1, name: "CA 2"),]
        let accountsViewModel = MyAccountsViewModel()
        accountsViewModel.fetchData(bankAccounts: bankAccountsArray)
        XCTAssert(accountsViewModel.CABankAccountsViewModels.count == 2, "there is a problem calculating the list of Credit Agricole accounts")
        XCTAssert(accountsViewModel.othersBankAccountsViewModels.count == 1, "there is a problem calculating the list of others banks accounts")
    }
    func testCreateAccountCellModel()
    {
        let accountsViewModel = MyAccountsViewModel()
        let bankAccountModel = BankAccount(accounts: [Account(balance: 30.0,label: "Compte de dépôt")], isCA: 1, name: "CA 1")
        let cellAccountViewModel = accountsViewModel.createCellModel(bankAccount:bankAccountModel )
        XCTAssert(cellAccountViewModel.bankAccountTitle == bankAccountModel.name , "the two fields are not identical")
        XCTAssert(cellAccountViewModel.bankAccountAmount == String(format: "%.2f €", accountsViewModel.getSumAmount(bankAccount: bankAccountModel)), "the two fields are not identical")
    }
    func testGetSumAmount() {
        let accountsViewModel = MyAccountsViewModel()
        let bankAccountModel = BankAccount(accounts: [Account(balance: 30.0,label: "Compte de dépôt"),Account(balance: 25.0,label: "Compte joint")], isCA: 1, name: "CA 1")
        XCTAssert(accountsViewModel.getSumAmount(bankAccount: bankAccountModel) == 55.0,"the method sum does not work well")
    }
    func testGetCellViewModel()
    {
        let accountsViewModel = MyAccountsViewModel()
        let bankAccountsArray : [BankAccount] = [BankAccount(accounts: [Account(balance: 30.0,label: "Compte de dépôt")], isCA: 1, name: "CA 1"),BankAccount(accounts: [Account(balance: 20.0,label: "Compte joint")], isCA: 0, name: "Banque pop"),BankAccount(accounts: [Account(balance: 25.0,label: "Compte joint")], isCA: 1, name: "CA 2"),]
        accountsViewModel.fetchData(bankAccounts: bankAccountsArray)
        let cellViewModelCA = accountsViewModel.getCellViewModel(at: 0, type: .CA)
        XCTAssert(cellViewModelCA.bankAccountTitle == "CA 1", "get equivalents accounts for CA does not work well")
        let cellViewModelOthersBanks = accountsViewModel.getCellViewModel(at: 0, type: .Other)
        XCTAssert(cellViewModelOthersBanks.bankAccountTitle == "Banque pop", "get equivalents accounts for others banks does not work well")
    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
