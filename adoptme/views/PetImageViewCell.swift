//
//  PetImageViewCellCollectionViewCell.swift
//  adoptme
//
//  Created by Raul Rodriguez on 06/09/2019.
//  Copyright © 2019 Raul Rodriguez. All rights reserved.
//

import UIKit

class PetImageViewCell: UICollectionViewCell {
    @IBOutlet weak var ivPet: UIImageView!
    
    func configureCell(imagerUrl: String)  {
        ivPet.sd_setImage(with: URL(string: imagerUrl))
    }
    
    
}
