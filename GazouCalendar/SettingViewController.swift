//
//  SettingViewController.swift
//  GazouCalendar
//
//  Created by 佐藤陸斗 on 2020/05/29.
//  Copyright © 2020 hannet. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var backBtn: UIButton!
    //DatePicker設定
    @IBOutlet weak var myDatePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //戻るボタンの設定
        backBtn!.addTarget(self, action: #selector(backEvent(_:)), for: .touchUpInside)
        
        //機能追加
        myDatePicker.addTarget(self, action: #selector(datePickerChanged(picker:)), for: .valueChanged)
        
        //viewにデートピッカー追加
        self.view.addSubview(myDatePicker)
    }
    
}

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
    
    @objc func datePickerChanged(picker: UIDatePicker) {
        print(DateUtils.stringFromDate(date: myDatePicker.date, format: "HH時mm分"))
    }
    
}
