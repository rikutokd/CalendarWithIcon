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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //戻るボタンの設定
        backBtn!.addTarget(self, action: #selector(backEvent(_:)), for: .touchUpInside)
        
        //DatePicker設定
        let myDatePicker = UIDatePicker()
        //DatePicker = 時間のみモード
        myDatePicker.datePickerMode = UIDatePicker.Mode.time
        // 分刻みを３０分単位で設定
        myDatePicker.minuteInterval = 10
        //DatePickerフレームサイズ設定
        myDatePicker.frame = CGRect(x:16 , y: 80, width: 400, height: 200)
        
        //viewにデートピッカー追加
        self.view.addSubview(myDatePicker)
    }
    
}

extension SettingViewController{
    //戻るボタン機能設定
    @objc func backEvent(_: UIButton){
        //前のページに戻る
        self.dismiss(animated: true, completion: nil)
    }

}
