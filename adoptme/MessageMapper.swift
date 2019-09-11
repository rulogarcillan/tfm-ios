//
//  MessageMapper.swift
//  adoptme
//
//  Created by Raul Rodriguez on 11/09/2019.
//  Copyright © 2019 Raul Rodriguez. All rights reserved.
//

import Foundation
import  Firebase


extension Message{
    
    func toMessageDto() -> MessageDto {
        return MessageDto(
            msg: self.msg,
            uid: self.uid?.documentID.self ?? "",
            timeStamp : self.timeStamp
        )
    }
}

extension MessageDto{
    
    func toMessage() -> Message {
        let populatedDictionary : [String: Any] = ["msg": self.msg,
                                                   "uid": Firestore.firestore().collection("users").document(self.uid),
                                                   "timeStamp": self.timeStamp]
        
        
        return Message(dictionary: populatedDictionary)
    }
}

extension MessageDto{
    func toDict() -> [String: Any] {
        return ["msg": self.msg,
                "uid": Firestore.firestore().collection("users").document(self.uid),
                "timeStamp": self.timeStamp]
        
    }
}

