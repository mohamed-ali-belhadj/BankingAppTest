//
//  MyAccountsController.swift
//  BankingApp
//
//  Created by Mohamed Ali BELHADJ on 07/05/2023.
//

import UIKit

class AccountDetailsController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var subAccountTitleLabel: UILabel!
    @IBOutlet var subAccountAmountLabel: UILabel!
    var viewModel : AccountDetailsViewModel = AccountDetailsViewModel(account: Account())

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        fillData()
    }
    // MARK: Private methods
    private func setupUI()
    {
        navigationController?.setNavigationBarHidden(false, animated: true)
        tableView.register(OperationCell.nib, forCellReuseIdentifier: OperationCell.identifier)
    }
    private func fillData()
    {
        if let account = viewModel.accountModel
        {
            if let accountTitle = account.label
            {
                subAccountTitleLabel.text = accountTitle
            }
            if let accountAmount = account.balance
            {
                subAccountAmountLabel.text = String(format: "%.2f €", accountAmount)
            }
            viewModel.fetchOperations()
            tableView.reloadData()
        }
    }
}
extension AccountDetailsController : UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.operationsCellViewModels.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OperationCell.identifier, for: indexPath) as! OperationCell
        let cellViewModel = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellViewModel
        return cell
    }
}

