//
//  PhotosModel.swift
//  IconCalendar
//
//  Created by 佐藤陸斗 on 2020/03/05.
//  Copyright © 2020 hannet. All rights reserved.
//

import UIKit

struct Photo {
    var name : String
    var category : String
    
    init(name: String, category: String) {
        self.name    = name
        self.category = category
    }
}
