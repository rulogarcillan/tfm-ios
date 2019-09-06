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
    
    @IBOutlet weak var tbViewPager: UICollectionView!
    @IBOutlet weak var tbView: UICollectionView!
    var animals = [RecordDto]()
    var animalsFive = [RecordDto]()
    weak var timer: Timer?
    var position = 0
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
        FirebaseRepository.getAllRecords(animal: nil){
            
        self.animals = $0
        self.animalsFive = self.createSlides()
        self.tbView.register(UINib(nibName: "PetViewCell", bundle: nil), forCellWithReuseIdentifier: "PetViewCell")
        self.tbView.reloadData()
        self.tbViewPager.reloadData()
        self.startTimer()
        }
    }
    
    func initImager() {
               
        if (animalsFive.count >= 5){
            if (position == 4){
                position  = 0
            }else{
                position += 1
            }
        }else{
            if (position == animalsFive.count-1){
                position = 0
            }else{
                position += 1
            }
        }
        
        let indexPath = IndexPath(row: position, section: 0)
        self.tbViewPager.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.right, animated: true)
        
    }
    
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self] _ in
            self!.initImager()
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
    
    deinit {
        stopTimer()
    }
    
   
    func createSlides() -> [RecordDto] {
        
        let size = animals.count > 5 ? 5 : animals.count
        var mSlides:[RecordDto] = [];
        for i in 0...size-1 {
            mSlides.append(animals[i])
        }

        return mSlides
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let petController = segue.destination as? PetController {
            petController.animal = sender as! RecordDto
        }
    }
}

extension HomeController:  UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       var ret = 0
        if (collectionView.restorationIdentifier == "imagePets"){
            ret = animalsFive.count
        }else{
             ret = animals.count
        }
        return ret
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell : UICollectionViewCell = UICollectionViewCell()
        if (collectionView.restorationIdentifier == "imagePets"){
           let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "PetImageViewCell", for: indexPath) as? PetImageViewCell
            cell1?.configureCell(imagerUrl: animalsFive[indexPath.row].imageUrl[0])
            cell = cell1 ?? UICollectionViewCell()
        }else{
          let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "PetViewCell", for: indexPath) as? PetViewCell
            cell2?.configureCell(animal: animals[indexPath.row])
              cell = cell2 ?? UICollectionViewCell()
        }
        
        return cell
    }
    
}


extension HomeController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
      
        if (collectionView.restorationIdentifier == "imagePets"){
          return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }else{
          return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        if (collectionView.restorationIdentifier == "imagePets"){
            let size = collectionView.frame.size
            return CGSize(width: size.width, height: size.height)
        }else{
            let padding: CGFloat = 25
            let collectionCellSize = collectionView.frame.size.width - padding
            return CGSize(width: collectionCellSize/2, height: collectionCellSize/2)
        }
        
    }
    
}

extension HomeController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailPet", sender: animals[indexPath.row])
    }
}




