//
//  EventModel.swift
//  IconCalendar
//
//  Created by 佐藤陸斗 on 2020/01/18.
//  Copyright © 2020 hannet. All rights reserved.
//

import Foundation
import RealmSwift

class EventModel: Object {
    @objc dynamic var date: String = ""
    @objc dynamic var icon: Data? = nil
}
