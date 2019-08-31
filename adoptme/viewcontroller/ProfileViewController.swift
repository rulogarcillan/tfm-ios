//
//  ProfileViewController.swift
//  adoptme
//
//  Created by Raul Rodriguez on 31/08/2019.
//  Copyright © 2019 Raul Rodriguez. All rights reserved.
//

import UIKit
import SDWebImage

class ProfileViewController: UIViewController {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lbNAme: UILabel!
    @IBOutlet weak var lbEmail: UILabel!
    
    let userDto = Commons.readUserInMemory()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbNAme.text = userDto.name
        lbEmail.text = userDto.email
        

        imgProfile.sd_setImage(with: URL(string: userDto.photoUrl))
        
        imgProfile.layer.cornerRadius = 32;

     
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
