//
//  ViewController.swift
//  fb-info
//
//  Created by Mason Macias on 8/30/17.
//  Copyright © 2017 griffinmacias. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore

class ViewController: UIViewController {
    
    var loginButton: LoginButton?
    var userInfoView: UserInfoView?
    var user: User?
    var isAlreadyLoggedIn:Bool = (AccessToken.current != nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createFacebookLoginButton()
        self.createUserInfoView()
        if self.isAlreadyLoggedIn {
            self.getFacebookInfo()
        }
    }
    
    // MARK: Views
    
    func createUserInfoView() {
        let userInfoView = UserInfoView()
        view.addSubview(userInfoView)
        let margins = view.layoutMarginsGuide
        userInfoView.translatesAutoresizingMaskIntoConstraints = false
        userInfoView.centerYAnchor.constraint(equalTo: margins.centerYAnchor).isActive = true
        userInfoView.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        userInfoView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        userInfoView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        self.userInfoView = userInfoView
    }
    
    func updateUserView() {
        guard let user = self.user, let userInfoView = self.userInfoView else  { return }
            userInfoView.nameLabel.text = "\(user.first) \(user.last)"
            userInfoView.emailLabel.text = user.email
            
        guard let pictureURL = URL(string: user.pictureUrl) else { return }
        self.getProfilePic(with: pictureURL)
    }
    
    func createFacebookLoginButton() {
        loginButton = LoginButton(readPermissions: [ .publicProfile, .email ])
        if let loginButton = loginButton {
            loginButton.delegate = self
            view.addSubview(loginButton)
            loginButton.translatesAutoresizingMaskIntoConstraints = false
            let margins = view.layoutMarginsGuide
            loginButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -16).isActive = true
            loginButton.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        }
    }
    
    // MARK: Network calls
    
    func getProfilePic(with url: URL) {
        APIClient.shared.downloadData(with: url) { (data, error) in
            //
        }
    }
    
    func getFacebookInfo() {
        APIClient.shared.getFacebookInfo { (fbDictionary, error) in
            guard let fbDictionary = fbDictionary else {
                //update UI alert user of error
                return
            }
            self.user = User(fbDictionary)
            DispatchQueue.main.async {
                self.updateUserView()
            }
        }
    }
}

extension ViewController: LoginButtonDelegate {
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        switch result {
        case .success(let grantedPermissions, let declinedPermissions, let accessToken):
            print(accessToken)
            print(grantedPermissions)
            print(declinedPermissions)
            self.getFacebookInfo()
        case .cancelled:
            print("cancelled")
        case .failed(let error):
            print(error)
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        self.userInfoView?.clearContents()
    }
}
