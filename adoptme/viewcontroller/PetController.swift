//
//  PetController.swift
//  adoptme
//
//  Created by Raul Rodriguez on 06/09/2019.
//  Copyright © 2019 Raul Rodriguez. All rights reserved.
//

import UIKit

class PetController: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var back: UIBarButtonItem!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lbNAme: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var position = 0
    weak var timer: Timer?
    
    var animal: RecordDto = RecordDto()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(animal.name)
        navigationBar.title=animal.name
        
        let userDto = Commons.readUserInMemory()
        
        lbNAme.text = userDto.name
       
        imgProfile.sd_setImage(with: URL(string: userDto.photoUrl))
        
        imgProfile.layer.cornerRadius = 32;
        startTimer()

    }
    
    @IBAction func clickBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func initImager() {
        
        if (animal.imageUrl.count >= 4){
            if (position == 3){
                position  = 0
            }else{
                position += 1
            }
        }else{
            if (position == animal.imageUrl.count-1){
                position = 0
            }else{
                position += 1
            }
        }
        
        let indexPath = IndexPath(row: position, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.right, animated: true)
        
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

}



extension PetController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return animal.imageUrl.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PetImageViewCell", for: indexPath) as? PetImageViewCell
        
        //Configuramos la celda
        cell?.configureCell(imagerUrl: animal.imageUrl[indexPath.row])
        
        return cell ?? UICollectionViewCell()
    }
}


extension PetController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }

}

