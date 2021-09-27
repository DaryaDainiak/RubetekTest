//
//  TableViewDataSource.swift
//  RubetekTest
//
//  Created by Darya Dainiak on 9/27/21.
//

import UIKit

// MARK: - SelfCreatingView

public protocol SelfCreatingView: UIView {
    static func createSelf() -> Self
}

public extension SelfCreatingView where Self: NibLoadable {
    static func createSelf() -> Self {
        return .loadFromNib()
    }
}

// MARK: - ConfigurableView

public protocol ConfigurableView {
    associatedtype ViewData

    func configure(with viewData: ViewData)
}

// MARK: - ConfigurableCell

public protocol ConfigurableCell {
    func configure(with viewData: Reusable)
}

// MARK: - ReusableCellItem

public protocol ReusableCellItem: Reusable {
    static var cellType: AnyClass? { get }
}

// MARK: - GenericTableViewCell

open class GenericTableViewCell<Content>:
  UITableViewCell,
  ConfigurableCell
where
  Content: ConfigurableView,
  Content: SelfCreatingView
{
    // MARK: - Private properties

    private lazy var content: Content = Content.createSelf()


    // MARK: - Initializers

    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubviewWithEdgeConstraints(content)
    }

    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: - Public methods

    public func configure(with model: Reusable) {
        guard let model = model as? Content.ViewData else {
            assertionFailure()

            return
        }

        content.configure(with: model)
    }
}

// MARK: - TableViewDataSource

open class TableViewDataSource:
    NSObject,
    UITableViewDataSource,
    UITableViewDelegate,
    UITableViewDataSourcePrefetching
{
    
    // MARK: - Public properties
    
    open weak var tableView: UITableView? {
        didSet {
            tableView?.delegate = self
            tableView?.dataSource = self

        }
    }
    
    open var items: [ReusableCellItem] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView?.reloadData()
            }
        }
    }
    
    
    // MARK: - Initializers
    
    public override init() {
        super.init()
    }

    public init(tableView: UITableView) {
        super.init()
        
        self.tableView = tableView
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
    }
    
    
    // MARK:- UITableViewDataSource
    
    open func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return items.count
    }
    
    open func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let item = items[indexPath.row]
        let itemType = type(of: item)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: itemType.reuseID) as? ConfigurableCell & UITableViewCell
        else {
            tableView.register(itemType.cellType, forCellReuseIdentifier: itemType.reuseID)
            return self.tableView(tableView, cellForRowAt: indexPath)
        }
        
        cell.configure(with: item)
 
        return cell
    }
    
    open func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        return nil
    }
    
    open func tableView(
        _ tableView: UITableView,
        viewForFooterInSection section: Int
    ) -> UIView? {
        return nil
    }
    
    open func tableView(
        _ tableView: UITableView,
        titleForFooterInSection section: Int
    ) -> String? {
        return nil
    }
    
    open func tableView(
        _ tableView: UITableView,
        titleForHeaderInSection section: Int
    ) -> String? {
        return nil
    }
    
    open func tableView(
        _ tableView: UITableView,
        canEditRowAt indexPath: IndexPath
    ) -> Bool {
        return false
    }
    
    open func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {}
    
    open func tableView(
        _ tableView: UITableView,
        moveRowAt sourceIndexPath: IndexPath,
        to destinationIndexPath: IndexPath
    ) {}
    
   
    // MARK: - UITableViewDataSourcePrefetching
    
    open func tableView(
        _ tableView: UITableView,
        prefetchRowsAt indexPaths: [IndexPath]) {}
    
    open func tableView(
        _ tableView: UITableView,
        cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {}
    
    
    // MARK: - UITableViewDelegate
    
    open func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath) {}
    
    open func tableView(
        _ tableView: UITableView,
        willDisplayHeaderView view: UIView,
        forSection section: Int) {}
    
    open func tableView(
        _ tableView: UITableView,
        willDisplayFooterView view: UIView,
        forSection section: Int) {}
    
    open func tableView(
        _ tableView: UITableView,
        didEndDisplaying cell: UITableViewCell,
        forRowAt indexPath: IndexPath) {}
    
    open func tableView(
        _ tableView: UITableView,
        didEndDisplayingHeaderView view: UIView,
        forSection section: Int) {}
    
    open func tableView(
        _ tableView: UITableView,
        didEndDisplayingFooterView view: UIView,
        forSection section: Int) {}
    
    open func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    open func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        return 0
    }
    
    open func tableView(
        _ tableView: UITableView,
        heightForFooterInSection section: Int
    ) -> CGFloat {
        return 0
    }
    
    open func tableView(
        _ tableView: UITableView,
        didHighlightRowAt indexPath: IndexPath) {}
    
    open func tableView(
        _ tableView: UITableView,
        didUnhighlightRowAt indexPath: IndexPath) {}
    
    open func tableView(
        _ tableView: UITableView,
        shouldHighlightRowAt indexPath: IndexPath
    ) -> Bool {
        return false
    }
    
    open func tableView(
        _ tableView: UITableView,
        willSelectRowAt indexPath: IndexPath
    ) -> IndexPath? {
        return indexPath
    }
    
    open func tableView(
        _ tableView: UITableView,
        willDeselectRowAt indexPath: IndexPath
    ) -> IndexPath? {
        return indexPath
    }
}

