//
//  MyAccountsController.swift
//  BankingApp
//
//  Created by Mohamed Ali BELHADJ on 07/05/2023.
//

import UIKit

class MyAccountsController: UIViewController {

    @IBOutlet weak var tableView: UITableView?
    lazy var viewModel = {
        MyAccountsViewModel()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Mes comptes"
        self.tableView?.register(BankAccountCell.nib, forCellReuseIdentifier: BankAccountCell.identifier)
        initViewModel()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    func initViewModel() {
        // Get employees data
        viewModel.getBankAccounts()
        
        // Reload TableView closure
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView?.reloadData()
            }
        }
    }
    
}
extension MyAccountsController : UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.bankAccountsCellViewModels.count
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Crédit agricole"
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BankAccountCell.identifier, for: indexPath) as! BankAccountCell
        let cellViewModel = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellViewModel
        cell.navc = self.navigationController
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var isCollapsed =  false
        if self.viewModel.currentIndexCollapsed != indexPath.row
        {
            self.viewModel.currentIndexCollapsed = indexPath.row
            isCollapsed = true
        }
        else
        {
            self.viewModel.currentIndexCollapsed = -1
        }
        self.viewModel.updateCollapseValueForCellViewModel(at: indexPath, isCollapsed: isCollapsed)
        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
    }
}


