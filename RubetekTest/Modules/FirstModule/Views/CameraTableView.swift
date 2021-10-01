//
//  CameraTableView.swift
//  RubetekTest
//
//  Created by Darya Dainiak on 9/29/21.
//

import UIKit

class CameraTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Nested enum
    
    enum Consts {
        static let imageCell = "CameraCellView"
        static let lableCell = "LableCellView"
    }
    
    public var goDetails: ((UIViewController) -> Void)?
    
    private var rooms: [String] = []
    private var cameras: [Camera] = []
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        register(UINib(nibName: "CameraCellView", bundle: nil), forCellReuseIdentifier: Consts.imageCell)
        register(UINib(nibName: "LableCellView", bundle: nil), forCellReuseIdentifier: Consts.lableCell)
    }
    
    @available(*, unavailable)
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        assertionFailure("init(frame:) has not been implemented")
    }
    
    func set(cameras: [Camera], rooms: [String]) {
        self.cameras = cameras
        self.rooms = rooms
        
        delegate = self
        dataSource = self
        
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let filteredCameras = cameras.filter { $0.room == rooms[section]}
        return filteredCameras.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return rooms.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: Consts.imageCell, for: indexPath) as? CameraCellView
        else
        { return UITableViewCell() }
        
        cell.configure(with: cameras[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        headerView.backgroundColor = .systemGray6
        
        let label = UILabel()
        label.frame = CGRect.init(x: 20, y: 5, width: headerView.frame.width - 10, height: headerView.frame.height - 10)
        label.text = rooms[section]
        label.font = .systemFont(ofSize: 16)
        label.textColor = .darkGray
        
        headerView.addSubview(label)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 315
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let dvc = DetailsViewController.instantiate()
        
        dvc.imageName = cameras[indexPath.row].snapshot
        dvc.titleName = cameras[indexPath.row].name
        
        goDetails?(dvc)
    }
    
    private func handleMarkAsFavourite() {
        print("Marked as favourite")
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal,
                                        title: nil) { [weak self] (action, view, completionHandler) in
            self?.handleMarkAsFavourite()
            completionHandler(true)
        }
        action.backgroundColor = .systemGray6
        action.image = UIImage(systemName: "star.fill")
        
        let configuration = UISwipeActionsConfiguration(actions: [action])
        
        return configuration
    }
}
