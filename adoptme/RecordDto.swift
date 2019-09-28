//
//  RecordDto.swift
//  adoptme
//
//  Created by Raul Rodriguez on 02/09/2019.
//  Copyright © 2019 Raul Rodriguez. All rights reserved.
//

import Foundation

struct RecordDto: Codable, Equatable, Comparable {
   
    static func < (lhs: RecordDto, rhs: RecordDto) -> Bool {
        lhs.id == rhs.id
    }
    
    var id: String = NSUUID().uuidString.lowercased()
    var uid: String = ""
    var animal: String = Animal.DOG.rawValue
    var sex: String = Sex.MALE.rawValue
    var name: String = ""
    var age: Int = -1
    var isDeleted: Bool = false
    var imageUrl: [String] = []
}
