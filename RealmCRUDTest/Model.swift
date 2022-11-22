//
//  Model.swift
//  RealmCRUDTest
//
//  Created by John Doe on 22/11/2022.
//

import Foundation
import RealmSwift

//final class Item: Object, ObjectKeyIdentifiable {
//    @Persisted(primaryKey: true) var _id: ObjectId
//    @Persisted var name = "item name"
//    @Persisted var isFavorite = false
//    @Persisted var itemDescription = "item details"
//    @Persisted (originProperty: "items") var group: LinkingObjects<ItemGroup>
//
//}

final class ItemGroup: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
//    @Persisted var items = RealmSwift.List<Item>()
    @Persisted var name: String
    @Persisted var picture: Data?
    
    convenience init ( name: String , picture: Data? = Data()) {

    self.init()

        self.name = name
        self.picture = picture

    }
    override class func primaryKey() -> String? {
        "id"
    }
    
}
