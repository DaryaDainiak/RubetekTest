//
//  ViewController.swift
//  RubetekTest
//
//  Created by Aliaksandr Dainiak on 9/21/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var cameraTableView: UITableView!
    private let imageCell = "imageCell"
    
    private let networkManager: NetworkManagerProtocol = NetworkManager()
    
    private var rooms: [String] = []
    private var cameras: [Camera] = []
    
    private var buttonIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        
        getRooms()
    }
    
    
    private func setUpTableView() {
        cameraTableView.delegate = self
        
        cameraTableView.dataSource = self
        //
        //        cameraTableView.rowHeight = UITableView.automaticDimension;
        //        cameraTableView.estimatedRowHeight = 44.0
    }
    
    private func getRooms() {
        networkManager.getRooms { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.rooms = data.room
                self.cameras = data.cameras
                DispatchQueue.main.async {
                    self.cameraTableView.reloadData()
                }
            case .failure:
                break
            }
        }
    }
    
    private func getDoors() {
        //        networkManager.getDoors { [weak self] result in
        //            guard let self = self else { return }
        //            switch result {
        //            case .succes(let data):
        //                self.rooms = data.room
        //                self.cameras = data.cameras
        //                DispatchQueue.main.async {
        //                    tableView.reload()
        //                }
        //            case .failure:
        //                break
        //            }
        //        }
    }
    
    @objc private func roomsButtonAction() {
        buttonIndex = 0
        getRooms()
    }
    
    @objc private func doorsButtonAction() {
        buttonIndex = 1
        getDoors()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if buttonIndex == 0 {
            let filteredCameras = cameras.filter { $0.room == rooms[section]}
            return filteredCameras.count
            
        } else {
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if buttonIndex == 0 {
            
            return rooms.count
        } else {
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: imageCell, for: indexPath) as? CameraCell else { return UITableViewCell() }
        cell.fill(camera: cameras[indexPath.row])
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        headerView.backgroundColor = .white
        
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
        if buttonIndex == 0 {
            return 275
        } else {
            return 60 //UITableView.automaticDimension
        }
    }
}


