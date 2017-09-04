//
//  Models.swift
//  fb-info
//
//  Created by Mason Macias on 8/30/17.
//  Copyright © 2017 griffinmacias. All rights reserved.
//

import Foundation

struct User {
    var first: String?
    var last: String?
    var email: String?
    var pictureUrl: String?
    
    init(_ dictionary: [String: Any]) {
        
        if let firstName = dictionary["first_name"] as? String {
            self.first = firstName
        }
        if let lastName = dictionary["last_name"] as? String {
            self.last = lastName
        }
        
        if let email = dictionary["email"] as? String {
            self.email = email
        }
        
        if let picture = dictionary["picture"] as? [String: Any],
        let data = picture["data"] as? [String: Any],
            let picURL = data["url"] as? String {
            self.pictureUrl = picURL
        }
    }
}
