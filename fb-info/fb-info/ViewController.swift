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

    override func viewDidLoad() {
        super.viewDidLoad()
        let loginButton = LoginButton(readPermissions: [ .publicProfile, .email ])
        loginButton.delegate = self
        loginButton.center = view.center
        if let _ = AccessToken.current {
            let request = GraphRequest(graphPath: "me",
                                       parameters: [ "fields": "first_name, last_name, picture, email" ])
            request.start { (response, result) in
                switch result {
                case .failed(let error):
                    print(error)
                case .success(response: _):
                    print(result)
                }
            }
        } 

        view.addSubview(loginButton)
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
