//
//  ChatViewController.swift
//  adoptme
//
//  Created by Raul Rodriguez on 08/09/2019.
//  Copyright © 2019 Raul Rodriguez. All rights reserved.
//

import UIKit
import Firebase
import MaterialComponents

class ChatViewController: UIViewController {
    
    @IBOutlet weak var msgBox: MDCTextField!
    @IBOutlet weak var tableChat: UITableView!
    var chatId : String = ""
    var listMessages: [Message] = []
    var me : UserDto? =  nil
    var he: UserDto? = nil
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        me = Commons.readUserInMemory()
        
        initChat(chatId: chatId)
        
        tableChat.rowHeight = UITableView.automaticDimension
     
        tableChat.register((UINib(nibName: "BubleChatViewReciver", bundle: nil)),forCellReuseIdentifier: "BubleChatViewReciver")
        
        tableChat.register((UINib(nibName: "BubbleChatViewIncome", bundle: nil)),forCellReuseIdentifier: "BubbleChatViewIncome")
        
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        if (!(msgBox.text?.elementsEqual("") ?? true)){
            FirebaseRepository.sendMessage(chatId: chatId, msg: MessageDto(msg: msgBox.text ?? "", uid: me?.uid ?? "", timeStamp: Timestamp(date: Date())))
            msgBox.text = ""
        }
    }
    
    

    func initChat(chatId: String) {
      let  docRef = Firestore.firestore().collection("chats").document(chatId).collection(chatId)
        
        docRef.addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
                    self.listMessages = document.documents.compactMap({
                    $0.data().flatMap({ (data) in
                        return Message(dictionary: data)
                    })
                })
                
               self.listMessages = self.listMessages.sorted { ($0.timeStamp?.compare($1.timeStamp!))!.rawValue < 0 }
                self.tableChat.reloadData()
                let lastRow: Int = self.tableChat.numberOfRows(inSection: 0) - 1
                let indexPath = IndexPath(row: lastRow, section: 0);
                if (self.listMessages.count > 0){
                    self.tableChat.scrollToRow(at: indexPath, at: .top, animated: false)
                }
            
        }
    }
    
    @IBAction func back(_ sender: Any) {
          dismiss(animated: true, completion: nil)
    }
    
}


extension ChatViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.separatorStyle = .none
     
        var cell : UITableViewCell = UITableViewCell()
        if (me?.uid == listMessages[indexPath.row].uid?.documentID){
            let item = tableView.dequeueReusableCell(withIdentifier: "BubleChatViewReciver") as? BubleChatViewReciver
            item?.configureCell(listMessages[indexPath.row], me?.photoUrl ?? "")
            item?.selectionStyle = .none
            cell = item ?? UITableViewCell()
        }else{
            let item = tableView.dequeueReusableCell(withIdentifier: "BubbleChatViewIncome") as? BubbleChatViewIncome
            item?.configureCell(listMessages[indexPath.row], he?.photoUrl ?? "")
            item?.selectionStyle = .none
            cell = item ?? UITableViewCell()
        }

        return cell
    }
        
}
