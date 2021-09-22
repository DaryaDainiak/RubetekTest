//
//  HeaderView.swift
//  RubetekTest
//
//  Created by Aliaksandr Dainiak on 9/22/21.
//

import UIKit

class HeaderView: UIView {

//    @IBOutlet var titleLabel: UILabel!
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        
        return label
    }()
    
    func fill(title: String) {
        titleLabel.text = title
    }
    
    override init(frame: CGRect = .zero) {
            super.init(frame: frame)
            
            setupSubviews()
        }
            
        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    private func setupSubviews() {
        addSubview(titleLabel)
        
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
}
