//
//  MessagesController.swift
//  adoptme
//
//  Created by Raul Rodriguez on 02/09/2019.
//  Copyright © 2019 Raul Rodriguez. All rights reserved.
//

import UIKit

class MessagesController: UIViewController {
    
    @IBOutlet weak var tableChat: UITableView!
    let userDto = Commons.readUserInMemory()
    var userChatsIds : [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        FirebaseRepository.getUserChats(userId: userDto.uid){ it in
            self.userChatsIds=it
            self.self.tableChat.reloadData()
        }
        tableChat.rowHeight = UITableView.automaticDimension
        tableChat.register((UINib(nibName: "ChatViewCell", bundle: nil)),forCellReuseIdentifier: "idCellChat")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = self.tableChat.indexPathForSelectedRow{
            self.tableChat.deselectRow(at: index, animated: true)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let chatController = segue.destination as? ChatViewController {
            
            let list: Array<Any> = sender as! Array
            
            chatController.chatId = list[0] as! String
            chatController.he = list[1] as? UserDto

        }
    }
}


extension MessagesController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userChatsIds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.separatorStyle = .none

        let item = tableView.dequeueReusableCell(withIdentifier: "idCellChat") as? ChatViewCell
     
        FirebaseRepository.getUserDataBase(userId: userChatsIds[indexPath.row]){user in
            item?.configureCell(user)
        }
                       
        return item ?? ChatViewCell()
    }   

}


extension MessagesController: UITableViewDelegate{
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let userPet = userChatsIds[indexPath.row]
        FirebaseRepository.getUserDataBase(userId: userPet){user in
            let chatId = self.userDto.uid.sortCombine(uid2: user.uid)
            self.performSegue(withIdentifier: "ChatSegue", sender: [chatId, user])
        }
        
    }
    
    

}

