//
//  ListViewController.swift
//  RandomUsersAPI
//
//  Created by Brian Jiménez Moedano on 23/05/23.
//

import UIKit

class ListViewController: UIViewController {
    
    init(arrayOfUsers: [User]) {
        
        users = arrayOfUsers
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private (set) var users: [User]
    private var listView: ListView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listView = ListView(viewController: self)
        listView?.configView()
    }
    
    override func viewDidLayoutSubviews() {
        
        listView?.resizeUserCollectionView()
    }

}

extension ListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let listView else { return UICollectionViewCell() }
        return listView.userCollectionViewCellForRowAt(indexPath)
    }
}

extension ListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        show(DetailsViewController(user: users[indexPath.row]), sender: self)
    }
}
