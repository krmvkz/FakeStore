//
//  Item+CoreDataProperties.swift
//  FakeStore
//
//  Created by Arman Karimov on 18.05.2022.
//
//

import Foundation
import CoreData

extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var category: String?
    @NSManaged public var id: Int64
    @NSManaged public var image: String?
    @NSManaged public var price: Double
    @NSManaged public var title: String?

}

extension Item : Identifiable {

}
