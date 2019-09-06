//
//  AnimalsAdapter.swift
//  adoptme
//
//  Created by Raul Rodriguez on 06/09/2019.
//  Copyright © 2019 Raul Rodriguez. All rights reserved.
//

import UIKit
import Foundation

class AnimalsAdapter: NSObject, UICollectionViewDataSource {

    var animals: [RecordDto]
    
    init(animals: [RecordDto]) {
        self.animals = animals
    }
    
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return animals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PetViewCell", for: indexPath) as? PetViewCell
        
        cell?.configureCell(animal: animals[indexPath.row])
        
        return cell ?? UICollectionViewCell()
    }
    
}
