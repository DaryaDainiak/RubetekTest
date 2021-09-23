//
//  ViewController.swift
//  RubetekTest
//
//  Created by Darya Dainiak on 9/21/21.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet var cameraTableView: UITableView!
    @IBOutlet var cameraButton: UIButton!
    @IBOutlet var doorButton: UIButton!
    @IBOutlet var blueUnderline: UIView!
    @IBOutlet var grayUnderline: UIView!
    
    private let networkManager: NetworkManagerProtocol = NetworkManager()
    private let imageCell = "imageCell"
    private let lableCell = "lableCell"
    private var rooms: [String] = []
    private var cameras: [Camera] = []
    private var doors: [Door] = []
    
    private var buttonIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        getRooms()
    }
    
    private func setUpTableView() {
        cameraTableView.delegate = self
        cameraTableView.dataSource = self
    }
    
    private func getRooms(isRefresh: Bool = false) {
        networkManager.getRooms(isRefresh: isRefresh) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.rooms = Array(data.room)
                self.cameras = Array(data.cameras)
                DispatchQueue.main.async {
                    self.cameraTableView.reloadData()
                }
            case .failure:
                break
            }
        }
    }
    
    private func getDoors(isRefresh: Bool = false) {
        networkManager.getDoors(isRefresh: isRefresh) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.doors = data
                DispatchQueue.main.async {
                    self.cameraTableView.reloadData()
                }
            case .failure:
                break
            }
        }
    }
    
    func refresh() {
        getRooms(isRefresh: true)
        getDoors(isRefresh: true)
    }
    
    @IBAction func tapCamerasButton(_ sender: UIButton) {
        guard buttonIndex == 1 else { return }
        
        buttonIndex = 0
        grayUnderline.backgroundColor = UIColor.systemGray4
        blueUnderline.backgroundColor = UIColor.systemTeal
        getRooms()
    }
    
    @IBAction func tapDoorsButton(_ sender: UIButton) {
        guard buttonIndex == 0 else { return }
        
        buttonIndex = 1
        blueUnderline.backgroundColor = UIColor.systemGray4
        grayUnderline.backgroundColor = UIColor.systemTeal
        getDoors()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if buttonIndex == 0 {
            let filteredCameras = cameras.filter { $0.room == rooms[section]}
            return filteredCameras.count
            
        } else {
            return doors.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if buttonIndex == 0 {
            return rooms.count
        } else {
            return 1
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if buttonIndex == 0 {
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: imageCell, for: indexPath) as? CameraCell
            else
            { return UITableViewCell() }
            
            cell.fill(camera: cameras[indexPath.row])
            
            return cell
        } else if doors[indexPath.row].snapshot != nil {
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: imageCell, for: indexPath) as? CameraCell
            else
            { return UITableViewCell() }
            
            cell.fill(doors: doors[indexPath.row])
            
            return cell
        } else {
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: lableCell, for: indexPath) as? LableCell
            else
            { return UITableViewCell() }
            
            cell.fillDoors(doors: doors[indexPath.row])
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if buttonIndex == 0 {
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
            headerView.backgroundColor = .systemGray6
            
            let label = UILabel()
            label.frame = CGRect.init(x: 20, y: 5, width: headerView.frame.width - 10, height: headerView.frame.height - 10)
            label.text = rooms[section]
            label.font = .systemFont(ofSize: 16)
            label.textColor = .darkGray
            
            headerView.addSubview(label)
            
            return headerView
        } else {
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if buttonIndex == 0 {
            return 50
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if buttonIndex == 0 {
            return 315
        } else if doors[indexPath.row].snapshot != nil {
            return 305
        } else {
            return 121
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dvc = DetailsViewController()
        if buttonIndex == 0 {
            let tappedImage = cameras[indexPath.row].snapshot
            dvc.imageName = tappedImage
        }
    }
    
    private func handleMarkAsFavourite() {
        print("Marked as favourite")
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal,
                                        title: "Favourite") { [weak self] (action, view, completionHandler) in
            self?.handleMarkAsFavourite()
            completionHandler(true)
        }
        action.backgroundColor = .systemBlue
        
        let configuration = UISwipeActionsConfiguration(actions: [action])
        
        return configuration
    }
}


