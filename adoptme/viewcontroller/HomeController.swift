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
    
    @IBOutlet weak var tbView: UICollectionView!
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
        self.tbView.register(UINib(nibName: "PetViewCell", bundle: nil), forCellWithReuseIdentifier: "PetViewCell")
        self.tbView.reloadData()
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let petController = segue.destination as? PetController {
            petController.animal = sender as! RecordDto
        }
    }
}


extension HomeController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return animals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //Recuperamos una celda de la tabla, si no hay ninguna en memoria se instanciara
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PetViewCell", for: indexPath) as? PetViewCell
        
        //Configuramos la celda
        cell?.configureCell(animal: animals[indexPath.row])
        
        return cell ?? UICollectionViewCell()
    }
}
/*
extension HomeController: UICollectionViewDelegateFlowLayout {
    
  /*  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //Se puede especificar el tamaño de las celdas de manera personalizada
        return  CGSize(width: 280, height: 280)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        //Los edge insets equivalen al pading en Android
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }*/
}
 */


extension HomeController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding: CGFloat = 25

        let collectionCellSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionCellSize/2, height: collectionCellSize/2)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
}

extension HomeController: UICollectionViewDelegate {
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailPet", sender: animals[indexPath.row])
    }
    
}




