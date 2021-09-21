//
//  CameraCell.swift
//  RubetekTest
//
//  Created by Aliaksandr Dainiak on 9/21/21.
//

import UIKit

final class CameraCell: UITableViewCell {

    @IBOutlet var titleLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fill() {
        titleLable.text = "Гостиная"
    }

}
