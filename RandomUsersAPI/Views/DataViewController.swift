//
//  DataViewController.swift
//  RandomUsersAPI
//
//  Created by Brian Jiménez Moedano on 29/03/23.
//

import UIKit

class DataViewController: UIViewController {
    
    init (rawData: String) {
        
        usersRawData = rawData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private (set) var usersRawData: String
    var dataView: DataView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataView = DataView(viewController: self)
        dataView?.configView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        dataView?.loadRawData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        dataView?.updateScrollableHeight()
    }
}

