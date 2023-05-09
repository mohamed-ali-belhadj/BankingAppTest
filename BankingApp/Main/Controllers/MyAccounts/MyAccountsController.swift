//
//  MyAccountsController.swift
//  BankingApp
//
//  Created by Mohamed Ali BELHADJ on 07/05/2023.
//

import UIKit

class MyAccountsController: UIViewController {

    @IBOutlet var tableView: InnerAutoTableView!
    var indicatorView: UIActivityIndicatorView = {
      let view = UIActivityIndicatorView(style: .large)
      view.color = .gray
      view.startAnimating()
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
    }()
    var viewModel = MyAccountsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        initViewModel()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    private func setupUI()
    {
        title = "Mes comptes"
        tableView.register(BankAccountCell.nib, forCellReuseIdentifier: BankAccountCell.identifier)
    }
    private func initViewModel() {
        showActivityIndicator()
        viewModel.getBankAccounts {[weak self]  success, error  in
            if success == true
            {
                DispatchQueue.main.async {
                    self?.hideActivityIndicator()
                    self?.tableView.reloadData()
                }
            }
            else
            {
                if let errorString = error
                {
                    print(errorString)
                }
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
            return viewModel.CABankAccountsViewModels.count
        }
        else
        {
            return viewModel.othersBankAccountsViewModels.count
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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
        cellViewModel.isCollapsed.toggle()
        cell.cellViewModel = cellViewModel
        cell.tableView?.reloadData()
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            viewModel.CABankAccountsViewModels[indexPath.row].isCollapsed.toggle()
        } else {
            viewModel.othersBankAccountsViewModels[indexPath.row].isCollapsed.toggle()
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

extension MyAccountsController
{
    func showActivityIndicator() {
        view.addSubview(indicatorView)
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
          ])
    }
    func hideActivityIndicator() {
        indicatorView.stopAnimating()
        indicatorView.removeFromSuperview()
    }
}
