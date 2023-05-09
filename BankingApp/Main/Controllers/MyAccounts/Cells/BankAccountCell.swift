//
//  BankAccountCell.swift
//  BankingApp
//
//  Created by Mohamed Ali BELHADJ on 08/05/2023.
//

import UIKit

class BankAccountCell: UITableViewCell {

    @IBOutlet weak var accountTitleLabel: UILabel?
    @IBOutlet weak var accountAmountLabel: UILabel?
    @IBOutlet weak var tableView: InnerAutoTableView?
    var navc : UINavigationController?
    static var identifier: String { return String(describing: self) }
    static var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tableView?.register(SubAccountCell.nib, forCellReuseIdentifier: SubAccountCell.identifier)
        self.tableView?.isScrollEnabled = false
        self.tableView?.rowHeight = UITableView.automaticDimension
        self.tableView?.estimatedRowHeight = 0
        // Initialization code
    }
    var bankAccount : BankAccount?
    var cellViewModel: BankAccountCellViewModel? {
        didSet {
            self.accountTitleLabel?.text = self.cellViewModel?.bankAccountTitle
            self.accountAmountLabel?.text = self.cellViewModel?.bankAccountAmount
            DispatchQueue.main.async {
                self.tableView?.reloadData()
            }
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension BankAccountCell : UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellViewModel?.subAccountsCellViewModels.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SubAccountCell.identifier, for: indexPath) as! SubAccountCell
        let cellViewModel = self.cellViewModel?.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellViewModel
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellViewModel = self.cellViewModel?.getCellViewModel(at: indexPath)
        let accountCoordinator = AccountCoordinator(account: cellViewModel?.accountModel , navc: self.navc)
        accountCoordinator.start()
    }
}


class InnerAutoTableView: UITableView {
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return self.contentSize
    }
    
    override var contentSize: CGSize {
        didSet{
            self.invalidateIntrinsicContentSize()
        }
    }
    override func reloadData() {
      super.reloadData()
      self.invalidateIntrinsicContentSize()
    }
}
