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
                if let data = querySnapshot?.documents.compactMap({
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
    
    
     static func getUserDataBase(userId: String, completion: @escaping (_ result: UserDto)->()) {
        
        Firestore.firestore().collection("users").document(userId).getDocument() {
            (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    if let data: User = User(dictionary: (querySnapshot?.data())!)  {
                       print(data.toUserDto())
                       completion(data.toUserDto())
                    }else{
                        print("Document does not exist")
                    }
               }
        }
    }
    
    
    static func deleteRecord(record: RecordDto) {
        let docRef = Firestore.firestore().collection("records").document(record.id)
        docRef.updateData(["deleted": true])
    }
    
    static func sendMessage(chatId: String, msg: MessageDto) {
        var map = [String: String]()
        map["dummy"] = "dummy"
        
        Firestore.firestore().collection("chats").document(chatId).setData(map)
        Firestore.firestore().collection("chats").document(chatId).collection(chatId).addDocument(data: msg.toDict())
        


    }

}
