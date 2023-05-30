//
//  HomeView.swift
//  RandomUsersAPI
//
//  Created by Brian Jiménez Moedano on 27/04/23.
//
import UIKit

class HomeView {
    
    init(viewController: HomeViewController) {
        
        self.viewController = viewController
    }
    
    private unowned var viewController: HomeViewController
    
    private lazy var titleLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.attributedText = NSAttributedString(string: "Random Users Generator", attributes: [
            .strokeColor: UIColor.black,
            .foregroundColor: AppColors.text,
            .strokeWidth: -2.0,
            .font: UIFont.systemFont(ofSize: 30.0)])
        label.layer.shadowOpacity = 1
        return label
    }()
    
    private lazy var numberOfUsersLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.attributedText = NSAttributedString(string: "Number of users:", attributes: [
            .strokeColor: UIColor.black,
            .foregroundColor: AppColors.text,
            .strokeWidth: -2.0,
            .font: UIFont.systemFont(ofSize: 20.0)])
        label.layer.shadowOpacity = 1
        return label
    }()
    
    private lazy var numberOfUsersTextField: UITextField = {
        
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "10"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.layer.shadowOpacity = 0.5
        textField.widthAnchor.constraint(equalToConstant: 50).isActive = true
        return textField
    }()
    
    var numberOfUsersInput: Int {
        
        guard let numberOfUsersString = numberOfUsersTextField.text else { return 0 }
        guard let numberOfUsersInt = Int(numberOfUsersString) else { return 0 }
        return numberOfUsersInt
    }
    
    private lazy var generateUsersButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = AppColors.accent
        button.setTitle("GO!", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 14
        button.layer.shadowOpacity = 1
        button.addAction(.init(handler: { _ in
            button.layer.shadowOpacity = 0
        }), for: .touchDown)
        button.addAction(.init(handler: { _ in
            button.layer.shadowOpacity = 1
            self.viewController.generateUsers()
        }), for: .touchUpInside)
        button.addAction(.init(handler: { _ in
            button.layer.shadowOpacity = 1
        }), for: .touchUpOutside)
        return button
    }()
    
    private lazy var numberOfUsersStackView: UIStackView = {
        
        let stackView = UIStackView(arrangedSubviews: [numberOfUsersLabel, numberOfUsersTextField, generateUsersButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var showRawDataButton: UIButton = configHomeButton(title: "RAW DATA", action: viewController.showRawData)
    private lazy var showRawListButton: UIButton = configHomeButton(title: "RAW LIST", action: viewController.showRawList)
    private lazy var showListButton: UIButton = configHomeButton(title: "LIST", action: viewController.showList)
    
    private lazy var buttonStackView: UIStackView = {
        
        let stackView = UIStackView(arrangedSubviews: [showRawDataButton, showRawListButton, showListButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()
    
    private lazy var generatingUsersIndicator: UIActivityIndicatorView = {
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.backgroundColor = UIColor(white: 1, alpha: 0.5)
        activityIndicator.layer.cornerRadius = 5
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    private lazy var errorViewDisplay: UIView = {
        
        let view = UIView(frame: CGRect(x: -100, y: -100, width: 200, height: 100))
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        view.layer.shadowOpacity = 1
        view.alpha = 0.8
        return view
    }()
    
    private lazy var errorLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .black
        label.text = "ERROR. No se pudo completar la petición."
        return label
    }()
    
    func configView() {
        
        addTapGesture()
        viewController.view.backgroundColor = AppColors.main
        
        viewController.view.addSubview(titleLabel)
        viewController.view.addSubview(numberOfUsersStackView)
        viewController.view.addSubview(buttonStackView)
        viewController.view.addSubview(generatingUsersIndicator)
        viewController.view.addSubview(errorViewDisplay)
        errorViewDisplay.addSubview(errorLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            numberOfUsersStackView.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
            numberOfUsersStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            buttonStackView.topAnchor.constraint(equalTo: numberOfUsersStackView.bottomAnchor, constant: 30),
            buttonStackView.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
            generatingUsersIndicator.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor),
            generatingUsersIndicator.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: errorViewDisplay.centerYAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: errorViewDisplay.trailingAnchor, constant: -10),
            errorLabel.leadingAnchor.constraint(equalTo: errorViewDisplay.leadingAnchor, constant: 10)])
    }
    
    private func addTapGesture() {
        
        let tapGesture = UITapGestureRecognizer(target: viewController, action: #selector(viewController.hideKeyboard))
        viewController.view.addGestureRecognizer(tapGesture)
    }
    
    private func configHomeButton(title: String, action: @escaping  () -> ()) -> UIButton {
        
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.setAttributedTitle(NSAttributedString(string: title, attributes: [
            .font: UIFont.systemFont(ofSize: 20)]), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.shadowOpacity = 1
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        button.isEnabled = false
        button.addAction(.init(handler: { _ in
            button.layer.shadowOpacity = 0
        }), for: .touchDown)
        button.addAction(.init(handler: { _ in
            action()
            button.layer.shadowOpacity = 1
        }), for: .touchUpInside)
        button.addAction(.init(handler: { _ in
            button.layer.shadowOpacity = 1
        }), for: .touchUpOutside)
        return button
    }
    
    func enableButtons(_ enable: Bool, withError error: Bool = false) {
        
        generateUsersButton.isEnabled = enable
        if enable {
            
            generateUsersButton.backgroundColor = AppColors.accent
            generatingUsersIndicator.stopAnimating()
        } else {
            
            generateUsersButton.backgroundColor = .gray
            generatingUsersIndicator.startAnimating()
        }
        
        if !error {
            
            showRawDataButton.isEnabled = enable
            showRawListButton.isEnabled = enable
            showListButton.isEnabled = enable
            if enable {
                
                showRawDataButton.backgroundColor = AppColors.accent
                showRawListButton.backgroundColor = AppColors.accent
                showListButton.backgroundColor = AppColors.accent
            } else {
                
                showRawDataButton.backgroundColor = .gray
                showRawListButton.backgroundColor = .gray
                showListButton.backgroundColor = .gray
            }
        }
    }
    
    func displayErrorView(message: String) {
        
        generateUsersButton.isEnabled = false
        errorLabel.text = message
        errorViewDisplay.center.x = viewController.view.center.x
        errorViewDisplay.center.y = (viewController.view.frame.height * 0.8) + 600
        UIView.animate(withDuration: 0.8) { [weak self] in
            
            self?.errorViewDisplay.center.y -= 600
        } completion: { _ in
            
            UIView.animate(withDuration: 0.4, delay: 2, animations: { [weak self] in
                
                self?.errorViewDisplay.center.y += 600
            }, completion: { [weak self] _ in
                
                self?.generateUsersButton.isEnabled = true
            })
        }
    }
    
    func enableRawDataButton() {
        
        if numberOfUsersInput > 55 {
            
            showRawDataButton.isEnabled = false
            showRawDataButton.backgroundColor = .gray
            displayErrorView(message: "WARNING: Raw Data too large to display.")
        }
    }
    
}
