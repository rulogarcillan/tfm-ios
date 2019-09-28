//
//  ProfileController.swift
//  adoptme
//
//  Created by Raul Rodriguez on 01/09/2019.
//  Copyright © 2019 Raul Rodriguez. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {

    @IBOutlet weak var tvNAme: UILabel!
    @IBOutlet weak var tvEmail: UILabel!
    @IBOutlet weak var nbNav: UINavigationItem!
    let userDto = Commons.readUserInMemory()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tvNAme.text=userDto.name
        tvEmail.text=userDto.email
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }


}
