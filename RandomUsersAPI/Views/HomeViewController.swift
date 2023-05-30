//
//  HomeViewController.swift
//  RandomUsersAPI
//
//  Created by Brian Jiménez Moedano on 27/04/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    var homeView: HomeView?
    var userData: UserData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeView = HomeView(viewController: self)
        homeView?.configView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.navigationBar.isHidden = true
    }
    
    @objc func hideKeyboard() {
        
        view.endEditing(true)
    }
    
    func generateUsers() {
        
        Task{
            
            guard let numberOfUsers = homeView?.numberOfUsersInput else { return }
            homeView?.enableButtons(false)
            if numberOfUsers > 0 {
                
                await userData = UserData(userCount: numberOfUsers)
            } else {
                
                await userData = UserData()
            }
            guard let _ = userData?.usersData else {
                
                homeView?.enableButtons(true, withError: true)
                homeView?.displayErrorView(message: "ERROR: Couldn't fetch or decode data from remote API.")
                return
            }
            homeView?.enableButtons(true)
            homeView?.enableRawDataButton()
        }
    }
    
    func showRawData() {
        
        guard let rawData = userData?.usersData else { return }
        show(DataViewController(rawData: rawData), sender: self)
    }
    
    func showRawList() {
        
        guard let rawArray = userData?.usersArray else { return }
        show(ListDataViewController(rawUserList: rawArray), sender: self)
    }
    
    func showList() {
        
        guard let rawArray = userData?.usersArray else { return }
        show(ListViewController(arrayOfUsers: rawArray), sender: self)
    }
}
