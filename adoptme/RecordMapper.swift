//
//  RecordMapper.swift
//  adoptme
//
//  Created by Raul Rodriguez on 02/09/2019.
//  Copyright © 2019 Raul Rodriguez. All rights reserved.
//

import Foundation
import FirebaseFirestore

extension Record{
    
    func toRecordDto() -> RecordDto {
        return RecordDto(
            id: self.id,
            uid: self.uid?.documentID.self ?? "",
            animal: self.animal,
            sex: self.sex,
            name: self.name,
            age: self.age,
            isDeleted: self.isDeleted,
            imageUrl: self.imageUrl
        
        )
    }
}

extension RecordDto{
    
    func toRecord() -> Record {
        
        var emptyDictionary = [String: Any]()
          var populatedDictionary = ["id": self.id,
                                   "uid": Firestore.firestore().collection("users").document(self.uid),
                                   "animal": self.animal,
                                   "sex": self.sex,
                                   "name": self.name,
                                   "deleted": self.isDeleted,
                                   "imageUrl": self.imageUrl] as [String : Any]
  
        return Record(dictionary: populatedDictionary)
    }
}

