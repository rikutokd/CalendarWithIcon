//
//  TextViewController.swift
//  IconCalendar
//
//  Created by 佐藤陸斗 on 2020/02/05.
//  Copyright © 2020 hannet. All rights reserved.
//

import UIKit
import RealmSwift

class TextViewController: UIViewController, UITextFieldDelegate {
    var pickedDate = ""
    
    var wroteText = ""
    
    @IBOutlet weak var addBtn: UIButton!
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var titleText: UITextField!
    
    @IBOutlet weak var placeText: UITextField!
    
    
    override func viewDidLoad() {
        //iOSのモードをライトに
        self.overrideUserInterfaceStyle = .light
        
        
        //TextFieldのdelegateプロパティにself（UIViewController）を指定します。
        titleText.delegate = self
        placeText.delegate = self
        
        //ボタン設定
        cancelBtn!.addTarget(self, action: #selector(cancelEvent(_:)), for: .touchUpInside)
        
        addBtn!.addTarget(self, action: #selector(trySave(_:)), for: .touchUpInside)
        
        //追加ボタンを初期でdisable状態に
        addBtn.isEnabled = false
        
    }
    
}

extension TextViewController{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        addBtn.isEnabled = true
        wroteText = titleText.text!
        
        print(wroteText)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.view.endEditing(true)
    }
    
    @objc func cancelEvent(_: UIButton){
        //前のページに戻る
        dismiss(animated: true, completion: nil)
    }
    
    @objc func trySave(_ : UIButton) {
        
        
        print("DB書き込み開始")
        
        
        let realm = try! Realm()

        try! realm.write {
            //日付表示の内容とスケジュール入力の内容が書き込まれる。
            let Events = [EventModel(value: ["date": pickedDate, "text": wroteText])]
            
                realm.add(Events)
                print("DB書き込み中")

                }
        
        print("データ書き込み完了")

        //前のページに戻る
        dismiss(animated: true, completion: nil)
        
    }
    
}
