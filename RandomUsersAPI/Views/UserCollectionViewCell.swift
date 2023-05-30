//
//  UserCollectionViewCell.swift
//  RandomUsersAPI
//
//  Created by Brian Jiménez Moedano on 24/05/23.
//

import UIKit

class UserCollectionViewCell: UICollectionViewCell {
    
    
    private lazy var label: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.backgroundColor = AppColors.accent.cgColor
        label.textColor = .black
        label.layer.shadowOpacity = 1
        label.layer.cornerRadius = 5
        label.textAlignment = .center
        return label
    }()
    
    private lazy var imageViewContainer: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.shadowOpacity = 1
        view.layer.cornerRadius = 40
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.layer.cornerRadius = 40
        return image
    }()
    
    private lazy var stack: UIStackView = {
        
        let stack = UIStackView(arrangedSubviews: [imageViewContainer, label])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    func configUICell(image: UIImage, title: String) {
        
        addSubview(stack)
        imageViewContainer.addSubview(imageView)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.topAnchor.constraint(equalTo: imageViewContainer.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: imageViewContainer.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: imageViewContainer.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: imageViewContainer.bottomAnchor)])
        label.text = title
        imageView.image = image
    }
}
