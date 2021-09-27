//
//  DetailsViewController.swift
//  RubetekTest
//
//  Created by Darya Dainiak on 9/22/21.
//

import UIKit
import Kingfisher

final class DetailsViewController: UIViewController {
    
    @IBOutlet private var titleLable: UILabel!
    @IBOutlet private var selectedImage: UIImageView!
//    @IBOutlet private var recView: UIView!
    @IBOutlet private var openDoorButton: UIButton!
    @IBOutlet private var numberLable: UILabel!
    @IBOutlet private var eye: UIImageView!
    @IBOutlet private var redDot: UIView!
    @IBOutlet private var textLable: UILabel!
    @IBOutlet private var shot: UIImageView!
    var imageName: String?
    var titleName: String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpImage()
        setUpRoundedCorners()
        title = titleName
        if imageName == nil {
            hideSubviews()
        }
    }
    
    private func setUpRoundedCorners() {
        redDot.layer.cornerRadius = 7
        redDot.layer.masksToBounds = true
        openDoorButton.layer.cornerRadius = 10
        openDoorButton.clipsToBounds = true
    }
    
    private func setUpImage() {
        if let imageName = imageName, let url = URL(string: imageName) {
            selectedImage.kf.setImage(with: url)
        }
    }
    
    private func hideSubviews() {
        selectedImage.isHidden = true
//        recView.isHidden = true
        eye.isHidden = true
        numberLable.isHidden = true
        redDot.isHidden = true
        shot.isHidden = true
        textLable.isHidden = true
    }
}
