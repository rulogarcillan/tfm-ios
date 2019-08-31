//
//  ViewController.swift
//  adoptme
//
//  Created by Raul Rodriguez on 30/08/2019.
//  Copyright © 2019 Raul Rodriguez. All rights reserved.
//

import UIKit
import MaterialComponents
import Firebase
import GoogleSignIn


class LoginController: UIViewController,  GIDSignInDelegate  {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        print("Google Sing In didSignInForUser")
        if let error = error {
            print(error.localizedDescription)
            return
        }
        guard let authentication = user.authentication else { return }

        let credential = GoogleAuthProvider.credential(withIDToken: (authentication.idToken)!, accessToken: (authentication.accessToken)!)
        // When user is signed in
        Auth.auth().signIn(with: credential, completion: { (user, error) in
            if let error = error {
                print("Login error: \(error.localizedDescription)")
                return
            }
            if let userDto = user?.toUserDto(){
                Commons.saveUserInMemory(user: userDto)
                self.navigateToMain()
            }
            
        })
        
    }
    @IBOutlet weak var btLogin: MDCButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDto = Commons.readUserInMemory()
        if (userDto.uid != ""){
            DispatchQueue.main.async {
                 self.navigateToMain()
            }
        }else{
            GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
            GIDSignIn.sharedInstance().delegate = self
            GIDSignIn.sharedInstance()?.presentingViewController = self
        }
        // Automatically sign in the user.
        //GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    }
    
    @IBAction func signIn(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
     // Start Google OAuth2 Authentication
    func sign(_ signIn: GIDSignIn?, present viewController: UIViewController?) {
        
        // Showing OAuth2 authentication window
        if let aController = viewController {
            present(aController, animated: true) {() -> Void in }
        }
    }
    // After Google OAuth2 authentication
    func sign(_ signIn: GIDSignIn?, dismiss viewController: UIViewController?) {
        // Close OAuth2 authentication window
        dismiss(animated: true) {() -> Void in }
    }
    
    func navigateToMain() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "mainStoryBoard") as! MainController
        self.present(newViewController, animated: true, completion: nil)
    }
}

