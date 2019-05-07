//
//  Category.swift
//  Todoye
//
//  Created by Georgi Malkhasyan on 5/7/19.
//  Copyright © 2019 Adamyan. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
    
}
