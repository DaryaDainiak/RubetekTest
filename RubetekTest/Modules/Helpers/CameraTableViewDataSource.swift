//
//  CameraTableViewDataSource.swift
//  RubetekTest
//
//  Created by Darya Dainiak on 9/28/21.
//

import UIKit

final class CameraTableViewDataSource: TableViewDataSource {
    var navigationController: UINavigationController?
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let dvc = DetailsViewController.instantiate()
        dvc.imageName = (items[indexPath.row] as? Camera)?.snapshot
        dvc.titleName =  (items[indexPath.row] as? Camera)?.name
        navigationController?.pushViewController(dvc, animated: true)
    }
}
