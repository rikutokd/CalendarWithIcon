//
//  Extensions.swift
//  GazouCalendar
//
//  Created by 佐藤陸斗 on 2020/06/21.
//  Copyright © 2020 hannet. All rights reserved.
//

import Foundation
import UserNotifications

func addNotifications(Date:pickedDate){
// NotifiTime取得
let userDefaults = UserDefaults.standard
let NotifiTime = userDefaults.string(forKey: "NotifiTime")
       
//NotifiTime:stringをStringでseparateする
let arr:[String] = NotifiTime!.components(separatedBy: "時")
print(arr[0])
print(arr[1])
       
//pickedDate Separate
let dateArrYear:[String] = pickedDate.components(separatedBy: "年")
let dateArrMonth:[String] = dateArrYear[1].components(separatedBy: "月")
let dateArrDay:[String] = dateArrMonth[1].components(separatedBy: "日")

print(dateArrYear[0])
print(dateArrMonth[0])
print(dateArrDay[0])

//登録処理
let content = UNMutableNotificationContent()
let center = UNUserNotificationCenter.current()

let uHour:Int = Int(arr[0])!
let uMinute:Int = Int(arr[1])!

let uYear:Int = Int(dateArrYear[0])!
let uMonth:Int = Int(dateArrMonth[0])!
let uDay:Int = Int(dateArrDay[0])!
       
//通知タイトル
content.title = "今日の予定";
//通知内容
content.body = "text";
//通知サウンド
content.sound = UNNotificationSound.default

//通知時間設定
let dateCompo = DateComponents(year:uYear,month:uMonth,day:uDay,hour:uHour, minute:uMinute)
print("通知の時間は\(dateCompo)です")
       
       //通知トリガー設定
       let trigger = UNCalendarNotificationTrigger(dateMatching: dateCompo, repeats: false)
       
       //通知リクエスト設定
       let request = UNNotificationRequest.init(identifier: "TestNotification", content: content, trigger: trigger)
       
       //通知リクエストを追加
       center.add(request)
       //デリゲート設定
       center.delegate = self
   }
