//
//  CameraCell.swift
//  RubetekTest
//
//  Created by Darya Dainiak on 9/21/21.
//

import UIKit
import Kingfisher

final class CameraCell: UITableViewCell {

    @IBOutlet var titleLable: UILabel!
//    @IBOutlet var subtitleLable: UILabel!
    @IBOutlet var icon: UIImageView!
    @IBOutlet var lock: UIImageView!
    @IBOutlet var cameraView: UIImageView!
    @IBOutlet var rec: UIImageView!
    @IBOutlet var favorites: UIImageView!
    
    @IBOutlet var backView: UIView! {
        didSet {
            backView.layer.cornerRadius = 20
            backView.clipsToBounds = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        cameraView.kf.cancelDownloadTask()
    }
    
    func fill(camera: Camera) {
        titleLable.text = camera.name
//        subtitleLable.isHidden = true
        icon.isHidden = true
        lock.isHidden = true
        
        let imageUrl = camera.snapshot
        if let url = URL(string: imageUrl) {
            cameraView.kf.setImage(with: url)
        }
        favorites.isHidden = !camera.favorites
        rec.isHidden = !camera.rec
        
    }
    
    func fill(doors: Door) {
        titleLable.text = doors.name
//        subtitleLable.isHidden = true
        icon.isHidden = true
        lock.isHidden = false
        if let url = URL(string: doors.snapshot ?? " ") {
            cameraView.kf.setImage(with: url)
        }
        favorites.isHidden = true
        rec.isHidden = true

    }
}
