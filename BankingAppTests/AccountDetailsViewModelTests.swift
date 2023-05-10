//
//  BankingAppTests.swift
//  BankingAppTests
//
//  Created by Mohamed Ali BELHADJ on 10/05/2023.
//

import XCTest
@testable import BankingApp

final class AccountDetailsViewModelTests: XCTestCase {

    func testFetchOperations()
    {
        let accountDetailViewModel = AccountDetailsViewModel(account: Account(balance: 20.0,label: "Compte joint",operations: [Operation(amount: "30.0", category: "leisure", date: "1644438769", id: "2", title: "Orange"),Operation(amount: "20.0", category: "costs", date: "1588690878", id: "2", title: "Tenue de compte")]))
        accountDetailViewModel.fetchOperations()
        XCTAssert(accountDetailViewModel.operationsCellViewModels.count == 2 , "There is a problem in the method of fetch operations")
    }
    func testCreateOperationCellModel()
    {
        let accountDetailViewModel = AccountDetailsViewModel(account: Account(balance: 20.0,label: "Compte joint"))
        let operation = Operation(amount: "30.0", category: "leisure", date: "1644438769", id: "2", title: "Orange")
        let operationDate = accountDetailViewModel.getOperationDate(operationDate: (operation.date) ?? "")
        let cellDetailAccountViewModel = accountDetailViewModel.createCellModel(operation: operation)
        XCTAssert(cellDetailAccountViewModel.operationTitle == operation.title , "the two fields are not identical")
        XCTAssert(cellDetailAccountViewModel.operationAmount == String (format: "%@ €", operation.amount ?? "") , "the two fields are not identical")
        XCTAssert(cellDetailAccountViewModel.operationDate == operationDate, "the two fields are not identical")
        XCTAssert(cellDetailAccountViewModel.operationDateString == accountDetailViewModel.getOperationDateString(operationDate: operationDate) , "the two fields are not identical")
    }
    func testGetBankAccountViewModel()
    {
        let operations = [Operation(amount: "30.0", category: "leisure", date: "1644438769", id: "2", title: "Orange"),Operation(amount: "20.0", category: "costs", date: "1588690878", id: "2", title: "Tenue de compte")]
        let accountDetailViewModel = AccountDetailsViewModel(account: Account(balance: 20.0,label: "Compte joint",operations: operations))
        accountDetailViewModel.fetchOperations()
        let operationCellViewModel = accountDetailViewModel.getCellViewModel(at: IndexPath(row: 0, section: 0))
        XCTAssert(operationCellViewModel.operationTitle == operations[0].title , "the two fields are not identical")
        XCTAssert(operationCellViewModel.operationAmount == String (format: "%@ €", operations[0].amount ?? "") , "the two fields are not identical")
    }
    func testGetOperationDate()
    {
        let accountDetailViewModel = AccountDetailsViewModel(account: Account(balance: 20.0,label: "Compte joint"))
        let date = accountDetailViewModel.getOperationDate(operationDate:"1588690878")
        XCTAssertNotNil(date,"Problem to convert operation date")
    }
    func testGetOperationDateString()
    {
        let accountDetailViewModel = AccountDetailsViewModel(account: Account(balance: 20.0,label: "Compte joint"))
        let date = accountDetailViewModel.getOperationDate(operationDate:"1588690878")
        let dateString = accountDetailViewModel.getOperationDateString(operationDate: date)
        XCTAssertNotNil(dateString,"Problem to convert operation date and get date string")
    }

}
