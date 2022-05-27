//
//  CartViewModel.swift
//  FakeStore
//
//  Created by Arman Karimov on 17.05.2022.
//

import CoreData

struct CartViewModel {
    
    var cartItems: [NSManagedObject] = []
    
}

extension CartViewModel {
    
    mutating func fetchCartItems() {
        do {
            self.cartItems = try CoreDataManager.shared.viewContext.fetch(CartItem.fetchRequest())
            print(cartItems)
        } catch  {
            print("ERROR: Fetching cart items can't be done")
        }
    }
    
    mutating func save(cartItem: CartItemModel) {
        let item = CoreDataManager.shared.insertToCart(item: cartItem)
        if item != nil {
            cartItems.append(item!)
        }
        print(cartItems)
    }
    
    func update(with cartItem: CartItemModel) {
        CoreDataManager.shared.updateCart(with: cartItem)
    }
    
    mutating func delete(id: Int64) {
        let arrRemovedObjects = CoreDataManager.shared.deleteFromCart(id: id)
        cartItems = cartItems.filter({ (param) -> Bool in
            if (arrRemovedObjects?.contains(param as! CartItem))!{
                return false
            } else {
                return true
            }
        })
    }
    
}
