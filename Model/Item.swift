//
//  Item.swift
//  Todoye
//
//  Created by Georgi Malkhasyan on 5/7/19.
//  Copyright © 2019 Adamyan. All rights reserved.
//

import Foundation
import  RealmSwift

class Item: Object {
    @objc dynamic  var title: String =  ""
    @objc dynamic var done: Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
