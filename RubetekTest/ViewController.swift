//
//  ViewController.swift
//  RubetekTest
//
//  Created by Aliaksandr Dainiak on 9/21/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var cameraTableView: UITableView!
    private let titleCellId = "title"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
    }
    
    
    private func setUpTableView() {
        cameraTableView.delegate = self
        
        cameraTableView.dataSource = self
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: titleCellId, for: indexPath) as? CameraCell else { return UITableViewCell() }
        cell.fill()
        
        return cell
        
    }
}


