//
//  FirebaseRepository.swift
//  adoptme
//
//  Created by Raul Rodriguez on 02/09/2019.
//  Copyright © 2019 Raul Rodriguez. All rights reserved.
//

import Foundation

import Firebase




final class FirebaseRepository {
    

    private init() {
    }

    static func getAllRecords(animal: Animal?, completion: @escaping (_ result: [RecordDto])->()) {

        Firestore.firestore().collection("records").whereField("deleted", isEqualTo: false).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                if var data = querySnapshot?.documents.flatMap({
                    $0.data().flatMap({ (data) in
                        return Record(dictionary: data)
                    })
                }) {
                    completion(data.map({$0.toRecordDto()}))
                } else {
                    print("Document does not exist")
                }
            }
        }
       
    }
    
    
    
}
