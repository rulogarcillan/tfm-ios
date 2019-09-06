//
//  PetViewCell.swift
//  adoptme
//
//  Created by Raul Rodriguez on 05/09/2019.
//  Copyright © 2019 Raul Rodriguez. All rights reserved.
//

import UIKit
import MaterialComponents

class PetViewCell: UICollectionViewCell {

    @IBOutlet weak var ivPetTiny: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var age: UILabel!
   
    @IBOutlet weak var sex: UIImageView!
    func configureCell(animal: RecordDto) {
        
        shadowLayer?.elevation = ShadowElevation.cardResting
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        clipsToBounds = false

        
        
        name.text = animal.name
        age.text = String(animal.age)
        ivPetTiny.sd_setImage(with: URL(string: animal.imageUrl[0]))
        if animal.sex == Sex.MALE.rawValue.self {
            sex.image = UIImage(named: "male");
            //sex.tintColor = UIColor(named: "femaleColor")
            sex.image = sex.image?.withRenderingMode(.alwaysTemplate)
        }else{
            sex.image =  UIImage(named: "female")
            //sex.tintColor = UIColor(named: "primaryColor")
            sex.image = sex.image?.withRenderingMode(.alwaysTemplate)
        }

    }
    
    override class var layerClass: AnyClass {
        return MDCShadowLayer.self
    }
    
    var shadowLayer: MDCShadowLayer? {
        return self.layer as? MDCShadowLayer
    }

}

import UIKit

@IBDesignable extension UIView {
    @IBInspectable var borderColor: UIColor? {
        set {
            layer.borderColor = newValue?.cgColor
        }
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
}



