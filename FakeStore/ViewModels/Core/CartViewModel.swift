//
//  CartViewModel.swift
//  FakeStore
//
//  Created by Arman Karimov on 17.05.2022.
//

import CoreData

protocol CartViewModelDelegate: AnyObject {
    func didFinishFetchingItems()
}

struct CartViewModel {
    
    // MARK: - Delegate
    weak var delegate: CartViewModelDelegate?
    
    // MARK: - Properties
    var cartItems: [NSManagedObject] = []
    
}

// MARK: - Methods
extension CartViewModel {
    
    mutating func fetchCartItems() {
        do {
            self.cartItems = try CoreDataManager.shared.viewContext.fetch(CartItem.fetchRequest())
            delegate?.didFinishFetchingItems()
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
    
    mutating func deleteAll() {
        if let items = CoreDataManager.shared.deleteAllFromCart() {
            self.cartItems = items
        } else {
            self.cartItems = []
        }
    }
    
    func totalPrice() -> Double {
        var total: Double = 0.0
        guard let items = cartItems as? [CartItem] else {
            print("There's no items in cart")
            return total
        }
        for item in items {
             total += item.price
        }
        return total
    }
    
    func totalItems() -> Int {
        return cartItems.count
    }
    
}
