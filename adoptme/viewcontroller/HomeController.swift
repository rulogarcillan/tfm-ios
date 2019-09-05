//
//  HomeController.swift
//  adoptme
//
//  Created by Raul Rodriguez on 02/09/2019.
//  Copyright © 2019 Raul Rodriguez. All rights reserved.
//

import UIKit
import Foundation

class HomeController: UIViewController{
    @IBOutlet weak var scView: UIScrollView!
    
    var animals = [RecordDto]()
    var slides:[MViewPager] = [];

    var position = 0
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scView.contentSize.height = 1.0 // disable vertical scroll

        scView.alwaysBounceHorizontal = true
        scView.alwaysBounceVertical = false
        FirebaseRepository.getAllRecords(animal: nil){
            self.animals = $0
            self.slides = self.createSlides()
            self.setupSlideScrollView(slides: self.slides)
        }
    }
    
    func createSlides() -> [MViewPager] {
        
        let size = animals.count > 5 ? 5 : animals.count
        var mSlides:[MViewPager] = [];
        for n in 0...size-1 {
            let slide1:MViewPager = Bundle.main.loadNibNamed("MViewPager", owner: self, options: nil)?.first as! MViewPager
            slide1.imageview.sd_setImage(with: URL(string: animals[n].imageUrl[0]))
            slide1.lbname.text = animals[n].name
            mSlides.append(slide1)
        }

        return mSlides
    
    }
    
    func setupSlideScrollView(slides : [MViewPager]) {
              
        scView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scView.isPagingEnabled = true
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scView.addSubview(slides[i])
        }
        
        if #available(iOS 11, *) {
            scView.contentInsetAdjustmentBehavior = .never
        }
    }

}
