//
//  Models.swift
//  fb-info
//
//  Created by Mason Macias on 8/30/17.
//  Copyright © 2017 griffinmacias. All rights reserved.
//

import Foundation

struct User {
    var first: String
    var last: String
    var email: String
    var pictureUrl: String
    
    init?(_ dictionary: [String: Any]) {
        
        guard let first = dictionary["first_name"] as? String,
            let last = dictionary["last_name"] as? String,
            let email = dictionary["email"] as? String,
            let pictureInfo = dictionary["picture"] as? [String: Any],
            let pictureData = pictureInfo["data"] as? [String: Any],
            let pictureURL = pictureData["url"] as? String else { return nil }
        self.first = first
        self.last = last
        self.email = email
        self.pictureUrl = pictureURL
    }
}
