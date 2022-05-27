//
//  CartItem+CoreDataProperties.swift
//  FakeStore
//
//  Created by Arman Karimov on 25.05.2022.
//
//

import Foundation
import CoreData


extension CartItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CartItem> {
        return NSFetchRequest<CartItem>(entityName: "CartItem")
    }

    @NSManaged public var category: String?
    @NSManaged public var id: Int64
    @NSManaged public var image: String?
    @NSManaged public var price: Double
    @NSManaged public var title: String?

}

extension CartItem : Identifiable {

}
