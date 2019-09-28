//
//  ChatViewCell.swift
//  adoptme
//
//  Created by Raul Rodriguez on 28/09/2019.
//  Copyright © 2019 Raul Rodriguez. All rights reserved.
//

import UIKit

class ChatViewCell: UITableViewCell {

    @IBOutlet weak var tvName: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(_ usr: UserDto) {
           imgProfile.layer.cornerRadius = 32;
        tvName.text = usr.name
        imgProfile.sd_setImage(with: URL(string: usr.photoUrl))
       }
       
    
}
