//
//  DetailsViewController.swift
//  RandomUsersAPI
//
//  Created by Brian Jiménez Moedano on 25/05/23.
//

import UIKit

class DetailsViewController: UIViewController {
    
    init(user: User) {
        
        selectedUser = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private (set) var selectedUser: User
    private var detailsView: DetailsView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailsView = DetailsView(viewController: self)
        detailsView?.configView()
    }
    
    override func viewDidLayoutSubviews() {
        
        detailsView?.arrangeSubViews()
    }

}
