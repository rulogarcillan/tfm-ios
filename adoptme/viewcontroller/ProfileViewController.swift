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
    @IBOutlet weak var tableMenu: UITableView!
    
    let userDto = Commons.readUserInMemory()
    var menu : [ItemProfileMenu] = []
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menu = createMenuList()
        
        lbNAme.text = userDto.name
        lbEmail.text = userDto.email
        
        imgProfile.sd_setImage(with: URL(string: userDto.photoUrl))
        
        imgProfile.layer.cornerRadius = 32;

        tableMenu.register((UINib(nibName: "MenuItemView", bundle: nil)),forCellReuseIdentifier: "idCellMenu")

        

    }
    
    func createMenuList() -> [ItemProfileMenu]{
        
        var listItem = [ItemProfileMenu]()

         listItem.append(ItemProfileMenu(icon: "people", text: NSLocalizedString("Personal Data", comment: "")))
        
         listItem.append(ItemProfileMenu(icon: "terms", text: NSLocalizedString("Terms & Condition", comment: "")))
        
         listItem.append(ItemProfileMenu(icon: "license", text: NSLocalizedString("License", comment: "")))      
        
         listItem.append(ItemProfileMenu(icon: "changelog", text: NSLocalizedString("Changelog", comment: "")))
        
         listItem.append(ItemProfileMenu(icon: "logout", text: NSLocalizedString("Logout", comment: "")))
        
        return listItem
        
    }

}

extension ProfileViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.separatorStyle = .none

        let item = tableView.dequeueReusableCell(withIdentifier: "idCellMenu") as? MenuItemView
        item?.configureCell(item: menu[indexPath.row])
               
        return item ?? MenuItemView()
    }
    

}

extension ProfileViewController: UITableViewDelegate{
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = menu[indexPath.row]
        
        if (item.text == "Logout"){
            Commons.saveUserInMemory(user: UserDto())
            Navigation.navigateToLogin(ui: self)
        }else if (item.text == "Personal Data"){
            
        }
        else if (item.text == "Terms & Condition"){
            Navigation.navigationToTerms(ui: self)
    
        }else if (item.text == "License"){
            
              Navigation.navigationToLicense(ui: self)
            
        }else if (item.text == "Changelog"){
            
        }
    }
    
    

}

