//
//  MenuItemView.swift
//  adoptme
//
//  Created by Raul Rodriguez on 01/09/2019.
//  Copyright © 2019 Raul Rodriguez. All rights reserved.
//

import UIKit

class MenuItemView: UITableViewCell {
    
    @IBOutlet weak var lbTitle: UILabel!

    @IBOutlet weak var ivIcon: UIImageView!
    
    func configureCell(item: ItemProfileMenu) {
       lbTitle.text = item.text
    }
}


