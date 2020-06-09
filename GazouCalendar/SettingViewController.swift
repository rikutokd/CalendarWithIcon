//
//  SettingViewController.swift
//  GazouCalendar
//
//  Created by 佐藤陸斗 on 2020/05/29.
//  Copyright © 2020 hannet. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UITextFieldDelegate{
    
    //戻るボタン設定
    @IBOutlet weak var backBtn: UIButton!
    
    //OKボタン設定
    @IBOutlet weak var okBtn: UIButton!

    //DatePicker設定
    @IBOutlet weak var myDatePicker: UIDatePicker!
    
    //空変数
    var userSetTime : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //戻るボタンの設定
        backBtn!.addTarget(self, action: #selector(backEvent(_:)), for: .touchUpInside)
        
        //okボタンの設定
        okBtn!.addTarget(self, action: #selector(okEvent(_:)), for: .touchUpInside)
        
        //機能追加
        myDatePicker.addTarget(self, action: #selector(datePickerChanged(picker:)), for: .valueChanged)
        
        //viewにデートピッカー追加
        self.view.addSubview(myDatePicker)
    }
    
}

//Dateをstringにする為のクラス
class DateUtils {
    class func stringFromDate(date: Date, format: String) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}

extension SettingViewController{
    //戻るボタン機能設定
    @objc func backEvent(_: UIButton){
        //前のページに戻る
        self.dismiss(animated: true, completion: nil)
    }
    
    //okボタン機能設定
    @objc func okEvent(_: UIButton){
        
        let userDefaults = UserDefaults.standard
        //forKey:NotifiTime で登録
        userDefaults.set(userSetTime, forKey: "NotifiTime")
        //UserDefaults永続化
        userDefaults.synchronize()
        
        // NotifiTime取得
        let NotifiTime = userDefaults.string(forKey: "NotifiTime")
        print("ユーザーへの通知時刻",NotifiTime!,"が永続化されました")
        
        //前のページに戻る
        self.dismiss(animated: true, completion: nil)
    }
    
    //時間が変更されたらdate型からstring型に変更し、値を格納するメソッド
    @objc func datePickerChanged(picker: UIDatePicker) {
        
        //date型からstring型に変更
        let userSetTimeLocal = DateUtils.stringFromDate(date: myDatePicker.date, format: "HH時mm分")
        //値格納
        userSetTime = userSetTimeLocal
        
        print(userSetTimeLocal)
    }
    
}
