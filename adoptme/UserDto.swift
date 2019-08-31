//
//  UserDto.swift
//  adoptme
//
//  Created by Raul Rodriguez on 31/08/2019.
//  Copyright © 2019 Raul Rodriguez. All rights reserved.
//

import Foundation


struct UserDto: Codable {
    var uid: String = ""
    var name: String = ""
    var email: String = ""
    var photoUrl: String = ""
    var emailVerified: Bool = false
    var description: String = ""
    var zip: String = ""
}
