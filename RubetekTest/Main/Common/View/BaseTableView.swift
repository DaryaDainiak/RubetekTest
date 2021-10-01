//
//  BaseTableView.swift
//  RubetekTest
//
//  Created by Darya Dainiak on 9/30/21.
//

import UIKit

class BaseTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    struct Section {
        var name: String?
        var items = [BaseTableView.Item]()
    }
    
    struct Item {
        var id: String = "item"
        var data: Any?
    }
    
    var sections: [Section] = []
    var goDetails: ((UIViewController) -> Void)?

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        start()
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        start()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        start()
    }
    
    func start() {
        setup()
        
        dataSource = self
        delegate = self
        
    }
    
    func setup() {}
    
    func numberOfSections(in tableView: UITableView) -> Int {  sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = sections[indexPath.section].items[indexPath.row]
        let cell = dequeueReusableCell(withIdentifier: item.id, for: indexPath) as! BaseTableCell
        cell.configure(with: item)
        
        return cell
    }
}
