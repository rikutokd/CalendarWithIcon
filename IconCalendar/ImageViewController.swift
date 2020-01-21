import UIKit
import RealmSwift

    private let photos = ["Airplane",
                          "Train",
                          "Hotel",]

    
class ImageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var selectedIconArray : [Data] = []
    
    //UserDefaults のインスタンス生成
     let userDefaults = UserDefaults.standard

     // ドキュメントディレクトリの「ファイルURL」（URL型）定義
     var documentDirectoryFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]

     // ドキュメントディレクトリの「パス」（String型）定義
     let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]

    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var dateText: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.overrideUserInterfaceStyle = .light
        
        //ピッカー設定
        
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = Locale.current
        
        datePicker.addTarget(self, action: #selector(picker(_:)), for: .valueChanged)
        
        
        //saveボタン設定
        self.saveButton.frame = CGRect(x: 299, y: 363, width: 70, height: 70)
        let saveIcon = UIImage(systemName: "plus")
        
        self.saveButton.setImage(saveIcon, for: .normal)
        
        let saveBtn = saveButton
        
        saveBtn?.tintColor = .white
        saveBtn?.backgroundColor = .systemBlue
        saveBtn!.layer.cornerRadius = 35
        
        saveBtn!.addTarget(self, action: #selector(saveEvent(_:)),for: .touchUpInside)
        
        //選択された画像の設定
        
    }
    
    //cellの横幅、高さ設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        let height: CGFloat = 128
        let width: CGFloat = 128
        
        return CGSize(width: width, height: height)
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count // 表示するセルの数
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) // 表示するセルを登録(先程命名した"Cell")
        // Tag番号を使ってインスタンスをつくる
                let photoImageView = cell.contentView.viewWithTag(1)  as! UIImageView
                let photoImage = UIImage(named: photos[indexPath.row])
               photoImageView.image = photoImage
                        
        //選択されてハイライトされる
        let selectedImageView = UIView(frame: cell.frame)
        selectedImageView.backgroundColor = .lightGray
        cell.selectedBackgroundView = selectedImageView
        
        return cell
    }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
                return CGFloat(-20)
        }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
                return CGFloat(0)
            }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets.zero
            }
    
    }

extension ImageViewController {
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        var selectedImage : UIImage?
        var pngSelectedIcon : Data?
        
        selectedImage = UIImage(named: photos[indexPath.row])
        
        //選択されている画像出力
        print(selectedImage!)
        
        //選択画像をpngに変換
        pngSelectedIcon = selectedImage!.pngData()
        
        //pngを空配列に格納
        selectedIconArray.append(pngSelectedIcon!)
        
        print(selectedIconArray)
        
    }
    
    @objc func saveEvent(_ : UIButton) {
        
        //②保存するためのパスを作成する
        func createLocalDataFile() {
            // 作成する画像の名前
            let fileName = "localData.png"

            // DocumentディレクトリのfileURLを取得
            if documentDirectoryFileURL != nil {
                // ディレクトリのパスにファイル名をつなげてファイルのフルパスを作る
                let path = documentDirectoryFileURL.appendingPathComponent(fileName)
                documentDirectoryFileURL = path
            }
        }
        
        //画像を保存する関数の部分
            func saveImage() {
                createLocalDataFile()
                //pngで保存する場合
                let pngImageData = (selectedIconArray.first!)
                do {
                    try pngImageData.write(to: documentDirectoryFileURL)
                    //②「Documents下のパス情報をUserDefaultsに保存する」
                    userDefaults.set(documentDirectoryFileURL, forKey: "userImage")
                } catch {
                    //エラー処理
                    print("エラー")
                }
            }
        
               // ③UserDefaultsの情報を参照してpath指定に使う
//                let path = String(describing: UserDefaults.standard.url(forKey: "userImage"))
//          if let image = UIImage(contentsOfFile: documentDirectoryFileURL.path)
                   
//        print(documentDirectoryFileURL.path)

        print("userDefaultsにpngData保存完了")
        print("DB書き込み開始")
        
        
        let realm = try! Realm()

        try! realm.write {
            //日付表示の内容とスケジュール入力の内容が書き込まれる。
            let Events = [EventModel(value: ["date": dateText.text!, "icon": selectedIconArray.first!])]
            
                realm.add(Events)
                print("DB書き込み中")

                }
        
        print("データ書き込み完了")

        //前のページに戻る
        dismiss(animated: true, completion: nil)
        
    }
    
   //日付フォーム
        @objc func picker(_ sender:UIDatePicker){
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd"
            dateText.text = formatter.string(from: sender.date)
        
            print(dateText.text!)
        }
    
}

