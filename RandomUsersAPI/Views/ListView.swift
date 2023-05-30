//
//  ListView.swift
//  RandomUsersAPI
//
//  Created by Brian Jiménez Moedano on 23/05/23.
//

import UIKit

class ListView {
    
    init(viewController: ListViewController) {
        
        self.viewController = viewController
    }
    
    private var viewController: ListViewController
    
    lazy private var userCollectionView: UICollectionView = {
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collection.dataSource = viewController
        collection.delegate = viewController
        collection.backgroundColor = AppColors.main
        collection.register(UserCollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        return collection
    }()
    
    func userCollectionViewCellForRowAt(_ indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = userCollectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! UserCollectionViewCell
        let url = URL(string: viewController.users[indexPath.row].picture.large)!
        Task {
            
            async let (data, _) = try URLSession.shared.data(from: url)
            var userImage: UIImage?
            await userImage = try? UIImage(data: data)
            if let userImage {
                
                await cell.configUICell(image: userImage, title: viewController.users[indexPath.row].name)
            } else {
               await  cell.configUICell(image: .init(systemName: "person.circle.fill")!, title: viewController.users[indexPath.row].name)
            }
        }
        return cell
    }
    
    func configView() {
        
        viewController.navigationController?.navigationBar.isHidden = false
        viewController.navigationController?.navigationBar.tintColor = .black
        viewController.view.addSubview(userCollectionView)
    }
    
    func resizeUserCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 200, height: 200)
        layout.minimumLineSpacing = 50
        switch UIDevice.current.orientation {
        
        case .landscapeLeft: layout.scrollDirection = .horizontal
        case .landscapeRight: layout.scrollDirection = .horizontal
        default: layout.scrollDirection = .vertical
        }
        userCollectionView.frame = viewController.view.frame
        userCollectionView.setCollectionViewLayout(layout, animated: false)
    }
}
