import UIKit
import RealmSwift

    private let photos = ["Airplane",
                          "Train",
                          "Hotel",]

class ImageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var tappedDate: String?
    var selectedImage : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.overrideUserInterfaceStyle = .light
        
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
            
        // [indexPath.row] から画像名を探し、UImage を設定
        selectedImage = UIImage(named: photos[indexPath.row])
        
        let pngImage = selectedImage?.pngData()
        
        print(pngImage)
        
                print("DBへの登録開始")
        
                let realm = try! Realm()
        
                try! realm.write{
                    //日付とカレンダーの画像を型変換して保存
                    let Events = [EventModel(value: ["icon": pngImage])]
                    realm.add(Events)
                    print("DBへ書き込み中")
                }
        
                print("DBへ書き込み完了")
        
        
    }
}
