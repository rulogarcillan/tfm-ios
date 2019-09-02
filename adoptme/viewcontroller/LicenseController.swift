//
//  LicenseController.swift
//  adoptme
//
//  Created by Raul Rodriguez on 01/09/2019.
//  Copyright © 2019 Raul Rodriguez. All rights reserved.
//

import UIKit
import WebKit

class LicenseController: UIViewController {

    @IBOutlet weak var nbNav: UINavigationItem!
    @IBOutlet weak var webView: WKWebView!

    let URL_TERM_CONDITION = "https://raw.githubusercontent.com/rulogarcillan/tfm-android/master/LICENSE"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myURL = URL(string:URL_TERM_CONDITION)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
