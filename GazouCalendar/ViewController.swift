//
//  ViewController.swift
//  IconCalendar
//
//  Created by 佐藤陸斗 on 2020/01/14.
//  Copyright © 2020 hannet. All rights reserved.
//

import UIKit
import FSCalendar
import CalculateCalendarLogic
import RealmSwift
import UserNotifications


class ViewController: UIViewController,FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance, UNUserNotificationCenterDelegate{
    
    @IBOutlet weak var calendar: FSCalendar!
    
    @IBOutlet weak var plusBtn: UIButton!
    
    @IBOutlet weak var deleteBtn: UIButton!
    
    @IBOutlet weak var textBtn: UIButton!
    
    @IBOutlet weak var dateIcon: UIImageView!
    
    @IBOutlet weak var tableText: UILabel!
    
    @IBOutlet weak var settingBtn: UIButton!
    
    
    
        //選択した日付を入れる空の変数
    var pickedDate = ""
    
        //ユーザーが設定した時間を入れる為の空変数
    var userSetTime = ""
    
    //エラーメッセージ設定
    //エラーアラート用の変数宣言
    let alert = UIAlertController(title: "エラー", message: "日付が選択されていません。", preferredStyle: .alert)
    
    let deleteAlert = UIAlertController(title: "警告", message: "予定を全て削除しますか？", preferredStyle: .alert)
    
    // OKボタン
    let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler:{
        // ボタンが押された時の処理を書く（クロージャ実装）
        (action: UIAlertAction!) -> Void in 
        print("OK")
        
                let realm = try! Realm()
        
                print("DBのデータを全て削除")
        
                // Delete all objects from the realm
                try! realm.write {
                    realm.deleteAll()
                }
        
        
    })
    
    //Cancel 一つだけしか指定できない
    let cancelAction:UIAlertAction = UIAlertAction(title: "キャンセル",
                                                   style: UIAlertAction.Style.cancel,
                handler:{
                (action:UIAlertAction!) -> Void in
                    print("キャンセル")
    })
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // デリゲートの設定
        calendar.dataSource = self
        calendar.delegate = self
        
        calendar.calendarWeekdayView.weekdayLabels[0].text = "日"
        calendar.calendarWeekdayView.weekdayLabels[1].text = "月"
        calendar.calendarWeekdayView.weekdayLabels[2].text = "火"
        calendar.calendarWeekdayView.weekdayLabels[3].text = "水"
        calendar.calendarWeekdayView.weekdayLabels[4].text = "木"
        calendar.calendarWeekdayView.weekdayLabels[5].text = "金"
        calendar.calendarWeekdayView.weekdayLabels[6].text = "土"
        
        //ダークモードoff
        self.overrideUserInterfaceStyle = .light
        
        //barのcolor設定
        self.navigationController!.navigationBar.barTintColor = .systemYellow
        
        //ボタンに機能4種追加
        plusBtn!.addTarget(self, action: #selector(addEvents(_:)), for: .touchUpInside)
        deleteBtn!.addTarget(self, action: #selector(deleteBtn(_:)), for: .touchUpInside)
        textBtn!.addTarget(self, action: #selector(textAdd(_:)), for: .touchUpInside)
        settingBtn!.addTarget(self, action: #selector(goToUserSetting(_:)), for: .touchUpInside)
        
        //alertにキャンセル追加
        alert.addAction(cancelAction)
        
        //deleteAlert
        deleteAlert.addAction(defaultAction)
        deleteAlert.addAction(cancelAction)
        
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    fileprivate let gregorian: Calendar = Calendar(identifier: .gregorian)
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    

    // 祝日判定を行い結果を返すメソッド(True:祝日)
    func judgeHoliday(_ date : Date) -> Bool {
        //祝日判定用のカレンダークラスのインスタンス
        let tmpCalendar = Calendar(identifier: .gregorian)

        // 祝日判定を行う日にちの年、月、日を取得
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)

        // CalculateCalendarLogic()：祝日判定のインスタンスの生成
        let holiday = CalculateCalendarLogic()

        return holiday.judgeJapaneseHoliday(year: year, month: month, day: day)
    }
    // date型 -> 年月日をIntで取得
    func getDay(_ date:Date) -> (Int,Int,Int){
        let tmpCalendar = Calendar(identifier: .gregorian)
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)
        return (year,month,day)
    }

    //曜日判定(日曜日:1 〜 土曜日:7)
    func getWeekIdx(_ date: Date) -> Int{
        let tmpCalendar = Calendar(identifier: .gregorian)
        return tmpCalendar.component(.weekday, from: date)
    }

    // 土日や祝日の日の文字色を変える
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        //祝日判定をする（祝日は赤色で表示する）
        if self.judgeHoliday(date){
            return UIColor.red
        }

        //土日の判定を行う（土曜日は青色、日曜日は赤色で表示する）
        let weekday = self.getWeekIdx(date)
        if weekday == 1 {   //日曜日
            return UIColor.red
        }
        else if weekday == 7 {  //土曜日
            return UIColor.blue
        }

        return nil
    }

}

extension ViewController {
    
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .none
        f.locale = Locale(identifier: "ja_JP")
        
        let da = f.string(from: date)
        
        let realm = try! Realm()
        
        //全スケジュール取得
        var allObjects = realm.objects(EventModel.self)
        
        allObjects = allObjects.filter("date = '\(da)'")
        let oneObje = allObjects.first
        let objcIcon = oneObje?.icon
        let objcText  = oneObje?.text
        

        if objcIcon == nil{
            dateIcon.image = UIImage(systemName: "clear")
            dateIcon.tintColor = .gray
        }else{
            dateIcon.image = UIImage(data: objcIcon!)
        }
        
        if objcText == nil{
            tableText.text = "イベントはありません"
            tableText.textColor = .gray
        }else{
            tableText.text = objcText
            tableText.textColor = .black
        }
        
        
    }
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition){
        
        let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .none
        f.locale = Locale(identifier: "ja_JP")
        
        let strDate = f.string(from: date)
        
        self.pickedDate = strDate
        
        //print(選択された日付)
        print(pickedDate)
        
        let da = f.string(from: date)
        
        let realm = try! Realm()
        
        //全スケジュール取得
        var allObjects = realm.objects(EventModel.self)
        
        allObjects = allObjects.filter("date = '\(da)'")
        let oneObje = allObjects.first
        let objcIcon = oneObje?.icon
        let objcText  = oneObje?.text
        
        if objcIcon == nil{
            dateIcon.image = UIImage(systemName: "clear")
            dateIcon.tintColor = .gray
        }else{
            dateIcon.image = UIImage(data: objcIcon!)
        }
        
        if objcText == nil{
            tableText.text = "イベントはありません"
            tableText.textColor = .gray
        }else{
            tableText.text = objcText
            tableText.textColor = .black
        }
        
    }
    
    
    
    @objc func deleteBtn(_ sender: UIButton){
        
        present(deleteAlert,animated: true, completion: nil)
        
    }
    
    @objc func textAdd(_ sender: UIButton){
        
        //日付が選択されていない時エラーアラート
        if pickedDate == "" {
            present(alert, animated: true, completion: nil)
        }else{
            
                //textViewに遷移
            let nextVC  = self.storyboard?.instantiateViewController(identifier: "textView") as?                         TextViewController
            nextVC!.pickedDate = self.pickedDate
            self.present(nextVC!, animated: true, completion: nil)
            
            //帰ってくる時.nextVCにあるプロパティにクロージャを渡す
            nextVC!.textViewCallBack = { self.callBack() }
        }
        
    }
    
    @objc func addEvents(_ sender: UIButton) {
        
        //日付が選択されていない時エラーアラート
        if pickedDate == "" {
            present(alert, animated: true, completion: nil)
        }else{
                let nextVC  = self.storyboard?.instantiateViewController(identifier: "imageView") as? ImageViewController
            
                //行く時.値渡し
                nextVC!.pickedDate = self.pickedDate
                self.present(nextVC!, animated: true, completion: nil)
            
                //帰ってくる時.nextVCにあるプロパティにクロージャを渡す
                nextVC!.imageViewCallBack = { self.callBack() }
            
                }
        
    }
        
    func callBack(){
        //更新
        let realm = try! Realm()
        
        let f = DateFormatter()
               f.dateStyle = .long
               f.timeStyle = .none
               f.locale = Locale(identifier: "ja_JP")
               
               let da = pickedDate
        
                print(da)
               
               //全スケジュール取得
               var allObjects = realm.objects(EventModel.self)
               
               allObjects = allObjects.filter("date = '\(da)'")
               let oneObje = allObjects.first
               let objcIcon = oneObje?.icon
                let objcText  = oneObje?.text
               

               if objcIcon == nil{
                   dateIcon.image = UIImage(systemName: "clear")
                   dateIcon.tintColor = .gray
               }else{
                   dateIcon.image = UIImage(data: objcIcon!)
               }
        
        if objcText == nil{
            tableText.text = "イベントはありません"
            tableText.textColor = .gray
        }else{
            tableText.text = objcText
            tableText.textColor = .black
        }
        
    }
    
    //userSetTimeをユーザー設定として更新する関数
    `c`
        //userSetTimeをUserDefaultsに格納する
        UserDefaults.standard.set(String(), forKey: userSetTime)
        let uTime = UserDefaults.standard.string(forKey: userSetTime)
        print(uTime!)
    }
    
    @objc func goToUserSetting(_ sender: UIButton) {
        let nextVC = self.storyboard?.instantiateViewController(identifier: "settingVIew") as? SettingViewController
        
            //行く時.値渡し
            self.present(nextVC!, animated: true, completion: nil)
        
            //帰ってくる時.nextVCにあるプロパティにクロージャを渡す
        nextVC!.settingViewTrigger = { self.updateUserSetting() }
    }
    
    //通知設定
    
    func addNotifications(){
    //登録処理
        let content = UNMutableNotificationContent()
        let center = UNUserNotificationCenter.current()
        var dateCompo = DateComponents()
        
        var uHour : Int
        var uMinute : Int
        
        //通知タイトル
        content.title = "今日の予定";
        //通知内容
        content.body = "text";
        //通知サウンド
        content.sound = UNNotificationSound.default
        
        //通知時間設定(時間と分)
        //dateCompo.hour = uHour
        //dateCompo.minute = uMinute
        
        //通知トリガー設定
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateCompo, repeats: false)
        
        //通知リクエスト設定
        let request = UNNotificationRequest.init(identifier: "TestNotification", content: content, trigger: trigger)
        
        //通知リクエストを追加
        center.add(request)
        //デリゲート設定
        center.delegate = self
    }
    
    //ポップアップ表示のタイミングで呼ばれる関数
    //（アプリがアクティブ、非アクテイブ、アプリ未起動,バックグラウンドでも呼ばれる）
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.sound])
    }
}
