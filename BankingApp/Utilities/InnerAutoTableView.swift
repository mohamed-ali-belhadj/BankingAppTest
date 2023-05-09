//
//  InnerAutoTableView.swift
//  BankingApp
//
//  Created by Mohamed Ali BELHADJ on 09/05/2023.
//

import Foundation
import UIKit

class InnerAutoTableView: UITableView {
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return contentSize
    }
    
    override var contentSize: CGSize {
        didSet{
            invalidateIntrinsicContentSize()
        }
    }
    override func reloadData() {
      super.reloadData()
      invalidateIntrinsicContentSize()
    }
}
