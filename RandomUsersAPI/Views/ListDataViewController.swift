//
//  ListDataViewController.swift
//  RandomUsersAPI
//
//  Created by Brian Jiménez Moedano on 23/05/23.
//

import UIKit

class ListDataViewController: UIViewController {
    
    init(rawUserList: [User]) {
        
        self.rawUserList = rawUserList
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private (set) var rawUserList: [User]
    private var listDataView: ListDataView?

    override func viewDidLoad() {
        super.viewDidLoad()

        listDataView = ListDataView(viewController: self)
        listDataView?.configView()
    }
    
    override func viewDidLayoutSubviews() {
        
        listDataView?.resizeUserTableView()
    }

}

extension ListDataViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        rawUserList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let listDataView else { return UITableViewCell() }
        return listDataView.userTableViewCellForRowAt(indexPath)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        guard let listDataView else { return nil }
        return listDataView.userTableViewHeaderTitle()
    }
}

extension ListDataViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        show(DetailsViewController(user: rawUserList[indexPath.row]), sender: self)
    }
}
