//
//  BubleChatViewReciver.swift
//  adoptme
//
//  Created by Raul Rodriguez on 09/09/2019.
//  Copyright © 2019 Raul Rodriguez. All rights reserved.
//

import UIKit

class BubleChatViewReciver: UITableViewCell {

    @IBOutlet weak var chat: UILabel!
    @IBOutlet weak var photo: UIImageView!
 
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(_ message: Message, _ url: String) {
        photo.layer.cornerRadius = 16;
        chat.text = message.msg
        photo.sd_setImage(with: URL(string: url))
    }
    
}
