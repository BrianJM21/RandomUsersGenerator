//
//  DetailsView.swift
//  RandomUsersAPI
//
//  Created by Brian Jiménez Moedano on 25/05/23.
//

import UIKit
import SwiftUI

class DetailsView {
    
    init(viewController: DetailsViewController) {
        
        self.viewController = viewController
    }
    
    private unowned var viewController: DetailsViewController
    
    private lazy var userInfo: UITextView = {
        
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.shadowOpacity = 1
        textView.layer.borderWidth = 2.5
        textView.layer.shadowRadius = 10
        textView.layer.cornerRadius = 5
        textView.isEditable = false
        textView.textAlignment = .center
        let user = viewController.selectedUser
        textView.text = "Name: \(user.name)\nGender: \(user.gender), Age: \(user.dob.age), Nationality: \(user.nat)\n\nEmail: \(user.email), Phone Number: \(user.phone)\nUsername: \(user.login.username)\n\n\(user.address.streetName) \(user.address.streetNumber), \(user.address.city), \(user.address.state), \(user.address.country)"
        return textView
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
        let setImage: (UIImage) -> Void = { userImage in DispatchQueue.main.async { image.image = userImage } }
        let url = URL(string: self.viewController.selectedUser.picture.large)!
        Task {
            
            async let (data, _) = try URLSession.shared.data(from: url)
            var userImage: UIImage?
            await userImage = try? UIImage(data: data)
            if let userImage {
                
                setImage(userImage)
            } else {
                
                setImage(.init(systemName: "person.circle.fill")!)
            }
        }
        return image
    }()
    
    private lazy var stack: UIStackView = {
        
        let stack = UIStackView(arrangedSubviews: [imageViewContainer, userInfo])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 50
        stack.alignment = .center
        return stack
    }()
    
    func configView() {
        
        viewController.view.backgroundColor = AppColors.main
        viewController.view.addSubview(stack)
        imageViewContainer.addSubview(imageView)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor),
            imageView.topAnchor.constraint(equalTo: imageViewContainer.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: imageViewContainer.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: imageViewContainer.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: imageViewContainer.bottomAnchor),
            userInfo.widthAnchor.constraint(equalToConstant: 250),
            userInfo.heightAnchor.constraint(equalToConstant: 250)])
    }
    
    func arrangeSubViews() {
        
        switch UIDevice.current.orientation {
        
        case .landscapeLeft: stack.axis = .horizontal
        case .landscapeRight: stack.axis = .horizontal
        default: stack.axis = .vertical
        }
    }
}
