//
//  CameraCell.swift
//  RubetekTest
//
//  Created by Aliaksandr Dainiak on 9/21/21.
//

import UIKit
import Kingfisher

final class CameraCell: UITableViewCell {

    @IBOutlet var titleLable: UILabel!
    @IBOutlet var subtitleLable: UILabel!
    @IBOutlet var icon: UIImageView!
    @IBOutlet var cameraView: UIImageView!
    @IBOutlet var rec: UIImageView!
    @IBOutlet var favorites: UIImageView!
    
    @IBOutlet var backView: UIView!
//    {
//        didSet {
//            backView.layer.cornerRadius = 20
//            backView.clipsToBounds = true
//        }
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        backView.layer.cornerRadius = 20
//        backView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        //TODO: -  отменить загрузку картинок , fk cancel
    }
    
    func fill(camera: Camera) {
        titleLable.text = camera.name
        subtitleLable.isHidden = true
        icon.isHidden = true
        if let url = URL(string: camera.snapshot) {
            cameraView.kf.setImage(with: url)
        }
        favorites.isHidden = !camera.favorites
        rec.isHidden = !camera.rec
        
    }
}
