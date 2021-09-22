//
//  DetailsViewController.swift
//  RubetekTest
//
//  Created by Darya Dainiak on 9/22/21.
//

import UIKit
import Kingfisher

class DetailsViewController: UIViewController {

    @IBOutlet var selectedImage: UIImageView!
    var imageName: String?
    @IBOutlet var recView: UIView!
    @IBOutlet var openDoorButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpRoundedCorners()
    }
    
    private func setUpRoundedCorners() {
        recView.layer.cornerRadius = 7
        recView.clipsToBounds = true
        recView.layer.cornerRadius = 12
        recView.clipsToBounds = true
    }
    
    private func setUpImage() {
        if let url = URL(string: imageName ?? " ") {
            selectedImage.kf.setImage(with: url)
        }
    }
}
