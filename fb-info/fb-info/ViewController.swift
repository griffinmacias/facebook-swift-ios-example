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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createFbLoginButton()
        self.createUserInfoView()
        //Check if already logged
        if let _ = AccessToken.current {
            self.getFbInfo()
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
        if let user = self.user,
            let first = user.first,
            let last = user.last,
            let email = user.email,
            let pictureUrl = user.pictureUrl,
            let userInfoView = self.userInfoView  {
            userInfoView.nameLabel.text = "\(first) \(last)"
            userInfoView.emailLabel.text = email
            
            if let pictureURL = URL(string: pictureUrl) {
                downloadProfilePic(pictureURL)
            }
        }
    }
    
    func createFbLoginButton() {
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
    
    // MARK: Network
    
    func downloadProfilePic(_ url: URL) {
        let session = URLSession(configuration: .default)
        let downloadPicTask = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error downloading picture: \(error)")
            } else {
                if let res = response as? HTTPURLResponse {
                    print("Downloaded fb profile picture with response code \(res.statusCode)")
                    if let imageData = data {
                        let image = UIImage(data: imageData)
                        DispatchQueue.main.async {
                            self.userInfoView?.imageView.image = image
                        }
                    } else {
                        print("Couldn't get image: Image is nil")
                    }
                } else {
                    print("Couldn't get response code for some reason")
                }
            }
        }
        downloadPicTask.resume()
    }
    
    func getFbInfo() {
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
            getFbInfo()
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
