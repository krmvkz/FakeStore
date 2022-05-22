//
//  Cart+CoreDataClass.swift
//  FakeStore
//
//  Created by Arman Karimov on 18.05.2022.
//
//

import Foundation
import CoreData

@objc(Cart)
public class Cart: NSManagedObject {

    var itemsArray: [Item] {
        let set = items as? Set<Item> ?? []
        let array = set.map { $0 }
        return array
    }
    
}
