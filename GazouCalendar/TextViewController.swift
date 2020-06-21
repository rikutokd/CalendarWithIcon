//
//  TextViewController.swift
//  IconCalendar
//
//  Created by 佐藤陸斗 on 2020/02/05.
//  Copyright © 2020 hannet. All rights reserved.
//

import UIKit
import RealmSwift

class TextViewController: UIViewController, UITextFieldDelegate, UNUserNotificationCenterDelegate {
    var pickedDate = ""
    
    var wroteText = ""
    
    //コールバックする時,引数無し
    var textViewCallBack: (() -> Void)?
    
    //テキストを通知する為のトリガー
    var textNotifiTrigger: (() -> Void)?
    
    @IBOutlet weak var addBtn: UIButton!
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var titleText: UITextField!
    
    
    override func viewDidLoad() {
        //iOSのモードをライトに
        self.overrideUserInterfaceStyle = .light
        
        
        //TextFieldのdelegateプロパティにself（UIViewController）を指定します。
        titleText.delegate = self
        
        //ボタン設定
        cancelBtn!.addTarget(self, action: #selector(cancelEvent(_:)), for: .touchUpInside)
        
        addBtn!.addTarget(self, action: #selector(trySave(_:)), for: .touchUpInside)
        
        //追加ボタンを初期でdisable状態に
        addBtn.isEnabled = false
        
        //テキスト設定
        titleText.clearButtonMode = UITextField.ViewMode.whileEditing //編集時クリアボタン表示
        titleText.keyboardType = UIKeyboardType.default //キーボードのタイプ:デフォルト
        titleText.returnKeyType = UIReturnKeyType.done //完了ボタン

        
    }
    
}

extension TextViewController{
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addBtn.isEnabled = true
        wroteText = titleText.text!
        
        print(wroteText)

        self.view.endEditing(true)
        return true
    }
    
    @objc func cancelEvent(_: UIButton){
        //前のページに戻る
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func trySave(_ : UIButton) {
        
        let realm = try! Realm()
        
        print("DB書き込み開始")
        
        //日付表示の内容とスケジュール入力の内容が書き込まれる。
        let Events = [EventModel(value: ["date": pickedDate, "text": wroteText])]
        let thisDate = realm.objects(EventModel.self).filter("date == '\(pickedDate)'").first
        let text = thisDate?.text
        
        try! realm.write {
            
            //その日付にデータが何も入っていない時
            if thisDate == nil{
                
                                            realm.add(Events)
                                            print("DB書き込み中")

                                            //DBをその日付で見た時に、値がnilではない時に,
                                        }else{
                                            
                                                    //既に画像が入ってるかつテキストがない時
                                                    if text == nil {
                                                            thisDate!.text = wroteText
                                                            print("元のデータにテキスト入力中")
                                                            
                                                            //既にその日にテキストが入っている時
                                                        }else if text != nil {
                                                                thisDate!.text = wroteText
                                                                print("テキスト上書き中")

                                                        }
                                                }
        
            print("データ書き込み完了")
            
            //通知登録
            addNotifications()

            //前のページに戻る
            self.dismiss(animated: true, completion: {
                //更新トリガー
                self.textViewCallBack?()
            })
        
        }
    
    }
    
    func addNotifications(){
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
    content.body = wroteText;
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
    
    //（アプリがアクティブ、非アクテイブ、アプリ未起動,バックグラウンドでも呼ばれる）
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.sound])
    }
    
}
