//
//  UserMapper.swift
//  adoptme
//
//  Created by Raul Rodriguez on 31/08/2019.
//  Copyright © 2019 Raul Rodriguez. All rights reserved.
//

import Foundation
import Firebase


extension AuthDataResult{

    func toUserDto() -> UserDto {
        return UserDto( uid: self.user.uid,
                        name: self.user.displayName ?? "",
                        email: self.user.email ?? "",
                        photoUrl: self.user.photoURL?.absoluteString ?? "",
                        emailVerified: self.user.isEmailVerified,
                        description: "",
                        zip: "")
    }
}






