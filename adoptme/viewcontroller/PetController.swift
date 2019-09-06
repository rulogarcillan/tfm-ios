//
//  PetController.swift
//  adoptme
//
//  Created by Raul Rodriguez on 06/09/2019.
//  Copyright © 2019 Raul Rodriguez. All rights reserved.
//

import UIKit

class PetController: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var back: UIBarButtonItem!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lbNAme: UILabel!
    
    var animal: RecordDto = RecordDto()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(animal.name)
        navigationBar.title=animal.name
        
        let userDto = Commons.readUserInMemory()
        
        lbNAme.text = userDto.name
       
        imgProfile.sd_setImage(with: URL(string: userDto.photoUrl))
        
        imgProfile.layer.cornerRadius = 32;

    }
    
    @IBAction func clickBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }   

}
