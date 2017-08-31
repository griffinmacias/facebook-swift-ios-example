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
    override func viewDidLoad() {
        super.viewDidLoad()
        createFbLoginButton()
        if let _ = AccessToken.current {
            getFbInfo()
        }
    }
    
    func createFbLoginButton() {
        loginButton = LoginButton(readPermissions: [ .publicProfile, .email ])
        if let loginButton = loginButton {
            loginButton.delegate = self
            loginButton.center = view.center
            view.addSubview(loginButton)
        }
    }
    
    func getFbInfo() {
        let request = GraphRequest(graphPath: "me",
                                   parameters: [ "fields": "first_name, last_name, picture, email" ])
        request.start { (response, result) in
            switch result {
            case .failed(let error):
                print(error)
            case .success(let graphResponse):
                if let responseDictionary = graphResponse.dictionaryValue {
                    print(responseDictionary)
                    let user = User(responseDictionary)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        print(loginButton)
    }
}
