//
//  FavouritesViewModel.swift
//  FakeStore
//
//  Created by Arman Karimov on 17.05.2022.
//

import Foundation

class FavouritesViewModel {
    
    var favoutite: Favourite?
    
    func addToFavourites() {
//        Favourite.addToItems
    }
    
    func loadFavourites() {
        CoreDataManager.shared.load {
//            Favourite.fetchRequest()
        }
    }
    
}
