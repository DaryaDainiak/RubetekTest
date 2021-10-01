//
//  DoorsTableView.swift
//  RubetekTest
//
//  Created by Darya Dainiak on 10/1/21.
//

import UIKit

class DoorsTableView: BaseTableView {
    // MARK: - Consts enum
    
    enum Consts {
        static let imageCell = "CameraCellView"
        static let lableCell = "LableCellView"
    }

    override func setup() {
        register(UINib(nibName: Consts.imageCell, bundle: nil), forCellReuseIdentifier: Consts.imageCell)
        register(UINib(nibName: Consts.lableCell, bundle: nil), forCellReuseIdentifier: Consts.lableCell)
    }

}
