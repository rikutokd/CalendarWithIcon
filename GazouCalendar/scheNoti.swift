//
//  scheNoti.swift
//  iconcalendar
//
//  Created by 佐藤陸斗 on 2020/05/28.
//  Copyright © 2020 hannet. All rights reserved.
//

import UserNotifications

let dateComponents = DateComponents()

let calendarTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

let calendarRequest = UNNotificationRequest(identifier: <#T##String#>, content: <#T##UNNotificationContent#>, trigger: <#T##UNNotificationTrigger?#>)


func pushNoti(){
    UNUserNotificationCenter.current().add(calendarRequest, withCompletionHandler: nil)
}
