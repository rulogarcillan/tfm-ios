//
//  ProfileController.swift
//  adoptme
//
//  Created by Raul Rodriguez on 01/09/2019.
//  Copyright © 2019 Raul Rodriguez. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {

    @IBOutlet weak var nbNav: UINavigationItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }


}
