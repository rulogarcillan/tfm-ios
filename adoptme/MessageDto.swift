//
//  MessageDto.swift
//  adoptme
//
//  Created by Raul Rodriguez on 11/09/2019.
//  Copyright © 2019 Raul Rodriguez. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct MessageDto {
    var msg: String = ""
    var uid: String = ""
    var timeStamp: Timestamp? = nil
}
