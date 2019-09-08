//
//  UserDtoExt.swift
//  adoptme
//
//  Created by Raul Rodriguez on 31/08/2019.
//  Copyright © 2019 Raul Rodriguez. All rights reserved.
//

import Foundation


final class Commons {
    private init() {
    }
    
    static func saveUserInMemory(user: UserDto){
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let jsonData = try encoder.encode(user)
            let jsonString = String(data: jsonData, encoding: .utf8)
            print("JSON String : " + jsonString!)
            
            UserDefaults.standard.set(jsonString, forKey: "USER")
        }
        catch {
        }
    }
    
    static func readUserInMemory() -> UserDto{
        let user = UserDefaults.standard.string(forKey: "USER") ?? ""
        var userDto : UserDto = UserDto()
        
        do{
            if let json = user.data(using: String.Encoding.utf8){
                    let jsonDecoder = JSONDecoder()
                    userDto = try jsonDecoder.decode(UserDto.self, from: json)
          }
        }catch {
            print(error.localizedDescription)
        }        
        return userDto
    }
    
}

extension String{
    func sortCombine(uid2 : String) -> String {
        var list = [self, uid2]
        list.sort()
        return  list[0] + "-" + list[1]
    }
}

