//
//  MyAccountsController.swift
//  BankingApp
//
//  Created by Mohamed Ali BELHADJ on 07/05/2023.
//

import UIKit

class MyAccountsController: UIViewController {

    @IBOutlet weak var tableView: UITableView?
    
    lazy var indicatorView: UIActivityIndicatorView = {
      let view = UIActivityIndicatorView(style: .large)
      view.color = .gray
      view.startAnimating()
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
    }()
    lazy var viewModel = {
        MyAccountsViewModel()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Mes comptes"
        self.tableView?.register(BankAccountCell.nib, forCellReuseIdentifier: BankAccountCell.identifier)
        self.initViewModel()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    func initViewModel() {
        self.showActivityIndicator()
        viewModel.getBankAccounts()
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.hideActivityIndicator()
                self?.tableView?.reloadData()
            }
        }
    }
}
extension MyAccountsController : UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0
        {
            return self.viewModel.CABankAccountsViewModels.count
        }
        else
        {
            return self.viewModel.othersBankAccountsViewModels.count
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.viewModel.currentIndexsCollapsed.contains(indexPath)
        {
            return 60.0 + (CGFloat(viewModel.getCellViewModel(at: indexPath).subAccountsCellViewModels.count) * 60.0)
        }
        else
        {
            return 60.0
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Crédit Agricole"
        default:
            return "Autres Banques"
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BankAccountCell.identifier, for: indexPath) as! BankAccountCell
        var cellViewModel = viewModel.getCellViewModel(at: indexPath)
        cellViewModel.isCollapsed = self.viewModel.currentIndexsCollapsed.contains(indexPath)
        cell.cellViewModel = cellViewModel
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !self.viewModel.currentIndexsCollapsed.contains(indexPath)
        {
            self.viewModel.currentIndexsCollapsed.append(indexPath)
        }
        else
        {
            if let index = self.viewModel.currentIndexsCollapsed.firstIndex(of: indexPath) {
                self.viewModel.currentIndexsCollapsed.remove(at: index)
            }
        }
        DispatchQueue.main.async {
            self.tableView?.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}

extension MyAccountsController
{
    func showActivityIndicator() {
        self.view.addSubview(self.indicatorView)
        NSLayoutConstraint.activate([
            self.indicatorView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.indicatorView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
          ])
    }
    func hideActivityIndicator() {
        self.indicatorView.stopAnimating()
        self.indicatorView.removeFromSuperview()
    }
}
