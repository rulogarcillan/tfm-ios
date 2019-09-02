//
//  RecordDto.swift
//  adoptme
//
//  Created by Raul Rodriguez on 02/09/2019.
//  Copyright © 2019 Raul Rodriguez. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Record {
    var id: String = NSUUID().uuidString.lowercased()
    var uid: DocumentReference? = nil
    var animal: String = Animal.DOG.rawValue
    var sex: String = Sex.MALE.rawValue
    var name: String = ""
    var age: Int = -1
    var isDeleted: Bool = false
    var imageUrl: [String] = []
    
    
    init(dictionary: [String: Any]) {

        self.id = dictionary["id"] as! String
        self.uid = dictionary["uid"] as! DocumentReference
        self.animal = dictionary["animal"] as! String
        self.sex = dictionary["sex"] as! String
        self.name = dictionary["name"] as! String
        self.age = dictionary["age"] as! Int
        self.isDeleted = dictionary["deleted"] as! Bool
        self.imageUrl = dictionary["imageUrl"] as! [String]
    }
}
