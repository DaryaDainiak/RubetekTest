//
//  ViewController.swift
//  RubetekTest
//
//  Created by Darya Dainiak on 9/21/21.
//

import UIKit

extension CameraCellView: ConfigurableView & NibLoadable & SelfCreatingView {
    typealias ViewData = Camera
}

extension Camera: ReusableCellItem {
    public static var cellType: AnyClass? {
            return GenericTableViewCell<CameraCellView>.self
        }
}

extension LableCellView: ConfigurableView & NibLoadable & SelfCreatingView {
    typealias ViewData = Door
}

extension Door: ReusableCellItem {
    public static var cellType: AnyClass? {
            return GenericTableViewCell<LableCellView>.self
        }
}


final class ViewController: UIViewController {
    
    @IBOutlet private var cameraTableView: UITableView!
    @IBOutlet private var cameraButton: UIButton!
    @IBOutlet private var doorButton: UIButton!
    @IBOutlet private var blueUnderline: UIView!
    @IBOutlet private var grayUnderline: UIView!
    private let networkManager: NetworkManagerProtocol = NetworkManager()
    private let networkService: NetworkService = NetworkService()
//    private let imageCell = "CameraCellView"
//    private let lableCell = "LableCellView"
//    private var rooms: [String] = []
//    private var cameras: [Camera] = []
//    private var doors: [Door] = []
    private var buttonIndex = 0
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor.lightGray
        
        return refreshControl
    }()
    
    var dataSource = CameraTableViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavBar()
        cameraTableView.refreshControl = refreshControl
        setUpTableView()
        getRooms()
    }
    
    private func setUpNavBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
    }
    
    @objc private func handleRefresh(_ refreshControl: UIRefreshControl) {
        if buttonIndex == 0 {
            getRooms(isRefresh: true)
        } else {
            getDoors(isRefresh: true)
        }
    }
    
    private func setUpTableView() {
        dataSource.tableView = cameraTableView
        dataSource.navigationController = navigationController
        
        //        cameraTableView.delegate = self
        //        cameraTableView.dataSource = self
        //        cameraTableView.register(UINib(nibName: "CameraCellView", bundle: nil), forCellReuseIdentifier: imageCell)
        //        cameraTableView.register(UINib(nibName: "LableCellView", bundle: nil), forCellReuseIdentifier: lableCell)
        
        //        instansesTableView.register(UINib(nibName: "DoorTableViewCell", bundle: nil), forCellReuseIdentifier: "doorCell")
        //        instansesTableView.register(UINib(nibName: "SmallDoorTableViewCell", bundle: nil), forCellReuseIdentifier: "smallDoorCell")
    }
    
    private func getRooms(isRefresh: Bool = false) {
        AllData.getData(isRefresh: isRefresh) { [weak self] result in
            
            switch result {
            case .success(let allData):
                self?.dataSource.items = allData.data.cameras
            case .failure(let error):
                self?.showAlert(error: error)
            }
        }
        
        
        //        self.rooms = rooms
        //        self.cameras = cameras
        //        DispatchQueue.main.async {
        //            self.cameraTableView.reloadData()
        //            self.refreshControl.endRefreshing()
        //        }
    }
    
    private func getDoors(isRefresh: Bool = false) {
        FullData.getData(isRefresh: isRefresh) { [weak self] result in
            
            switch result {
            case .success(let doors):
                self?.dataSource.items = doors
            case .failure(let error):
                self?.showAlert(error: error)
            }
        }
        
//        self.doors = doors
//        DispatchQueue.main.async {
//            self.cameraTableView.reloadData()
//            self.refreshControl.endRefreshing()
//        }
    }
    
    private func showAlert(error: Error? = nil) {
        let alert = UIAlertController(title: "Ошибка", message: "Ошибка сервиса", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction private func tapCamerasButton(_ sender: UIButton) {
        guard buttonIndex == 1 else { return }
        
        buttonIndex = 0
        grayUnderline.backgroundColor = UIColor.systemGray4
        blueUnderline.backgroundColor = UIColor.systemTeal
        getRooms()
    }
    
    @IBAction private func tapDoorsButton(_ sender: UIButton) {
        guard buttonIndex == 0 else { return }
        
        buttonIndex = 1
        blueUnderline.backgroundColor = UIColor.systemGray4
        grayUnderline.backgroundColor = UIColor.systemTeal
        getDoors()
    }
}

//extension ViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if buttonIndex == 0 {
//            let filteredCameras = cameras.filter { $0.room == rooms[section]}
//            return filteredCameras.count
//
//        } else {
//            return doors.count
//        }
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        if buttonIndex == 0 {
//            return rooms.count
//        } else {
//            return 1
//        }
//    }
//
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        if buttonIndex == 0 {
//            guard
//                let cell = tableView.dequeueReusableCell(withIdentifier: imageCell, for: indexPath) as? CameraCellView
//            else
//            { return UITableViewCell() }
//
//            cell.configure(with: cameras[indexPath.row])
//
//            return cell
//        } else if doors[indexPath.row].snapshot != nil {
//            guard
//                let cell = tableView.dequeueReusableCell(withIdentifier: imageCell, for: indexPath) as? CameraCellView
//            else
//            { return UITableViewCell() }
//
//            cell.configure(with: doors[indexPath.row])
//
//            return cell
//        } else {
//            guard
//                let cell = tableView.dequeueReusableCell(withIdentifier: lableCell, for: indexPath) as? LableCellView
//            else
//            { return UITableViewCell() }
//
//            cell.configure(with: doors[indexPath.row])
//
//            return cell
//        }
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        if buttonIndex == 0 {
//            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
//            headerView.backgroundColor = .systemGray6
//
//            let label = UILabel()
//            label.frame = CGRect.init(x: 20, y: 5, width: headerView.frame.width - 10, height: headerView.frame.height - 10)
//            label.text = rooms[section]
//            label.font = .systemFont(ofSize: 16)
//            label.textColor = .darkGray
//
//            headerView.addSubview(label)
//
//            return headerView
//        } else {
//            return UIView()
//        }
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if buttonIndex == 0 {
//            return 50
//        } else {
//            return 0
//        }
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if buttonIndex == 0 {
//            return 315
//        } else if doors[indexPath.row].snapshot != nil {
//            return 305
//        } else {
//            return 121
//        }
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        guard let dvc = storyboard.instantiateViewController(withIdentifier: "DetailsViewController")
//                // сделать в низкоуровневом контролере  class func -> controller  --> override class func с конкр именем и --> если надо данными для передачи в ините
//                as? DetailsViewController else { return }
//        if buttonIndex == 0 {
//            dvc.imageName = cameras[indexPath.row].snapshot
//            dvc.titleName = cameras[indexPath.row].name
//        } else {
//            if doors[indexPath.row].snapshot != nil {
//                dvc.imageName = doors[indexPath.row].snapshot
//                dvc.titleName = doors[indexPath.row].name
//            } else {
//                dvc.titleName = doors[indexPath.row].name
//            }
//        }
//
//        self.navigationController?.pushViewController(dvc, animated: true)
//    }
//
//    private func handleMarkAsFavourite() {
//        print("favourite tapped")
//    }
//
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let action = UIContextualAction(style: .normal,
//                                        title: nil) { [weak self] (action, view, completionHandler) in
//            self?.handleMarkAsFavourite()
//            completionHandler(true)
//        }
//        action.backgroundColor = .systemGray6
//
//        let favouriteImage = UIImage(systemName: "star")?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
//        action.image = favouriteImage
//
//        let configuration = UISwipeActionsConfiguration(actions: [action])
//
//        return configuration
//    }
//}
//
//
