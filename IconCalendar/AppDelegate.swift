//
//  AppDelegate.swift
//  IconCalendar
//
//  Created by 佐藤陸斗 on 2020/01/14.
//  Copyright © 2020 hannet. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {


    //起動時に呼ばれる関数
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //ローンチ終わったら通知について聞く
        let center = UNUserNotificationCenter.current()

        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("通知が許可されました")
            } else {
                print("通知は拒否されました")
            }
        }
        
        //登録処理
        let content = UNMutableNotificationContent()
        //通知タイトル
        content.title = "今日の予定";
        //通知内容
        content.body = "text";
        //通知サウンド
        content.sound = UNNotificationSound.default
        
        //通知トリガー設定
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 5, repeats: false)//5秒後
        
        //通知リクエスト設定
        let request = UNNotificationRequest.init(identifier: "TestNotification", content: content, trigger: trigger)
        
        //通知リクエストを追加
        center.add(request)
        //デリゲート設定
        center.delegate = self
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

