//
//  BaseTableCell.swift
//  RubetekTest
//
//  Created by Darya Dainiak on 10/1/21.
//

import UIKit

class BaseTableCell: UITableViewCell  {

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
        setup()
    }

    func configure(with data: Any?) {}
    
    func setup() {
        
    }
}
