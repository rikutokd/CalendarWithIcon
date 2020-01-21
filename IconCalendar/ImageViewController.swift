import UIKit
import RealmSwift

    private let photos = ["Airplane",
                          "Train",
                          "Hotel",]

class ImageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
   
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    var datePicker: UIDatePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.overrideUserInterfaceStyle = .light
        
        //ピッカー設定
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = Locale.current
        
        //saveボタン設定
        self.saveButton.frame = CGRect(x: 299, y: 363, width: 70, height: 70)
        let saveIcon = UIImage(systemName: "plus")
        
        self.saveButton.setImage(saveIcon, for: .normal)
        
        let saveBtn = saveButton
        
        saveBtn?.tintColor = .white
        saveBtn?.backgroundColor = .systemBlue
        saveBtn!.layer.cornerRadius = 35
        
        saveBtn!.addTarget(self, action: #selector(saveEvent(_:)),for: .touchUpInside)
        
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
        // [indexPath.row] から画像名を探し、UImage を設定
        selectedImage = UIImage(named: photos[indexPath.row])
        
        print(selectedImage!)
        
    }
    
    @objc func saveEvent(_ : UIButton) {
        print("データ書き込み開始")
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
//        dateText = "\(formatter.string(from: Date()))"
//
//        print(dateText)
    }
    
}
