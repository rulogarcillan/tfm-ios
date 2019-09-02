//
//  HomeController.swift
//  adoptme
//
//  Created by Raul Rodriguez on 02/09/2019.
//  Copyright © 2019 Raul Rodriguez. All rights reserved.
//

import UIKit
import Foundation

class HomeController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var animals = [RecordDto]()
    var position = 0
    
 
   
    override func viewDidLoad() {
        super.viewDidLoad()

        
        FirebaseRepository.getAllRecords(animal: nil){
            self.animals = $0
            self.initImager()
            self.startTimer()
        }
    }
    
    func initImager() {
        
          imageView.sd_setImage(with: URL(string: animals[position].imageUrl[0]))
        
        if (animals.count >= 5){
            if (position == 4){
                position  = 0
            }else{
                position += 1
            }
        }else{
            if (position == animals.count-1){
                position = 0
            }else{
                position += 1
            }
        }
        
    }
    
    
    weak var timer: Timer?
    
    func startTimer() {
        timer?.invalidate()   // just in case you had existing `Timer`, `invalidate` it before we lose our reference to it
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self] _ in
            self!.initImager()
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
    
    // if appropriate, make sure to stop your timer in `deinit`
    
    deinit {
        stopTimer()
    }


}
