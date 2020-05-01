//
//  Park.swift
//  CollectionView
//
//  Created by abdulrahman on 4/27/20.
//  Copyright © 2020 abdulrahmanAbdou. All rights reserved.
//

import Foundation
import UIKit

class Park{
    var name: String
    var state: String
    var date: String
    var photo: String
    var index: Int
    
    init(name: String, state: String, date: String, photo: String, index: Int) {
        self.name = name
        self.state = state
        self.date = date
        self.photo = photo
        self.index = index
    }
    
    convenience init(copying park: Park){
        self.init(name: park.name, state: park.state, date: park.date, photo: park.photo, index: park.index)
    }
}
