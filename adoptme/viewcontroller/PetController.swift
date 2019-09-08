//
//  PetController.swift
//  adoptme
//
//  Created by Raul Rodriguez on 06/09/2019.
//  Copyright © 2019 Raul Rodriguez. All rights reserved.
//

import UIKit
import MaterialComponents

class PetController: UIViewController {

    @IBOutlet weak var lbSex: UILabel!
    
    @IBOutlet weak var lbPetName: UILabel!
    @IBOutlet weak var lbAge: UILabel!
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var back: UIBarButtonItem!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lbNAme: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var position = 0
    weak var timer: Timer?
    @IBOutlet weak var btnActions: MDCRaisedButton!
    
    var animal: RecordDto = RecordDto()
    var userDto :UserDto? = nil
    var userPet :UserDto? = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(animal.name)
        navigationBar.title=animal.name
        
        userDto = Commons.readUserInMemory()
       
        FirebaseRepository.getUserDataBase(userId: animal.uid){userPet in
            self.userPet = userPet
            self.lbNAme.text = userPet.name
            self.imgProfile.sd_setImage(with: URL(string: userPet.photoUrl))
            
            if self.userDto?.uid.elementsEqual(userPet.uid) ?? false{
                self.btnActions.setTitle("Remove add", for: .normal) // sets text
            }else{
                self.btnActions.setTitle("Send me a message", for: .normal) // sets text
            }
        }
        
        
        if (animal.isDeleted){
            btnActions.isHidden = true
        }
        
        imgProfile.layer.cornerRadius = 32;
        startTimer()
        
        lbPetName.text = animal.name
        lbAge.text = String(animal.age)
        lbSex.text = animal.sex

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let chatController = segue.destination as? ChatViewController {
            chatController.chatId = sender as! String
        }
    }
    
    @IBAction func clickBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func brActionClick(_ sender: Any) {
        
        if self.userDto?.uid.elementsEqual(userPet?.uid ?? "") ?? false{
            //delete add
            FirebaseRepository.deleteRecord(record: animal)
            dismiss(animated: true, completion: nil)
            
        }else{
            let chatId = userDto?.uid.sortCombine(uid2: userPet?.uid ?? "")
            performSegue(withIdentifier: "ChatSegue", sender: chatId)
        }
        
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

