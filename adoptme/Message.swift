//
//  Message.swift
//  adoptme
//
//  Created by Raul Rodriguez on 10/09/2019.
//  Copyright © 2019 Raul Rodriguez. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Message {
    
    var msg: String = ""
    var uid: DocumentReference? = nil
    var timeStamp: Timestamp? = nil
    
    init(dictionary: [String: Any]) {
        self.msg = dictionary["msg"] as! String
        self.uid = dictionary["uid"] as! DocumentReference
        self.timeStamp = dictionary["timeStamp"] as! Timestamp
    }
}
