//
//  CameraCell.swift
//  RubetekTest
//
//  Created by Darya Dainiak on 9/21/21.
//

import UIKit
import Kingfisher

final class CameraCellView: BaseTableCell {

    @IBOutlet var titleLable: UILabel!{
        didSet {
            titleLable.isUserInteractionEnabled = true
        }
    }
//    @IBOutlet var icon: UIImageView!
//    @IBOutlet var lock: UIImageView!
    @IBOutlet var cameraView: UIImageView!
//    @IBOutlet var rec: UIImageView!
//    @IBOutlet var favorites: UIImageView!
    @IBOutlet var backView: UIView! {
        didSet {
            backView.isUserInteractionEnabled = true
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        cameraView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    override func prepareForReuse() {
        cameraView.kf.cancelDownloadTask()
    }
    
    func configure(with camera: Camera) {
        titleLable.text = camera.name
//        icon.isHidden = true
//        lock.isHidden = true
        
        let imageUrl = camera.snapshot
        if let url = URL(string: imageUrl) {
            cameraView.kf.setImage(with: url)
        }
//        favorites.isHidden = !camera.favorites
//        rec.isHidden = !camera.rec
    }
    
    func configure(with doors: Door) {
        titleLable.text = doors.name
//        icon.isHidden = true
//        lock.isHidden = false
        if let url = URL(string: doors.snapshot ?? " ") {
            cameraView.kf.setImage(with: url)
        }
//        favorites.isHidden = true
//        rec.isHidden = true

    }
}
