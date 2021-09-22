//
//  LableCell.swift
//  RubetekTest
//
//  Created by Darya Dainiak on 9/22/21.
//

import UIKit

class LableCell: UITableViewCell {
    @IBOutlet var backView: UIView!{
        didSet {
            backView.layer.cornerRadius = 20
            backView.clipsToBounds = true
        }
    }
    @IBOutlet var lockImage: UIImageView!
    @IBOutlet var titleLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillDoors(doors: Door) {
        titleLable.text = doors.name
    }
}
