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
    
    //VCに渡す為の空変数
    var EmptyuserSetTime : String = ""
    
    //コールバックする時,引数無し
    var settingViewTrigger: (() -> Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //戻るボタンの設定
        backBtn!.addTarget(self, action: #selector(backEvent(_:)), for: .touchUpInside)
        
        //OKボタンの設定
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
    
    //OKボタン機能設定
    @objc func okEvent(_: UIButton){
        
        let nextVC = self.storyboard?.instantiateViewController(identifier: "mainView") as? ViewController
        //値渡し
        nextVC!.userSetTime = self.EmptyuserSetTime
        //前のページに戻る
        self.dismiss(animated: true, completion: {
            //Trigger起動でupdateUserSetting()を呼びに行く
            self.settingViewTrigger?()
        })
    }
    
    //時間が変更されたらdate型からstring型に変更し、値を格納するメソッド
    @objc func datePickerChanged(picker: UIDatePicker) {
        
        //date型からstring型に変更
        let userSetTime = DateUtils.stringFromDate(date: myDatePicker.date, format: "HH時mm分")
        //値格納
        EmptyuserSetTime = userSetTime
        
        print(userSetTime)
    }
    
}
