//
//  OperationCell.swift
//  BankingApp
//
//  Created by Mohamed Ali BELHADJ on 08/05/2023.
//

import UIKit

class OperationCell: UITableViewCell {

    @IBOutlet weak var operationTitleLabel: UILabel?
    @IBOutlet weak var operationDateLabel: UILabel?
    @IBOutlet weak var operationAmountLabel: UILabel?
    static var identifier: String { return String(describing: self) }
    static var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var cellViewModel: OperationCellViewModel? {
        didSet {
            self.operationTitleLabel?.text = self.cellViewModel?.operationTitle
            self.operationAmountLabel?.text = self.cellViewModel?.operationAmount
            self.operationDateLabel?.text = self.cellViewModel?.operationDateString
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
