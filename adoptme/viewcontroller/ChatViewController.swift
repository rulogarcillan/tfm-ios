//
//  ChatViewController.swift
//  adoptme
//
//  Created by Raul Rodriguez on 08/09/2019.
//  Copyright © 2019 Raul Rodriguez. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    
    var chatId : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        print(chatId)
    }
    
    @IBAction func back(_ sender: Any) {
          dismiss(animated: true, completion: nil)
    }

}
