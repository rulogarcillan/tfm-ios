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
        
     

        let slide1:MViewPager = Bundle.main.loadNibNamed("MViewPager", owner: self, options: nil)?.first as! MViewPager
        slide1.ivPet.sd_setImage(with: URL(string: animals[0].imageUrl[0]))
        
       /* let slide2:PagerView = Bundle.main.loadNibNamed("PagerView", owner: self, options: nil)?.first as! PagerView
        slide2.imageview.sd_setImage(with: URL(string: animals[1].imageUrl[0]))
        
        let slide3:PagerView = Bundle.main.loadNibNamed("PagerView", owner: self, options: nil)?.first as! PagerView
        slide3.imageview.sd_setImage(with: URL(string: animals[2].imageUrl[0]))

        let slide4:PagerView = Bundle.main.loadNibNamed("PagerView", owner: self, options: nil)?.first as! PagerView
        slide4.imageview.sd_setImage(with: URL(string: animals[3].imageUrl[0]))
        
        let slide5:PagerView = Bundle.main.loadNibNamed("PagerView", owner: self, options: nil)?.first as! PagerView
        slide5.imageview.sd_setImage(with: URL(string: animals[4].imageUrl[0]))
        
        return [slide1, slide2, slide3, slide4, slide5]*/
        return [slide1]
    }
    
    func setupSlideScrollView(slides : [MViewPager]) {
      /*  scView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
        
        */
        scView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scView.isPagingEnabled = true
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scView.addSubview(slides[i])
        }
    }

}
