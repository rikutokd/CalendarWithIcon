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
    
    @IBOutlet weak var hourField: UITextField!
    
    @IBOutlet weak var minuteField: UITextField!
    
    override func viewDidLoad() {
        //戻るボタンの設定
        backBtn!.addTarget(self, action: #selector(backEvent(_:)), for: .touchUpInside)
        
        //TextFieldのデリゲート設定（必須）
        hourField.delegate = self
        minuteField.delegate = self
        
    }
    
}

extension SettingViewController{
    //戻るボタン機能設定
    @objc func backEvent(_: UIButton){
        //前のページに戻る
        self.dismiss(animated: true, completion: nil)
    }
    
}
