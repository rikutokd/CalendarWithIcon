import UIKit
import FSCalendar
import CalculateCalendarLogic
import RealmSwift


class ViewController: UIViewController,FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance{
    
    @IBOutlet weak var calendar: FSCalendar!
    
    @IBOutlet weak var plusBtn: UIButton!
    
    @IBOutlet weak var deleteBtn: UIButton!
    
    @IBOutlet weak var textBtn: UIButton!
    
    
    
    
    @IBOutlet weak var dateText: UILabel!
    
    @IBOutlet weak var dateIcon: UIImageView!
    
        //選択した日付を入れる空の変数
    var pickedDate = ""
    
    //エラーメッセージ設定
    //エラーアラート用の変数宣言
    let alert = UIAlertController(title: "エラー", message: "日付が選択されていません。", preferredStyle: .alert)
    
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
        
        //ボタン設定3種
        plusBtn!.addTarget(self, action: #selector(addEvents(_:)), for: .touchUpInside)
        deleteBtn!.addTarget(self, action: #selector(deleteBtn(_:)), for: .touchUpInside)
        textBtn!.addTarget(self, action: #selector(textAdd(_:)), for: .touchUpInside)
        
        //defaultのrealmデータファイル
//        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        //alertにキャンセル追加
        alert.addAction(cancelAction)
        
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
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition){
        
        let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .none
        f.locale = Locale(identifier: "ja_JP")
        
        let strDate = f.string(from: date)
        
        self.pickedDate = strDate
        
        print(pickedDate)
        
        //予定がある場合、イベントをDBから取得・表示する。
        //無い場合、「イベントはありません」と表示。
        dateText.text = "イベントはありません"
        dateText.textColor = .lightGray
        
        //初期値で"nosign"imageセット
        dateIcon.image = UIImage(systemName: "nosign")

        
        let da = f.string(from: date)
        
        //スケジュール取得
        let realm = try! Realm()
        
        var eventsDate = realm.objects(EventModel.self)
        eventsDate = eventsDate.filter("date = '\(da)'")
        print(eventsDate)
        
        for gettingEvents in eventsDate {
            if gettingEvents.date == da {
                let eventIcon: UIImage = UIImage(data: gettingEvents.icon!)!
                
                dateText.text = ""
                dateText.textColor = .clear
                
                dateIcon.image = eventIcon
                
                }
        }
        
    }
    
    
    
    @objc func deleteBtn(_ sender: UIButton){
        let realm = try! Realm()
        
        print("DBのデータを全て削除")
        
        // Delete all objects from the realm
        try! realm.write {
            realm.deleteAll()
        }
        
        print("削除完了")
        
    }
    
    @objc func textAdd(_ sender: UIButton){
        if pickedDate == "" {
            present(alert, animated: true, completion: nil)
        }else{
            self.performSegue(withIdentifier: "toTextView", sender: AnyObject?.self)
        }
        
    }
    
    @objc func addEvents(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toImageView", sender: AnyObject?.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toImageView" {
            
            let nextVC = segue.destination as! ImageViewController
            nextVC.pickedDate = self.pickedDate
            
        } else if segue.identifier == "toTextView" {
            
            let nextVC = segue.destination as! TextViewController
            nextVC.pickedDate = self.pickedDate
            
        }
    }
            
}
