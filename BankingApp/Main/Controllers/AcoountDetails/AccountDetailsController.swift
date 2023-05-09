//
//  MyAccountsController.swift
//  BankingApp
//
//  Created by Mohamed Ali BELHADJ on 07/05/2023.
//

import UIKit

class AccountDetailsController: UIViewController {

    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var subAccountTitleLabel: UILabel?
    @IBOutlet weak var subAccountAmountLabel: UILabel?
    var viewModel: AccountDetailsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tableView?.register(OperationCell.nib, forCellReuseIdentifier: OperationCell.identifier)
        if let account = self.viewModel?.account
        {
            if let accountTitle = account.label
            {
                self.subAccountTitleLabel?.text = accountTitle
            }
            if let accountAmount = account.balance
            {
                self.subAccountAmountLabel?.text = String(format: "%.2f €", accountAmount)
            }
            self.viewModel?.fetchOperations()
            self.tableView?.reloadData()
        }
    }
}
extension AccountDetailsController : UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.operationsCellViewModels.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OperationCell.identifier, for: indexPath) as! OperationCell
        let cellViewModel = self.viewModel?.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellViewModel
        return cell
    }
}

