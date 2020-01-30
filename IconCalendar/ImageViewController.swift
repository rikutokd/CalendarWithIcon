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
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var addBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //iOSのモードをライトに
        self.overrideUserInterfaceStyle = .light
        
        
        //ボタン設定2種
        cancelBtn!.addTarget(self, action: #selector(cancelEvent(_:)), for: .touchUpInside)
        
        addBtn!.addTarget(self, action: #selector(addEvent(_:)), for: .touchUpInside)

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
        
        //選択されている画像出力
        print(selectedImage!)
        
        //選択画像をpngに変換
        pngSelectedIcon = selectedImage!.pngData()
        
        //pngを空配列に格納
        selectedIconArray.append(pngSelectedIcon!)
        
        print(selectedIconArray)
        
        print(pickedDate)
        
    }
    
    @objc func cancelEvent(_: UIButton){
        //前のページに戻る
        dismiss(animated: true, completion: nil)
    }
    
    @objc func addEvent(_ : UIButton) {
        
        
        print("DB書き込み開始")
        
        
        let realm = try! Realm()

        try! realm.write {
            //日付表示の内容とスケジュール入力の内容が書き込まれる。
            let Events = [EventModel(value: ["date": pickedDate, "icon": selectedIconArray.first!])]
            
                realm.add(Events)
                print("DB書き込み中")

                }
        
        print("データ書き込み完了")

        //前のページに戻る
        dismiss(animated: true, completion: nil)
        
    }

    
}

