//
//  Cart+CoreDataProperties.swift
//  FakeStore
//
//  Created by Arman Karimov on 18.05.2022.
//
//

import Foundation
import CoreData

extension Cart {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cart> {
        return NSFetchRequest<Cart>(entityName: "Cart")
    }

    @NSManaged public var items: NSSet?

}

// MARK: Generated accessors for items
extension Cart {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: Item)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: Item)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}

extension Cart : Identifiable {

}
