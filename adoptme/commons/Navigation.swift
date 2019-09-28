//
//  Navigation.swift
//  adoptme
//
//  Created by Raul Rodriguez on 01/09/2019.
//  Copyright © 2019 Raul Rodriguez. All rights reserved.
//

import Foundation
import UIKit


final class Navigation {
    private init() {
    }
    
    static func navigateToLogin(ui: UIViewController) {
        let newViewController = ui.storyboard?.instantiateViewController(withIdentifier: "LoginController") as! LoginController
        ui.present(newViewController, animated: true, completion: nil)
    }
    
    static func navigationToHome(ui: UIViewController) {
        let newViewController = ui.storyboard?.instantiateViewController(withIdentifier: "TabController") as! TabController
        ui.present(newViewController, animated: true, completion: nil)
       }
    
    static func navigationToTerms(ui: UIViewController) {
        let newViewController = ui.storyboard?.instantiateViewController(withIdentifier: "TermsController") as! TermsController
        ui.present(newViewController, animated: true, completion: nil)    }
    
    static func navigationToLicense(ui: UIViewController) {
        let newViewController = ui.storyboard?.instantiateViewController(withIdentifier: "LicenseController") as! LicenseController
        ui.present(newViewController, animated: true, completion: nil)
    }
    
    static func navigationToChangelog(ui: UIViewController) {
        let newViewController = ui.storyboard?.instantiateViewController(withIdentifier: "ChangelogViewController") as! ChangelogViewController
        ui.present(newViewController, animated: true, completion: nil)
    }
    
    
    static func navigationToProfile(ui: UIViewController) {
        let newViewController = ui.storyboard?.instantiateViewController(withIdentifier: "ProfileController") as! ProfileController
        ui.present(newViewController, animated: true, completion: nil)
    }
    
    
}

