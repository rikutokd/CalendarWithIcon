//
//  DatePickerViewController.swift
//  IconCalendar
//
//  Created by 佐藤陸斗 on 2020/01/20.
//  Copyright © 2020 hannet. All rights reserved.
//

import Foundation
import UIKit

class DatePickerViewController: UIViewController{
    var datePicker: UIDatePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.overrideUserInterfaceStyle = .light

        
        //ピッカー設定
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = Locale.current
        
        //決定バーの生成
        
        
    }
}
