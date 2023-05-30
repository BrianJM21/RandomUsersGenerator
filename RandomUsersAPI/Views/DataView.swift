//
//  DataView.swift
//  RandomUsersAPI
//
//  Created by Brian Jiménez Moedano on 17/05/23.
//

import UIKit

class DataView {
    
    init(viewController: DataViewController) {
        
        self.viewController = viewController
    }
    
    private unowned var viewController: DataViewController
    
    private lazy var label: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = AppColors.text
        return label
    }()
    
    private lazy var scrollView: UIScrollView = {
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentScrollView: UIView = {
        
        let uiview = UIView()
        uiview.translatesAutoresizingMaskIntoConstraints = false
        return uiview
    }()
    
    private lazy var loadingRawDataIndicator: UIActivityIndicatorView = {
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.backgroundColor = UIColor(white: 1, alpha: 0.5)
        activityIndicator.layer.cornerRadius = 5
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    func configView() {
        
        viewController.view.backgroundColor = AppColors.main
        viewController.navigationController?.navigationBar.isHidden = false
        viewController.navigationController?.navigationBar.tintColor = .black
        
        viewController.view.addSubview(scrollView)
        scrollView.addSubview(contentScrollView)
        contentScrollView.addSubview(label)
        contentScrollView.addSubview(loadingRawDataIndicator)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.bottomAnchor),
            contentScrollView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentScrollView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentScrollView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentScrollView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentScrollView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            contentScrollView.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor),
            label.topAnchor.constraint(equalTo: contentScrollView.topAnchor),
            label.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentScrollView.trailingAnchor),
            loadingRawDataIndicator.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
            loadingRawDataIndicator.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor)])
    }
        
    func loadRawData() {
        
        loadingRawDataIndicator.startAnimating()
        DispatchQueue.main.async { [weak self] in
            
            self?.label.text = self?.viewController.usersRawData
            self?.updateScrollableHeight()
            self?.loadingRawDataIndicator.stopAnimating()
        }
    }
    
    func updateScrollableHeight() {
        
        for constraint in scrollView.constraints where constraint.identifier == "UIScrollView-frameLayoutGuide-height" {
            
            constraint.constant = label.intrinsicContentSize.height - scrollView.frame.height
        }
    }
}

