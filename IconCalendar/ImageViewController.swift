import UIKit

    private let photos = ["Airplane",
                          "Train",
                          "Hotel",]

class ImageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        let height: CGFloat = 128
        let width: CGFloat = 128
        
        return CGSize(width: width, height: height)
        
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
        
        return cell
    }
    
}

