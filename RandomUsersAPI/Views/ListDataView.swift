//
//  ListDataViewController.swift
//  RandomUsersAPI
//
//  Created by Brian Jiménez Moedano on 23/05/23.
//

import UIKit

class ListDataView {
    
    init(viewController: ListDataViewController) {
        
        self.viewController = viewController
    }
    
    private unowned var viewController: ListDataViewController
    
    lazy private var userTableView: UITableView = {
        
        let table = UITableView(frame: viewController.view.frame, style: .insetGrouped)
        table.dataSource = viewController
        table.delegate = viewController
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.backgroundColor = AppColors.main
        return table
    }()
    
    func userTableViewCellForRowAt(_ indexPath: IndexPath) -> UITableViewCell {
        
        let cell = userTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var cellConfig = cell.defaultContentConfiguration()
        cellConfig.text = "\(indexPath.row + 1). \(viewController.rawUserList[indexPath.row].name)"
        cellConfig.secondaryText = ("age: \(viewController.rawUserList[indexPath.row].dob.age), nationality: \(viewController.rawUserList[indexPath.row].nat)")
        cell.contentConfiguration = cellConfig
        return cell
    }
    
    func userTableViewHeaderTitle() -> String {
        
        "List Of Users"
    }
    
    func configView() {
        
        viewController.navigationController?.navigationBar.isHidden = false
        viewController.navigationController?.navigationBar.tintColor = .black
        viewController.view.addSubview(userTableView)
    }
    
    func resizeUserTableView() {
        
        userTableView.frame.size = viewController.view.frame.size
    }
}
