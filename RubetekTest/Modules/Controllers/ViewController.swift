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
    
    
    @IBOutlet private var customSegmentedControl: UnderlineSegmentedControl!

    @IBOutlet private var cameraTableView: UITableView!
    private let networkService: NetworkService = NetworkService()
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
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            customSegmentedControl.frame.size.height = 50
            setUpSegmentedControl()
        }
    
    private func setUpNavBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
    }
    
    @objc private func handleRefresh(_ refreshControl: UIRefreshControl) {
        if customSegmentedControl.selectedSegmentIndex == 0 {
            getRooms(isRefresh: true)
        } else {
            getDoors(isRefresh: true)
        }
    }
    
    private func setUpTableView() {
        dataSource.tableView = cameraTableView
        dataSource.navigationController = navigationController
    }
    
    private func getRooms(isRefresh: Bool = false) {
        AllData.getData(isRefresh: isRefresh) { [weak self] result in
            self?.refreshControl.endRefreshing()
            switch result {
            case .success(let allData):
                self?.dataSource.items = allData.data.cameras
            case .failure(let error):
                self?.showAlert(error: error)
            }
        }
    }
    
    private func getDoors(isRefresh: Bool = false) {
        FullData.getData(isRefresh: isRefresh) { [weak self] result in
            self?.refreshControl.endRefreshing()
            switch result {
            case .success(let doors):
                self?.dataSource.items = doors
            case .failure(let error):
                self?.showAlert(error: error)
            }
        }
    }
    
    private func showAlert(error: Error? = nil) {
        let alert = UIAlertController(title: "Ошибка", message: "Ошибка сервиса", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func setUpSegmentedControl() {
        customSegmentedControl.addUnderlineForSelectedSegment(backgroundColor: .systemGray6, titleColor: .black, selectedColor: .systemTeal)
        customSegmentedControl.selectedSegmentIndex = 0
    }
    
    @IBAction private func tapSegment(_ sender: Any) {
        customSegmentedControl.changeUnderlinePosition()
        let segmentIndex = customSegmentedControl.selectedSegmentIndex
        if segmentIndex == 0 {
            getRooms()
        } else {
            getDoors()
        }
    }
}
