//
//  DataModel.swift
//  Todoye
//
//  Created by Georgi Malkhasyan on 9/8/18.
//  Copyright © 2018 Adamyan. All rights reserved.
//

import Foundation
class Item: Codable {
    var title: String = ""
    var done: Bool = false
}
