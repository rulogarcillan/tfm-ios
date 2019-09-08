//
//  User.swift
//  adoptme
//
//  Created by Raul Rodriguez on 08/09/2019.
//  Copyright © 2019 Raul Rodriguez. All rights reserved.
//

import Foundation


struct User {
    var uid: String = ""
    var name: String = ""
    var email: String = ""
    var photoUrl: String = ""
    var emailVerified: Bool = false
    var description: String = ""
    var zip: String = ""
    
    
    init(dictionary: [String: Any]) {
        
        self.uid = dictionary["uid"] as! String
        self.name = dictionary["name"] as! String
        self.email = dictionary["email"] as! String
        self.photoUrl = dictionary["photoUrl"] as! String
        self.emailVerified = dictionary["emailVerified"] as! Bool
        self.description = dictionary["description"] as! String
        self.zip = dictionary["zip"] as! String
   
    }
}
