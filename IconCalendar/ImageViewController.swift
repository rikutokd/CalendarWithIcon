import UIKit
import RealmSwift

    private let photos = [
"Coffee01",
"Coffee02",
"Computer",
"Desk",
"Diary",
"Grass",
"Lamp",
"Mail",
"Mouse",
"Music",
"PencilStand",
"PenTab",
"Picture",
"Prize",
"Radio",
"Timer",
"USB",
"Workspace",
"video-recorder",
]

    
class ImageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var pickedDate = ""
    
    var selectedIconArray : [Data] = []
    
    //コールバックする時,引数無し
    var imageViewCallBack: (() -> Void)?
    
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var addBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //iOSのモードをライトに
        self.overrideUserInterfaceStyle = .light
        
        
        //ボタン設定2種
        cancelBtn!.addTarget(self, action: #selector(cancelEvent(_:)), for: .touchUpInside)
        
        addBtn!.addTarget(self, action: #selector(trySave(_:)), for: .touchUpInside)
        
        //追加ボタンを初期でdisable状態に
        addBtn.isEnabled = false

    }
    
    //cellの横幅、高さ設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        let height: CGFloat = 256
        let width: CGFloat = 256
        
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
                return CGFloat(0)
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
        
        //選択されている画像
        print(selectedImage!)
        
        //選択画像をpngに変換
        pngSelectedIcon = selectedImage!.pngData()
        
        //pngを空配列に格納
        selectedIconArray.append(pngSelectedIcon!)
        
        print(selectedIconArray)
        
        print(pickedDate)
        
        //選択されたら追加ボタンを可能状態に
        addBtn.isEnabled = true
        
    }
    
    @objc func cancelEvent(_: UIButton){
        //前のページに戻る
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func trySave(_ : UIButton) {
        
        let realm = try! Realm()
        
        print("DB書き込み開始")
        
        //日付表示の内容とスケジュール入力の内容が書き込まれる。
        let selectIcon = selectedIconArray.last!
        let Events = [EventModel(value: ["date": pickedDate, "icon": selectIcon])]
        let thisDate = realm.objects(EventModel.self).filter("date == '\(pickedDate)'").first
        let icon = thisDate?.icon
        
        let event_Icon = EventModel()
        event_Icon.icon = selectIcon
        
        print(thisDate as Any)

        try! realm.write {
            
            
                if thisDate == nil {
                
                        realm.add(Events)
                        print("DB書き込み中")
                    
                    //DBをその日付で見た時に、値がnilではない時に,
                }else{
                    
                    if icon == nil {
                        
                        thisDate!.icon = selectIcon
                        print("その日付に書き込み中")
                        
                    }else if icon != nil{
                        
                        thisDate!.icon = selectIcon
                        print("画像を上書き中")
                        
                    }
                    
                }
        
            print("データ書き込み完了")
            //前のページに戻る
            
            self.dismiss(animated: true, completion: {
                self.imageViewCallBack?()
            })
        
        }

    
    }

}
