//
//  BankAccountCell.swift
//  BankingApp
//
//  Created by Mohamed Ali BELHADJ on 08/05/2023.
//

import UIKit

class BankAccountCell: UITableViewCell {

    @IBOutlet  var accountTitleLabel: UILabel!
    @IBOutlet  var accountAmountLabel: UILabel!
    @IBOutlet  var arrowImageView: UIImageView!
    @IBOutlet  var tableView: InnerAutoTableView!
    static var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    static var identifier: String { return String(describing: self) }
    var bankAccount : BankAccount?
    var cellViewModel: BankAccountCellViewModel? {
        didSet {
            accountTitleLabel.text = cellViewModel?.bankAccountTitle
            accountAmountLabel.text = cellViewModel?.bankAccountAmount
                arrowImageView.transform = CGAffineTransform.identity
            if cellViewModel?.isCollapsed == true
                {
                    arrowImageView.transform = arrowImageView.transform.rotated(by: .pi * 2)
                }
                else
                {
                    arrowImageView.transform = arrowImageView.transform.rotated(by: -.pi)
                }
        }
    }
    private func setupUI()
    {
        tableView?.register(SubAccountCell.nib, forCellReuseIdentifier: SubAccountCell.identifier)
        tableView?.isScrollEnabled = false
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numRows = (cellViewModel?.isCollapsed == true) ? cellViewModel?.subAccountsCellViewModels.count : 0
        return numRows ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SubAccountCell.identifier, for: indexPath) as! SubAccountCell
        let cellViewModel = cellViewModel?.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellViewModel
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellViewModel?.didTapOnAccount(account: (cellViewModel?.getCellViewModel(at: indexPath).accountModel)!)
    }
}


