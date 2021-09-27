//
//  UIView+Autolayout.swift
//  RubetekTest
//
//  Created by Darya Dainiak on 9/27/21.
//
import UIKit

extension UIView {
    
    open func addSubviewWithAutolayout(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
    }
    
    open func addSubviewWithEdgeConstraints(_ view: UIView) {
        addSubviewWithAutolayout(view)
        NSLayoutConstraint.activate(
            [
                topAnchor.constraint(
                    equalTo: view.topAnchor
                ),
                leadingAnchor.constraint(
                    equalTo: view.leadingAnchor
                ),
                bottomAnchor.constraint(
                    equalTo: view.bottomAnchor
                ),
//                .withPriority(UILayoutPriority(rawValue: 999)),
                trailingAnchor.constraint(
                    equalTo: view.trailingAnchor
                )
//                .withPriority(UILayoutPriority(rawValue: 999))
            ]
        )
    }
}
