//
//  CoreDataManager.swift
//  FakeStore
//
//  Created by Arman Karimov on 18.05.2022.
//

import UIKit
import CoreData

class CoreDataManager {
    
    // MARK: - Shared instance
    static let shared = CoreDataManager(modelName: "FakeStore")
    
    // MARK: - Properties
    var persistentContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Init
    // TODO: - Refactor code
    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    func load(completion: (() -> Void)? = nil) {
        persistentContainer.loadPersistentStores { description, error in
            guard error == nil else {
                fatalError(error!.localizedDescription)
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
    
}
