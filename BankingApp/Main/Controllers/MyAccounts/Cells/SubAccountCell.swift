//
//  SubAccountCell.swift
//  BankingApp
//
//  Created by Mohamed Ali BELHADJ on 08/05/2023.
//

import UIKit

class SubAccountCell: UITableViewCell {

    @IBOutlet weak var subAccountTitleLabel: UILabel?
    @IBOutlet weak var subAccountAmountLabel: UILabel?
    static var identifier: String { return String(describing: self) }
    static var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var cellViewModel: SubAccountCellViewModel? {
        didSet {
            subAccountTitleLabel?.text = cellViewModel?.accountTitle
            subAccountAmountLabel?.text = cellViewModel?.accountAmount
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
