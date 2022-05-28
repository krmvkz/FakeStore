//
//  CoreDataManager.swift
//  FakeStore
//
//  Created by Arman Karimov on 18.05.2022.
//

import UIKit
import CoreData

private struct Constants {
    static let entityName: String = "CartItem"
}

final class CoreDataManager {
    
    // MARK: - Shared instance
    static let shared = CoreDataManager()
    
    // MARK: - Properties
    
    lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "FakeStore")
        return persistentContainer
    }()
    lazy var viewContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()

    // MARK: - Init
    private init() {}
    
}

// MARK: - Methods
extension CoreDataManager {
    
    func load(completion: (() -> Void)? = nil) {
        persistentContainer.loadPersistentStores { description, error in
            guard error == nil else {
                print(error!)
                return
            }
            completion?()
        }
    }
    
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchAllCartItem() -> [CartItem]?{
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Constants.entityName)
        do {
            let items = try viewContext.fetch(fetchRequest)
            return items as? [CartItem]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func insertToCart(item: CartItemModel) -> CartItem? {
        let entity = NSEntityDescription.entity(forEntityName: "CartItem",
                                                in: viewContext)!
        let cartItem = NSManagedObject(entity: entity,
                                       insertInto: viewContext)
        
        cartItem.setValue(item.category, forKey: "category")
        cartItem.setValue(item.id, forKeyPath: "id")
        cartItem.setValue(item.image, forKey: "image")
        cartItem.setValue(item.price, forKey: "price")
        cartItem.setValue(item.title, forKeyPath: "title")
        
        do {
            try viewContext.save()
            return cartItem as? CartItem
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func updateCart(with item: CartItemModel) {
        let entity = NSEntityDescription.entity(forEntityName: Constants.entityName,
                                                in: viewContext)!
        let cartItem = NSManagedObject(entity: entity,
                                       insertInto: viewContext)
        
        do {
            cartItem.setValue(item.category, forKey: "category")
            cartItem.setValue(item.id, forKeyPath: "id")
            cartItem.setValue(item.image, forKey: "image")
            cartItem.setValue(item.price, forKey: "price")
            cartItem.setValue(item.title, forKeyPath: "title")
            do {
                try viewContext.save()
                print("updated!")
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            } catch {
                print(error)
            }
        } catch {
            print("Error with request: \(error)")
        }
    }
    
    func deleteFromCart(id: Int64) -> [CartItem]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Constants.entityName)
        fetchRequest.predicate = NSPredicate(format: "id == %@" , id)
        do {
            let item = try viewContext.fetch(fetchRequest)
            var arrRemovedItems = [CartItem]()
            for i in item {
                viewContext.delete(i)
                try viewContext.save()
                arrRemovedItems.append(i as! CartItem)
            }
            return arrRemovedItems
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func deleteAllFromCart() -> [CartItem]? {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: Constants.entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try persistentContainer.viewContext.execute(deleteRequest)
            print("All items have been deleted")
            return fetchAllCartItem()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
}
